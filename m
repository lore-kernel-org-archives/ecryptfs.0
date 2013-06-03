From: Will Morrison <camocrazed@gmail.com>
Subject: [RFC] eCryptfs: Add mount option for cipher mode
Date: Mon, 03 Jun 2013 13:13:45 -0400
Message-ID: <51ACCEC9.3070303@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:58624 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759377Ab3FCRNn (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Jun 2013 13:13:43 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so7701416obb.1
        for <ecryptfs@vger.kernel.org>; Mon, 03 Jun 2013 10:13:43 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, Zameer Manji <zmanji@gmail.com>, Michael Chang <thenewme91@gmail.com>, Alvin Tran <althaitran@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch removes the hardcoding of CBC mode in eCryptfs and adds a 
mount option allowing one to specify the desired mode of operation. 
Currently this defaults to cbc, but should would with any plain block 
cipher mode supported by the kernel. We've been testing with ecb to 
ensure we've found any implicit assumptions about cbc.

Future work will involve supporting AEAD modes (GCM) and adding in 
integrity checking code.

As this is our first kernel patch, we'd like feedback on what we've 
done right and what we've done wrong, not only in code, but also 
anything related to the patch submission itself.

Signed-off-by: William Morrison <camocrazed@gmail.com>
- ---
diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryptfs/crypto.c ecryptfs/fs/ecryptfs/crypto.c
- --- ecryptfs_base/fs/ecryptfs/crypto.c	2013-06-03 07:49:51.734430193 -0400
+++ ecryptfs/fs/ecryptfs/crypto.c	2013-05-23 17:51:37.814355879 -0400
@@ -743,7 +743,8 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 	}
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
 	rc = ecryptfs_crypto_api_algify_cipher_name(&full_alg_name,
- -						    crypt_stat->cipher, "cbc");
+						crypt_stat->cipher,
+						crypt_stat->cipher_mode);
 	if (rc)
 		goto out_unlock;
 	crypt_stat->tfm = crypto_alloc_blkcipher(full_alg_name, 0,
@@ -753,8 +754,9 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 		rc = PTR_ERR(crypt_stat->tfm);
 		crypt_stat->tfm = NULL;
 		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): "
- -				"Error initializing cipher [%s]\n",
- -				crypt_stat->cipher);
+			"Error initializing cipher [%s] and mode [%s]\n",
+			crypt_stat->cipher,
+			crypt_stat->cipher_mode);
 		goto out_unlock;
 	}
 	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
@@ -916,6 +918,7 @@ static void ecryptfs_set_default_crypt_s
 						      mount_crypt_stat);
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
+	strcpy(crypt_stat->cipher_mode, ECRYPTFS_DEFAULT_CIPHER_MODE);
 	crypt_stat->key_size = ECRYPTFS_DEFAULT_KEY_BYTES;
 	crypt_stat->flags &= ~(ECRYPTFS_KEY_VALID);
 	crypt_stat->file_version = ECRYPTFS_FILE_VERSION;
