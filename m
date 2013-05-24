From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4/5] eCryptfs: Accept one offset parameter in page offset crypto functions
Date: Fri, 24 May 2013 16:55:57 -0700
Message-ID: <1369439758-10261-5-git-send-email-tyhicks@canonical.com>
References: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36654 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3EXX4Z (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 19:56:25 -0400
In-Reply-To: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

There is no longer a need to accept different offset values for the
source and destination pages when encrypting/decrypting an extent in an
eCryptfs page. The two offsets can be collapsed into a single parameter.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 3547708..ec640eb 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -39,14 +39,12 @@
 
 static int
 ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, int dst_offset,
-			     struct page *src_page, int src_offset, int size,
-			     unsigned char *iv);
+			     struct page *dst_page, struct page *src_page,
+			     int offset, int size, unsigned char *iv);
 static int
 ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, int dst_offset,
-			     struct page *src_page, int src_offset, int size,
-			     unsigned char *iv);
+			     struct page *dst_page, struct page *src_page,
+			     int offset, int size, unsigned char *iv);
 
 /**
  * ecryptfs_to_hex
@@ -450,9 +448,7 @@ static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page,
-					extent_offset * crypt_stat->extent_size,
-					page,
+	rc = ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page, page,
 					extent_offset * crypt_stat->extent_size,
 					crypt_stat->extent_size, extent_iv);
 	if (rc < 0) {
@@ -555,9 +551,7 @@ static int ecryptfs_decrypt_extent(struct page *page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = ecryptfs_decrypt_page_offset(crypt_stat, page,
-					extent_offset * crypt_stat->extent_size,
-					enc_extent_page,
+	rc = ecryptfs_decrypt_page_offset(crypt_stat, page, enc_extent_page,
 					extent_offset * crypt_stat->extent_size,
 					crypt_stat->extent_size, extent_iv);
 	if (rc < 0) {
@@ -716,9 +710,8 @@ out:
  * ecryptfs_encrypt_page_offset
  * @crypt_stat: The cryptographic context
  * @dst_page: The page to encrypt into
- * @dst_offset: The offset in the page to encrypt into
  * @src_page: The page to encrypt from
- * @src_offset: The offset in the page to encrypt from
+ * @offset: The byte offset into the dst_page and src_page
  * @size: The number of bytes to encrypt
  * @iv: The initialization vector to use for the encryption
  *
@@ -726,17 +719,16 @@ out:
  */
 static int
 ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, int dst_offset,
-			     struct page *src_page, int src_offset, int size,
-			     unsigned char *iv)
+			     struct page *dst_page, struct page *src_page,
+			     int offset, int size, unsigned char *iv)
 {
 	struct scatterlist src_sg, dst_sg;
 
 	sg_init_table(&src_sg, 1);
 	sg_init_table(&dst_sg, 1);
 
-	sg_set_page(&src_sg, src_page, size, src_offset);
-	sg_set_page(&dst_sg, dst_page, size, dst_offset);
+	sg_set_page(&src_sg, src_page, size, offset);
+	sg_set_page(&dst_sg, dst_page, size, offset);
 	return encrypt_scatterlist(crypt_stat, &dst_sg, &src_sg, size, iv);
 }
 
@@ -744,9 +736,8 @@ ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
  * ecryptfs_decrypt_page_offset
  * @crypt_stat: The cryptographic context
  * @dst_page: The page to decrypt into
- * @dst_offset: The offset in the page to decrypt into
  * @src_page: The page to decrypt from
- * @src_offset: The offset in the page to decrypt from
+ * @offset: The byte offset into the dst_page and src_page
  * @size: The number of bytes to decrypt
  * @iv: The initialization vector to use for the decryption
  *
@@ -754,17 +745,16 @@ ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
  */
 static int
 ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, int dst_offset,
-			     struct page *src_page, int src_offset, int size,
-			     unsigned char *iv)
+			     struct page *dst_page, struct page *src_page,
+			     int offset, int size, unsigned char *iv)
 {
 	struct scatterlist src_sg, dst_sg;
 
 	sg_init_table(&src_sg, 1);
-	sg_set_page(&src_sg, src_page, size, src_offset);
+	sg_set_page(&src_sg, src_page, size, offset);
 
 	sg_init_table(&dst_sg, 1);
-	sg_set_page(&dst_sg, dst_page, size, dst_offset);
+	sg_set_page(&dst_sg, dst_page, size, offset);
 
 	return decrypt_scatterlist(crypt_stat, &dst_sg, &src_sg, size, iv);
 }
-- 
1.8.1.2
