From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ecryptfs: add a ->set_page_dirty cludge
Date: Thu, 24 Jun 2021 14:52:50 +0200
Message-ID: <20210624125250.536369-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFXMzq (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 24 Jun 2021 08:55:46 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: akpm@linux-foundation.org
Cc: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

"fix" ecryptfs to work the same as before the recent change to the
behavior without a ->set_page_dirty method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ecryptfs/mmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 392e721b50a3..7d85e64ea62f 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -533,7 +533,20 @@ static sector_t ecryptfs_bmap(struct address_space *mapping, sector_t block)
 	return block;
 }
 
+#include <linux/buffer_head.h>
+
 const struct address_space_operations ecryptfs_aops = {
+	/*
+	 * XXX: This is pretty broken for multiple reasons: ecryptfs does not
+	 * actually use buffer_heads, and ecryptfs will crash without
+	 * CONFIG_BLOCK.  But it matches the behavior before the default for
+	 * address_space_operations without the ->set_page_dirty method was
+	 * cleaned up, so this is the best we can do without maintainer
+	 * feedback.
+	 */
+#ifdef CONFIG_BLOCK
+	.set_page_dirty = __set_page_dirty_buffers,
+#endif
 	.writepage = ecryptfs_writepage,
 	.readpage = ecryptfs_readpage,
 	.write_begin = ecryptfs_write_begin,
-- 
2.30.2

