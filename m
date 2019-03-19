From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/6] security/keys/ecryptfs: Drop direct dependency on
 key_type_encrypted
Date: Mon, 18 Mar 2019 23:06:36 -0700
Message-ID: <155297559625.2276575.11539296499176067525.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <155297557534.2276575.16264199708584900090.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tyler Hicks <tyhicks-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Lookup the key type by name and protect ecryptfs from encrypted_keys.ko
module load failures, and cleanup the configuration dependencies on the
definition of the ecryptfs_get_encrypted_key() helper.

Cc: Tyler Hicks <tyhicks-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: <ecryptfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 fs/ecryptfs/ecryptfs_kernel.h |   22 +---------------------
 fs/ecryptfs/keystore.c        |   12 ++++++++++++
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index e74cb2a0b299..3106d23d95f0 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -87,13 +87,12 @@ struct ecryptfs_page_crypt_context {
 	} param;
 };
 
-#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
 static inline struct ecryptfs_auth_tok *
 ecryptfs_get_encrypted_key_payload_data(struct key *key)
 {
 	struct encrypted_key_payload *payload;
 
-	if (key->type != &key_type_encrypted)
+	if (strcmp(key->type->name, "encrypted") != 0)
 		return NULL;
 
 	payload = key->payload.data[0];
@@ -103,25 +102,6 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
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
 static inline struct ecryptfs_auth_tok *
 ecryptfs_get_key_payload_data(struct key *key)
 {
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index e74fe84d0886..52a01dd57f4a 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1619,6 +1619,17 @@ parse_tag_11_packet(unsigned char *data, unsigned char *contents,
 	return rc;
 }
 
+static struct key *ecryptfs_get_encrypted_key(char *sig)
+{
+	struct key_type *type;
+	struct key *key;
+
+	type = key_type_lookup("encrypted");
+	if (IS_ERR(type))
+		return (struct key *) type;
+	return request_key(type, sig, NULL);
+}
+
 int ecryptfs_keyring_auth_tok_for_sig(struct key **auth_tok_key,
 				      struct ecryptfs_auth_tok **auth_tok,
 				      char *sig)
@@ -2542,3 +2553,4 @@ ecryptfs_add_global_auth_tok(struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	return 0;
 }
 
+MODULE_SOFTDEP("pre: encrypted_keys");
