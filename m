From: Tim Gardner <tim.gardner@canonical.com>
Subject: [PATCH linux-next] eCryptfs: decrypt_pki_encrypted_session_key(): remove kfree() redundant null check
Date: Tue, 12 Feb 2013 10:56:54 -0700
Message-ID: <1360691814-60569-1-git-send-email-tim.gardner@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>, Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org

smatch analysis:

fs/ecryptfs/keystore.c:1206 decrypt_pki_encrypted_session_key() info:
 redundant null check on msg calling kfree()

Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 fs/ecryptfs/keystore.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 6154cde..5aceff2 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1202,8 +1202,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 				  crypt_stat->key_size);
 	}
 out:
-	if (msg)
-		kfree(msg);
+	kfree(msg);
 	return rc;
 }
 
-- 
1.7.9.5
