From: Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ecryptfs: Fix comment typo
Date: Mon, 25 Jul 2022 12:38:53 +0800
Message-ID: <20220725043853.7441-1-wangborong@cdjrlc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiG1MlA (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 28 Jul 2022 08:41:00 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: wangborong@cdjrlc.com
Cc: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..2452d6fd7062 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
  * @filename: This function kmalloc's the memory for the filename
  * @filename_size: This function sets this to the amount of memory
  *                 kmalloc'd for the filename
- * @packet_size: This function sets this to the the number of octets
+ * @packet_size: This function sets this to the number of octets
  *               in the packet parsed
  * @mount_crypt_stat: The mount-wide cryptographic context
  * @data: The memory location containing the start of the tag 70
-- 
2.35.1

