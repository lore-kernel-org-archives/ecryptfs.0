From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 16/16] iomap: Make readpage synchronous
Date: Fri,  9 Oct 2020 15:31:04 +0100
Message-ID: <20201009143104.22673-17-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

A synchronous readpage lets us report the actual errno instead of
ineffectively setting PageError.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 74 ++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e60f572e1590..887bf871ca9b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -150,9 +150,6 @@ static void iomap_set_range_uptodate(struct page *page, unsigned off,
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
-	if (PageError(page))
-		return;
-
 	if (!iop) {
 		SetPageUptodate(page);
 		return;
@@ -165,42 +162,50 @@ static void iomap_set_range_uptodate(struct page *page, unsigned off,
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void
-iomap_read_page_end_io(struct bio_vec *bvec, int error)
+static void iomap_read_page_end_io(struct bio_vec *bvec,
+		struct completion *done, bool error)
 {
 	struct page *page = bvec->bv_page;
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (unlikely(error)) {
-		ClearPageUptodate(page);
-		SetPageError(page);
-	} else {
+	if (!error)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
-	}
 
-	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
-		unlock_page(page);
+	if (!iop ||
+	    atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending)) {
+		if (done)
+			complete(done);
+		else
+			unlock_page(page);
+	}
 }
 
+struct iomap_readpage_ctx {
+	struct page		*cur_page;
+	bool			cur_page_in_bio;
+	blk_status_t		status;
+	struct bio		*bio;
+	struct readahead_control *rac;
+	struct completion	done;
+};
+
 static void
 iomap_read_end_io(struct bio *bio)
 {
-	int error = blk_status_to_errno(bio->bi_status);
+	struct iomap_readpage_ctx *ctx = bio->bi_private;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	/* Capture the first error */
+	if (ctx && ctx->status == BLK_STS_OK)
+		ctx->status = bio->bi_status;
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, error);
+		iomap_read_page_end_io(bvec, ctx ? &ctx->done : NULL,
+				bio->bi_status != BLK_STS_OK);
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
-};
-
 static void
 iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
@@ -292,6 +297,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ctx->bio->bi_opf = REQ_OP_READ;
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
+		else
+			ctx->bio->bi_private = ctx;
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
@@ -318,15 +325,17 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
+	ctx.status = BLK_STS_OK;
+	init_completion(&ctx.done);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
 				iomap_readpage_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			SetPageError(page);
+		if (WARN_ON_ONCE(ret == 0))
+			ret = -EIO;
+		if (ret < 0)
 			break;
-		}
 	}
 
 	if (ctx.bio) {
@@ -334,15 +343,16 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 		WARN_ON_ONCE(!ctx.cur_page_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		unlock_page(page);
+		complete(&ctx.done);
 	}
 
-	/*
-	 * Just like mpage_readahead and block_read_full_page we always
-	 * return 0 and just mark the page as PageError on errors.  This
-	 * should be cleaned up all through the stack eventually.
-	 */
-	return 0;
+	wait_for_completion(&ctx.done);
+	if (ret >= 0)
+		ret = blk_status_to_errno(ctx.status);
+	if (ret == 0)
+		return AOP_UPDATED_PAGE;
+	unlock_page(page);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-- 
2.28.0

