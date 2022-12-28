From: <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGVjcnlwdGZzOiBjcnlwdG86IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Date: Wed, 28 Dec 2022 09:36:54 +0800 (CST)
Message-ID: <202212280936545669762@zte.com.cn>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BhB (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 27 Dec 2022 20:37:01 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: code@tyhicks.com
Cc: ira.weiny@intel.com, fmdefrancesco@gmail.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, xu.panda@zte.com.cn, yang.yang29@zte.com.cn

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 fs/ecryptfs/crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 03263ebcccc6..c618a6878584 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1630,9 +1630,8 @@ ecryptfs_add_new_key_tfm(struct ecryptfs_key_tfm **key_tfm, char *cipher_name,
 		goto out;
 	}
 	mutex_init(&tmp_tfm->key_tfm_mutex);
-	strncpy(tmp_tfm->cipher_name, cipher_name,
-		ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-	tmp_tfm->cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+	strscpy(tmp_tfm->cipher_name, cipher_name,
+		ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
 	tmp_tfm->key_size = key_size;
 	rc = ecryptfs_process_key_cipher(&tmp_tfm->key_tfm,
 					 tmp_tfm->cipher_name,
-- 
2.15.2
