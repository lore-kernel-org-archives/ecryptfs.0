From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 1/2] eCryptfs: Write out all dirty pages just before releasing the lower file
Date: Thu, 13 Sep 2012 21:39:10 -0700
Message-ID: <1347597551-14832-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49810 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2INEjd (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 14 Sep 2012 00:39:33 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Sergio Pena <sergio.pena@gazzang.com>

Fixes a regression caused by:

821f749 eCryptfs: Revert to a writethrough cache model

That patch reverted some code (specifically, 32001d6f) that was
necessary to properly handle open() -> mmap() -> close() -> dirty pages
-> munmap(), because the lower file could be closed before the dirty
pages are written out.

Rather than reapplying 32001d6f, this approach is a better way of
ensuring that the lower file is still open in order to handle writing
out the dirty pages. It is called from ecryptfs_release(), while we have
a lock on the lower file pointer, just before the lower file gets the
final fput() and we overwrite the pointer.

https://launchpad.net/bugs/1047261

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Sergio Pena <sergio.pena@gazzang.com>
---
 fs/ecryptfs/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2768138..9b627c1 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -162,6 +162,7 @@ void ecryptfs_put_lower_file(struct inode *inode)
 	inode_info = ecryptfs_inode_to_private(inode);
 	if (atomic_dec_and_mutex_lock(&inode_info->lower_file_count,
 				      &inode_info->lower_file_mutex)) {
+		filemap_write_and_wait(inode->i_mapping);
 		fput(inode_info->lower_file);
 		inode_info->lower_file = NULL;
 		mutex_unlock(&inode_info->lower_file_mutex);
-- 
1.7.10.4
