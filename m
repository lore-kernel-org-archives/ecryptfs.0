From: Will Morrison <camocrazed@gmail.com>
Subject: Re: [PATCH 3/3] eCryptfs: Enable GCM support in eCryptfs
Date: Tue, 18 Mar 2014 00:26:38 -0400
Message-ID: <5327CAFE.4030501@gmail.com>
References: <53136FFA.3050707@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44083 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaCRE0i (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 18 Mar 2014 00:26:38 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so6194597ieb.26
        for <ecryptfs@vger.kernel.org>; Mon, 17 Mar 2014 21:26:37 -0700 (PDT)
In-Reply-To: <53136FFA.3050707@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

We got some more feedback on our recent patch from Taylor Hornby, who pointed out
the previous issue with IVs. It turns out our solution to that introduced another
issue. In CBC mode, the generation of IVs includes the extent offset, which has
the effect that if someone reorders the extents in a file, they will fail to
decrypt properly. With GCM and the new IV behaviour, there was no such protection
from reordering of extents within a file.

Our solution to this is to set associated data to include the extent number,
which will cause integrity checks to fail and errors to be returned if extents
are reordered within a file. The following patch should replace 3/3 in this
patchset.

This patch adds support for GCM as a cipher mode in eCryptfs. If a file
is encrypted in this mode, the layout of the lower file will change to
accomodate it. This is due to the need to store auth tags and IVs as well as
encrypted data.

The file layout being used is as follows. After the header, the first
extent will hold IVs and auth tags. After this metadata extent, data extents are
written until the first metadata extent becomes full, at which point
another metadata extent is created, and subsequent data extents have
auth tags and IVs stored in that new extent until it fills up, etc. The last
extent in the file should always be a data extent, except in the case of
a zero length upper file, in which case it is the header. This makes it
so that the lower file will never have a case where it needs to move
extents around or have large gaps in the file.

Signed-off-by: Alvin Tran <althaitran@gmail.com>
Signed-off-by: Michael Chang <thenewme91@gmail.com>
Signed-off-by: William Morrison <camocrazed@gmail.com>
Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 fs/ecryptfs/Kconfig           |   1 +
 fs/ecryptfs/crypto.c          | 483 +++++++++++++++++++++++++++++++++++++++---
 fs/ecryptfs/ecryptfs_kernel.h |   9 +-
 fs/ecryptfs/inode.c           |  18 +-
 fs/ecryptfs/main.c            |   2 +-
 fs/ecryptfs/super.c           |   3 +
 include/linux/ecryptfs.h      |   1 +
 7 files changed, 479 insertions(+), 38 deletions(-)

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
index 3e4fcb9..c544e5a 100644
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
@@ -328,7 +328,115 @@ static void extent_crypt_complete(struct crypto_async_request *req, int rc)
 }
 
 /**
- * crypt_scatterlist
+ * crypt_scatterlist_aead
+ * @crypt_stat: Pointer to the crypt_stat struct to initialize.
+ * @dst_sg: Destination of the data after performing the crypto operation
+ * @src_sg: Data to be encrypted or decrypted
+ * @data_size: Length of data
+ * @assoc_sg: scatterlist to include as associated data
+ * @assoc_size: size of associated data
+ * @iv: IV to use
+ * @op: ENCRYPT or DECRYPT to indicate the desired operation
+ *
+ * Returns the number of bytes encrypted or decrypted; negative value on error
+ */
+static int crypt_scatterlist_aead(struct ecryptfs_crypt_stat *crypt_stat,
+				  struct scatterlist *dst_sg,
+				  struct scatterlist *src_sg, int data_size,
+				  struct scatterlist *assoc_sg, int assoc_size,
+				  unsigned char *iv, int op)
+{
+	struct aead_request *aead_req = NULL;
+	struct extent_crypt_result ecr;
+	int rc = 0;
+
+	BUG_ON(!crypt_stat || !crypt_stat->tfm
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
+	if (unlikely(ecryptfs_verbosity > 0)) {
+		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
+				crypt_stat->key_size);
+		ecryptfs_dump_hex(crypt_stat->key,
+				  crypt_stat->key_size);
+	}
+
+	init_completion(&ecr.completion);
+
+	mutex_lock(&crypt_stat->cs_tfm_mutex);
+	aead_req = aead_request_alloc((struct crypto_aead *)
+					crypt_stat->tfm,
+					GFP_NOFS);
+	if (!aead_req) {
+		mutex_unlock(&crypt_stat->cs_tfm_mutex);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	aead_request_set_callback(aead_req,
+		CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+		extent_crypt_complete, &ecr);
+
+	/* Consider doing this once, when the file is opened */
+	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
+
+		rc = crypto_aead_setkey(
+				(struct crypto_aead *)
+				crypt_stat->tfm,
+				crypt_stat->key,
+				crypt_stat->key_size);
+
+		if (rc) {
+			ecryptfs_printk(KERN_ERR,
+					"Error setting key; rc = [%d]\n",
+					rc);
+			mutex_unlock(&crypt_stat->cs_tfm_mutex);
+			rc = -EINVAL;
+			goto out;
+		}
+		crypt_stat->flags |= ECRYPTFS_KEY_SET;
+
+		rc = crypto_aead_setauthsize(
+			(struct crypto_aead *) crypt_stat->tfm,
+			ECRYPTFS_GCM_TAG_SIZE);
+		if (rc) {
+			ecryptfs_printk(KERN_ERR,
+				"Error setting auth size; rc = [%d]\n",
+				rc);
+			mutex_unlock(&crypt_stat->cs_tfm_mutex);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+	mutex_unlock(&crypt_stat->cs_tfm_mutex);
+
+	if (op == DECRYPT)
+		data_size += ECRYPTFS_GCM_TAG_SIZE;
+
+	aead_request_set_crypt(aead_req, src_sg, dst_sg, data_size, iv);
+	aead_request_set_assoc(aead_req, assoc_sg,
+		assoc_size);
+
+	if (op == ENCRYPT)
+		rc = crypto_aead_encrypt(aead_req);
+	else
+		rc = crypto_aead_decrypt(aead_req);
+
+	if (rc == -EINPROGRESS || rc == -EBUSY) {
+		struct extent_crypt_result *ecr;
+
+		ecr = aead_req->base.data;
+
+		wait_for_completion(&ecr->completion);
+		rc = ecr->rc;
+		reinit_completion(&ecr->completion);
+	}
+out:
+	aead_request_free(aead_req);
+	return rc;
+}
+
+
+/**
+ * crypt_scatterlist_ablk
  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
  * @dst_sg: Destination of the data after performing the crypto operation
  * @src_sg: Data to be encrypted or decrypted
@@ -338,7 +446,7 @@ static void extent_crypt_complete(struct crypto_async_request *req, int rc)
  *
  * Returns the number of bytes encrypted or decrypted; negative value on error
  */
-static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
+static int crypt_scatterlist_ablk(struct ecryptfs_crypt_stat *crypt_stat,
 			     struct scatterlist *dst_sg,
 			     struct scatterlist *src_sg, int size,
 			     unsigned char *iv, int op)
@@ -359,7 +467,8 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	init_completion(&ecr.completion);
 
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	req = ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
+	req = ablkcipher_request_alloc((struct crypto_ablkcipher *)
+					crypt_stat->tfm, GFP_NOFS);
 	if (!req) {
 		mutex_unlock(&crypt_stat->cs_tfm_mutex);
 		rc = -ENOMEM;
@@ -371,7 +480,8 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 			extent_crypt_complete, &ecr);
 	/* Consider doing this once, when the file is opened */
 	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
-		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
+		rc = crypto_ablkcipher_setkey((struct crypto_ablkcipher *)
+					      crypt_stat->tfm, crypt_stat->key,
 					      crypt_stat->key_size);
 		if (rc) {
 			ecryptfs_printk(KERN_ERR,
@@ -412,7 +522,87 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
 }
 
 /**
- * crypt_extent
+ * crypt_extent_aead
+ * @crypt_stat: crypt_stat containing cryptographic context for the
+ *              encryption operation
+ * @dst_page: The page to write the result into
+ * @src_page: The page to read from
+ * @tag_data: Array of auth tags for the page
+ * @iv_data: Array of iv's for the page
+ * @extent_offset: Page extent offset for use with tag_data and iv_data
+ * @op: ENCRYPT or DECRYPT to indicate the desired operation
+ *
+ * Encrypts or decrypts one extent of data.
+ *
+ * Return zero on success; non-zero otherwise
+ */
+static int crypt_extent_aead(struct ecryptfs_crypt_stat *crypt_stat,
+				struct page *dst_page,
+				struct page *src_page,
+				u8 *tag_data, u8 *iv_data,
+				unsigned long extent_offset, int op)
+{
+	pgoff_t page_index = op == ENCRYPT ? src_page->index : dst_page->index;
+	loff_t extent_num;
+	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
+	struct scatterlist src_sg[2];
+	struct scatterlist dst_sg[2];
+	struct scatterlist assoc_sg;
+	size_t extent_size = crypt_stat->extent_size;
+	u8 tag_data_src[ECRYPTFS_GCM_TAG_SIZE] = {0};
+	u8 tag_data_dst[ECRYPTFS_GCM_TAG_SIZE] = {0};
+	int rc;
+
+	extent_num = (((loff_t)page_index) * (PAGE_CACHE_SIZE / extent_size)) +
+		      extent_offset;
+
+	if (op == ENCRYPT) {
+		get_random_bytes(extent_iv, ECRYPTFS_MAX_IV_BYTES);
+	} else if (op == DECRYPT) {
+		unsigned long offset = ECRYPTFS_MAX_IV_BYTES * extent_offset;
+		memcpy(extent_iv, iv_data + offset, ECRYPTFS_MAX_IV_BYTES);
+		offset = ECRYPTFS_GCM_TAG_SIZE * extent_offset;
+		memcpy(tag_data_src, tag_data + offset, ECRYPTFS_GCM_TAG_SIZE);
+	}
+
+	sg_init_table(&src_sg[0], 2);
+	sg_init_table(&dst_sg[0], 2);
+
+	sg_set_page(&src_sg[0], src_page, extent_size,
+		extent_offset * extent_size);
+	sg_set_buf(&src_sg[1], tag_data_src, ARRAY_SIZE(tag_data_src));
+
+	sg_set_page(&dst_sg[0], dst_page, extent_size,
+		extent_offset * extent_size);
+	sg_set_buf(&dst_sg[1], tag_data_dst, ARRAY_SIZE(tag_data_dst));
+
+	sg_init_one(&assoc_sg, &extent_num, sizeof(extent_num));
+
+	rc = crypt_scatterlist_aead(crypt_stat, &dst_sg[0], &src_sg[0],
+					extent_size, &assoc_sg,
+					sizeof(extent_num), extent_iv, op);
+
+	if (rc < 0) {
+		printk(KERN_ERR "%s: Error attempting to crypt page with "
+		       "page_index = [%ld], extent_offset = [%ld]; "
+		       "rc = [%d]\n", __func__, page_index, extent_offset, rc);
+		goto out;
+	}
+	rc = 0;
+
+	if (op == ENCRYPT) {
+		unsigned long offset = ECRYPTFS_GCM_TAG_SIZE * extent_offset;
+		memcpy(tag_data + offset, tag_data_dst, ECRYPTFS_GCM_TAG_SIZE);
+
+		offset = ECRYPTFS_MAX_IV_BYTES * extent_offset;
+		memcpy(iv_data + offset, extent_iv, ECRYPTFS_MAX_IV_BYTES);
+	}
+out:
+	return rc;
+}
+
+/**
+ * crypt_extent_ablk
  * @crypt_stat: crypt_stat containing cryptographic context for the
  *              encryption operation
  * @dst_page: The page to write the result into
@@ -424,7 +614,7 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
  *
  * Return zero on success; non-zero otherwise
  */
-static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
+static int crypt_extent_ablk(struct ecryptfs_crypt_stat *crypt_stat,
 			struct page *dst_page,
 			struct page *src_page,
 			unsigned long extent_offset, int op)
@@ -437,6 +627,7 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 	int rc;
 
 	extent_base = (((loff_t)page_index) * (PAGE_CACHE_SIZE / extent_size));
+
 	rc = ecryptfs_derive_iv(extent_iv, crypt_stat,
 				(extent_base + extent_offset));
 	if (rc) {
@@ -454,7 +645,7 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 	sg_set_page(&dst_sg, dst_page, extent_size,
 		    extent_offset * extent_size);
 
-	rc = crypt_scatterlist(crypt_stat, &dst_sg, &src_sg, extent_size,
+	rc = crypt_scatterlist_ablk(crypt_stat, &dst_sg, &src_sg, extent_size,
 			       extent_iv, op);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to crypt page with "
@@ -487,16 +678,29 @@ int ecryptfs_encrypt_page(struct page *page)
 {
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
+	struct ecryptfs_extent_metadata extent_metadata;
 	char *enc_extent_virt;
 	struct page *enc_extent_page = NULL;
 	loff_t extent_offset;
 	loff_t lower_offset;
 	int rc = 0;
+	int data_extent_num;
+	int num_extents;
+	int meta_extent_num;
+	int metadata_per_extent;
+	u8 cipher_mode_code;
+	u8 *tag_data = NULL;
+	u8 *iv_data = NULL;
 
 	ecryptfs_inode = page->mapping->host;
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
+	num_extents = PAGE_CACHE_SIZE / crypt_stat->extent_size;
+	cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+		crypt_stat->cipher_mode);
+	metadata_per_extent = crypt_stat->extent_size / sizeof(extent_metadata);
+
 	enc_extent_page = alloc_page(GFP_USER);
 	if (!enc_extent_page) {
 		rc = -ENOMEM;
@@ -505,11 +709,39 @@ int ecryptfs_encrypt_page(struct page *page)
 		goto out;
 	}
 
+
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		/* Make sure iv_data and tag_data are not the same pointer */
+		tag_data = kmalloc(num_extents * ECRYPTFS_GCM_TAG_SIZE,
+				GFP_KERNEL);
+		if (!tag_data) {
+			rc = -ENOMEM;
+			ecryptfs_printk(KERN_ERR, "Error allocating memory for "
+					"auth_tag\n");
+			goto out;
+		}
+
+		iv_data = kmalloc(num_extents * ECRYPTFS_MAX_IV_BYTES,
+				GFP_KERNEL);
+		if (!iv_data) {
+			rc = -ENOMEM;
+			ecryptfs_printk(KERN_ERR, "Error allocating memory for "
+					"iv_data\n");
+			goto out;
+		}
+	}
+
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = crypt_extent(crypt_stat, enc_extent_page, page,
-				  extent_offset, ENCRYPT);
+		if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+			rc = crypt_extent_aead(crypt_stat, enc_extent_page,
+					       page, tag_data, iv_data,
+					       extent_offset, ENCRYPT);
+		} else {
+			rc = crypt_extent_ablk(crypt_stat, enc_extent_page,
+				page, extent_offset, ENCRYPT);
+		}
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -517,22 +749,82 @@ int ecryptfs_encrypt_page(struct page *page)
 		}
 	}
 
-	lower_offset = lower_offset_for_page(crypt_stat, page);
-	enc_extent_virt = kmap(enc_extent_page);
-	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
-				  PAGE_CACHE_SIZE);
-	kunmap(enc_extent_page);
-	if (rc < 0) {
-		ecryptfs_printk(KERN_ERR,
-			"Error attempting to write lower page; rc = [%d]\n",
-			rc);
-		goto out;
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		for (extent_offset = 0; extent_offset < num_extents;
+			extent_offset++) {
+
+			/*
+			 * Lower offset must take into account the number of
+			 * data extents, auth tag extents, and header size.
+			 */
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			data_extent_num = (page->index * num_extents);
+			data_extent_num += extent_offset;
+			lower_offset += data_extent_num
+				* crypt_stat->extent_size;
+			meta_extent_num = data_extent_num
+				/ metadata_per_extent;
+			lower_offset += (meta_extent_num + 1)
+				* crypt_stat->extent_size;
+
+			enc_extent_virt = kmap(enc_extent_page);
+			rc = ecryptfs_write_lower(ecryptfs_inode,
+					enc_extent_virt + (extent_offset
+						* crypt_stat->extent_size),
+					lower_offset,
+					crypt_stat->extent_size);
+			kunmap(enc_extent_page);
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to write lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			}
+
+			memcpy(extent_metadata.iv_bytes, iv_data +
+				ECRYPTFS_MAX_IV_BYTES * extent_offset,
+				ECRYPTFS_MAX_IV_BYTES);
+			memcpy(extent_metadata.auth_tag_bytes, tag_data +
+				ECRYPTFS_GCM_TAG_SIZE * extent_offset,
+				ECRYPTFS_GCM_TAG_SIZE);
+
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			lower_offset += meta_extent_num *
+				(metadata_per_extent + 1) *
+				crypt_stat->extent_size;
+			lower_offset += (data_extent_num % metadata_per_extent)
+				* sizeof(extent_metadata);
+
+			rc = ecryptfs_write_lower(ecryptfs_inode,
+					(void *) &extent_metadata,
+					lower_offset,
+					sizeof(extent_metadata));
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to write lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			}
+		}
+	} else {
+		lower_offset = lower_offset_for_page(crypt_stat, page);
+		enc_extent_virt = kmap(enc_extent_page);
+		rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt,
+					lower_offset, PAGE_CACHE_SIZE);
+		kunmap(enc_extent_page);
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
 	if (enc_extent_page) {
 		__free_page(enc_extent_page);
 	}
