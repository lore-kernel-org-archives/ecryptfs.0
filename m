From: Matthew Wilcox <willy@linux.intel.com>
Subject: [PATCH] Use ecryptfs_dentry_to_lower_path in a couple of places
Date: Sat, 15 Jun 2013 07:55:59 -0400
Message-ID: <20130615115559.GQ8211@linux.intel.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62839 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386Ab3FOL4F (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sat, 15 Jun 2013 07:56:05 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org


There are two places in ecryptfs that benefit from using
ecryptfs_dentry_to_lower_path() instead of separate calls to
ecryptfs_dentry_to_lower() and ecryptfs_dentry_to_lower_mnt().  Both
sites use fewer instructions and less stack (determined by examining
objdump output).

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index a7abbea..0943f6f 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -49,7 +49,7 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 				unsigned long nr_segs, loff_t pos)
 {
 	ssize_t rc;
-	struct path lower;
+	struct path *path;
 	struct file *file = iocb->ki_filp;
 
 	rc = generic_file_aio_read(iocb, iov, nr_segs, pos);
@@ -60,9 +60,8 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 	if (-EIOCBQUEUED == rc)
 		rc = wait_on_sync_kiocb(iocb);
 	if (rc >= 0) {
-		lower.dentry = ecryptfs_dentry_to_lower(file->f_path.dentry);
-		lower.mnt = ecryptfs_dentry_to_lower_mnt(file->f_path.dentry);
-		touch_atime(&lower);
+		path = ecryptfs_dentry_to_lower_path(file->f_path.dentry);
+		touch_atime(path);
 	}
 	return rc;
 }
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index e924cf4..eb1c597 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -120,16 +120,15 @@ static int ecryptfs_init_lower_file(struct dentry *dentry,
 				    struct file **lower_file)
 {
 	const struct cred *cred = current_cred();
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	struct vfsmount *lower_mnt = ecryptfs_dentry_to_lower_mnt(dentry);
+	struct path *path = ecryptfs_dentry_to_lower_path(dentry);
 	int rc;
 
-	rc = ecryptfs_privileged_open(lower_file, lower_dentry, lower_mnt,
+	rc = ecryptfs_privileged_open(lower_file, path->dentry, path->mnt,
 				      cred);
 	if (rc) {
 		printk(KERN_ERR "Error opening lower file "
 		       "for lower_dentry [0x%p] and lower_mnt [0x%p]; "
-		       "rc = [%d]\n", lower_dentry, lower_mnt, rc);
+		       "rc = [%d]\n", path->dentry, path->mnt, rc);
 		(*lower_file) = NULL;
 	}
 	return rc;
