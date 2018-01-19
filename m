From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ecryptfs: lookup: Don't check if mount_crypt_stat is NULL
Date: Thu, 18 Jan 2018 18:40:25 -0800
Message-ID: <1516329625-19236-1-git-send-email-linux@roeck-us.net>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34014 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754836AbeASCka (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 18 Jan 2018 21:40:30 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

mount_crypt_stat is assigned to
&ecryptfs_superblock_to_private(ecryptfs_dentry->d_sb)->mount_crypt_stat,
and mount_crypt_stat is not the first object in struct ecryptfs_sb_info.
mount_crypt_stat is therefore never NULL. At the same time, no crash
in ecryptfs_lookup() has been reported, and the lookup functions in
other file systems don't check if d_sb is NULL either.
Given that, remove the NULL check.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ecryptfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 847904aa63a9..97d17eaeba07 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -395,8 +395,7 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 				ecryptfs_dentry->d_sb)->mount_crypt_stat;
-	if (mount_crypt_stat
-	    && (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
+	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
 		rc = ecryptfs_encrypt_and_encode_filename(
 			&encrypted_and_encoded_name, &len,
 			mount_crypt_stat, name, len);
-- 
2.7.4
