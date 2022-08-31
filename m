From: Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] ecryptfs: make splice write available again
Date: Wed, 31 Aug 2022 11:35:05 +0800
Message-ID: <20220831033505.23178-1-frank.li@vivo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiHaDfW (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Aug 2022 23:35:22 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: code@tyhicks.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>

Since 5.10, splice() or sendfile() return EINVAL.  This was
caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops").

This patch initializes the splice_write field in file_operations, like
most file systems do, to restore the functionality.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ecryptfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 18d5b91cb573..d070ca0fac2b 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -421,4 +421,5 @@ const struct file_operations ecryptfs_main_fops = {
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
-- 
2.25.1

