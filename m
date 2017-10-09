From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 2/3] ecryptfs: fix out-of-bounds read of key payload
Date: Mon,  9 Oct 2017 12:51:28 -0700
Message-ID: <20171009195129.68610-2-ebiggers3@gmail.com>
References: <20171009195129.68610-1-ebiggers3@gmail.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33726 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754497AbdJITwp (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 9 Oct 2017 15:52:45 -0400
In-Reply-To: <20171009195129.68610-1-ebiggers3@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>

From: Eric Biggers <ebiggers@google.com>

eCryptfs blindly casts the user-supplied key payload to a
'struct ecryptfs_auth_tok' without validating that the payload does, in
fact, have the size of a 'struct ecryptfs_auth_tok'.  Fix it.

Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: <stable@vger.kernel.org>    [v2.6.19+]
Cc: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Changed since v1: added Reviewed-by and resent in series with just the
ecryptfs patches.  Can this please be taken through the ecryptfs tree?

 fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
 fs/ecryptfs/keystore.c        | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 3fbc0ff79699..945844d5f0ef 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -93,6 +93,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	if (!payload)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (payload->payload_datalen != sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
@@ -129,6 +132,9 @@ ecryptfs_get_key_payload_data(struct key *key)
 	if (!ukp)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (ukp->datalen != sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)ukp->data;
 }
 
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index fa218cd64f74..95e20ab67df3 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -471,6 +471,10 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
 	(*auth_tok) = ecryptfs_get_key_payload_data(auth_tok_key);
 	if (IS_ERR(*auth_tok)) {
 		rc = PTR_ERR(*auth_tok);
+		if (rc == -EINVAL) {
+			ecryptfs_printk(KERN_ERR,
+					"Authentication token payload has wrong length\n");
+		}
 		*auth_tok = NULL;
 		goto out;
 	}
-- 
2.14.2.920.gcf0c67979c-goog
