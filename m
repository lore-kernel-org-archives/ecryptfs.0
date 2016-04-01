From: Ricky Zhou <rickyz@chromium.org>
Subject: [PATCH] ecryptfs: open lower files on kthread under SELinux
Date: Thu, 31 Mar 2016 19:36:38 -0700
Message-ID: <1459478198-37952-1-git-send-email-rickyz@chromium.org>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35179 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbcDAChO (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 31 Mar 2016 22:37:14 -0400
Received: by mail-pf0-f176.google.com with SMTP id n5so83284376pfn.2
        for <ecryptfs@vger.kernel.org>; Thu, 31 Mar 2016 19:37:14 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, keescook@chromium.org, Ricky Zhou <rickyz@chromium.org>

When SELinux is enabled, files are associated with the current task's
SID when they are opened. Before this change, the lower file would
sometimes be associated with the SID of the first process to open the
corresponding eCryptfs file. If a second process attempts to access this
file through the same lower file, the access is denied unless the
SELinux policy allows the second process to use files opened by the
first process (the FD__USE permission).

Since it may not be desirable to allow all processes this permission,
this change always opens the lower file from a thread with the kernel
SID. This way, the policy only needs to grant all processes FD__USE on
the kernel context (which in practice, is exactly the use of eCryptfs
lower files).

Signed-off-by: Ricky Zhou <rickyz@chromium.org>
---
 fs/ecryptfs/kthread.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index 866bb18..0ce7828 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/mount.h>
+#include <linux/selinux.h>
 #include "ecryptfs_kernel.h"
 
 struct ecryptfs_open_req {
@@ -141,17 +142,30 @@ int ecryptfs_privileged_open(struct file **lower_file,
 	req.path.dentry = lower_dentry;
 	req.path.mnt = lower_mnt;
 
-	/* Corresponding dput() and mntput() are done when the
-	 * lower file is fput() when all eCryptfs files for the inode are
-	 * released. */
-	flags |= IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
-	(*lower_file) = dentry_open(&req.path, flags, cred);
-	if (!IS_ERR(*lower_file))
-		goto out;
-	if ((flags & O_ACCMODE) == O_RDONLY) {
-		rc = PTR_ERR((*lower_file));
-		goto out;
+	/*
+	 * When SELinux is enabled, force the lower file to be opened by the
+	 * kernel thread. Otherwise, the lower file will be associated with the
+	 * SELinux context of the first process that opens it, which may prevent
+	 * a different process from using it, unless that process has permission
+	 * to use fds from the first process.
+	 *
+	 * If SELinux is enabled, then any process that needs read access to an
+	 * ecryptfs filesytem must allow fd:use on the kernel context.
+	 */
+	if (!selinux_is_enabled()) {
+		/* Corresponding dput() and mntput() are done when the lower
+		 * file is fput() when all eCryptfs files for the inode are
+		 * released. */
+		flags |= IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
+		(*lower_file) = dentry_open(&req.path, flags, cred);
+		if (!IS_ERR(*lower_file))
+			goto out;
+		if ((flags & O_ACCMODE) == O_RDONLY) {
+			rc = PTR_ERR((*lower_file));
+			goto out;
+		}
 	}
+
 	mutex_lock(&ecryptfs_kthread_ctl.mux);
 	if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
 		rc = -EIO;
-- 
2.8.0.rc3.226.g39d4020
