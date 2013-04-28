From: Zeev Zilberman <zeev@annapurnaLabs.com>
Subject: Re: [RFC v3 1/1] eCryptfs: Use the ablkcipher crypto API
Date: Sun, 28 Apr 2013 07:37:43 +0000
Message-ID: <CDA2AA4E.40C38%zeev@annapurnalabs.com>
References: <1365534479-13202-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:2199 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538Ab3D1Hhu convert rfc822-to-8bit
	(ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 28 Apr 2013 03:37:50 -0400
In-Reply-To: <1365534479-13202-1-git-send-email-tyhicks@canonical.com>
Content-Language: en-US
Content-ID: <E0931B0D0F5D914384F15A0D5CBD13B3@apcprd02.prod.outlook.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>
Cc: Colin King <colin.king@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>, Thieu Le <thieule@google.com>, Li Wang <dragonylffly@163.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

Hi Tyler,

The patch works well, except the use of
wait_for_completion_interruptible() which can cause crashes.
In case a signal is sent, the request is freed before the processing was
finished.
So, the driver can attempt to access a request that was already freed.

I think that regular wait_for_completion() should be used.

Zeev

On 4/9/13 10:07 PM, "Tyler Hicks" <tyhicks@canonical.com> wrote:

>Make the switch from the blkcipher kernel crypto interface to the
>ablkcipher interface.
>
>encrypt_scatterlist() and decrypt_scatterlist() now use the ablkcipher
>interface but, from the eCryptfs standpoint, still treat the crypto
>operation as a synchronous operation. They submit the async request and
>then wait until the operation is finished before they return. Most of
>the changes are contained inside those two functions.
>
>Despite waiting for the completion of the crypto operation, the
>ablkcipher interface provides performance increases in most cases when
>used on AES-NI capable hardware. However, sequential I/O with one or two
>threads on slow storage media does exhibit a sizeable decrease in
>performance.
>
>Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>Cc: Colin King <colin.king@canonical.com>
>Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>
>Cc: Tim Chen <tim.c.chen@intel.com>
>Cc: Ying Huang <ying.huang@intel.com>
>Cc: Thieu Le <thieule@google.com>
>Cc: Li Wang <dragonylffly@163.com>
>Cc: Zeev Zilberman <zeev@annapurnaLabs.com>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
>---
>
>* I only made the changes mentioned in RFC v2 to encrypt_scatterlist().
>This
>  patch also makes those same changes to decrypt_scatterlist():
>  - Unlock cs_tfm_mutex if ablkcipher_request_alloc() fails
>  - Add CRYPTO_TFM_REQ_MAY_SLEEP flag to the
>ablkcipher_request_set_callback()
>    parameters
>
>I won't have a chance to gather new performance numbers until later
>tonight or
>tomorrow morning.
>
> fs/ecryptfs/crypto.c          | 143
>++++++++++++++++++++++++++++++------------
> fs/ecryptfs/ecryptfs_kernel.h |   3 +-
> 2 files changed, 105 insertions(+), 41 deletions(-)
>
>diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
>index d5c25db..eb50bce 100644
>--- a/fs/ecryptfs/crypto.c
>+++ b/fs/ecryptfs/crypto.c
>@@ -243,7 +243,7 @@ void ecryptfs_destroy_crypt_stat(struct
>ecryptfs_crypt_stat *crypt_stat)
> 	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
> 
> 	if (crypt_stat->tfm)
>-		crypto_free_blkcipher(crypt_stat->tfm);
>+		crypto_free_ablkcipher(crypt_stat->tfm);
> 	if (crypt_stat->hash_tfm)
> 		crypto_free_hash(crypt_stat->hash_tfm);
> 	list_for_each_entry_safe(key_sig, key_sig_tmp,
>@@ -319,6 +319,22 @@ int virt_to_scatterlist(const void *addr, int size,
>struct scatterlist *sg,
> 	return i;
> }
> 
>+struct extent_crypt_result {
>+	struct completion completion;
>+	int rc;
>+};
>+
>+static void extent_crypt_complete(struct crypto_async_request *req, int
>rc)
>+{
>+	struct extent_crypt_result *ecr = req->data;
>+
>+	if (rc == -EINPROGRESS)
>+		return;
>+
>+	ecr->rc = rc;
>+	complete(&ecr->completion);
>+}
>+
> /**
>  * encrypt_scatterlist
>  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
>@@ -334,11 +350,8 @@ static int encrypt_scatterlist(struct
>ecryptfs_crypt_stat *crypt_stat,
> 			       struct scatterlist *src_sg, int size,
> 			       unsigned char *iv)
> {
>-	struct blkcipher_desc desc = {
>-		.tfm = crypt_stat->tfm,
>-		.info = iv,
>-		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
>-	};
>+	struct ablkcipher_request *req = NULL;
>+	struct extent_crypt_result ecr;
> 	int rc = 0;
> 
> 	BUG_ON(!crypt_stat || !crypt_stat->tfm
>@@ -349,24 +362,48 @@ static int encrypt_scatterlist(struct
>ecryptfs_crypt_stat *crypt_stat,
> 		ecryptfs_dump_hex(crypt_stat->key,
> 				  crypt_stat->key_size);
> 	}
>-	/* Consider doing this once, when the file is opened */
>+
>+	init_completion(&ecr.completion);
>+
> 	mutex_lock(&crypt_stat->cs_tfm_mutex);
>-	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>-		rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
>-					     crypt_stat->key_size);
>-		crypt_stat->flags |= ECRYPTFS_KEY_SET;
>-	}
>-	if (rc) {
>-		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
>-				rc);
>+	req = ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
>+	if (!req) {
> 		mutex_unlock(&crypt_stat->cs_tfm_mutex);
>-		rc = -EINVAL;
>+		rc = -ENOMEM;
> 		goto out;
> 	}
>-	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
>-	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
>+
>+	ablkcipher_request_set_callback(req,
>+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
>+			extent_crypt_complete, &ecr);
>+	/* Consider doing this once, when the file is opened */
>+	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>+		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
>+					      crypt_stat->key_size);
>+		if (rc) {
>+			ecryptfs_printk(KERN_ERR,
>+					"Error setting key; rc = [%d]\n",
>+					rc);
>+			mutex_unlock(&crypt_stat->cs_tfm_mutex);
>+			rc = -EINVAL;
>+			goto out;
>+		}
>+		crypt_stat->flags |= ECRYPTFS_KEY_SET;
>+	}
> 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
>+	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
>+	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
>+	rc = crypto_ablkcipher_encrypt(req);
>+	if (rc == -EINPROGRESS || rc == -EBUSY) {
>+		struct extent_crypt_result *ecr = req->base.data;
>+
>+		rc = wait_for_completion_interruptible(&ecr->completion);
>+		if (!rc)
>+			rc = ecr->rc;
>+		INIT_COMPLETION(ecr->completion);
>+	}
> out:
>+	ablkcipher_request_free(req);
> 	return rc;
> }
> 
>@@ -624,35 +661,62 @@ static int decrypt_scatterlist(struct
>ecryptfs_crypt_stat *crypt_stat,
> 			       struct scatterlist *src_sg, int size,
> 			       unsigned char *iv)
> {
>-	struct blkcipher_desc desc = {
>-		.tfm = crypt_stat->tfm,
>-		.info = iv,
>-		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
>-	};
>+	struct ablkcipher_request *req = NULL;
>+	struct extent_crypt_result ecr;
> 	int rc = 0;
> 
>-	/* Consider doing this once, when the file is opened */
>+	BUG_ON(!crypt_stat || !crypt_stat->tfm
>+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>+	if (unlikely(ecryptfs_verbosity > 0)) {
>+		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
>+				crypt_stat->key_size);
>+		ecryptfs_dump_hex(crypt_stat->key,
>+				  crypt_stat->key_size);
>+	}
>+
>+	init_completion(&ecr.completion);
>+
> 	mutex_lock(&crypt_stat->cs_tfm_mutex);
>-	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
>-				     crypt_stat->key_size);
>-	if (rc) {
>-		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
>-				rc);
>+	req = ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
>+	if (!req) {
> 		mutex_unlock(&crypt_stat->cs_tfm_mutex);
>-		rc = -EINVAL;
>+		rc = -ENOMEM;
> 		goto out;
> 	}
>-	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
>-	rc = crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
>+
>+	ablkcipher_request_set_callback(req,
>+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
>+			extent_crypt_complete, &ecr);
>+	/* Consider doing this once, when the file is opened */
>+	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>+		rc = crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
>+					      crypt_stat->key_size);
>+		if (rc) {
>+			ecryptfs_printk(KERN_ERR,
>+					"Error setting key; rc = [%d]\n",
>+					rc);
>+			mutex_unlock(&crypt_stat->cs_tfm_mutex);
>+			rc = -EINVAL;
>+			goto out;
>+		}
>+		crypt_stat->flags |= ECRYPTFS_KEY_SET;
>+	}
> 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
>-	if (rc) {
>-		ecryptfs_printk(KERN_ERR, "Error decrypting; rc = [%d]\n",
>-				rc);
>-		goto out;
>+	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
>+	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
>+	rc = crypto_ablkcipher_decrypt(req);
>+	if (rc == -EINPROGRESS || rc == -EBUSY) {
>+		struct extent_crypt_result *ecr = req->base.data;
>+
>+		rc = wait_for_completion_interruptible(&ecr->completion);
>+		if (!rc)
>+			rc = ecr->rc;
>+		INIT_COMPLETION(ecr->completion);
> 	}
>-	rc = size;
> out:
>+	ablkcipher_request_free(req);
> 	return rc;
>+
> }
> 
> /**
>@@ -746,8 +810,7 @@ int ecryptfs_init_crypt_ctx(struct
>ecryptfs_crypt_stat *crypt_stat)
> 						    crypt_stat->cipher, "cbc");
> 	if (rc)
> 		goto out_unlock;
>-	crypt_stat->tfm = crypto_alloc_blkcipher(full_alg_name, 0,
>-						 CRYPTO_ALG_ASYNC);
>+	crypt_stat->tfm = crypto_alloc_ablkcipher(full_alg_name, 0, 0);
> 	kfree(full_alg_name);
> 	if (IS_ERR(crypt_stat->tfm)) {
> 		rc = PTR_ERR(crypt_stat->tfm);
>@@ -757,7 +820,7 @@ int ecryptfs_init_crypt_ctx(struct
>ecryptfs_crypt_stat *crypt_stat)
> 				crypt_stat->cipher);
> 		goto out_unlock;
> 	}
>-	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
>+	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
> 	rc = 0;
> out_unlock:
> 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
>diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
>index dd299b3..f622a73 100644
>--- a/fs/ecryptfs/ecryptfs_kernel.h
>+++ b/fs/ecryptfs/ecryptfs_kernel.h
>@@ -38,6 +38,7 @@
> #include <linux/nsproxy.h>
> #include <linux/backing-dev.h>
> #include <linux/ecryptfs.h>
>+#include <linux/crypto.h>
> 
> #define ECRYPTFS_DEFAULT_IV_BYTES 16
> #define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
>@@ -233,7 +234,7 @@ struct ecryptfs_crypt_stat {
> 	size_t extent_shift;
> 	unsigned int extent_mask;
> 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
>-	struct crypto_blkcipher *tfm;
>+	struct crypto_ablkcipher *tfm;
> 	struct crypto_hash *hash_tfm; /* Crypto context for generating
> 				       * the initialization vectors */
> 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
>-- 
>1.8.1.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

