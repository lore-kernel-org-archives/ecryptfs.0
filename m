From: Simon Que <sque@chromium.org>
Subject: [PATCH] fs: ecryptfs: initialize payload_len in keystore.c
Date: Wed, 16 Jan 2013 18:08:14 -0800
Message-ID: <1358388494-31158-1-git-send-email-sque@chromium.org>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:55179 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897Ab3AQCIj (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 16 Jan 2013 21:08:39 -0500
Received: by mail-ob0-f202.google.com with SMTP id wd20so568283obb.3
        for <ecryptfs@vger.kernel.org>; Wed, 16 Jan 2013 18:08:39 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, tyhicks@canonical.com, dustin.kirkland@gazzang.com
Cc: msb@chromium.org, Simon Que <sque@chromium.org>

Signed-off-by: Simon Que <sque@chromium.org>
---
 fs/ecryptfs/keystore.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 2333203..6154cde 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1150,7 +1150,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 	struct ecryptfs_message *msg = NULL;
 	char *auth_tok_sig;
 	char *payload;
-	size_t payload_len;
+	size_t payload_len = 0;
 	int rc;
 
 	rc = ecryptfs_get_auth_tok_sig(&auth_tok_sig, auth_tok);
-- 
1.7.8.6
