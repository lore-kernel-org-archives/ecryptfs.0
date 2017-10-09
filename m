From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 3/3] ecryptfs: move key payload accessor functions into keystore.c
Date: Mon,  9 Oct 2017 12:51:29 -0700
Message-ID: <20171009195129.68610-3-ebiggers3@gmail.com>
References: <20171009195129.68610-1-ebiggers3@gmail.com>
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <20171009195129.68610-1-ebiggers3@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Biggers <ebiggers@google.com>, Michael Halcrow <mhalcrow@google.com>

From: Eric Biggers <ebiggers@google.com>

As experience has shown, accessing the 'struct key' payload is very
error-prone, since we need to hold the key semaphore and properly
validate everything.  Fortunately eCryptfs only does it from one place,
in ecryptfs_verify_auth_tok_from_key() in keystore.c.  Therefore, move
the payload accessor functions like ecryptfs_get_key_payload_data() out
of ecryptfs_kernel.h and into keystore.c so that people might be less
tempted to use them directly.

Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Changed since v1: added Reviewed-by and resent in series with just the
ecryptfs patches.  Can this please be taken through the ecryptfs tree?

 fs/ecryptfs/ecryptfs_kernel.h | 60 -------------------------------------------
 fs/ecryptfs/keystore.c        | 60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 945844d5f0ef..f2e339a6f9e9 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -29,8 +29,6 @@
 #define ECRYPTFS_KERNEL_H
 
 #include <crypto/skcipher.h>
-#include <keys/user-type.h>
-#include <keys/encrypted-type.h>
 #include <linux/fs.h>
 #include <linux/fs_stack.h>
 #include <linux/namei.h>
@@ -80,64 +78,6 @@ struct ecryptfs_page_crypt_context {
 	} param;
 };
 
-#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
-static inline struct ecryptfs_auth_tok *
-ecryptfs_get_encrypted_key_payload_data(struct key *key)
-{
-	struct encrypted_key_payload *payload;
-
-	if (key->type != &key_type_encrypted)
-		return NULL;
-
-	payload = key->payload.data[0];
-	if (!payload)
-		return ERR_PTR(-EKEYREVOKED);
-
-	if (payload->payload_datalen != sizeof(struct ecryptfs_auth_tok))
-		return ERR_PTR(-EINVAL);
-
-	return (struct ecryptfs_auth_tok *)payload->payload_data;
-}
-
-static inline struct key *ecryptfs_get_encrypted_key(char *sig)
-{
-	return request_key(&key_type_encrypted, sig, NULL);
-}
-
-#else
-static inline struct ecryptfs_auth_tok *
-ecryptfs_get_encrypted_key_payload_data(struct key *key)
-{
-	return NULL;
-}
-
-static inline struct key *ecryptfs_get_encrypted_key(char *sig)
-{
-	return ERR_PTR(-ENOKEY);
-}
-
-#endif /* CONFIG_ENCRYPTED_KEYS */
-
-static inline struct ecryptfs_auth_tok *
-ecryptfs_get_key_payload_data(struct key *key)
-{
-	struct ecryptfs_auth_tok *auth_tok;
-	struct user_key_payload *ukp;
-
-	auth_tok = ecryptfs_get_encrypted_key_payload_data(key);
-	if (auth_tok)
-		return auth_tok;
-
-	ukp = user_key_payload_locked(key);
-	if (!ukp)
-		return ERR_PTR(-EKEYREVOKED);
-
-	if (ukp->datalen != sizeof(struct ecryptfs_auth_tok))
-		return ERR_PTR(-EINVAL);
-
-	return (struct ecryptfs_auth_tok *)ukp->data;
-}
-
 #define ECRYPTFS_MAX_KEYSET_SIZE 1024
 #define ECRYPTFS_MAX_CIPHER_NAME_SIZE 31
 #define ECRYPTFS_MAX_NUM_ENC_KEYS 64
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 95e20ab67df3..cb801bdcbae2 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -27,6 +27,8 @@
 
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
+#include <keys/user-type.h>
+#include <keys/encrypted-type.h>
 #include <linux/string.h>
 #include <linux/pagemap.h>
 #include <linux/key.h>
@@ -454,6 +456,64 @@ static int ecryptfs_verify_version(u16 version)
 	return rc;
 }
 
+#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
+static inline struct ecryptfs_auth_tok *
+ecryptfs_get_encrypted_key_payload_data(struct key *key)
+{
+	struct encrypted_key_payload *payload;
+
+	if (key->type != &key_type_encrypted)
+		return NULL;
+
+	payload = key->payload.data[0];
+	if (!payload)
+		return ERR_PTR(-EKEYREVOKED);
+
+	if (payload->payload_datalen != sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
+	return (struct ecryptfs_auth_tok *)payload->payload_data;
+}
+
+static inline struct key *ecryptfs_get_encrypted_key(char *sig)
+{
+	return request_key(&key_type_encrypted, sig, NULL);
+}
+
+#else
+static inline struct ecryptfs_auth_tok *
+ecryptfs_get_encrypted_key_payload_data(struct key *key)
+{
+	return NULL;
+}
+
+static inline struct key *ecryptfs_get_encrypted_key(char *sig)
+{
+	return ERR_PTR(-ENOKEY);
+}
+
+#endif /* CONFIG_ENCRYPTED_KEYS */
+
+static struct ecryptfs_auth_tok *
+ecryptfs_get_key_payload_data(struct key *key)
+{
+	struct ecryptfs_auth_tok *auth_tok;
+	struct user_key_payload *ukp;
+
+	auth_tok = ecryptfs_get_encrypted_key_payload_data(key);
+	if (auth_tok)
+		return auth_tok;
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return ERR_PTR(-EKEYREVOKED);
+
+	if (ukp->datalen != sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
+	return (struct ecryptfs_auth_tok *)ukp->data;
+}
+
 /**
  * ecryptfs_verify_auth_tok_from_key
  * @auth_tok_key: key containing the authentication token
-- 
2.14.2.920.gcf0c67979c-goog

