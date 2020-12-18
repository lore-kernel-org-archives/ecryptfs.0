From: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] ecryptfs: Fix inodes not being evicted until unmount
Date: Fri, 18 Dec 2020 13:07:30 -0600
Message-ID: <20201218190730.141761-1-jeffrey.mitchell@starlab.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bl2gcc02on2109.outbound.protection.outlook.com ([40.107.89.109]:20448
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgLRTJX (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:09:23 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Robertson <daniel.robertson@starlab.io>, Jeffrey Mitchell <jeffrey.mitchell@starlab.io>

On asynchronous base filesystems like NFS, eCryptFS leaves inodes for
deleted files in the cache until unmounting. Change call in
ecryptfs_do_unlink() from set_nlink() to drop_nlink() in order to reliably
evict inodes from the cache even on top of NFS.

Signed-off-by: Dan Robertson <daniel.robertson@starlab.io>
Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
---
 fs/ecryptfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d..f7594b6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -147,7 +147,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 		goto out_unlock;
 	}
 	fsstack_copy_attr_times(dir, lower_dir_inode);
-	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
+	drop_nlink(inode);
 	inode->i_ctime = dir->i_ctime;
 out_unlock:
 	dput(lower_dentry);
-- 
2.7.4

