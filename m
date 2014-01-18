From: Will Morrison <camocrazed@gmail.com>
Subject: [RFC 3/3] Enable GCM support in eCryptfs
Date: Sat, 18 Jan 2014 14:26:41 -0500
Message-ID: <52DAD571.5070801@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53715 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaART0X (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 18 Jan 2014 14:26:23 -0500
Received: by mail-ie0-f180.google.com with SMTP id at1so3713516iec.25
        for <ecryptfs@vger.kernel.org>; Sat, 18 Jan 2014 11:26:23 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

This patch adds support for GCM as a cipher mode in eCryptfs. If a file
is encrypted in this mode, the layout of the lower file will change to
accomodate it. This is due to the need to store auth tags as well as
encrypted data.

The file layout being used is as follows. After the header, the first
extent will hold auth tags. After this auth tag extent, data extents are
written until the first auth tag extent becomes full, at which point
another auth tag extent is created, and subsequent data extents have
auth tags stored in that new extent until it fills up, etc. The last
extent in the file should always be a data extent, except in the case of
a zero length upper file, in which case it is the header. This makes it
so that the lower file will never have a case where it needs to move
extents around or have large gaps in the file.

Signed-off-by: Alvin Tran <althaitran@gmail.com>
Signed-off-by: Michael Chang <thenewme91@gmail.com>
Signed-off-by: William Morrison <camocrazed@gmail.com>
Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 fs/ecryptfs/Kconfig           |    1 +
 fs/ecryptfs/crypto.c          |  342 ++++++++++++++++++++++++++++++++++++-----
 fs/ecryptfs/ecryptfs_kernel.h |    3 +-
 fs/ecryptfs/inode.c           |   12 +-
 fs/ecryptfs/main.c            |    2 +-
 fs/ecryptfs/mmap.c            |    1 -
 fs/ecryptfs/super.c           |    3 +
 include/linux/ecryptfs.h      |    1 +
 8 files changed, 319 insertions(+), 46 deletions(-)

diff --git a/fs/ecryptfs/Kconfig b/fs/ecryptfs/Kconfig
index 434aa31..b11e555 100644
--- a/fs/ecryptfs/Kconfig
+++ b/fs/ecryptfs/Kconfig
@@ -4,6 +4,7 @@ config ECRYPT_FS
 	select CRYPTO_ECB
 	select CRYPTO_CBC
 	select CRYPTO_MD5
+	select CRYPTO_GCM
 	help
 	  Encrypted filesystem that operates on the VFS layer.  See
 	  <file:Documentation/filesystems/ecryptfs.txt> to learn more about
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 3e4fcb9..9ad18f9 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -235,7 +235,7 @@ void ecryptfs_destroy_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
 
 	if (crypt_stat->tfm)
-		crypto_free_ablkcipher(crypt_stat->tfm);
+		crypto_free_tfm(crypt_stat->tfm);
 	if (crypt_stat->hash_tfm)
 		crypto_free_hash(crypt_stat->hash_tfm);
 	list_for_each_entry_safe(key_sig, key_sig_tmp,
@@ -343,9 +343,16 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 			     struct scatterlist *src_sg, int size,
 			     unsigned char *iv, int op)
 {
-	struct ablkcipher_request *req = NULL;
+	struct ablkcipher_request *ablk_req = NULL;
+	struct aead_request *aead_req = NULL;
 	struct extent_crypt_result ecr;
 	int rc = 0;
+	int cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+			crypt_stat->cipher_mode);
+	u8 assoc_buf[ECRYPTFS_GCM_TAG_SIZE] = {0};
+	struct scatterlist assoc_sg;
+
+	sg_init_one(&assoc_sg, &assoc_buf[0], ARRAY_SIZE(assoc_buf));
 
 	BUG_ON(!crypt_stat || !crypt_stat->tfm
 	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
@@ -359,20 +366,46 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	init_completion(&ecr.completion);
 
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	req = ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
-	if (!req) {
+
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		aead_req = aead_request_alloc((struct crypto_aead *)
+				crypt_stat->tfm, GFP_NOFS);
+	} else {
+		ablk_req = ablkcipher_request_alloc((struct crypto_ablkcipher *)
+					crypt_stat->tfm, GFP_NOFS);
+	}
+
+	if (!ablk_req && !aead_req) {
 		mutex_unlock(&crypt_stat->cs_tfm_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	ablkcipher_request_set_callback(req,
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		aead_request_set_callback(aead_req,
 			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
 			extent_crypt_complete, &ecr);
+	} else {
+		ablkcipher_request_set_callback(ablk_req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			extent_crypt_complete, &ecr);
+	}
 	/* Consider doing this once, when the file is opened */
 	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
-		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
-					      crypt_stat->key_size);
+
+		if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+			rc = crypto_aead_setkey((struct crypto_aead *)
+					crypt_stat->tfm,
+					crypt_stat->key,
+					crypt_stat->key_size);
+		} else {
+			rc = crypto_ablkcipher_setkey(
+					(struct crypto_ablkcipher *)
+					crypt_stat->tfm,
+					crypt_stat->key,
+					crypt_stat->key_size);
+		}
+
 		if (rc) {
 			ecryptfs_printk(KERN_ERR,
 					"Error setting key; rc = [%d]\n",
@@ -382,20 +415,46 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 			goto out;
 		}
 		crypt_stat->flags |= ECRYPTFS_KEY_SET;
+		rc = crypto_aead_setauthsize(
+				(struct crypto_aead *)crypt_stat->tfm,
+				ECRYPTFS_GCM_TAG_SIZE);
 	}
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
-	ablkcipher_request_set_crypt(req, src_sg, dst_sg, size, iv);
-	rc = op == ENCRYPT ? crypto_ablkcipher_encrypt(req) :
-			     crypto_ablkcipher_decrypt(req);
+
+
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		if (op == DECRYPT)
+			size += ECRYPTFS_GCM_TAG_SIZE;
+		aead_request_set_crypt(aead_req, src_sg, dst_sg, size, iv);
+		aead_request_set_assoc(aead_req, &assoc_sg,
+			ARRAY_SIZE(assoc_buf));
+	} else {
+		ablkcipher_request_set_crypt(ablk_req,
+			src_sg,
+			dst_sg,
+			size,
+			iv);
+	}
+
+	if (op == ENCRYPT && cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM)
+		rc = crypto_aead_encrypt(aead_req);
+	else if (op == ENCRYPT)
+		rc = crypto_ablkcipher_encrypt(ablk_req);
+	else if (op == DECRYPT && cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM)
+		rc = crypto_aead_decrypt(aead_req);
+	else
+		rc = crypto_ablkcipher_decrypt(ablk_req);
+
 	if (rc == -EINPROGRESS || rc == -EBUSY) {
-		struct extent_crypt_result *ecr = req->base.data;
+		struct extent_crypt_result *ecr = ablk_req->base.data;
 
 		wait_for_completion(&ecr->completion);
 		rc = ecr->rc;
 		reinit_completion(&ecr->completion);
 	}
 out:
-	ablkcipher_request_free(req);
+	ablkcipher_request_free(ablk_req);
+	aead_request_free(aead_req);
 	return rc;
 }
 
