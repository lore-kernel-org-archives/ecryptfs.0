From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 02/16] mm: Inline wait_on_page_read into its one caller
Date: Fri,  9 Oct 2020 15:30:50 +0100
Message-ID: <20201009143104.22673-3-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

Having this code inline helps the function read more easily.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 95b68ec1f22c..0ef06d515532 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2834,18 +2834,6 @@ EXPORT_SYMBOL(filemap_page_mkwrite);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
-static struct page *wait_on_page_read(struct page *page)
-{
-	if (!IS_ERR(page)) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			put_page(page);
-			page = ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
 static struct page *do_read_cache_page(struct address_space *mapping,
 				pgoff_t index,
 				int (*filler)(void *, struct page *),
@@ -2876,7 +2864,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			err = mapping->a_ops->readpage(data, page);
 		if (err == AOP_UPDATED_PAGE) {
 			unlock_page(page);
-			goto out;
+		} else if (!err) {
+			wait_on_page_locked(page);
+			if (!PageUptodate(page))
+				err = -EIO;
 		}
 
 		if (err < 0) {
@@ -2884,9 +2875,6 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			return ERR_PTR(err);
 		}
 
-		page = wait_on_page_read(page);
-		if (IS_ERR(page))
-			return page;
 		goto out;
 	}
 	if (PageUptodate(page))
-- 
2.28.0

