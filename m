From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 14/20] ecryptfs: use crypto_shash_tfm_digest()
Date: Fri,  1 May 2020 22:31:16 -0700
Message-ID: <20200502053122.995648-15-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-crypto@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Cc: ecryptfs@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ecryptfs/crypto.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 2c449aed1b9209..0681540c48d985 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -48,18 +48,6 @@ void ecryptfs_from_hex(char *dst, char *src, int dst_size)
 	}
 }
 
-static int ecryptfs_hash_digest(struct crypto_shash *tfm,
-				char *src, int len, char *dst)
-{
-	SHASH_DESC_ON_STACK(desc, tfm);
-	int err;
-
-	desc->tfm = tfm;
-	err = crypto_shash_digest(desc, src, len, dst);
-	shash_desc_zero(desc);
-	return err;
-}
-
 /**
  * ecryptfs_calculate_md5 - calculates the md5 of @src
  * @dst: Pointer to 16 bytes of allocated memory
@@ -74,11 +62,8 @@ static int ecryptfs_calculate_md5(char *dst,
 				  struct ecryptfs_crypt_stat *crypt_stat,
 				  char *src, int len)
 {
-	struct crypto_shash *tfm;
-	int rc = 0;
+	int rc = crypto_shash_tfm_digest(crypt_stat->hash_tfm, src, len, dst);
 
-	tfm = crypt_stat->hash_tfm;
-	rc = ecryptfs_hash_digest(tfm, src, len, dst);
 	if (rc) {
 		printk(KERN_ERR
 		       "%s: Error computing crypto hash; rc = [%d]\n",
-- 
2.26.2