@@ -949,6 +952,7 @@ int ecryptfs_new_file_context(struct ino
 	    &ecryptfs_superblock_to_private(
 		    ecryptfs_inode->i_sb)->mount_crypt_stat;
 	int cipher_name_len;
+	int cipher_mode_name_len;
 	int rc = 0;
 
 	ecryptfs_set_default_crypt_stat_vals(crypt_stat, mount_crypt_stat);
@@ -968,6 +972,12 @@ int ecryptfs_new_file_context(struct ino
 	       mount_crypt_stat->global_default_cipher_name,
 	       cipher_name_len);
 	crypt_stat->cipher[cipher_name_len] = '\0';
+	cipher_mode_name_len =
+		strlen(mount_crypt_stat->global_default_cipher_mode_name);
+	memcpy(crypt_stat->cipher_mode,
+		mount_crypt_stat->global_default_cipher_mode_name,
+		cipher_mode_name_len);
+	crypt_stat->cipher_mode[cipher_mode_name_len] = '\0';
 	crypt_stat->key_size =
 		mount_crypt_stat->global_default_cipher_key_size;
 	ecryptfs_generate_new_key(crypt_stat);
diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryptfs/ecryptfs_kernel.h ecryptfs/fs/ecryptfs/ecryptfs_kernel.h
- --- ecryptfs_base/fs/ecryptfs/ecryptfs_kernel.h	2013-06-03 07:49:51.734430193 -0400
+++ ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2013-05-23 17:51:37.814355879 -0400
@@ -124,6 +124,7 @@ ecryptfs_get_key_payload_data(struct key
 
 #define ECRYPTFS_MAX_KEYSET_SIZE 1024
 #define ECRYPTFS_MAX_CIPHER_NAME_SIZE 32
+#define ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE 32
 #define ECRYPTFS_MAX_NUM_ENC_KEYS 64
 #define ECRYPTFS_MAX_IV_BYTES 16	/* 128 bits */
 #define ECRYPTFS_SALT_BYTES 2
@@ -133,6 +134,7 @@ ecryptfs_get_key_payload_data(struct key
 #define ECRYPTFS_SIZE_AND_MARKER_BYTES (ECRYPTFS_FILE_SIZE_BYTES \
 					+ MAGIC_ECRYPTFS_MARKER_SIZE_BYTES)
 #define ECRYPTFS_DEFAULT_CIPHER "aes"
+#define ECRYPTFS_DEFAULT_CIPHER_MODE "cbc"
 #define ECRYPTFS_DEFAULT_KEY_BYTES 16
 #define ECRYPTFS_DEFAULT_HASH "md5"
 #define ECRYPTFS_TAG_70_DIGEST ECRYPTFS_DEFAULT_HASH
@@ -237,6 +239,7 @@ struct ecryptfs_crypt_stat {
 	struct crypto_hash *hash_tfm; /* Crypto context for generating
 				       * the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
+	unsigned char cipher_mode[ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE];
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
 	struct list_head keysig_list;
@@ -338,6 +341,8 @@ struct ecryptfs_mount_crypt_stat {
 	size_t global_default_fn_cipher_key_bytes;
 	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
 						 + 1];
+	unsigned char global_default_cipher_mode_name[
+		ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE + 1];
 	unsigned char global_default_fn_cipher_name[
 		ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
 	char global_default_fnek_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryptfs/keystore.c ecryptfs/fs/ecryptfs/keystore.c
- --- ecryptfs_base/fs/ecryptfs/keystore.c	2013-06-03 07:49:51.734430193 -0400
+++ ecryptfs/fs/ecryptfs/keystore.c	2013-06-03 10:45:56.142519966 -0400
@@ -1467,6 +1467,9 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		crypt_stat->key_size =
 			(*new_auth_tok)->session_key.encrypted_key_size;
 	}
+	strncpy(crypt_stat->cipher_mode,
+		crypt_stat->mount_crypt_stat->global_default_cipher_mode_name,
+		ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
 	rc = ecryptfs_init_crypt_ctx(crypt_stat);
 	if (rc)
 		goto out_free;
diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryptfs/main.c ecryptfs/fs/ecryptfs/main.c
- --- ecryptfs_base/fs/ecryptfs/main.c	2013-06-03 07:49:51.734430193 -0400
+++ ecryptfs/fs/ecryptfs/main.c	2013-06-03 10:54:26.570524304 -0400
@@ -171,6 +171,7 @@ void ecryptfs_put_lower_file(struct inod
 
 enum { ecryptfs_opt_sig, ecryptfs_opt_ecryptfs_sig,
        ecryptfs_opt_cipher, ecryptfs_opt_ecryptfs_cipher,
+       ecryptfs_opt_cipher_mode, ecryptfs_opt_ecryptfs_cipher_mode,
        ecryptfs_opt_ecryptfs_key_bytes,
        ecryptfs_opt_passthrough, ecryptfs_opt_xattr_metadata,
        ecryptfs_opt_encrypted_view, ecryptfs_opt_fnek_sig,
@@ -183,7 +184,9 @@ static const match_table_t tokens = {
 	{ecryptfs_opt_sig, "sig=%s"},
 	{ecryptfs_opt_ecryptfs_sig, "ecryptfs_sig=%s"},
 	{ecryptfs_opt_cipher, "cipher=%s"},
+	{ecryptfs_opt_cipher_mode, "cipher_mode=%s"},
 	{ecryptfs_opt_ecryptfs_cipher, "ecryptfs_cipher=%s"},
+	{ecryptfs_opt_ecryptfs_cipher_mode, "ecryptfs_cipher_mode=%s"},
 	{ecryptfs_opt_ecryptfs_key_bytes, "ecryptfs_key_bytes=%u"},
 	{ecryptfs_opt_passthrough, "ecryptfs_passthrough"},
 	{ecryptfs_opt_xattr_metadata, "ecryptfs_xattr_metadata"},
@@ -258,10 +261,13 @@ static void ecryptfs_init_mount_crypt_st
 static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 				  uid_t *check_ruid)
 {
+	const char *mode_white_list[] = {"cbc", "ecb", "gcm"};
 	char *p;
+	int i = 0;
 	int rc = 0;
 	int sig_set = 0;
 	int cipher_name_set = 0;
+	int cipher_mode_name_set = 0;
 	int fn_cipher_name_set = 0;
 	int cipher_key_bytes;
 	int cipher_key_bytes_set = 0;
@@ -274,6 +280,8 @@ static int ecryptfs_parse_options(struct
 	char *sig_src;
 	char *cipher_name_dst;
 	char *cipher_name_src;
+	char *cipher_mode_name_dst;
+	char *cipher_mode_name_src;
 	char *fn_cipher_name_dst;
 	char *fn_cipher_name_src;
 	char *fnek_dst;
@@ -317,6 +325,18 @@ static int ecryptfs_parse_options(struct
 			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
 			cipher_name_set = 1;
 			break;
+		case ecryptfs_opt_cipher_mode:
+		case ecryptfs_opt_ecryptfs_cipher_mode:
+			cipher_mode_name_src = args[0].from;
+			cipher_mode_name_dst =
+				mount_crypt_stat->
+				global_default_cipher_mode_name;
+			strncpy(cipher_mode_name_dst, cipher_mode_name_src,
+				ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
+			cipher_mode_name_dst[
+				ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE] = '\0';
+			cipher_mode_name_set = 1;
+			break;
 		case ecryptfs_opt_ecryptfs_key_bytes:
 			cipher_key_bytes_src = args[0].from;
 			cipher_key_bytes =
@@ -412,6 +432,14 @@ static int ecryptfs_parse_options(struct
 		strcpy(mount_crypt_stat->global_default_cipher_name,
 		       ECRYPTFS_DEFAULT_CIPHER);
 	}
+	if (!cipher_mode_name_set) {
+		int cipher_mode_name_len = strlen(ECRYPTFS_DEFAULT_CIPHER_MODE);
+
+		BUG_ON(cipher_mode_name_len >=
+			ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
+		strcpy(mount_crypt_stat->global_default_cipher_mode_name,
+		       ECRYPTFS_DEFAULT_CIPHER_MODE);
+	}
 	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)
 	    && !fn_cipher_name_set)
 		strcpy(mount_crypt_stat->global_default_fn_cipher_name,
@@ -434,6 +462,22 @@ static int ecryptfs_parse_options(struct
 		goto out;
 	}
 
+	rc = -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(mode_white_list); i++) {
+		if (strcmp(mount_crypt_stat->global_default_cipher_mode_name,
+				mode_white_list[i]) == 0) {
+			rc = 0;
+			break;
+		}
+	}
+	if (rc) {
+		ecryptfs_printk(KERN_ERR,
+				"eCryptfs doesn't support cipher mode: %s",
+				mount_crypt_stat->
+					global_default_cipher_mode_name);
+		goto out;
+	}
+
 	mutex_lock(&key_tfm_list_mutex);
 	if (!ecryptfs_tfm_exists(mount_crypt_stat->global_default_cipher_name,
 				 NULL)) {
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRrM7JAAoJEH8zVN2+6bAcNDQP/RqMXatRh93P2C8Cz9b5gT+Q
FwYCuyp8dr+TA/CQ+qTl80XdVUlMzAz6121ENm+WjY5M3KjTu5WuCnKRr1v6JfyT
sFDDd+gc+CGOT4KTF1bwIxCUWxkaFWAD2bC0+Bttfb7jjyTMEjOu0YULiHsAXiBi
hOdstGAeayk7Fbkc6cDnrJVaM6n/D9pLvGS+RjUa3NHXWQHAH4zwGpCnER7ZeFcR
p6FFpLoMjbVEco41juvp8ZcWYmerEvSo/N+kmUb1DNoR0m7Dp7h5dbkK9rFFUV9/
CusszUiZ87//79R7fLN9pCuxGAiQiJsnZv//mAMZi3zPWvgLhjMMO2dWyAaA7rGD
YCDlhl3tkaAnPCwUHYc9WDuJR+8MqwZIfTMJqLP1J3Ne9Fie+OheEMyMpOmqafSG
M1pRGX1ZU2UdZEWcn8d0hGSz23wfyM/B+A9/w+1MHrUeWLGPGMR+6fsPThUqPXDz
8Qp+NYCXmabWKWMqshVgjXd7veCKWB/P0rWe/gNX+irM8oII4hUVe+QisxCulJVh
/sg+cZ00V/R6htJDpQCAztUAFxMAPRi+CyC3gsaoYGGLKUDQ6QQJz8WO4uz4Ue5B
U7l1PA9UQ9eJ+oNkGAxLvVQWUC24QRMVegk5i3PfXUu8nFz3vDbikqTNi+IYJ0lu
4jFJhK37ZMwfHja1bkbm
=NWjy
-----END PGP SIGNATURE-----
