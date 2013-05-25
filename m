From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 2/4] eCryptfs: Merge ecryptfs_encrypt_extent() and ecryptfs_decrypt_extent()
Date: Fri, 24 May 2013 17:05:09 -0700
Message-ID: <1369440311-10351-3-git-send-email-tyhicks@canonical.com>
References: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36704 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab3EYAF0 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 20:05:26 -0400
In-Reply-To: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

They are identical except if the src_page or dst_page index is used, so
they can be merged safely if page_index is conditionally assigned.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 74 ++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 54 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 609efc0..9845d2f 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -416,28 +416,29 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
 }
 
 /**
- * ecryptfs_encrypt_extent
- * @enc_extent_page: Allocated page into which to encrypt the data in
- *                   @page
+ * crypt_extent
+ * @dst_page: The page to write the result into
  * @crypt_stat: crypt_stat containing cryptographic context for the
  *              encryption operation
- * @page: Page containing plaintext data extent to encrypt
+ * @src_page: The page to read from
  * @extent_offset: Page extent offset for use in generating IV
+ * @op: ENCRYPT or DECRYPT to indicate the desired operation
  *
- * Encrypts one extent of data.
+ * Encrypts or decrypts one extent of data.
  *
  * Return zero on success; non-zero otherwise
  */
-static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
-				   struct ecryptfs_crypt_stat *crypt_stat,
-				   struct page *page,
-				   unsigned long extent_offset)
+static int crypt_extent(struct page *dst_page,
+			struct ecryptfs_crypt_stat *crypt_stat,
+			struct page *src_page,
+			unsigned long extent_offset, int op)
 {
+	pgoff_t page_index = op == ENCRYPT ? src_page->index : dst_page->index;
 	loff_t extent_base;
 	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
 	int rc;
 
-	extent_base = (((loff_t)page->index)
+	extent_base = (((loff_t)page_index)
 		       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
 	rc = ecryptfs_derive_iv(extent_iv, crypt_stat,
 				(extent_base + extent_offset));
@@ -447,14 +448,13 @@ static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = crypt_page_offset(crypt_stat, enc_extent_page, page,
+	rc = crypt_page_offset(crypt_stat, dst_page, src_page,
 			       (extent_offset * crypt_stat->extent_size),
-			       crypt_stat->extent_size, extent_iv, ENCRYPT);
+			       crypt_stat->extent_size, extent_iv, op);
 	if (rc < 0) {
-		printk(KERN_ERR "%s: Error attempting to encrypt page with "
-		       "page->index = [%ld], extent_offset = [%ld]; "
-		       "rc = [%d]\n", __func__, page->index, extent_offset,
-		       rc);
+		printk(KERN_ERR "%s: Error attempting to crypt page with "
+		       "page_index = [%ld], extent_offset = [%ld]; "
+		       "rc = [%d]\n", __func__, page_index, extent_offset, rc);
 		goto out;
 	}
 	rc = 0;
@@ -503,8 +503,8 @@ int ecryptfs_encrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = ecryptfs_encrypt_extent(enc_extent_page, crypt_stat, page,
-					     extent_offset);
+		rc = crypt_extent(enc_extent_page, crypt_stat, page,
+				  extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -531,40 +531,6 @@ out:
 	return rc;
 }
 
-static int ecryptfs_decrypt_extent(struct page *page,
-				   struct ecryptfs_crypt_stat *crypt_stat,
-				   struct page *enc_extent_page,
-				   unsigned long extent_offset)
-{
-	loff_t extent_base;
-	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
-	int rc;
-
-	extent_base = (((loff_t)page->index)
-		       * (PAGE_CACHE_SIZE / crypt_stat->extent_size));
-	rc = ecryptfs_derive_iv(extent_iv, crypt_stat,
-				(extent_base + extent_offset));
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error attempting to derive IV for "
-			"extent [0x%.16llx]; rc = [%d]\n",
-			(unsigned long long)(extent_base + extent_offset), rc);
-		goto out;
-	}
-	rc = crypt_page_offset(crypt_stat, page, enc_extent_page,
-			       (extent_offset * crypt_stat->extent_size),
-			       crypt_stat->extent_size, extent_iv, DECRYPT);
-	if (rc < 0) {
-		printk(KERN_ERR "%s: Error attempting to decrypt to page with "
-		       "page->index = [%ld], extent_offset = [%ld]; "
-		       "rc = [%d]\n", __func__, page->index, extent_offset,
-		       rc);
-		goto out;
-	}
-	rc = 0;
-out:
-	return rc;
-}
-
 /**
  * ecryptfs_decrypt_page
  * @page: Page mapped from the eCryptfs inode for the file; data read
@@ -610,8 +576,8 @@ int ecryptfs_decrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = ecryptfs_decrypt_extent(page, crypt_stat, page,
-					     extent_offset);
+		rc = crypt_extent(page, crypt_stat, page,
+				  extent_offset, DECRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
-- 
1.8.1.2
