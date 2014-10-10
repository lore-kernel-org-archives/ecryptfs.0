From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 3/3] ecryptfs: add fadvise/set_flags calbacks
Date: Fri, 10 Oct 2014 20:29:36 +0400
Message-ID: <1412958576-32621-3-git-send-email-dmonakhov@openvz.org>
References: <1412958576-32621-1-git-send-email-dmonakhov@openvz.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1412958576-32621-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, Dmitry Monakhov <dmonakhov@openvz.org>, tyhicks@canonical.com, ecryptfs@vger.kernel.org

CC: tyhicks@canonical.com
CC: ecryptfs@vger.kernel.org
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 fs/ecryptfs/file.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index db0fad3..637469a 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -31,6 +31,7 @@
 #include <linux/security.h>
 #include <linux/compat.h>
 #include <linux/fs_stack.h>
+#include <linux/fadvise.h>
 #include <linux/aio.h>
 #include "ecryptfs_kernel.h"
 
@@ -333,6 +334,68 @@ ecryptfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 #endif
 
+static int
+ecryptfs_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct file *lower_file = NULL;
+	long rc = 0;
+
+	if (ecryptfs_file_to_private(file))
+		lower_file = ecryptfs_file_to_lower(file);
+
+	if (!lower_file || !lower_file->f_op)
+		return rc;
+
+	if (lower_file->f_op && lower_file->f_op->fadvise)
+		rc = lower_file->f_op->fadvise(lower_file, offset, len, advice);
+	else
+		rc = generic_fadvise(lower_file, offset, len, advice);
+	if (!rc)
+		generic_fadvise(file, offset, len, advice);
+
+	return rc;
+}
+
+#define ECRYPTFS_FL_MASK (O_NONBLOCK | O_NDELAY | O_NOATIME)
+static int ecryptfs_set_flags(struct file *file, int flags)
+{
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
+	struct dentry *ecryptfs_dentry = file->f_path.dentry;
+	struct file *lower_file = NULL;
+	int rc = 0;
+
+	mount_crypt_stat = &ecryptfs_superblock_to_private(
+		ecryptfs_dentry->d_sb)->mount_crypt_stat;
+	if ((mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
+	    && (flags & O_APPEND)) {
+		printk(KERN_WARNING "Mount has encrypted view enabled; "
+		       "files may only be read\n");
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (ecryptfs_file_to_private(file))
+		lower_file = ecryptfs_file_to_lower(file);
+	if (!lower_file)
+		goto out;
+
+	if (lower_file->f_op && lower_file->f_op->set_flags) {
+		rc = lower_file->f_op->set_flags(lower_file, flags);
+		if (rc)
+			return rc;
+	} else {
+		spin_lock(&lower_file->f_lock);
+		lower_file->f_flags = (flags & ECRYPTFS_FL_MASK) |
+			(lower_file->f_flags & ~ECRYPTFS_FL_MASK);
+		spin_unlock(&lower_file->f_lock);
+	}
+	spin_lock(&file->f_lock);
+	file->f_flags = (flags & ECRYPTFS_FL_MASK) |
+		(file->f_flags & ~ECRYPTFS_FL_MASK);
+	spin_unlock(&file->f_lock);
+out:
+	return rc;
+}
 const struct file_operations ecryptfs_dir_fops = {
 	.iterate = ecryptfs_readdir,
 	.read = generic_read_dir,
@@ -347,6 +410,8 @@ const struct file_operations ecryptfs_dir_fops = {
 	.fasync = ecryptfs_fasync,
 	.splice_read = generic_file_splice_read,
 	.llseek = default_llseek,
+	.set_flags = ecryptfs_set_flags,
+	.fadvise = ecryptfs_fadvise,
 };
 
 const struct file_operations ecryptfs_main_fops = {
@@ -367,4 +432,6 @@ const struct file_operations ecryptfs_main_fops = {
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
 	.splice_read = generic_file_splice_read,
+	.set_flags = ecryptfs_set_flags,
+	.fadvise = ecryptfs_fadvise,
 };
-- 
1.7.1

