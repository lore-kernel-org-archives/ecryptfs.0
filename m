From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 2/2] eCryptfs: Call lower ->flush() from ecryptfs_flush()
Date: Thu, 13 Sep 2012 21:39:11 -0700
Message-ID: <1347597551-14832-2-git-send-email-tyhicks@canonical.com>
References: <1347597551-14832-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49813 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2INEjo (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 14 Sep 2012 00:39:44 -0400
In-Reply-To: <1347597551-14832-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Sergio Pena <sergio.pena@gazzang.com>

Since eCryptfs only calls fput() on the lower file in
ecryptfs_release(), eCryptfs should call the lower filesystem's
->flush() from ecryptfs_flush().

If the lower filesystem implements ->flush(), then eCryptfs should try
to flush out any dirty pages prior to calling the lower ->flush(). If
the lower filesystem does not implement ->flush(), then eCryptfs has no
need to do anything in ecryptfs_flush() since dirty pages are now
written out to the lower filesystem in ecryptfs_release().

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Sergio Pena <sergio.pena@gazzang.com>
---
 fs/ecryptfs/file.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 44ce5c6..d45ba45 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -275,8 +275,14 @@ out:
 
 static int ecryptfs_flush(struct file *file, fl_owner_t td)
 {
-	return file->f_mode & FMODE_WRITE
-	       ? filemap_write_and_wait(file->f_mapping) : 0;
+	struct file *lower_file = ecryptfs_file_to_lower(file);
+
+	if (lower_file->f_op && lower_file->f_op->flush) {
+		filemap_write_and_wait(file->f_mapping);
+		return lower_file->f_op->flush(lower_file, td);
+	}
+
+	return 0;
 }
 
 static int ecryptfs_release(struct inode *inode, struct file *file)
-- 
1.7.10.4
