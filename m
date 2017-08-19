From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ecryptfs: Delete 21 error messages for a failed memory
 allocation
Date: Sat, 19 Aug 2017 18:55:31 +0200
Message-ID: <1dcce3db-c162-c6bc-d1a8-bcf427248a77@users.sourceforge.net>
References: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:64388 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751327AbdHSQze (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Sat, 19 Aug 2017 12:55:34 -0400
In-Reply-To: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Content-Language: en-GB
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 19 Aug 2017 17:37:30 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/ecryptfs/crypto.c    | 16 ----------------
 fs/ecryptfs/inode.c     |  3 ---
 fs/ecryptfs/keystore.c  | 33 ++++++---------------------------
 fs/ecryptfs/messaging.c |  6 ------
 fs/ecryptfs/miscdev.c   |  6 +-----
 fs/ecryptfs/mmap.c      |  2 --
 6 files changed, 7 insertions(+), 59 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7acd57da4f14..4a7ef33d4d79 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1419,8 +1419,6 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 	page_virt = kmem_cache_alloc(ecryptfs_header_cache, GFP_USER);
 	if (!page_virt) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "%s: Unable to allocate page_virt\n",
-		       __func__);
 		goto out;
 	}
 	rc = ecryptfs_read_lower(page_virt, 0, crypt_stat->extent_size,
@@ -1509,7 +1507,4 @@ ecryptfs_encrypt_filename(struct ecryptfs_filename *filename,
 		if (!filename->encrypted_filename) {
-			printk(KERN_ERR "%s: Out of memory whilst attempting "
-			       "to kmalloc [%zd] bytes\n", __func__,
-			       filename->encrypted_filename_size);
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -1658,8 +1653,6 @@ ecryptfs_add_new_key_tfm(struct ecryptfs_key_tfm **key_tfm, char *cipher_name,
 		(*key_tfm) = tmp_tfm;
 	if (!tmp_tfm) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "Error attempting to allocate from "
-		       "ecryptfs_key_tfm_cache\n");
 		goto out;
 	}
 	mutex_init(&tmp_tfm->key_tfm_mutex);
@@ -1936,7 +1929,4 @@ int ecryptfs_encrypt_and_encode_filename(
 		if (!filename) {
-			printk(KERN_ERR "%s: Out of memory whilst attempting "
-			       "to kzalloc [%zd] bytes\n", __func__,
-			       sizeof(*filename));
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -1966,8 +1956,5 @@ int ecryptfs_encrypt_and_encode_filename(
 		(*encoded_name) = kmalloc((*encoded_name_size) + 1, GFP_KERNEL);
 		if (!(*encoded_name)) {
-			printk(KERN_ERR "%s: Out of memory whilst attempting "
-			       "to kzalloc [%zd] bytes\n", __func__,
-			       (*encoded_name_size));
 			rc = -ENOMEM;
 			kfree(filename->encrypted_filename);
 			kfree(filename);
@@ -2051,7 +2038,4 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 		if (!decoded_name) {
-			printk(KERN_ERR "%s: Out of memory whilst attempting "
-			       "to kmalloc [%zd] bytes\n", __func__,
-			       decoded_name_size);
 			rc = -ENOMEM;
 			goto out;
 		}
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index efc2db42d175..93ed19ac770f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -334,9 +334,6 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 
 	dentry_info = kmem_cache_alloc(ecryptfs_dentry_info_cache, GFP_KERNEL);
 	if (!dentry_info) {
-		printk(KERN_ERR "%s: Out of memory whilst attempting "
-		       "to allocate ecryptfs_dentry_info struct\n",
-			__func__);
 		dput(lower_dentry);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 11d39ab7774e..0131b0547699 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -632,11 +632,9 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 	int rc = 0;
 
 	s = kzalloc(sizeof(*s), GFP_KERNEL);
-	if (!s) {
-		printk(KERN_ERR "%s: Out of memory whilst trying to kmalloc "
-		       "[%zd] bytes of kernel memory\n", __func__, sizeof(*s));
+	if (!s)
 		return -ENOMEM;
-	}
+
 	(*packet_size) = 0;
 	rc = ecryptfs_find_auth_tok_for_sig(
 		&auth_tok_key,
@@ -709,7 +707,4 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 	if (!s->block_aligned_filename) {
-		printk(KERN_ERR "%s: Out of kernel memory whilst attempting to "
-		       "kzalloc [%zd] bytes\n", __func__,
-		       s->block_aligned_filename_size);
 		rc = -ENOMEM;
 		goto out_unlock;
 	}
@@ -764,8 +759,4 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 	if (!s->hash_desc) {
-		printk(KERN_ERR "%s: Out of kernel memory whilst attempting to "
-		       "kmalloc [%zd] bytes\n", __func__,
-		       sizeof(*s->hash_desc) +
-		       crypto_shash_descsize(s->hash_tfm));
 		rc = -ENOMEM;
 		goto out_release_free_unlock;
 	}
@@ -918,11 +909,9 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 	(*filename_size) = 0;
 	(*filename) = NULL;
 	s = kzalloc(sizeof(*s), GFP_KERNEL);
-	if (!s) {
-		printk(KERN_ERR "%s: Out of memory whilst trying to kmalloc "
-		       "[%zd] bytes of kernel memory\n", __func__, sizeof(*s));
+	if (!s)
 		return -ENOMEM;
-	}
+
 	if (max_packet_size < ECRYPTFS_TAG_70_MIN_METADATA_SIZE) {
 		printk(KERN_WARNING "%s: max_packet_size is [%zd]; it must be "
 		       "at least [%d]\n", __func__, max_packet_size,
@@ -1010,7 +999,4 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 	if (!s->decrypted_filename) {
-		printk(KERN_ERR "%s: Out of memory whilst attempting to "
-		       "kmalloc [%zd] bytes\n", __func__,
-		       s->block_aligned_filename_size);
 		rc = -ENOMEM;
 		goto out_unlock;
 	}
@@ -1092,7 +1078,4 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 	if (!(*filename)) {
-		printk(KERN_ERR "%s: Out of memory whilst attempting to "
-		       "kmalloc [%zd] bytes\n", __func__,
-		       ((*filename_size) + 1));
 		rc = -ENOMEM;
 		goto out_free_unlock;
 	}
@@ -2518,11 +2501,9 @@ int ecryptfs_add_keysig(struct ecryptfs_crypt_stat *crypt_stat, char *sig)
 	struct ecryptfs_key_sig *new_key_sig;
 
 	new_key_sig = kmem_cache_alloc(ecryptfs_key_sig_cache, GFP_KERNEL);
-	if (!new_key_sig) {
-		printk(KERN_ERR
-		       "Error allocating from ecryptfs_key_sig_cache\n");
+	if (!new_key_sig)
 		return -ENOMEM;
-	}
+
 	memcpy(new_key_sig->keysig, sig, ECRYPTFS_SIG_SIZE_HEX);
 	new_key_sig->keysig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
 	/* Caller must hold keysig_list_mutex */
@@ -2545,7 +2526,5 @@ ecryptfs_add_global_auth_tok(struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	if (!new_auth_tok) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "Error allocating from "
-		       "ecryptfs_global_auth_tok_cache\n");
 		goto out;
 	}
 	memcpy(new_auth_tok->sig, sig, ECRYPTFS_SIG_SIZE_HEX);
diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index 286f10b0363b..6ab4f7110d6b 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -148,7 +148,5 @@ ecryptfs_spawn_daemon(struct ecryptfs_daemon **daemon, struct file *file)
 	if (!(*daemon)) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "%s: Failed to allocate [%zd] bytes of "
-		       "GFP_KERNEL memory\n", __func__, sizeof(**daemon));
 		goto out;
 	}
 	(*daemon)->file = file;
@@ -251,7 +249,5 @@ int ecryptfs_process_response(struct ecryptfs_daemon *daemon,
 	if (!msg_ctx->msg) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "%s: Failed to allocate [%zd] bytes of "
-		       "GFP_KERNEL memory\n", __func__, msg_size);
 		goto unlock;
 	}
 	msg_ctx->state = ECRYPTFS_MSG_CTX_STATE_DONE;
@@ -387,6 +383,5 @@ int __init ecryptfs_init_messaging(void)
 	if (!ecryptfs_daemon_hash) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "%s: Failed to allocate memory\n", __func__);
 		mutex_unlock(&ecryptfs_daemon_hash_mux);
 		goto out;
 	}
@@ -399,6 +394,5 @@ int __init ecryptfs_init_messaging(void)
 	if (!ecryptfs_msg_ctx_arr) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "%s: Failed to allocate memory\n", __func__);
 		goto out;
 	}
 	mutex_init(&ecryptfs_msg_ctx_lists_mux);
diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 595e684a95a5..f09cacaf8c80 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -166,9 +166,5 @@ int ecryptfs_send_miscdev(char *data, size_t data_size,
-	if (!msg) {
-		printk(KERN_ERR "%s: Out of memory whilst attempting "
-		       "to kmalloc(%zd, GFP_KERNEL)\n", __func__,
-		       (sizeof(*msg) + data_size));
+	if (!msg)
 		return -ENOMEM;
-	}
 
 	mutex_lock(&msg_ctx->mux);
 	msg_ctx->msg = msg;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 1f0c471b4ba3..cdf358b209d9 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -431,8 +431,6 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
 	}
 	xattr_virt = kmem_cache_alloc(ecryptfs_xattr_cache, GFP_KERNEL);
 	if (!xattr_virt) {
-		printk(KERN_ERR "Out of memory whilst attempting to write "
-		       "inode size to xattr\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-- 
2.14.0
