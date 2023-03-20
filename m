From: Zipeng Zhang <zhangzipeng0@foxmail.com>
Subject: [PATCH] fs: ecryptfs: comment typo fix
Date: Mon, 20 Mar 2023 10:04:28 +0800
Message-ID: <tencent_3EF4F3D0717E80F131BF00B982698C34DF07@qq.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCTCGo (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 19 Mar 2023 22:06:44 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: code@tyhicks.com
Cc: herbert@gondor.apana.org.au, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Zipeng Zhang <zhangzipeng0@foxmail.com>

Comment typo fix "vitual" -> "virtual".

Signed-off-by: Zipeng Zhang <zhangzipeng0@foxmail.com>
---
 fs/ecryptfs/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index c16f0d660cb7..faa901cde636 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1289,7 +1289,7 @@ static int ecryptfs_read_headers_virt(char *page_virt,
 
 /**
  * ecryptfs_read_xattr_region
- * @page_virt: The vitual address into which to read the xattr data
+ * @page_virt: The virtual address into which to read the xattr data
  * @ecryptfs_inode: The eCryptfs inode
  *
  * Attempts to read the crypto metadata from the extended attribute
-- 
2.39.2


