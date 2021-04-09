From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/3] ecryptfs: remove unused helpers
Date: Fri,  9 Apr 2021 18:24:20 +0200
Message-ID: <20210409162422.1326565-2-brauner@kernel.org>
References: <20210409162422.1326565-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIQ0K (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:10 -0400
In-Reply-To: <20210409162422.1326565-1-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>

From: Christian Brauner <christian.brauner@ubuntu.com>

Remove two helpers that are unused.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ecryptfs/ecryptfs_kernel.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index e6ac78c62ca4..463b2d99b554 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -496,12 +496,6 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
 	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
 }
 
-static inline struct ecryptfs_dentry_info *
-ecryptfs_dentry_to_private(struct dentry *dentry)
-{
-	return (struct ecryptfs_dentry_info *)dentry->d_fsdata;
-}
-
 static inline void
 ecryptfs_set_dentry_private(struct dentry *dentry,
 			    struct ecryptfs_dentry_info *dentry_info)
@@ -515,12 +509,6 @@ ecryptfs_dentry_to_lower(struct dentry *dentry)
 	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
 }
 
-static inline struct vfsmount *
-ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
-{
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt;
-}
-
 static inline struct path *
 ecryptfs_dentry_to_lower_path(struct dentry *dentry)
 {
-- 
2.27.0

