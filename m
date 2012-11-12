From: Abhijit Pawar <abhi.c.pawar@gmail.com>
Subject: [PATCH 1/2] fs:ecryptfs basic code optimization
Date: Mon, 12 Nov 2012 14:17:27 +0530
Message-ID: <1352710047-3663-1-git-send-email-abhi.c.pawar@gmail.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39250 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab2KLIr7 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 12 Nov 2012 03:47:59 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Abhijit Pawar <abhi.c.pawar@gmail.com>

debug.c: ecryptfs_dump_auth_tok () : salt and sig arrays initialized so as to avoid adding null terminator explicitly.

Signed-off-by: Abhijit Pawar <abhi.c.pawar@gmail.com>
---
 fs/ecryptfs/debug.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 3d2bdf5..480e3b5 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -31,8 +31,8 @@
  */
 void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
 {
-	char salt[ECRYPTFS_SALT_SIZE * 2 + 1];
-	char sig[ECRYPTFS_SIG_SIZE_HEX + 1];
+	char salt[ECRYPTFS_SALT_SIZE * 2 + 1] = {'\0'};
+	char sig[ECRYPTFS_SIG_SIZE_HEX + 1] = {'\0'};
 
 	ecryptfs_printk(KERN_DEBUG, "Auth tok at mem loc [%p]:\n",
 			auth_tok);
@@ -42,7 +42,6 @@ void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
 		ecryptfs_printk(KERN_DEBUG, " * passphrase type\n");
 		ecryptfs_to_hex(salt, auth_tok->token.password.salt,
 				ECRYPTFS_SALT_SIZE);
-		salt[ECRYPTFS_SALT_SIZE * 2] = '\0';
 		ecryptfs_printk(KERN_DEBUG, " * salt = [%s]\n", salt);
 		if (auth_tok->token.password.flags &
 		    ECRYPTFS_PERSISTENT_PASSWORD) {
@@ -50,7 +49,6 @@ void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
 		}
 		memcpy(sig, auth_tok->token.password.signature,
 		       ECRYPTFS_SIG_SIZE_HEX);
-		sig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
 		ecryptfs_printk(KERN_DEBUG, " * signature = [%s]\n", sig);
 	}
 	ecryptfs_printk(KERN_DEBUG, " * session_key.flags = [0x%x]\n",
-- 
1.7.7.6
