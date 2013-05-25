From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 3/4] eCryptfs: Collapse crypt_page_offset() into crypt_extent()
Date: Fri, 24 May 2013 17:05:10 -0700
Message-ID: <1369440311-10351-4-git-send-email-tyhicks@canonical.com>
References: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36706 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab3EYAF1 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 20:05:27 -0400
In-Reply-To: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

crypt_page_offset() simply initialized the two scatterlists and called
crypt_scatterlist() so it is simple enough to move into the only
function that calls it.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 50 ++++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 9845d2f..9947388 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -40,10 +40,6 @@
 #define DECRYPT		0
 #define ENCRYPT		1
 
-static int crypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, struct page *src_page,
-			     int offset, int size, unsigned char *iv, int op);
-
 /**
  * ecryptfs_to_hex
  * @dst: Buffer to take hex character representation of contents of
@@ -436,10 +432,11 @@ static int crypt_extent(struct page *dst_page,
 	pgoff_t page_index = op == ENCRYPT ? src_page->index : dst_page->index;
 	loff_t extent_base;
 	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
+	struct scatterlist src_sg, dst_sg;
+	size_t extent_size = crypt_stat->extent_size;
 	int rc;
 
-	extent_base = (((loff_t)page_index)
-		       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
+	extent_base = (((loff_t)page_index) * (PAGE_CACHE_SIZE / extent_size));
 	rc = ecryptfs_derive_iv(extent_iv, crypt_stat,
 				(extent_base + extent_offset));
 	if (rc) {
@@ -448,9 +445,17 @@ static int crypt_extent(struct page *dst_page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = crypt_page_offset(crypt_stat, dst_page, src_page,
-			       (extent_offset * crypt_stat->extent_size),
-			       crypt_stat->extent_size, extent_iv, op);
+
+	sg_init_table(&src_sg, 1);
+	sg_init_table(&dst_sg, 1);
+
+	sg_set_page(&src_sg, src_page, extent_size,
+		    extent_offset * extent_size);
+	sg_set_page(&dst_sg, dst_page, extent_size,
+		    extent_offset * extent_size);
+
+	rc = crypt_scatterlist(crypt_stat, &dst_sg, &src_sg, extent_size,
+			       extent_iv, op);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to crypt page with "
 		       "page_index = [%ld], extent_offset = [%ld]; "
@@ -588,33 +593,6 @@ out:
 	return rc;
 }
 
-/**
- * crypt_page_offset
- * @crypt_stat: The cryptographic context
- * @dst_page: The page to write the result into
- * @src_page: The page to read from
- * @offset: The byte offset into the dst_page and src_page
- * @size: The number of bytes of data
- * @iv: The initialization vector to use for the crypto operation
- * @op: ENCRYPT or DECRYPT to indicate the desired operation
- *
- * Returns the number of bytes encrypted or decrypted
- */
-static int crypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, struct page *src_page,
-			     int offset, int size, unsigned char *iv, int op)
-{
-	struct scatterlist src_sg, dst_sg;
-
-	sg_init_table(&src_sg, 1);
-	sg_init_table(&dst_sg, 1);
-
-	sg_set_page(&src_sg, src_page, size, offset);
-	sg_set_page(&dst_sg, dst_page, size, offset);
-
-	return crypt_scatterlist(crypt_stat, &dst_sg, &src_sg, size, iv, op);
-}
-
 #define ECRYPTFS_MAX_SCATTERLIST_LEN 4
 
 /**
-- 
1.8.1.2
