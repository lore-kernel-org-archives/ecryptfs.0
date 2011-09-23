From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] ecryptfs/inode.c: local functions should be static
Date: Fri, 23 Sep 2011 13:33:57 -0700
Message-ID: <201109231333.58042.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:4572 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1IWUea (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 23 Sep 2011 16:34:30 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ecryptfs@vger.kernel.org, tyhicks@linux.vnet.ibm.com, kirkland@canonical.com

This quiets the following sparse noise:

warning: symbol 'ecryptfs_getattr_link' was not declared. Should it be static?
warning: symbol 'ecryptfs_getattr' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Tyler Hicks <tyhicks@linux.vnet.ibm.com>
Cc: Dustin Kirkland <kirkland@canonical.com>

---

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 11f8582..6837d8d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1017,7 +1017,7 @@ out:
 	return rc;
 }
 
-int ecryptfs_getattr_link(struct vfsmount *mnt, struct dentry *dentry,
+static int ecryptfs_getattr_link(struct vfsmount *mnt, struct dentry *dentry,
 			  struct kstat *stat)
 {
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
@@ -1039,7 +1039,7 @@ int ecryptfs_getattr_link(struct vfsmount *mnt, struct dentry *dentry,
 	return rc;
 }
 
-int ecryptfs_getattr(struct vfsmount *mnt, struct dentry *dentry,
+static int ecryptfs_getattr(struct vfsmount *mnt, struct dentry *dentry,
 		     struct kstat *stat)
 {
 	struct kstat lower_stat;
