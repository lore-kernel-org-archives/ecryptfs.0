From: Tyler Hicks <tyhicks@canonical.com>
Subject: [RFC v2 1/1] eCryptfs: Use the ablkcipher crypto API
Date: Mon,  8 Apr 2013 21:39:49 -0700
Message-ID: <1365482389-4949-1-git-send-email-tyhicks@canonical.com>
References: <20130409043046.GA3795@boyd>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50209 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab3DIEj7 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 9 Apr 2013 00:39:59 -0400
In-Reply-To: <20130409043046.GA3795@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>, Thieu Le <thieule@google.com>, Li Wang <dragonylffly@163.com>, Zeev Zilberman <zeev@annapurnaLabs.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

Make the switch from the blkcipher kernel crypto interface to the
ablkcipher interface.

encrypt_scatterlist() and decrypt_scatterlist() now use the ablkcipher
interface but, from the eCryptfs standpoint, still treat the crypto
operation as a synchronous operation. They submit the async request and
then wait until the operation is finished before they return. Most of
the changes are contained inside those two functions.

Despite waiting for the completion of the crypto operation, the
ablkcipher interface provides performance increases in most cases when
used on AES-NI capable hardware. However, sequential I/O with one or two
threads on slow storage media does exhibit a sizeable decrease in
performance.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Ying Huang <ying.huang@intel.com>
Cc: Thieu Le <thieule@google.com>
Cc: Li Wang <dragonylffly@163.com>
Cc: Zeev Zilberman <zeev@annapurnaLabs.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
---

* Changes from v1:
  - Unlock cs_tfm_mutex if ablkcipher_request_alloc() fails
  - Add CRYPTO_TFM_REQ_MAY_SLEEP flag to the ablkcipher_request_set_callback()
    parameters

 fs/ecryptfs/crypto.c          | 143 ++++++++++++++++++++++++++++++------------
 fs/ecryptfs/ecryptfs_kernel.h |   3 +-
 2 files changed, 104 insertions(+), 42 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index d5c25db..76808e7 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -243,7 +243,7 @@ void ecryptfs_destroy_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
 
 	if (crypt_stat->tfm)
-		crypto_free_blkcipher(crypt_stat->tfm);
+		crypto_free_ablkcipher(crypt_stat->tfm);
 	if (crypt_stat->hash_tfm)
 		crypto_free_hash(crypt_stat->hash_tfm);
 	list_for_each_entry_safe(key_sig, key_sig_tmp,
@@ -319,6 +319,22 @@ int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
 	return i;
 }
 
+struct extent_crypt_result {
+	struct completion completion;
+	int rc;
+};
+
+static void extent_crypt_complete(struct crypto_async_request *req, int rc)
+{
+	struct extent_crypt_result *ecr = req->data;
+
+	if (rc == -EINPROGRESS)
+		return;
+
+	ecr->rc = rc;
+	complete(&ecr->completion);
+}
+
 /**
  * encrypt_scatterlist
  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
@@ -334,11 +350,8 @@ static int encrypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 			       struct scatterlist *src_sg, int size,
 			       unsigned char *iv)
 {
-	struct blkcipher_desc desc = {
-		.tfm = crypt_stat->tfm,
-		.info = iv,
-		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
-	};
+	struct ablkcipher_request *req = NULL;
+	struct extent_crypt_result ecr;
 	int rc = 0;
 
 	BUG_ON(!crypt_stat || !crypt_stat->tfm
@@ -349,24 +362,48 @@ static int encrypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 		ecryptfs_dump_hex(crypt_stat->key,
 				  crypt_stat->key_size);
 	}
-	/* Consider doing this once, when the file is opened */
+
+	init_completion(&ecr.completion);
+
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
-		rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
-					     crypt_stat->key_size);
-		crypt_stat->flags |= ECRYPTFS_KEY_SET;
-	}
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
-				rc);
+	req = ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
+	if (!req) {
 		mutex_unlock(&crypt_stat->cs_tfm_mutex);
-		rc = -EINVAL;
+		rc = -ENOMEM;
 		goto out;
 	}
