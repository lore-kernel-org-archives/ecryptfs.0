From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Fix directory open regression in linux-stable
Date: Tue, 28 Jun 2016 22:39:41 -0500
Message-ID: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45986 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcF2ERI (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 29 Jun 2016 00:17:08 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

Cherry-picking mainline commit 2f36db71009304b3f0b95afacd8eba1f9f046b87
introduces a regression in eCryptfs when mainline commit
6a480a7842545ec520a91730209ec0bae41694c1 (4.6+) is not present. The
regression causes all attempts at opening directory files to fail with
EMEDIUMTYPE when the lower filesystem's file_operations for directory
files do not implement mmap.

This is a simple fix that allows the check for the lower file's mmap
implementation to be ignored if the lower file is a directory.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Tested-by: Tyler Hicks <tyhicks@canonical.com> # 4.4.y, 3.18.y
Cc: <stable@vger.kernel.org> # 4.5-
---
 fs/ecryptfs/kthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index e818f5a..b9faeab 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -171,7 +171,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
 		goto out;
 	}
 have_file:
-	if ((*lower_file)->f_op->mmap == NULL) {
+	if ((*lower_file)->f_op->mmap == NULL && !d_is_dir(lower_dentry)) {
 		fput(*lower_file);
 		*lower_file = NULL;
 		rc = -EMEDIUMTYPE;
-- 
2.7.4
