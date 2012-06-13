From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 1/2] eCryptfs: Unlink lower inode when ecryptfs_create() fails
Date: Tue, 12 Jun 2012 19:30:46 -0700
Message-ID: <1339554647-17445-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54408 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab2FMCaw (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 12 Jun 2012 22:30:52 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Colin Ian King <colin.king@canonical.com>

ecryptfs_create() creates a lower inode, allocates an eCryptfs inode,
initializes the eCryptfs inode and cryptographic metadata attached to
the inode, and then writes the metadata to the header of the file.

If an error was to occur after the lower inode was created, an empty
lower file would be left in the lower filesystem. This is a problem
because ecryptfs_open() refuses to open any lower files which do not
have the appropriate metadata in the file header.

This patch properly unlinks the lower inode when an error occurs in the
later stages of ecryptfs_create(), reducing the chance that an empty
lower file will be left in the lower filesystem.

https://launchpad.net/bugs/872905

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Colin Ian King <colin.king@canonical.com>
---
 fs/ecryptfs/inode.c |   55 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index a07441a..65efe5f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -143,6 +143,31 @@ static int ecryptfs_interpose(struct dentry *lower_dentry,
 	return 0;
 }
 
+static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
+			      struct inode *inode)
+{
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	struct inode *lower_dir_inode = ecryptfs_inode_to_lower(dir);
+	struct dentry *lower_dir_dentry;
+	int rc;
+
+	dget(lower_dentry);
+	lower_dir_dentry = lock_parent(lower_dentry);
+	rc = vfs_unlink(lower_dir_inode, lower_dentry);
+	if (rc) {
+		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
+		goto out_unlock;
+	}
+	fsstack_copy_attr_times(dir, lower_dir_inode);
+	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
+	inode->i_ctime = dir->i_ctime;
+	d_drop(dentry);
+out_unlock:
+	unlock_dir(lower_dir_dentry);
+	dput(lower_dentry);
+	return rc;
+}
+
 /**
  * ecryptfs_do_create
  * @directory_inode: inode of the new file's dentry's parent in ecryptfs
@@ -182,8 +207,10 @@ ecryptfs_do_create(struct inode *directory_inode,
 	}
 	inode = __ecryptfs_get_inode(lower_dentry->d_inode,
 				     directory_inode->i_sb);
-	if (IS_ERR(inode))
+	if (IS_ERR(inode)) {
+		vfs_unlink(lower_dir_dentry->d_inode, lower_dentry);
 		goto out_lock;
+	}
 	fsstack_copy_attr_times(directory_inode, lower_dir_dentry->d_inode);
 	fsstack_copy_inode_size(directory_inode, lower_dir_dentry->d_inode);
 out_lock:
@@ -265,7 +292,9 @@ ecryptfs_create(struct inode *directory_inode, struct dentry *ecryptfs_dentry,
 	 * that this on disk file is prepared to be an ecryptfs file */
 	rc = ecryptfs_initialize_file(ecryptfs_dentry, ecryptfs_inode);
 	if (rc) {
-		drop_nlink(ecryptfs_inode);
+		ecryptfs_do_unlink(directory_inode, ecryptfs_dentry,
+				   ecryptfs_inode);
+		make_bad_inode(ecryptfs_inode);
 		unlock_new_inode(ecryptfs_inode);
 		iput(ecryptfs_inode);
 		goto out;
@@ -477,27 +506,7 @@ out_lock:
 
 static int ecryptfs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int rc = 0;
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct inode *lower_dir_inode = ecryptfs_inode_to_lower(dir);
-	struct dentry *lower_dir_dentry;
-
-	dget(lower_dentry);
-	lower_dir_dentry = lock_parent(lower_dentry);
-	rc = vfs_unlink(lower_dir_inode, lower_dentry);
-	if (rc) {
-		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
-		goto out_unlock;
-	}
-	fsstack_copy_attr_times(dir, lower_dir_inode);
-	set_nlink(dentry->d_inode,
-		  ecryptfs_inode_to_lower(dentry->d_inode)->i_nlink);
-	dentry->d_inode->i_ctime = dir->i_ctime;
-	d_drop(dentry);
-out_unlock:
-	unlock_dir(lower_dir_dentry);
-	dput(lower_dentry);
-	return rc;
+	return ecryptfs_do_unlink(dir, dentry, dentry->d_inode);
 }
 
 static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
-- 
1.7.9.5
