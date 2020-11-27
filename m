From: trix@redhat.com
Subject: [PATCH] eCryptfs: add a semicolon
Date: Fri, 27 Nov 2020 08:05:13 -0800
Message-ID: <20201127160513.2619747-1-trix@redhat.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730324AbgK0QFX (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 27 Nov 2020 11:05:23 -0500
Received: by mail-qk1-f200.google.com with SMTP id p129so3948434qkc.20
        for <ecryptfs@vger.kernel.org>; Fri, 27 Nov 2020 08:05:20 -0800 (PST)
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: code@tyhicks.com, hannes@cmpxchg.org, mhocko@suse.com, longman@redhat.com, herbert@gondor.apana.org.au, ebiggers@google.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Function like macros should have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index f6a17d259db7..2abd219cfeec 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1172,7 +1172,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 	rc = ecryptfs_cipher_code_to_string(crypt_stat->cipher, cipher_code);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
-				cipher_code)
+				cipher_code);
 		goto out;
 	}
 	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
-- 
2.18.4

