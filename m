From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: file->private_data is always valid
Date: Wed, 13 Nov 2013 10:54:03 -0800
Message-ID: <1384368843-10072-1-git-send-email-tyhicks@canonical.com>
References: <20131112103013.GB10651@elgon.mountain>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41655 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640Ab3KMSyK (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Nov 2013 13:54:10 -0500
In-Reply-To: <20131112103013.GB10651@elgon.mountain>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>

When accessing the lower_file pointer located in private_data of
eCryptfs files, there is no need to check to see if the private_data
pointer has been initialized to a non-NULL value. The file->private_data
and file->private_data->lower_file pointers are always initialized to
non-NULL values in ecryptfs_open().

This change quiets a Smatch warning:

  CHECK   /var/scm/kernel/linux/fs/ecryptfs/file.c
fs/ecryptfs/file.c:321 ecryptfs_unlocked_ioctl() error: potential NULL dereference 'lower_file'.
fs/ecryptfs/file.c:335 ecryptfs_compat_ioctl() error: potential NULL dereference 'lower_file'.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---

Thanks, Dan! You're right that the "if (ecryptfs_file_to_private(file))" check
is not needed.

I'll include this patch in an upcoming pull request.

Tyler

 fs/ecryptfs/file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 2229a74..b1eaa7a 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -313,11 +313,9 @@ static int ecryptfs_fasync(int fd, struct file *file, int flag)
 static long
 ecryptfs_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct file *lower_file = NULL;
+	struct file *lower_file = ecryptfs_file_to_lower(file);
 	long rc = -ENOTTY;
 
-	if (ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
 	if (lower_file->f_op->unlocked_ioctl)
 		rc = lower_file->f_op->unlocked_ioctl(lower_file, cmd, arg);
 	return rc;
@@ -327,11 +325,9 @@ ecryptfs_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static long
 ecryptfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct file *lower_file = NULL;
+	struct file *lower_file = ecryptfs_file_to_lower(file);
 	long rc = -ENOIOCTLCMD;
 
-	if (ecryptfs_file_to_private(file))
-		lower_file = ecryptfs_file_to_lower(file);
 	if (lower_file->f_op && lower_file->f_op->compat_ioctl)
 		rc = lower_file->f_op->compat_ioctl(lower_file, cmd, arg);
 	return rc;
-- 
1.8.3.2
