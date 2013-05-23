From: Paul Taysom <taysom@chromium.org>
Subject: [PATCH] fs: ecryptfs: fixed msync to flush data
Date: Thu, 23 May 2013 14:31:43 -0700
Message-ID: <1369344703-22245-1-git-send-email-taysom@chromium.org>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ye0-f202.google.com ([209.85.213.202]:52670 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907Ab3EWVcq (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 23 May 2013 17:32:46 -0400
Received: by mail-ye0-f202.google.com with SMTP id m13so88336yen.3
        for <ecryptfs@vger.kernel.org>; Thu, 23 May 2013 14:32:46 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, taysom@chromium.org

When msync is called on a memory mapped file, that
data is not flushed to the disk.

In Linux, msync calls fsync for the file. For ecryptfs,
fsync just calls the lower level file system's fsync.
Changed the ecryptfs fsync code to call filemap_write_and_wait
before calling the lower level fsync.

Addresses the problem described in http://crbug.com/239536

Signed-off-by: Paul Taysom <taysom@chromium.org>
---
 fs/ecryptfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 201f0a0..16f509d 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -295,6 +295,7 @@ static int ecryptfs_release(struct inode *inode, struct file *file)
 static int
 ecryptfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
+	filemap_write_and_wait(file->f_mapping);
 	return vfs_fsync(ecryptfs_file_to_lower(file), datasync);
 }
 
-- 
1.8.2.1
