From: Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ecryptfs: keystore: Fix comment typo
Date: Thu, 11 Aug 2022 22:03:35 +0800
Message-ID: <20220811140335.32067-1-wangborong@cdjrlc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiHKOEe (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 11 Aug 2022 10:04:34 -0400
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
2.36.1

