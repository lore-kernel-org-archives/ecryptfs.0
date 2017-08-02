From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ecryptfs: convert to file_write_and_wait in ->fsync
Date: Wed,  2 Aug 2017 12:29:24 -0400
Message-ID: <20170802162924.31956-1-jlayton@kernel.org>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbdHBQ31 (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Wed, 2 Aug 2017 12:29:27 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

This change is mainly for documentation/completeness, as ecryptfs never
calls mapping_set_error, and so will never return a previous writeback
error.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ecryptfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index ca4e83750214..c74ed3ca3372 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -328,7 +328,7 @@ ecryptfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	int rc;
 
-	rc = filemap_write_and_wait(file->f_mapping);
+	rc = file_write_and_wait(file);
 	if (rc)
 		return rc;
 
-- 
2.13.3
