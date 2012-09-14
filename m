From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Copy up attributes of the lower target inode after rename
Date: Thu, 13 Sep 2012 21:40:04 -0700
Message-ID: <1347597604-14905-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49818 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2INEkR (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 14 Sep 2012 00:40:17 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Sergio Pena <sergio.pena@gazzang.com>

After calling into the lower filesystem to do a rename, the lower target
inode's attributes were not copied up to the eCryptfs target inode. This
resulted in the eCryptfs target inode staying around, rather than being
evicted, because i_nlink was not updated for the eCryptfs inode. This
also meant that eCryptfs didn't do the final iput() on the lower target
inode so it stayed around, as well. This would result in a failure to
free up space occupied by the target file in the rename() operation.
Both target inodes would eventually be evicted when the eCryptfs
filesystem was unmounted.

This patch calls fsstack_copy_attr_all() after the lower filesystem
does its ->rename() so that important inode attributes, such as i_nlink,
are updated at the eCryptfs layer. ecryptfs_evict_inode() is now called
and eCryptfs can drop its final reference on the lower inode.

http://launchpad.net/bugs/561129

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Sergio Pena <sergio.pena@gazzang.com>
---
 fs/ecryptfs/inode.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 534b129..cc7709e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -619,6 +619,7 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
 	struct dentry *trap = NULL;
+	struct inode *target_inode;
 
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
 	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
@@ -626,6 +627,7 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	dget(lower_new_dentry);
 	lower_old_dir_dentry = dget_parent(lower_old_dentry);
 	lower_new_dir_dentry = dget_parent(lower_new_dentry);
+	target_inode = new_dentry->d_inode;
 	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
 	/* source should not be ancestor of target */
 	if (trap == lower_old_dentry) {
@@ -641,6 +643,9 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			lower_new_dir_dentry->d_inode, lower_new_dentry);
 	if (rc)
 		goto out_lock;
+	if (target_inode)
+		fsstack_copy_attr_all(target_inode,
+				      ecryptfs_inode_to_lower(target_inode));
 	fsstack_copy_attr_all(new_dir, lower_new_dir_dentry->d_inode);
 	if (new_dir != old_dir)
 		fsstack_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
-- 
1.7.10.4
