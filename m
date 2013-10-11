From: "Geyslan G. Bem" <geyslan@gmail.com>
Subject: [PATCH] ecryptfs: Fix memory leakage in keystore.c
Date: Fri, 11 Oct 2013 16:49:16 -0300
Message-ID: <1381520956-20282-1-git-send-email-geyslan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, kernel-br@googlegroups.com, "Geyslan G. Bem" <geyslan@gmail.com>

In 'decrypt_pki_encrypted_session_key' function:

Initializes 'payload' pointer and releases it on exit.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 fs/ecryptfs/keystore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 7d52806..4725a07 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1149,7 +1149,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 	struct ecryptfs_msg_ctx *msg_ctx;
 	struct ecryptfs_message *msg = NULL;
 	char *auth_tok_sig;
-	char *payload;
+	char *payload = NULL;
 	size_t payload_len = 0;
 	int rc;
 
@@ -1203,6 +1203,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 	}
 out:
 	kfree(msg);
+	kfree(payload);
 	return rc;
 }
 
-- 
1.8.4