@@ -427,12 +486,16 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
 static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 			struct page *dst_page,
 			struct page *src_page,
+			u8 *tag_data,
 			unsigned long extent_offset, int op)
 {
 	pgoff_t page_index = op == ENCRYPT ? src_page->index : dst_page->index;
 	loff_t extent_base;
 	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
-	struct scatterlist src_sg, dst_sg;
+	struct scatterlist src_sg[2];
+	struct scatterlist dst_sg[2];
+	u8 tag_data_src[ECRYPTFS_GCM_TAG_SIZE] = {0};
+	u8 tag_data_dst[ECRYPTFS_GCM_TAG_SIZE] = {0};
 	size_t extent_size = crypt_stat->extent_size;
 	int rc;
 
@@ -446,15 +509,24 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 		goto out;
 	}
 
-	sg_init_table(&src_sg, 1);
-	sg_init_table(&dst_sg, 1);
+	/* Copy the auth tag value from the auth tag page*/
+	if (op == DECRYPT) {
+		unsigned long offset = ECRYPTFS_GCM_TAG_SIZE * extent_offset;
+		memcpy(tag_data_src, tag_data + offset, ECRYPTFS_GCM_TAG_SIZE);
+
+	}
+
+	sg_init_table(&src_sg[0], 2); sg_init_table(&dst_sg[0], 2);
 