+	kfree(tag_data);
+	kfree(iv_data);
 	return rc;
 }
 
@@ -556,33 +848,134 @@ int ecryptfs_decrypt_page(struct page *page)
 {
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
+	struct ecryptfs_extent_metadata extent_metadata;
 	char *page_virt;
 	unsigned long extent_offset;
 	loff_t lower_offset;
 	int rc = 0;
+	int num_extents;
+	int num_valid_extents = 0;
+	int data_extent_num;
+	int meta_extent_num;
+	int metadata_per_extent;
+	u8 cipher_mode_code;
+	u8 *tag_data = NULL;
+	u8 *iv_data = NULL;
 
 	ecryptfs_inode = page->mapping->host;
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
-	lower_offset = lower_offset_for_page(crypt_stat, page);
-	page_virt = kmap(page);
-	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_CACHE_SIZE,
-				 ecryptfs_inode);
-	kunmap(page);
-	if (rc < 0) {
-		ecryptfs_printk(KERN_ERR,
-			"Error attempting to read lower page; rc = [%d]\n",
-			rc);
-		goto out;
+	num_extents = PAGE_CACHE_SIZE / crypt_stat->extent_size;
+	metadata_per_extent = crypt_stat->extent_size / sizeof(extent_metadata);
+	cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+		crypt_stat->cipher_mode);
+
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		/* Make sure iv_data and tag_data are not the same pointer */
+		tag_data = kmalloc(num_extents * ECRYPTFS_GCM_TAG_SIZE,
+				GFP_KERNEL);
+		if (!tag_data) {
+			rc = -ENOMEM;
+			ecryptfs_printk(KERN_ERR, "Error allocating memory for "
+					"auth_tag\n");
+			goto out;
+		}
+
+		iv_data = kmalloc(num_extents * ECRYPTFS_MAX_IV_BYTES,
+			GFP_KERNEL);
+		if (!iv_data) {
+			rc = -ENOMEM;
+			ecryptfs_printk(KERN_ERR, "Error allocating memory for "
+					"iv_data\n");
+			goto out;
+		}
+
+		for (extent_offset = 0; extent_offset < num_extents;
+				extent_offset++) {
+
+			/*
+			 * Lower offset must take into account the number of
+			 * data extents, auth tag extents, and header size.
+			 */
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			data_extent_num = (page->index * num_extents);
+			data_extent_num += extent_offset;
+			lower_offset += data_extent_num
+				* crypt_stat->extent_size;
+			meta_extent_num = data_extent_num
+				/ metadata_per_extent;
+			lower_offset += (meta_extent_num + 1)
+				* crypt_stat->extent_size;
+
+			page_virt = kmap(page);
+			rc = ecryptfs_read_lower(page_virt +
+				(extent_offset * crypt_stat->extent_size),
+				lower_offset,
+				crypt_stat->extent_size,
+				ecryptfs_inode);
+			kunmap(page);
+
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to read lower"
+						"page; rc = [%d]\n", rc);
+				goto out;
+			} else if (rc == 0) {
+				break;
+			}
+
+			lower_offset = ecryptfs_lower_header_size(crypt_stat);
+			lower_offset += meta_extent_num *
+				(metadata_per_extent + 1) *
+				crypt_stat->extent_size;
+			lower_offset += (data_extent_num % metadata_per_extent)
+				* sizeof(extent_metadata);
+
+			rc = ecryptfs_read_lower((void *)&extent_metadata,
+					lower_offset,
+					sizeof(extent_metadata),
+					ecryptfs_inode);
+
+			memcpy(tag_data + ECRYPTFS_GCM_TAG_SIZE * extent_offset,
+				&(extent_metadata.auth_tag_bytes),
+				ECRYPTFS_GCM_TAG_SIZE);
+
+			memcpy(iv_data + ECRYPTFS_MAX_IV_BYTES * extent_offset,
+				&(extent_metadata.iv_bytes),
+				ECRYPTFS_MAX_IV_BYTES);
+
+			if (rc < 0) {
+				printk(KERN_ERR "Error attempting to read lower"
+						"page; rc = [%d]\n", rc);
+			}
+			num_valid_extents++;
+		}
+	} else {
+		lower_offset = lower_offset_for_page(crypt_stat, page);
+		page_virt = kmap(page);
+		rc = ecryptfs_read_lower(page_virt, lower_offset,
+					 PAGE_CACHE_SIZE, ecryptfs_inode);
+		kunmap(page);
+		if (rc < 0) {
+			ecryptfs_printk(KERN_ERR,
+				"Error attempting to read lower page; rc = [%d]\n",
+				rc);
+			goto out;
+		}
+		num_valid_extents = num_extents;
 	}
 
 	for (extent_offset = 0;
-	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
+	     extent_offset < num_valid_extents;
 	     extent_offset++) {
-		rc = crypt_extent(crypt_stat, page, page,
+		if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+			rc = crypt_extent_aead(crypt_stat, page, page,
+				  tag_data, iv_data, extent_offset, DECRYPT);
+		} else {
+			rc = crypt_extent_ablk(crypt_stat, page, page,
 				  extent_offset, DECRYPT);
+		}
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -590,6 +983,8 @@ int ecryptfs_decrypt_page(struct page *page)
 		}
 	}
 out:
