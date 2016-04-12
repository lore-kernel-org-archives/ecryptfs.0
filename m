From: Ricky Zhou <rickyz@chromium.org>
Subject: [PATCH v2] ecryptfs: open lower files using kernel creds
Date: Tue, 12 Apr 2016 03:15:44 -0700
Message-ID: <1460456144-27669-1-git-send-email-rickyz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, keescook@chromium.org

In LSMs such as SELinux, files can be associated with state from the
credentials of the task that opens it. Since ecryptfs shares a single
handle to lower files across tasks that access it, others tasks can
later be denied access to the lower file as a result.

This change removes the kthread and unconditionally opens lower files
with kernel service credentials. Under SELinux, users will need to allow
the FD__USE permissions on the kernel context to process that need to
access files on an ecryptfs filesystem.

Signed-off-by: Ricky Zhou <rickyz@chromium.org>
---
 fs/ecryptfs/Makefile          |   2 +-
 fs/ecryptfs/ecryptfs_kernel.h |   4 -
 fs/ecryptfs/kthread.c         | 172 ------------------------------------------
 fs/ecryptfs/main.c            |  78 +++++++++++++++----
 4 files changed, 65 insertions(+), 191 deletions(-)
 delete mode 100644 fs/ecryptfs/kthread.c

diff --git a/fs/ecryptfs/Makefile b/fs/ecryptfs/Makefile
index 49678a6..f0bcf51 100644
--- a/fs/ecryptfs/Makefile
+++ b/fs/ecryptfs/Makefile
@@ -5,6 +5,6 @@
 obj-$(CONFIG_ECRYPT_FS) += ecryptfs.o
 
 ecryptfs-y := dentry.o file.o inode.o main.o super.o mmap.o read_write.o \
-	      crypto.o keystore.o kthread.o debug.o
+	      crypto.o keystore.o debug.o
 
 ecryptfs-$(CONFIG_ECRYPT_FS_MESSAGING) += messaging.o miscdev.o
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index d123fba..6434736 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -695,10 +695,6 @@ int ecryptfs_find_daemon_by_euid(struct ecryptfs_daemon **daemon);
 #endif
 int ecryptfs_init_kthread(void);
 void ecryptfs_destroy_kthread(void);
-int ecryptfs_privileged_open(struct file **lower_file,
-			     struct dentry *lower_dentry,
-			     struct vfsmount *lower_mnt,
-			     const struct cred *cred);
 int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode);
 void ecryptfs_put_lower_file(struct inode *inode);
 int
diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
deleted file mode 100644
index 866bb18..0000000
--- a/fs/ecryptfs/kthread.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/**
- * eCryptfs: Linux filesystem encryption layer
- *
- * Copyright (C) 2008 International Business Machines Corp.
- *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/kthread.h>
-#include <linux/freezer.h>
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include <linux/mount.h>
-#include "ecryptfs_kernel.h"
-
-struct ecryptfs_open_req {
-	struct file **lower_file;
-	struct path path;
-	struct completion done;
-	struct list_head kthread_ctl_list;
-};
-
-static struct ecryptfs_kthread_ctl {
-#define ECRYPTFS_KTHREAD_ZOMBIE 0x00000001
-	u32 flags;
-	struct mutex mux;
-	struct list_head req_list;
-	wait_queue_head_t wait;
-} ecryptfs_kthread_ctl;
-
-static struct task_struct *ecryptfs_kthread;
-
-/**
- * ecryptfs_threadfn
- * @ignored: ignored
- *
- * The eCryptfs kernel thread that has the responsibility of getting
- * the lower file with RW permissions.
- *
- * Returns zero on success; non-zero otherwise
- */
-static int ecryptfs_threadfn(void *ignored)
-{
-	set_freezable();
-	while (1)  {
-		struct ecryptfs_open_req *req;
-
-		wait_event_freezable(
-			ecryptfs_kthread_ctl.wait,
-			(!list_empty(&ecryptfs_kthread_ctl.req_list)
-			 || kthread_should_stop()));
-		mutex_lock(&ecryptfs_kthread_ctl.mux);
-		if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
-			mutex_unlock(&ecryptfs_kthread_ctl.mux);
-			goto out;
-		}
-		while (!list_empty(&ecryptfs_kthread_ctl.req_list)) {
-			req = list_first_entry(&ecryptfs_kthread_ctl.req_list,
-					       struct ecryptfs_open_req,
-					       kthread_ctl_list);
-			list_del(&req->kthread_ctl_list);
-			*req->lower_file = dentry_open(&req->path,
-				(O_RDWR | O_LARGEFILE), current_cred());
-			complete(&req->done);
-		}
-		mutex_unlock(&ecryptfs_kthread_ctl.mux);
-	}
-out:
-	return 0;
-}
-
-int __init ecryptfs_init_kthread(void)
-{
-	int rc = 0;
-
-	mutex_init(&ecryptfs_kthread_ctl.mux);
-	init_waitqueue_head(&ecryptfs_kthread_ctl.wait);
-	INIT_LIST_HEAD(&ecryptfs_kthread_ctl.req_list);
-	ecryptfs_kthread = kthread_run(&ecryptfs_threadfn, NULL,
-				       "ecryptfs-kthread");
-	if (IS_ERR(ecryptfs_kthread)) {
-		rc = PTR_ERR(ecryptfs_kthread);
-		printk(KERN_ERR "%s: Failed to create kernel thread; rc = [%d]"
-		       "\n", __func__, rc);
-	}
-	return rc;
-}
-
-void ecryptfs_destroy_kthread(void)
-{
-	struct ecryptfs_open_req *req, *tmp;
-
-	mutex_lock(&ecryptfs_kthread_ctl.mux);
-	ecryptfs_kthread_ctl.flags |= ECRYPTFS_KTHREAD_ZOMBIE;
-	list_for_each_entry_safe(req, tmp, &ecryptfs_kthread_ctl.req_list,
-				 kthread_ctl_list) {
-		list_del(&req->kthread_ctl_list);
-		*req->lower_file = ERR_PTR(-EIO);
-		complete(&req->done);
-	}
-	mutex_unlock(&ecryptfs_kthread_ctl.mux);
-	kthread_stop(ecryptfs_kthread);
-	wake_up(&ecryptfs_kthread_ctl.wait);
-}
-
-/**
- * ecryptfs_privileged_open
- * @lower_file: Result of dentry_open by root on lower dentry
- * @lower_dentry: Lower dentry for file to open
- * @lower_mnt: Lower vfsmount for file to open
- *
- * This function gets a r/w file opened againt the lower dentry.
- *
- * Returns zero on success; non-zero otherwise
- */
-int ecryptfs_privileged_open(struct file **lower_file,
-			     struct dentry *lower_dentry,
-			     struct vfsmount *lower_mnt,
-			     const struct cred *cred)
-{
-	struct ecryptfs_open_req req;
-	int flags = O_LARGEFILE;
-	int rc = 0;
-
-	init_completion(&req.done);
-	req.lower_file = lower_file;
-	req.path.dentry = lower_dentry;
-	req.path.mnt = lower_mnt;
-
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
-	}
-	mutex_lock(&ecryptfs_kthread_ctl.mux);
-	if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
-		rc = -EIO;
-		mutex_unlock(&ecryptfs_kthread_ctl.mux);
-		printk(KERN_ERR "%s: We are in the middle of shutting down; "
-		       "aborting privileged request to open lower file\n",
-			__func__);
-		goto out;
-	}
-	list_add_tail(&req.kthread_ctl_list, &ecryptfs_kthread_ctl.req_list);
-	mutex_unlock(&ecryptfs_kthread_ctl.mux);
-	wake_up(&ecryptfs_kthread_ctl.wait);
-	wait_for_completion(&req.done);
-	if (IS_ERR(*lower_file))
-		rc = PTR_ERR(*lower_file);
-out:
-	return rc;
-}
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 1698132..9459fbb 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -24,6 +24,7 @@
  * 02111-1307, USA.
  */
 
+#include <linux/cred.h>
 #include <linux/dcache.h>
 #include <linux/file.h>
 #include <linux/module.h>
