From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] ecryptfs/crypto.c: local functions should be static
Date: Fri, 23 Sep 2011 13:38:55 -0700
Message-ID: <201109231338.55363.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ecryptfs@vger.kernel.org, tyhicks@linux.vnet.ibm.com, kirkland@canonical.com

This quiets the sparse noise:

warning: symbol 'ecryptfs_encode_for_filename' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Tyler Hicks <tyhicks@linux.vnet.ibm.com>
Cc: Dustin Kirkland <kirkland@canonical.com>

---

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 58609bd..0d4f5fc 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1969,8 +1969,8 @@ static const unsigned char filename_rev_map[] = {
  * @src: Source location for the filename to encode
  * @src_size: Size of the source in bytes
  */
-void ecryptfs_encode_for_filename(unsigned char *dst, size_t *dst_size,
-				  unsigned char *src, size_t src_size)
+static void ecryptfs_encode_for_filename(unsigned char *dst, size_t *dst_size,
+					 unsigned char *src, size_t src_size)
 {
 	size_t num_blocks;
 	size_t block_num = 0;