+	kfree(tag_data);
+	kfree(iv_data);
 	return rc;
 }
 
@@ -608,6 +1003,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	char *full_alg_name;
 	int rc = -EINVAL;
+	int cipher_mode_code;
 
 	ecryptfs_printk(KERN_DEBUG,
 			"Initializing cipher [%s]; strlen = [%d]; "
@@ -624,7 +1020,16 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 						crypt_stat->cipher_mode);
 	if (rc)
 		goto out_unlock;
-	crypt_stat->tfm = crypto_alloc_ablkcipher(full_alg_name, 0, 0);
+	cipher_mode_code = ecryptfs_code_for_cipher_mode_string(
+		crypt_stat->cipher_mode);
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		crypt_stat->tfm = (struct crypto_tfm *)
+			crypto_alloc_aead(full_alg_name, 0, 0);
+	} else {
+		crypt_stat->tfm = (struct crypto_tfm *)
+			crypto_alloc_ablkcipher(full_alg_name, 0, 0);
+	}
+
 	if (IS_ERR(crypt_stat->tfm)) {
 		rc = PTR_ERR(crypt_stat->tfm);
 		crypt_stat->tfm = NULL;
@@ -633,7 +1038,14 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 				full_alg_name);
 		goto out_free;
 	}
-	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
+
+	if (cipher_mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+		crypto_aead_set_flags((struct crypto_aead *) crypt_stat->tfm,
+				CRYPTO_TFM_REQ_WEAK_KEY);
+	} else {
+		crypto_ablkcipher_set_flags((struct crypto_ablkcipher *)
+				crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
+	}
 	rc = 0;
 out_free:
 	kfree(full_alg_name);
@@ -972,6 +1384,7 @@ struct ecryptfs_cipher_mode_code_str_map_elem {
 static struct ecryptfs_cipher_mode_code_str_map_elem
 ecryptfs_cipher_mode_code_str_map[] = {
 	{"cbc", ECRYPTFS_CIPHER_MODE_CBC},
+	{"gcm", ECRYPTFS_CIPHER_MODE_GCM}
 };
 
 /**
@@ -999,7 +1412,7 @@ u8 ecryptfs_code_for_cipher_mode_string(char *mode_name)
 /**
  * ecryptfs_cipher_mode_code_to_string
  * @str: Destination to write out the cipher mode name
- * @cipher_code: The code to conver to cipher mode name string
+ * @cipher_mode_code: The code to conver to cipher mode name string
  *
  * Retruns zero in success
  */
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 392f710..19eeac2 100644
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
@@ -359,6 +360,12 @@ struct ecryptfs_sb_info {
 	struct backing_dev_info bdi;
 };
 
+/* extent metadata (for GCM) */
+struct ecryptfs_extent_metadata {
+	u8 iv_bytes[ECRYPTFS_MAX_IV_BYTES];
+	u8 auth_tag_bytes[ECRYPTFS_GCM_TAG_SIZE];
+};
+
 /* file private data. */
 struct ecryptfs_file_info {
 	struct file *wfi_file;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 87ad33e..1778539 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -720,15 +720,31 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
 			 loff_t upper_size)
 {
 	loff_t lower_size;
+	int mode_code = ecryptfs_code_for_cipher_mode_string(
+			crypt_stat->cipher_mode);
 
 	lower_size = ecryptfs_lower_header_size(crypt_stat);
 	if (upper_size != 0) {
 		loff_t num_extents;
+		int metadata_per_extent;
+		struct ecryptfs_extent_metadata extent_metadata;
 
 		num_extents = upper_size >> crypt_stat->extent_shift;
+		metadata_per_extent = crypt_stat->extent_size
+				      / sizeof(extent_metadata);
+
 		if (upper_size & ~crypt_stat->extent_mask)
 			num_extents++;
-		lower_size += (num_extents * crypt_stat->extent_size);
+
+		if (mode_code == ECRYPTFS_CIPHER_MODE_GCM) {
+			lower_size +=
+				(num_extents +
+				((num_extents + metadata_per_extent - 1)
+				/ metadata_per_extent)) *
+				crypt_stat->extent_size;
+		} else {
+			lower_size += (num_extents * crypt_stat->extent_size);
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
1.8.3.2
