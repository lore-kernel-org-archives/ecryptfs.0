From: Simon Que <sque@chromium.org>
Subject: [PATCH v2] fs: ecryptfs: initialize payload_len in keystore.c
Date: Thu, 17 Jan 2013 11:18:20 -0800
Message-ID: <1358450300-23826-1-git-send-email-sque@chromium.org>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44535 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab3AQTXy (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Jan 2013 14:23:54 -0500
Received: by mail-oa0-f73.google.com with SMTP id n12so761130oag.0
        for <ecryptfs@vger.kernel.org>; Thu, 17 Jan 2013 11:23:54 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, tyhicks@canonical.com, dustin.kirkland@gazzang.com
Cc: msb@chromium.org, Simon Que <sque@chromium.org>

This is meant to remove a compiler warning.  It should not make any
functional change.

payload_len should be initialized when it is passed to
write_tag_64_packet() as a pointer.  If that call fails, this function
should return early, and payload_len won't be used.

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
