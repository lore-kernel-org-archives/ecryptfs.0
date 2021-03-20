From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/4] ecryptfs: get rid of pointless dget/dput in ->symlink()
 and ->link()
Date: Sat, 20 Mar 2021 21:51:05 +0000
Message-ID: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35550 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCTVxX (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 20 Mar 2021 17:53:23 -0400
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

calls in ->unlink(), ->rmdir() and ->rename() make sense - we want
to prevent the underlying dentries going negative there.  In
->symlink() and ->link() they are absolutely pointless.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..689aa493e587 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -437,8 +437,6 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
 	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
-	dget(lower_old_dentry);
-	dget(lower_new_dentry);
 	lower_dir_dentry = lock_parent(lower_new_dentry);
 	rc = vfs_link(lower_old_dentry, &init_user_ns,
 		      d_inode(lower_dir_dentry), lower_new_dentry, NULL);
@@ -454,8 +452,6 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
 	unlock_dir(lower_dir_dentry);
-	dput(lower_new_dentry);
-	dput(lower_old_dentry);
 	return rc;
 }
 
@@ -476,7 +472,6 @@ static int ecryptfs_symlink(struct user_namespace *mnt_userns,
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat = NULL;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	dget(lower_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		dir->i_sb)->mount_crypt_stat;
@@ -498,7 +493,6 @@ static int ecryptfs_symlink(struct user_namespace *mnt_userns,
 	fsstack_copy_inode_size(dir, d_inode(lower_dir_dentry));
 out_lock:
 	unlock_dir(lower_dir_dentry);
-	dput(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
-- 
2.11.0

