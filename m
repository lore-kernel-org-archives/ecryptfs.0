From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ecryptfs: remove unneeded buggy code in ecryptfs_do_create()
Date: Tue, 23 Sep 2014 00:39:31 +0400
Message-ID: <1411418371-11953-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:44195 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbaIVUjo (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 22 Sep 2014 16:39:44 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

There is a bug in error handling of lock_parent() in ecryptfs_do_create():
lock_parent() acquries mutex even if dget_parent() fails, so mutex should be unlocked anyway.

But dget_parent() does not fail, so the patch just removes unneeded buggy code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 fs/ecryptfs/inode.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d4a9431ec73c..97735c75085f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -192,12 +192,6 @@ ecryptfs_do_create(struct inode *directory_inode,
 
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
-	if (IS_ERR(lower_dir_dentry)) {
-		ecryptfs_printk(KERN_ERR, "Error locking directory of "
-				"dentry\n");
-		inode = ERR_CAST(lower_dir_dentry);
-		goto out;
-	}
 	rc = vfs_create(lower_dir_dentry->d_inode, lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
@@ -215,7 +209,6 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_inode_size(directory_inode, lower_dir_dentry->d_inode);
 out_lock:
 	unlock_dir(lower_dir_dentry);
-out:
 	return inode;
 }
 
-- 
1.9.1