-	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
-	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
+
+	ablkcipher_request_set_callback(req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			extent_crypt_complete, &ecr);
+	/* Consider doing this once, when the file is opened */
+	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
+		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
+					      crypt_stat->key_size);
+		if (rc) {
+			ecryptfs_printk(KERN_ERR,
+					"Error setting key; rc = [%d]\n",
+					rc);
+			mutex_unlock(&crypt_stat->cs_tfm_mutex);
+			rc = -EINVAL;
+			goto out;
+		}
+		crypt_stat->flags |= ECRYPTFS_KEY_SET;
+	}
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
+	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
+	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
+	rc = crypto_ablkcipher_encrypt(req);
+	if (rc == -EINPROGRESS || rc == -EBUSY) {
+		struct extent_crypt_result *ecr = req->base.data;
+
+		rc = wait_for_completion_interruptible(&ecr->completion);
+		if (!rc)
+			rc = ecr->rc;
+		INIT_COMPLETION(ecr->completion);
+	}
 out:
+	ablkcipher_request_free(req);
 	return rc;
 }
 
@@ -624,35 +661,60 @@ static int decrypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 			       struct scatterlist *src_sg, int size,
 			       unsigned char *iv)
 {
-	struct blkcipher_desc desc = {
-		.tfm = crypt_stat->tfm,
-		.info = iv,
-		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
-	};
+	struct ablkcipher_request *req = NULL;
+	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	/* Consider doing this once, when the file is opened */
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
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
-				     crypt_stat->key_size);
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
-				rc);
-		mutex_unlock(&crypt_stat->cs_tfm_mutex);
-		rc = -EINVAL;
+	req = ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
+	if (!req) {
+		rc = -ENOMEM;
 		goto out;
 	}
-	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
-	rc = crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
+
+	ablkcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+					extent_crypt_complete, &ecr);
+	/* Consider doing this once, when the file is opened */
+	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
+		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
+					      crypt_stat->key_size);
+		if (rc) {
+			ecryptfs_printk(KERN_ERR,
+					"Error setting key; rc = [%d]\n",
+					rc);
+			mutex_unlock(&crypt_stat->cs_tfm_mutex);
+			rc = -EINVAL;
+			goto out;
+		}
+		crypt_stat->flags |= ECRYPTFS_KEY_SET;
+	}
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error decrypting; rc = [%d]\n",
-				rc);
-		goto out;
+	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
+	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
+	rc = crypto_ablkcipher_decrypt(req);
+	if (rc == -EINPROGRESS || rc == -EBUSY) {
+		struct extent_crypt_result *ecr = req->base.data;
+
+		rc = wait_for_completion_interruptible(&ecr->completion);
+		if (!rc)
+			rc = ecr->rc;
+		INIT_COMPLETION(ecr->completion);
 	}
-	rc = size;
 out:
+	ablkcipher_request_free(req);
 	return rc;
+
 }
 
 /**
@@ -746,8 +808,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 						    crypt_stat->cipher, "cbc");
 	if (rc)
 		goto out_unlock;
-	crypt_stat->tfm = crypto_alloc_blkcipher(full_alg_name, 0,
-						 CRYPTO_ALG_ASYNC);
+	crypt_stat->tfm = crypto_alloc_ablkcipher(full_alg_name, 0, 0);
 	kfree(full_alg_name);
 	if (IS_ERR(crypt_stat->tfm)) {
 		rc = PTR_ERR(crypt_stat->tfm);
@@ -757,7 +818,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 				crypt_stat->cipher);
 		goto out_unlock;
 	}
-	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
+	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
 	rc = 0;
 out_unlock:
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index dd299b3..f622a73 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -38,6 +38,7 @@
 #include <linux/nsproxy.h>
 #include <linux/backing-dev.h>
 #include <linux/ecryptfs.h>
+#include <linux/crypto.h>
 
 #define ECRYPTFS_DEFAULT_IV_BYTES 16
 #define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
@@ -233,7 +234,7 @@ struct ecryptfs_crypt_stat {
 	size_t extent_shift;
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
-	struct crypto_blkcipher *tfm;
+	struct crypto_ablkcipher *tfm;
 	struct crypto_hash *hash_tfm; /* Crypto context for generating
 				       * the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
-- 
1.8.1.2
