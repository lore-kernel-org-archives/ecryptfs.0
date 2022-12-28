From: <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGVjcnlwdGZzOiBtYWluOiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Date: Wed, 28 Dec 2022 09:38:27 +0800 (CST)
Message-ID: <202212280938279799834@zte.com.cn>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiL1Bie (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 27 Dec 2022 20:38:34 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: code@tyhicks.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, xu.panda@zte.com.cn, yang.yang29@zte.com.cn

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 fs/ecryptfs/main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067f..007bed5ddf6e 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -296,9 +296,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			cipher_name_dst =
 				mount_crypt_stat->
 				global_default_cipher_name;
-			strncpy(cipher_name_dst, cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(cipher_name_dst, cipher_name_src,
+				ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
 			cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_ecryptfs_key_bytes:
@@ -328,9 +327,7 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			fnek_src = args[0].from;
 			fnek_dst =
 				mount_crypt_stat->global_default_fnek_sig;
-			strncpy(fnek_dst, fnek_src, ECRYPTFS_SIG_SIZE_HEX);
-			mount_crypt_stat->global_default_fnek_sig[
-				ECRYPTFS_SIG_SIZE_HEX] = '\0';
+			strscpy(fnek_dst, fnek_src, ECRYPTFS_SIG_SIZE_HEX + 1);
 			rc = ecryptfs_add_global_auth_tok(
 				mount_crypt_stat,
 				mount_crypt_stat->global_default_fnek_sig,
@@ -350,10 +347,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			fn_cipher_name_src = args[0].from;
 			fn_cipher_name_dst =
 				mount_crypt_stat->global_default_fn_cipher_name;
-			strncpy(fn_cipher_name_dst, fn_cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			mount_crypt_stat->global_default_fn_cipher_name[
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(fn_cipher_name_dst, fn_cipher_name_src,
+				ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
 			fn_cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_fn_cipher_key_bytes:
-- 
2.15.2
