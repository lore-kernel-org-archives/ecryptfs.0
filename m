From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/13] ubifs: Tell the VFS that readpage was synchronous
Date: Thu, 17 Sep 2020 16:10:48 +0100
Message-ID: <20200917151050.5363-12-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgIQPLm (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Sep 2020 11:11:42 -0400
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>

The ubifs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index b77d1637bbbc..82633509c45e 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -772,7 +772,6 @@ static int ubifs_do_bulk_read(struct ubifs_info *c, struct bu_info *bu,
 	if (err)
 		goto out_warn;
 
-	unlock_page(page1);
 	ret = 1;
 
 	isize = i_size_read(inode);
@@ -892,11 +891,16 @@ static int ubifs_bulk_read(struct page *page)
 
 static int ubifs_readpage(struct file *file, struct page *page)
 {
-	if (ubifs_bulk_read(page))
-		return 0;
-	do_readpage(page);
-	unlock_page(page);
-	return 0;
+	int err;
+
+	err = ubifs_bulk_read(page);
+	if (err == 0)
+		err = do_readpage(page);
+	if (err < 0) {
+		unlock_page(page);
+		return err;
+	}
+	return AOP_UPDATED_PAGE;
 }
 
 static int do_writepage(struct page *page, int len)
-- 
2.28.0

