From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4/4] eCryptfs: Make extent and scatterlist crypt function parameters similar
Date: Fri, 24 May 2013 17:05:11 -0700
Message-ID: <1369440311-10351-5-git-send-email-tyhicks@canonical.com>
References: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36708 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab3EYAF2 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 20:05:28 -0400
In-Reply-To: <1369440311-10351-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

The 'dest' abbreviation is only used in crypt_scatterlist(), while all
other functions in crypto.c use 'dst' so dest_sg should be renamed to
dst_sg.

The crypt_stat parameter is typically the first parameter in internal
eCryptfs functions so crypt_stat and dst_page should be swapped in
crypt_extent().

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 9947388..46a6f6a 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -330,7 +330,7 @@ static void extent_crypt_complete(struct crypto_async_request *req, int rc)
 /**
  * crypt_scatterlist
  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
- * @dest_sg: Destination of the data after performing the crypto operation
+ * @dst_sg: Destination of the data after performing the crypto operation
  * @src_sg: Data to be encrypted or decrypted
  * @size: Length of data
  * @iv: IV to use
@@ -339,7 +339,7 @@ static void extent_crypt_complete(struct crypto_async_request *req, int rc)
  * Returns the number of bytes encrypted or decrypted; negative value on error
  */
 static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct scatterlist *dest_sg,
+			     struct scatterlist *dst_sg,
 			     struct scatterlist *src_sg, int size,
 			     unsigned char *iv, int op)
 {
@@ -384,7 +384,7 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 		crypt_stat->flags |= ECRYPTFS_KEY_SET;
 	}
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
-	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
+	ablkcipher_request_set_crypt(req, src_sg, dst_sg, size, iv);
 	rc = op == ENCRYPT ? crypto_ablkcipher_encrypt(req) :
 			     crypto_ablkcipher_decrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY) {
@@ -413,9 +413,9 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
 
 /**
  * crypt_extent
- * @dst_page: The page to write the result into
  * @crypt_stat: crypt_stat containing cryptographic context for the
  *              encryption operation
+ * @dst_page: The page to write the result into
  * @src_page: The page to read from
  * @extent_offset: Page extent offset for use in generating IV
  * @op: ENCRYPT or DECRYPT to indicate the desired operation
@@ -424,8 +424,8 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
  *
  * Return zero on success; non-zero otherwise
  */
-static int crypt_extent(struct page *dst_page,
-			struct ecryptfs_crypt_stat *crypt_stat,
+static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
+			struct page *dst_page,
 			struct page *src_page,
 			unsigned long extent_offset, int op)
 {
@@ -508,7 +508,7 @@ int ecryptfs_encrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = crypt_extent(enc_extent_page, crypt_stat, page,
+		rc = crypt_extent(crypt_stat, enc_extent_page, page,
 				  extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
@@ -581,7 +581,7 @@ int ecryptfs_decrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = crypt_extent(page, crypt_stat, page,
+		rc = crypt_extent(crypt_stat, page, page,
 				  extent_offset, DECRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
-- 
1.8.1.2
