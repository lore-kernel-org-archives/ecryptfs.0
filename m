From: Colin King <colin.king@canonical.com>
Subject: [PATCH] eCryptfs: ensure copy to crypt_stat->cipher does not overrun
Date: Mon, 23 Feb 2015 11:34:10 +0000
Message-ID: <1424691250-24458-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The patch 237fead61998: "[PATCH] ecryptfs: fs/Makefile and
fs/Kconfig" from Oct 4, 2006, leads to the following static checker
warning:

  fs/ecryptfs/crypto.c:846 ecryptfs_new_file_context()
  error: off-by-one overflow 'crypt_stat->cipher' size 32.  rl = '0-32'

There is a mismatch between the size of ecryptfs_crypt_stat.cipher
and ecryptfs_mount_crypt_stat.global_default_cipher_name causing the
copy of the cipher name to cause a off-by-one string copy error. This
fix ensures the space reserved for this string is the same size including
the trailing zero at the end throughout ecryptfs.

This fix avoids increasing the size of ecryptfs_crypt_stat.cipher
and also ecryptfs_parse_tag_70_packet_silly_stack.cipher_string and instead
reduces the of ECRYPTFS_MAX_CIPHER_NAME_SIZE to 31 and includes the + 1 for
the end of string terminator.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ecryptfs/ecryptfs_kernel.h | 4 ++--
 fs/ecryptfs/keystore.c        | 2 +-
 fs/ecryptfs/main.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 90d1882..5ba029e 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -124,7 +124,7 @@ ecryptfs_get_key_payload_data(struct key *key)
 }
 
 #define ECRYPTFS_MAX_KEYSET_SIZE 1024
-#define ECRYPTFS_MAX_CIPHER_NAME_SIZE 32
+#define ECRYPTFS_MAX_CIPHER_NAME_SIZE 31
 #define ECRYPTFS_MAX_NUM_ENC_KEYS 64
 #define ECRYPTFS_MAX_IV_BYTES 16	/* 128 bits */
 #define ECRYPTFS_SALT_BYTES 2
@@ -237,7 +237,7 @@ struct ecryptfs_crypt_stat {
 	struct crypto_ablkcipher *tfm;
 	struct crypto_hash *hash_tfm; /* Crypto context for generating
 				       * the initialization vectors */
-	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
+	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
 	struct list_head keysig_list;
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 917bd5c..6bd67e2 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -891,7 +891,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
 	struct blkcipher_desc desc;
 	char fnek_sig_hex[ECRYPTFS_SIG_SIZE_HEX + 1];
 	char iv[ECRYPTFS_MAX_IV_BYTES];
-	char cipher_string[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
+	char cipher_string[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
 };
 
 /**
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index d9eb84b..76dfb01 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -407,7 +407,7 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 	if (!cipher_name_set) {
 		int cipher_name_len = strlen(ECRYPTFS_DEFAULT_CIPHER);
 
-		BUG_ON(cipher_name_len >= ECRYPTFS_MAX_CIPHER_NAME_SIZE);
+		BUG_ON(cipher_name_len > ECRYPTFS_MAX_CIPHER_NAME_SIZE);
 		strcpy(mount_crypt_stat->global_default_cipher_name,
 		       ECRYPTFS_DEFAULT_CIPHER);
 	}
-- 
2.1.4
