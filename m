From: Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH] ecryptfs: Fix stat command displays wrong file size in xattr region
Date: Thu, 22 Jun 2017 15:21:15 +0800
Message-ID: <1498116075-2195-1-git-send-email-kerneljasonxing@gmail.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33328 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdFVHX1 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 22 Jun 2017 03:23:27 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: tyhicks@canonical.com, linux-kernel@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>

When doing ecryptfs_read_and_validate_xattr_region(), eCryptfs
reads only 16 bytes from xattr region. However, the lower filesystem
like ext4 always compares 16 with the size of ecryptfs xattr region
which is 81 bytes, and then it will return ERANGE (-34) and do not
read that region.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 fs/ecryptfs/crypto.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e5e29f8..895140f 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1389,19 +1389,36 @@ int ecryptfs_read_xattr_region(char *page_virt, struct inode *ecryptfs_inode)
 int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
 					    struct inode *inode)
 {
-	u8 file_size[ECRYPTFS_SIZE_AND_MARKER_BYTES];
-	u8 *marker = file_size + ECRYPTFS_FILE_SIZE_BYTES;
+	char *page_virt;
 	int rc;
 
+	page_virt = kmem_cache_alloc(ecryptfs_header_cache, GFP_USER);
+	if (!page_virt) {
+		rc = -ENOMEM;
+		printk(KERN_ERR "%s: Unable to allocate page_virt\n",
+		       __func__);
+		goto out;
+	}
 	rc = ecryptfs_getxattr_lower(ecryptfs_dentry_to_lower(dentry),
 				     ecryptfs_inode_to_lower(inode),
-				     ECRYPTFS_XATTR_NAME, file_size,
-				     ECRYPTFS_SIZE_AND_MARKER_BYTES);
-	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
-		return rc >= 0 ? -EINVAL : rc;
-	rc = ecryptfs_validate_marker(marker);
+				     ECRYPTFS_XATTR_NAME, page_virt,
+				     ECRYPTFS_DEFAULT_EXTENT_SIZE);
+	if (rc < 0) {
+		if (unlikely(ecryptfs_verbosity > 0))
+			printk(KERN_INFO "Error attempting to read the [%s] "
+			       "xattr from the lower file; return value = "
+			       "[%d]\n", ECRYPTFS_XATTR_NAME, rc);
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = ecryptfs_validate_marker(page_virt + ECRYPTFS_FILE_SIZE_BYTES);
 	if (!rc)
-		ecryptfs_i_size_init(file_size, inode);
+		ecryptfs_i_size_init(page_virt, inode);
+out:
+	if (page_virt) {
+		memset(page_virt, 0, PAGE_SIZE);
+		kmem_cache_free(ecryptfs_header_cache, page_virt);
+	}
 	return rc;
 }
 
-- 
2.7.4