-	sg_set_page(&src_sg, src_page, extent_size,
+	sg_set_page(&src_sg[0], src_page, extent_size,
 		    extent_offset * extent_size);
-	sg_set_page(&dst_sg, dst_page, extent_size,
+	sg_set_buf(&src_sg[1], tag_data_src, ARRAY_SIZE(tag_data_src));
+
+	sg_set_page(&dst_sg[0], dst_page, extent_size,
 		    extent_offset * extent_size);
+	sg_set_buf(&dst_sg[1], tag_data_dst, ARRAY_SIZE(tag_data_dst));
 
-	rc = crypt_scatterlist(crypt_stat, &dst_sg, &src_sg, extent_size,
+	rc = crypt_scatterlist(crypt_stat, &dst_sg[0], &src_sg[0], extent_size,
 			       extent_iv, op);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to crypt page with "
@@ -462,6 +534,13 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 		       "rc = [%d]\n", __func__, page_index, extent_offset, rc);
 		goto out;
 	}
+
+	/* Copy the new auth tag value to the auth tag page */
+	if (op == ENCRYPT) {
+		unsigned long offset = ECRYPTFS_GCM_TAG_SIZE * extent_offset;
+		memcpy(tag_data + offset, tag_data_dst, ECRYPTFS_GCM_TAG_SIZE);
+	}
+
 	rc = 0;
 out:
 	return rc;
@@ -481,6 +560,12 @@ out:
  * file, 24K of page 0 of the lower file will be read and decrypted,
  * and then 8K of page 1 of the lower file will be read and decrypted.
  *
+ * For GCM encrypted files there are additional extents dedicated to holding
+ * auth tags. The first extent after the header will be an auth tag extent,
+ * which is followed by 256 data extents. 256 is the number of 16 byte auth tags
+ * that fit in an extent. When the 257th data extent is created, it is preceded
+ * by a second auth tag extent, and so on.
+ *
  * Returns zero on success; negative on error
  */
 int ecryptfs_encrypt_page(struct page *page)
@@ -491,12 +576,24 @@ int ecryptfs_encrypt_page(struct page *page)
 	struct page *enc_extent_page = NULL;
 	loff_t extent_offset;
 	loff_t lower_offset;
+	int num_extents;
+	u8 *tag_data;
+	u8 cipher_mode_code;
+	int data_extent_num;
+	int auth_extent_num;
+	int auth_tags_per_extent;
 	int rc = 0;
 
 	ecryptfs_inode = page->mapping->host;
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
+
+	num_extents = PAGE_CACHE_SIZE / crypt_stat->extent_size;
+	cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+		crypt_stat->cipher_mode);
+	auth_tags_per_extent = crypt_stat->extent_size / ECRYPTFS_GCM_TAG_SIZE;
+
 	enc_extent_page = alloc_page(GFP_USER);
 	if (!enc_extent_page) {
 		rc = -ENOMEM;
@@ -505,10 +602,20 @@ int ecryptfs_encrypt_page(struct page *page)
 		goto out;
 	}
 
