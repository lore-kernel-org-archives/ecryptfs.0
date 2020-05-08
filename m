From: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] ecryptfs: Fix inodes not being evicted until unmount
Date: Fri, 8 May 2020 09:31:33 -0500
Message-ID: <20200508143131.GA7116@jeffrey-work>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-dm3gcc02on2127.outbound.protection.outlook.com ([40.107.91.127]:15904
        "EHLO GCC02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbgEHObh (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 8 May 2020 10:31:37 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.robertson@starlab.io

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

