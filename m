From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] eCryptfs: fix ecryptfs_privileged_open() for read only files
Date: Sat, 9 Jun 2012 12:11:29 +0300
Message-ID: <20120609091129.GD877@elgon.mountain>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:32255 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab2FIJLk (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 9 Jun 2012 05:11:40 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org

The intent here is to handle read only opens differently.  For example,
if we don't want to create the file if it doesn't exist.  The problem
here is that O_RDONLY is 0 and if (x & 0) {... is always false.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is a static checker bug, and I am not very familiar with eCryptfs.
Please review carefully.

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index 69f994a..d01b364 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -149,7 +149,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
 	(*lower_file) = dentry_open(lower_dentry, lower_mnt, flags, cred);
 	if (!IS_ERR(*lower_file))
 		goto out;
-	if (flags & O_RDONLY) {
+	if (!(flags & O_RDWR)) {
 		rc = PTR_ERR((*lower_file));
 		goto out;
 	}