+	tag_data = kmalloc(num_extents * ECRYPTFS_GCM_TAG_SIZE, GFP_KERNEL);
+
+	if (!tag_data) {
+		rc = -ENOMEM;
+		ecryptfs_printk(KERN_ERR, "Error allocating extra memory for "
+				"auth tag\n");
+		goto out;
+
+	}
+
 	for (extent_offset = 0;
-	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
+	     extent_offset < num_extents;
 	     extent_offset++) {
-		rc = crypt_extent(crypt_stat, enc_extent_page, page,
+		rc = crypt_extent(crypt_stat, enc_extent_page, page, tag_data,
 				  extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
@@ -517,22 +624,74 @@ int ecryptfs_encrypt_page(struct page *page)
 		}
 	}
 
-	lower_offset = lower_offset_for_page(crypt_stat, page);
 	enc_extent_virt = kmap(enc_extent_page);
-	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
-				  PAGE_CACHE_SIZE);
-	kunmap(enc_extent_page);
-	if (rc < 0) {
-		ecryptfs_printk(KERN_ERR,
-			"Error attempting to write lower page; rc = [%d]\n",
-			rc);
-		goto out;
+
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		for (extent_offset = 0; extent_offset < num_extents;
+			extent_offset++) {
+
+			/*
+			 * Lower offset must take into account the number of
+			 * data extents, auth tag extents, and header size.
+			 */
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			data_extent_num = (page->index * num_extents) + 1;
+			data_extent_num += extent_offset;
+			lower_offset += (data_extent_num - 1)
+				* crypt_stat->extent_size;
+			auth_extent_num = (data_extent_num
+				+ (auth_tags_per_extent - 1))
+				/ auth_tags_per_extent;
+			lower_offset += auth_extent_num
+				* crypt_stat->extent_size;
+
+			rc = ecryptfs_write_lower(ecryptfs_inode,
+					enc_extent_virt + (extent_offset
+						* crypt_stat->extent_size),
+					lower_offset,
+					crypt_stat->extent_size);
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to write lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			}
+
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			lower_offset += (auth_extent_num - 1) *
+				(auth_tags_per_extent + 1) *
+				crypt_stat->extent_size;
+
+			rc = ecryptfs_write_lower(ecryptfs_inode,
+					tag_data + (ECRYPTFS_GCM_TAG_SIZE
+						* extent_offset),
+					lower_offset,
+					ECRYPTFS_GCM_TAG_SIZE);
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to write lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			}
+		}
+	} else {
+		lower_offset = lower_offset_for_page(crypt_stat, page);
+		rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt,
+					lower_offset,
+					PAGE_CACHE_SIZE);
+		if (rc < 0) {
+			ecryptfs_printk(KERN_ERR,
+				"Error attempting to write lower page; rc = [%d]\n",
+				rc);
+			goto out;
+		}
 	}
+
 	rc = 0;
 out:
+	kunmap(enc_extent_page);
 	if (enc_extent_page) {
 		__free_page(enc_extent_page);
 	}
+	kfree(tag_data);
 	return rc;
 }
 
@@ -550,6 +709,12 @@ out:
  * file, 24K of page 0 of the lower file will be read and decrypted,
  * and then 8K of page 1 of the lower file will be read and decrypted.
  *
+ * For GCM encrypted files there are additional extents dedicated to holding
+ * auth tags. The first extent after the header will be an auth tag extent,
+ * which is followed by 256 data extents. 256 is the number of 16 byte auth tags
+ * that fit in an extent. When the 257th data extent is created, it is preceded
+ * by a second auth tag extent, and so on.
+ *
  * Returns zero on success; negative on error
  */
 int ecryptfs_decrypt_page(struct page *page)
@@ -559,6 +724,12 @@ int ecryptfs_decrypt_page(struct page *page)
 	char *page_virt;
 	unsigned long extent_offset;
 	loff_t lower_offset;
+	int num_extents;
+	u8 *tag_data;
+	u8 cipher_mode_code;
+	int data_extent_num;
+	int auth_extent_num;
+	int auth_tags_per_extent;
 	int rc = 0;
 
 	ecryptfs_inode = page->mapping->host;
@@ -566,30 +737,98 @@ int ecryptfs_decrypt_page(struct page *page)
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
+	num_extents = PAGE_CACHE_SIZE / crypt_stat->extent_size;
+	auth_tags_per_extent = crypt_stat->extent_size / ECRYPTFS_GCM_TAG_SIZE;
+	cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+		crypt_stat->cipher_mode);
+
+	tag_data = kmalloc(num_extents * ECRYPTFS_GCM_TAG_SIZE, GFP_KERNEL);
+
+	if (!tag_data) {
+		rc = -ENOMEM;
+		ecryptfs_printk(KERN_ERR, "Error allocating extra memory for "
+				"encrypted extent\n");
+		goto out;
+	}
+
 	lower_offset = lower_offset_for_page(crypt_stat, page);
 	page_virt = kmap(page);
