From: Li zeming <zeming@nfschina.com>
Subject: [PATCH] ecryptfs: main: Remove unnecessary (void*) conversions
Date: Mon,  7 Nov 2022 10:04:04 +0800
Message-ID: <20221107020404.3380-1-zeming@nfschina.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGCEL (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 6 Nov 2022 21:04:11 -0500
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: code@tyhicks.com, sforshee@digitalocean.com, brauner@kernel.org, amir73il@gmail.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>

The ei pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/ecryptfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dd23a82e0de..3e499207d4c6 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -649,7 +649,7 @@ MODULE_ALIAS_FS("ecryptfs");
 static void
 inode_info_init_once(void *vptr)
 {
-	struct ecryptfs_inode_info *ei = (struct ecryptfs_inode_info *)vptr;
+	struct ecryptfs_inode_info *ei = vptr;
 
 	inode_init_once(&ei->vfs_inode);
 }
-- 
2.18.2

