From: Wei Yuan <weiyuan.wei@huawei.com>
Subject: [PATCH] eCryptfs: fix typos in comment
Date: Wed, 17 Feb 2016 14:50:10 +0800
Message-ID: <1455691810-14274-1-git-send-email-weiyuan.wei@huawei.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:42940 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532AbcBQGwK (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 17 Feb 2016 01:52:10 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: lizefan@huawei.com, weiyuan.wei@huawei.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Weiyuan <weiyuan.wei@huawei.com>
---
 fs/ecryptfs/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 80d6901..d47a7d4 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -44,7 +44,7 @@
  * ecryptfs_to_hex
  * @dst: Buffer to take hex character representation of contents of
  *       src; must be at least of size (src_size * 2)
- * @src: Buffer to be converted to a hex string respresentation
+ * @src: Buffer to be converted to a hex string representation
  * @src_size: number of bytes to convert
  */
 void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
@@ -59,7 +59,7 @@ void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
  * ecryptfs_from_hex
  * @dst: Buffer to take the bytes from src hex; must be at least of
  *       size (src_size / 2)
- * @src: Buffer to be converted from a hex string respresentation to raw value
+ * @src: Buffer to be converted from a hex string representation to raw value
  * @dst_size: size of dst buffer, or number of hex characters pairs to convert
  */
 void ecryptfs_from_hex(char *dst, char *src, int dst_size)
-- 
2.1.0