-	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_CACHE_SIZE,
-				 ecryptfs_inode);
-	kunmap(page);
-	if (rc < 0) {
-		ecryptfs_printk(KERN_ERR,
-			"Error attempting to read lower page; rc = [%d]\n",
-			rc);
-		goto out;
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		for (extent_offset = 0; extent_offset < num_extents;
+				extent_offset++) {
+
+			/*
+			 * Lower offset must take into account the number of
+			 * data extents, auth tag extents, and header size.
+			 */
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			data_extent_num = (page->index * num_extents) + 1;
+			data_extent_num += extent_offset;
+			lower_offset += (data_extent_num - 1)
+				* crypt_stat->extent_size;
+			auth_extent_num = (data_extent_num +
+				(auth_tags_per_extent - 1))
+				/ auth_tags_per_extent;
+			lower_offset += auth_extent_num
+				* crypt_stat->extent_size;
+
+			rc = ecryptfs_read_lower(page_virt +
+				(extent_offset * crypt_stat->extent_size),
+				lower_offset,
+				crypt_stat->extent_size,
+				ecryptfs_inode);
+
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to read lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			}
+
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			lower_offset += (auth_extent_num - 1) *
+				(auth_tags_per_extent + 1) *
+				crypt_stat->extent_size;
+
+			rc = ecryptfs_read_lower(tag_data +
+					(ECRYPTFS_GCM_TAG_SIZE * extent_offset),
+					lower_offset,
+					ECRYPTFS_GCM_TAG_SIZE, ecryptfs_inode);
+
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to read lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			}
+		}
+	} else {
+		rc = ecryptfs_read_lower(page_virt, lower_offset,
+					PAGE_CACHE_SIZE,
+					ecryptfs_inode);
+		if (rc < 0) {
+			ecryptfs_printk(KERN_ERR,
+				"Error attempting to read lower page; rc = [%d]\n",
+				rc);
+			goto out;
+		}
 	}
 
 	for (extent_offset = 0;
-	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
+	     extent_offset < num_extents;
 	     extent_offset++) {
 		rc = crypt_extent(crypt_stat, page, page,
-				  extent_offset, DECRYPT);
+				tag_data + (ECRYPTFS_GCM_TAG_SIZE
+					* extent_offset),
+				extent_offset, DECRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
 			goto out;
 		}
 	}
+
 out:
+	kunmap(page);
+	kfree(tag_data);
 	return rc;
 }
 
@@ -608,6 +847,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	char *full_alg_name;
 	int rc = -EINVAL;
+	int cipher_mode_code;
 
 	ecryptfs_printk(KERN_DEBUG,
 			"Initializing cipher [%s]; strlen = [%d]; "
@@ -624,7 +864,17 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 						crypt_stat->cipher_mode);
 	if (rc)
 		goto out_unlock;
-	crypt_stat->tfm = crypto_alloc_ablkcipher(full_alg_name, 0, 0);
+
+	cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+		crypt_stat->cipher_mode);
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		crypt_stat->tfm = (struct crypto_tfm *)
+			crypto_alloc_aead(full_alg_name, 0, 0);
+	} else {
+		crypt_stat->tfm = (struct crypto_tfm *)
+			crypto_alloc_ablkcipher(full_alg_name, 0, 0);
+	}
+	kfree(full_alg_name);
 	if (IS_ERR(crypt_stat->tfm)) {
 		rc = PTR_ERR(crypt_stat->tfm);
 		crypt_stat->tfm = NULL;
@@ -633,7 +883,14 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 				full_alg_name);
 		goto out_free;
 	}
-	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		crypto_aead_set_flags((struct crypto_aead *) crypt_stat->tfm,
+				CRYPTO_TFM_REQ_WEAK_KEY);
+	} else {
+		crypto_ablkcipher_set_flags((struct crypto_ablkcipher *)
+					crypt_stat->tfm,
+					CRYPTO_TFM_REQ_WEAK_KEY);
+	}
 	rc = 0;
 out_free:
 	kfree(full_alg_name);
