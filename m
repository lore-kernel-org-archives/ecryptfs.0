From: jeffm@suse.com
Subject: [PATCH 1/2] Revert "ecryptfs: forbid opening files without mmap handler"
Date: Tue,  5 Jul 2016 17:32:29 -0400
Message-ID: <1467754350-8995-1-git-send-email-jeffm@suse.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: Jann Horn <jann@thejh.net>, stable@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

This reverts commit 2f36db71009304b3f0b95afacd8eba1f9f046b87.

It fixed a local root exploit but also introduced a dependency on
the lower file system implementing an mmap operation just to open a file,
which is a bit of a heavy hammer.  The right fix is to have mmap depend
on the existence of the mmap handler instead.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/ecryptfs/kthread.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index e818f5a..866bb18 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/mount.h>
-#include <linux/file.h>
 #include "ecryptfs_kernel.h"
 
 struct ecryptfs_open_req {
@@ -148,7 +147,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
 	flags |= IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
 	(*lower_file) = dentry_open(&req.path, flags, cred);
 	if (!IS_ERR(*lower_file))
-		goto have_file;
+		goto out;
 	if ((flags & O_ACCMODE) == O_RDONLY) {
 		rc = PTR_ERR((*lower_file));
 		goto out;
@@ -166,16 +165,8 @@ int ecryptfs_privileged_open(struct file **lower_file,
 	mutex_unlock(&ecryptfs_kthread_ctl.mux);
 	wake_up(&ecryptfs_kthread_ctl.wait);
 	wait_for_completion(&req.done);
-	if (IS_ERR(*lower_file)) {
+	if (IS_ERR(*lower_file))
 		rc = PTR_ERR(*lower_file);
-		goto out;
-	}
-have_file:
-	if ((*lower_file)->f_op->mmap == NULL) {
-		fput(*lower_file);
-		*lower_file = NULL;
-		rc = -EMEDIUMTYPE;
-	}
 out:
 	return rc;
 }
-- 
2.7.1
