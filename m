From: jeffm@suse.com
Subject: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't support it
Date: Tue,  5 Jul 2016 17:32:30 -0400
Message-ID: <1467754350-8995-2-git-send-email-jeffm@suse.com>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36329 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbcGEVno (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 5 Jul 2016 17:43:44 -0400
In-Reply-To: <1467754350-8995-1-git-send-email-jeffm@suse.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: Jann Horn <jann@thejh.net>, stable@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

There are legitimate reasons to disallow mmap on certain files, notably
in sysfs or procfs.  We shouldn't emulate mmap support on file systems
that don't offer support natively.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/ecryptfs/file.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 7000b96..4aaa656 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -169,6 +169,20 @@ out:
 	return rc;
 }
 
+
+static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct dentry *dentry = ecryptfs_dentry_to_lower(file_dentry(file));
+	/*
+	 * Don't allow mmap on top of file systems that don't support it
+	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
+	 * allows recursive mounting, this will need to be extended.
+	 */
+	if (!d_inode(dentry)->i_fop->mmap)
+		return -ENODEV;
+	return generic_file_mmap(file, vma);
+}
+
 /**
  * ecryptfs_open
  * @inode: inode speciying file to open
@@ -403,7 +417,7 @@ const struct file_operations ecryptfs_main_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = ecryptfs_compat_ioctl,
 #endif
-	.mmap = generic_file_mmap,
+	.mmap = ecryptfs_mmap,
 	.open = ecryptfs_open,
 	.flush = ecryptfs_flush,
 	.release = ecryptfs_release,
-- 
2.7.1