@@ -95,6 +96,56 @@ void __ecryptfs_printk(const char *fmt, ...)
 }
 
 /**
+ * Credentials for opening lower files.
+ */
+static const struct cred *kernel_cred;
+
+/**
+ * ecryptfs_privileged_open
+ * @lower_file: Result of dentry_open by root on lower dentry
+ * @lower_dentry: Lower dentry for file to open
+ * @lower_mnt: Lower vfsmount for file to open
+ *
+ * This function gets a r/w file opened againt the lower dentry.
+ *
+ * Returns zero on success; non-zero otherwise
+ */
+static int ecryptfs_privileged_open(struct file **lower_file,
+				    struct dentry *lower_dentry,
+				    struct vfsmount *lower_mnt)
+{
+	struct path path;
+	int flags = O_LARGEFILE;
+	int rc = 0;
+	const struct cred *old_cred;
+
+	path.dentry = lower_dentry;
+	path.mnt = lower_mnt;
+	flags |= IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
+
+	/*
+	 * Use kernel service credentials to open the lower file, as the current
+	 * task may not have write privileges.  Uses kernel creds instead of
+	 * normal creds with CAP_DAC_OVERRIDE because because some LSMs like
+	 * SELinux associate the file with extra state from the current
+	 * credentials. When this happens, access to the lower file can
+	 * be affected by which task was the first to open it.
+	 */
+	old_cred = override_creds(kernel_cred);
+
+	/* Corresponding dput() and mntput() are done when the
+	 * lower file is fput() when all eCryptfs files for the inode are
+	 * released. */
+	(*lower_file) = dentry_open(&path, flags, kernel_cred);
+
+	revert_creds(old_cred);
+
+	if (IS_ERR(*lower_file))
+		rc = PTR_ERR(*lower_file);
+	return rc;
+}
+
+/**
  * ecryptfs_init_lower_file
  * @ecryptfs_dentry: Fully initialized eCryptfs dentry object, with
  *                   the lower dentry and the lower mount set
@@ -118,12 +169,10 @@ void __ecryptfs_printk(const char *fmt, ...)
 static int ecryptfs_init_lower_file(struct dentry *dentry,
 				    struct file **lower_file)
 {
-	const struct cred *cred = current_cred();
 	struct path *path = ecryptfs_dentry_to_lower_path(dentry);
 	int rc;
 
-	rc = ecryptfs_privileged_open(lower_file, path->dentry, path->mnt,
-				      cred);
+	rc = ecryptfs_privileged_open(lower_file, path->dentry, path->mnt);
 	if (rc) {
 		printk(KERN_ERR "Error opening lower file "
 		       "for lower_dentry [0x%p] and lower_mnt [0x%p]; "
@@ -829,29 +878,30 @@ static int __init ecryptfs_init(void)
 				(unsigned long)PAGE_SIZE);
 		goto out;
 	}
+	kernel_cred = prepare_kernel_cred(NULL);
+	if (kernel_cred == NULL) {
+		rc = -ENOMEM;
+		ecryptfs_printk(KERN_ERR,
+				"Failed to prepare kernel credentials\n");
+		goto out;
+	}
 	rc = ecryptfs_init_kmem_caches();
 	if (rc) {
 		printk(KERN_ERR
 		       "Failed to allocate one or more kmem_cache objects\n");
-		goto out;
+		goto out_put_cred;
 	}
 	rc = do_sysfs_registration();
 	if (rc) {
 		printk(KERN_ERR "sysfs registration failed\n");
 		goto out_free_kmem_caches;
 	}
-	rc = ecryptfs_init_kthread();
-	if (rc) {
-		printk(KERN_ERR "%s: kthread initialization failed; "
-		       "rc = [%d]\n", __func__, rc);
-		goto out_do_sysfs_unregistration;
-	}
 	rc = ecryptfs_init_messaging();
 	if (rc) {
 		printk(KERN_ERR "Failure occurred while attempting to "
 				"initialize the communications channel to "
 				"ecryptfsd\n");
-		goto out_destroy_kthread;
+		goto out_do_sysfs_unregistration;
 	}
 	rc = ecryptfs_init_crypto();
 	if (rc) {
@@ -873,12 +923,12 @@ out_destroy_crypto:
 	ecryptfs_destroy_crypto();
 out_release_messaging:
 	ecryptfs_release_messaging();
-out_destroy_kthread:
-	ecryptfs_destroy_kthread();
 out_do_sysfs_unregistration:
 	do_sysfs_unregistration();
 out_free_kmem_caches:
 	ecryptfs_free_kmem_caches();
+out_put_cred:
+	put_cred(kernel_cred);
 out:
 	return rc;
 }
@@ -892,10 +942,10 @@ static void __exit ecryptfs_exit(void)
 		printk(KERN_ERR "Failure whilst attempting to destroy crypto; "
 		       "rc = [%d]\n", rc);
 	ecryptfs_release_messaging();
-	ecryptfs_destroy_kthread();
 	do_sysfs_unregistration();
 	unregister_filesystem(&ecryptfs_fs_type);
 	ecryptfs_free_kmem_caches();
+	put_cred(kernel_cred);
 }
 
 MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
-- 
2.8.0.rc3.226.g39d4020

