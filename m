From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ecryptfs: Return an error code only as a constant in
 ecryptfs_add_global_auth_tok()
Date: Sat, 19 Aug 2017 18:56:50 +0200
Message-ID: <0a02a893-798a-d126-3e64-45f8f5185bc7@users.sourceforge.net>
References: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 19 Aug 2017 17:51:53 +0200

* Return an error code without storing it in an intermediate variable.

* Delete the jump target "out" and the local variable "rc"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/ecryptfs/keystore.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 0131b0547699..47c1fd73638d 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -2519,14 +2519,12 @@ ecryptfs_add_global_auth_tok(struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 			     char *sig, u32 global_auth_tok_flags)
 {
 	struct ecryptfs_global_auth_tok *new_auth_tok;
-	int rc = 0;
 
 	new_auth_tok = kmem_cache_zalloc(ecryptfs_global_auth_tok_cache,
 					GFP_KERNEL);
-	if (!new_auth_tok) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!new_auth_tok)
+		return -ENOMEM;
+
 	memcpy(new_auth_tok->sig, sig, ECRYPTFS_SIG_SIZE_HEX);
 	new_auth_tok->flags = global_auth_tok_flags;
 	new_auth_tok->sig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
@@ -2534,7 +2532,6 @@ ecryptfs_add_global_auth_tok(struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	list_add(&new_auth_tok->mount_crypt_stat_list,
 		 &mount_crypt_stat->global_auth_tok_list);
 	mutex_unlock(&mount_crypt_stat->global_auth_tok_list_mutex);
-out:
-	return rc;
+	return 0;
 }
 
-- 
2.14.0

