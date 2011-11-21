From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Flush file in vma close
Date: Mon, 21 Nov 2011 11:24:32 -0600
Message-ID: <1321896272-10130-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33521 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab1KURYm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 21 Nov 2011 12:24:42 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eCryptfs <ecryptfs@vger.kernel.org>
Cc: John Johansen <john.johansen@canonical.com>

Dirty pages weren't being written back when an mmap'ed eCryptfs file was
closed before the mapping was unmapped. Since f_ops->flush() is not
called by the munmap() path, the lower file was simply being released.
This patch flushes the eCryptfs file in the vm_ops->close() path.

https://launchpad.net/bugs/870326

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/file.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c6ac98c..d3f95f9 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -139,6 +139,27 @@ out:
 	return rc;
 }
 
+static void ecryptfs_vma_close(struct vm_area_struct *vma)
+{
+	filemap_write_and_wait(vma->vm_file->f_mapping);
+}
+
+static const struct vm_operations_struct ecryptfs_file_vm_ops = {
+	.close		= ecryptfs_vma_close,
+	.fault		= filemap_fault,
+};
+
+static int ecryptfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int rc;
+
+	rc = generic_file_mmap(file, vma);
+	if (!rc)
+		vma->vm_ops = &ecryptfs_file_vm_ops;
+
+	return rc;
+}
+
 struct kmem_cache *ecryptfs_file_info_cache;
 
 /**
@@ -349,7 +370,7 @@ const struct file_operations ecryptfs_main_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = ecryptfs_compat_ioctl,
 #endif
-	.mmap = generic_file_mmap,
+	.mmap = ecryptfs_file_mmap,
 	.open = ecryptfs_open,
 	.flush = ecryptfs_flush,
 	.release = ecryptfs_release,
-- 
1.7.5.4