@@ -972,6 +1229,7 @@ struct ecryptfs_cipher_mode_code_str_map_elem {
 static struct ecryptfs_cipher_mode_code_str_map_elem
 ecryptfs_cipher_mode_code_str_map[] = {
 	{"cbc", ECRYPTFS_CIPHER_MODE_CBC},
+	{"gcm", ECRYPTFS_CIPHER_MODE_GCM}
 };
 
 /**
@@ -999,7 +1257,7 @@ u8 ecryptfs_code_for_cipher_mode_string(char *mode_name)
 /**
  * ecryptfs_cipher_mode_code_to_string
  * @str: Destination to write out the cipher mode name
- * @cipher_code: The code to conver to cipher mode name string
+ * @mode_code: The code to conver to cipher mode name string
  *
  * Retruns zero in success
  */
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 392f710..2d227e4 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -129,6 +129,7 @@ ecryptfs_get_key_payload_data(struct key *key)
 #define ECRYPTFS_MAX_NUM_ENC_KEYS 64
 #define ECRYPTFS_MAX_IV_BYTES 16	/* 128 bits */
 #define ECRYPTFS_SALT_BYTES 2
+#define ECRYPTFS_GCM_TAG_SIZE 16
 #define MAGIC_ECRYPTFS_MARKER 0x3c81b7f5
 #define MAGIC_ECRYPTFS_MARKER_SIZE_BYTES 8	/* 4*2 */
 #define ECRYPTFS_FILE_SIZE_BYTES (sizeof(u64))
@@ -236,7 +237,7 @@ struct ecryptfs_crypt_stat {
 	size_t extent_shift;
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
-	struct crypto_ablkcipher *tfm;
+	struct crypto_tfm *tfm;
 	struct crypto_hash *hash_tfm; /* Crypto context for generating
 				       * the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 87ad33e..41cd682 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -720,6 +720,8 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
 			 loff_t upper_size)
 {
 	loff_t lower_size;
+	int mode_code = ecryptfs_code_for_cipher_mode_string(
+			crypt_stat->cipher_mode);
 
 	lower_size = ecryptfs_lower_header_size(crypt_stat);
 	if (upper_size != 0) {
@@ -728,7 +730,15 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
 		num_extents = upper_size >> crypt_stat->extent_shift;
 		if (upper_size & ~crypt_stat->extent_mask)
 			num_extents++;
-		lower_size += (num_extents * crypt_stat->extent_size);
+
+		if (mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+			lower_size +=
+				(num_extents + ((num_extents + 255) >> 8)) *
+				crypt_stat->extent_size;
+		} else {
+			lower_size += num_extents * crypt_stat->extent_size;
+
+		}
 	}
 	return lower_size;
 }
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 0e912f7..7c087ef 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -260,7 +260,7 @@ static void ecryptfs_init_mount_crypt_stat(
 static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 				  uid_t *check_ruid)
 {
-	const char *mode_white_list[] = {"cbc"};
+	const char *mode_white_list[] = {"cbc", "gcm"};
 	char *p;
 	int i = 0;
 	int rc = 0;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 564a1fa..5e9acbd 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -163,7 +163,6 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
 			loff_t lower_offset =
 				((view_extent_num * crypt_stat->extent_size)
 				 - crypt_stat->metadata_size);
-
 			rc = ecryptfs_read_lower_page_segment(
 				page, (lower_offset >> PAGE_CACHE_SHIFT),
 				(lower_offset & ~PAGE_CACHE_MASK),
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index e879cf8..54d61f9 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -164,6 +164,9 @@ static int ecryptfs_show_options(struct seq_file *m, struct dentry *root)
 	seq_printf(m, ",ecryptfs_cipher=%s",
 		mount_crypt_stat->global_default_cipher_name);
 
+	seq_printf(m, ",ecryptfs_cipher_mode=%s",
+		mount_crypt_stat->global_default_cipher_mode_name);
+
 	if (mount_crypt_stat->global_default_cipher_key_size)
 		seq_printf(m, ",ecryptfs_key_bytes=%zd",
 			   mount_crypt_stat->global_default_cipher_key_size);
diff --git a/include/linux/ecryptfs.h b/include/linux/ecryptfs.h
index 8244e03..770ee13 100644
--- a/include/linux/ecryptfs.h
+++ b/include/linux/ecryptfs.h
@@ -45,6 +45,7 @@
 #define RFC2440_CIPHER_RSA 0x01
 
 #define ECRYPTFS_CIPHER_MODE_CBC 0x01
+#define ECRYPTFS_CIPHER_MODE_GCM 0x02
 
 /**
  * For convenience, we may need to pass around the encrypted session
-- 
1.7.10.4
