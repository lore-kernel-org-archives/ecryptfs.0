From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 1/4] eCryptfs: Combine page_offset crypto functions
Date: Fri, 24 May 2013 17:05:08 -0700
Message-ID: <1369440311-10351-2-git-send-email-tyhicks@canonical.com>
References: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36702 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab3EYAFZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 20:05:25 -0400
In-Reply-To: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Combine ecryptfs_encrypt_page_offset() and
ecryptfs_decrypt_page_offset(). These two functions are functionally
identical so they can be safely merged if the caller can indicate
whether an encryption or decryption operation should occur.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 69 ++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index fb54a01..609efc0 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -40,14 +40,9 @@
 #define DECRYPT		0
 #define ENCRYPT		1
 
-static int
-ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, struct page *src_page,
-			     int offset, int size, unsigned char *iv);
-static int
-ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
+static int crypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
 			     struct page *dst_page, struct page *src_page,
-			     int offset, int size, unsigned char *iv);
+			     int offset, int size, unsigned char *iv, int op);
 
 /**
  * ecryptfs_to_hex
@@ -452,9 +447,9 @@ static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page, page,
-					extent_offset * crypt_stat->extent_size,
-					crypt_stat->extent_size, extent_iv);
+	rc = crypt_page_offset(crypt_stat, enc_extent_page, page,
+			       (extent_offset * crypt_stat->extent_size),
+			       crypt_stat->extent_size, extent_iv, ENCRYPT);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to encrypt page with "
 		       "page->index = [%ld], extent_offset = [%ld]; "
@@ -555,9 +550,9 @@ static int ecryptfs_decrypt_extent(struct page *page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = ecryptfs_decrypt_page_offset(crypt_stat, page, enc_extent_page,
-					extent_offset * crypt_stat->extent_size,
-					crypt_stat->extent_size, extent_iv);
+	rc = crypt_page_offset(crypt_stat, page, enc_extent_page,
+			       (extent_offset * crypt_stat->extent_size),
+			       crypt_stat->extent_size, extent_iv, DECRYPT);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to decrypt to page with "
 		       "page->index = [%ld], extent_offset = [%ld]; "
@@ -628,20 +623,20 @@ out:
 }
 
 /**
- * ecryptfs_encrypt_page_offset
+ * crypt_page_offset
  * @crypt_stat: The cryptographic context
- * @dst_page: The page to encrypt into
- * @src_page: The page to encrypt from
+ * @dst_page: The page to write the result into
+ * @src_page: The page to read from
  * @offset: The byte offset into the dst_page and src_page
- * @size: The number of bytes to encrypt
- * @iv: The initialization vector to use for the encryption
+ * @size: The number of bytes of data
+ * @iv: The initialization vector to use for the crypto operation
+ * @op: ENCRYPT or DECRYPT to indicate the desired operation
  *
- * Returns the number of bytes encrypted
+ * Returns the number of bytes encrypted or decrypted
  */
-static int
-ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
+static int crypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
 			     struct page *dst_page, struct page *src_page,
-			     int offset, int size, unsigned char *iv)
+			     int offset, int size, unsigned char *iv, int op)
 {
 	struct scatterlist src_sg, dst_sg;
 
@@ -650,36 +645,8 @@ ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
 
 	sg_set_page(&src_sg, src_page, size, offset);
 	sg_set_page(&dst_sg, dst_page, size, offset);
-	return crypt_scatterlist(crypt_stat, &dst_sg, &src_sg,
-				 size, iv, ENCRYPT);
-}
-
-/**
- * ecryptfs_decrypt_page_offset
- * @crypt_stat: The cryptographic context
- * @dst_page: The page to decrypt into
- * @src_page: The page to decrypt from
- * @offset: The byte offset into the dst_page and src_page
- * @size: The number of bytes to decrypt
- * @iv: The initialization vector to use for the decryption
- *
- * Returns the number of bytes decrypted
- */
-static int
-ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, struct page *src_page,
-			     int offset, int size, unsigned char *iv)
-{
-	struct scatterlist src_sg, dst_sg;
-
-	sg_init_table(&src_sg, 1);
-	sg_set_page(&src_sg, src_page, size, offset);
-
-	sg_init_table(&dst_sg, 1);
-	sg_set_page(&dst_sg, dst_page, size, offset);
 
-	return crypt_scatterlist(crypt_stat, &dst_sg, &src_sg,
-				 size, iv, DECRYPT);
+	return crypt_scatterlist(crypt_stat, &dst_sg, &src_sg, size, iv, op);
 }
 
 #define ECRYPTFS_MAX_SCATTERLIST_LEN 4
-- 
1.8.1.2
