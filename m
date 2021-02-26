From: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] ecryptfs: add rename flag support
Date: Fri, 26 Feb 2021 15:01:25 -0600
Message-ID: <20210226210125.77692-1-jeffrey.mitchell@starlab.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bl2gcc02on2093.outbound.protection.outlook.com ([40.107.89.93]:63680
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230434AbhBZVCZ (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 26 Feb 2021 16:02:25 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Mitchell <jeffrey.mitchell@starlab.io>

Currently, ecryptfs_rename() returns EINVAL if any flags are passed in.
However, if the lower filesystem has support for those flags, it doesn't
require any additional complexity to take advantage of it in eCryptfs.

Add flag support to ecryptfs_rename() by passing them through to the lower
filesystem

Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
---
 fs/ecryptfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..647afc2fd754 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -601,9 +601,6 @@ ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode *target_inode;
 	struct renamedata rd = {};
 
-	if (flags)
-		return -EINVAL;
-
 	lower_old_dir_dentry = ecryptfs_dentry_to_lower(old_dentry->d_parent);
 	lower_new_dir_dentry = ecryptfs_dentry_to_lower(new_dentry->d_parent);
 
@@ -636,6 +633,7 @@ ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	rd.new_mnt_userns	= &init_user_ns;
 	rd.new_dir		= d_inode(lower_new_dir_dentry);
 	rd.new_dentry		= lower_new_dentry;
+	rd.flags		= flags;
 	rc = vfs_rename(&rd);
 	if (rc)
 		goto out_lock;
-- 
2.25.1

