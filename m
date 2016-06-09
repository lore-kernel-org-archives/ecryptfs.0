From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH] ecryptfs: fix spelling mistakes
Date: Thu,  9 Jun 2016 15:31:29 -0500
Message-ID: <1465504293-23323-1-git-send-email-chris.j.arges@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50051 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFIUcA (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 9 Jun 2016 16:32:00 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: Chris J Arges <chris.j.arges@canonical.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Noticed some minor spelling errors when looking through the code.

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 fs/ecryptfs/crypto.c | 8 ++++----
 fs/ecryptfs/file.c   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 0d8eb34..e5e29f8 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -45,7 +45,7 @@
  * ecryptfs_to_hex
  * @dst: Buffer to take hex character representation of contents of
  *       src; must be at least of size (src_size * 2)
- * @src: Buffer to be converted to a hex string respresentation
+ * @src: Buffer to be converted to a hex string representation
  * @src_size: number of bytes to convert
  */
 void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
@@ -60,7 +60,7 @@ void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
  * ecryptfs_from_hex
  * @dst: Buffer to take the bytes from src hex; must be at least of
  *       size (src_size / 2)
- * @src: Buffer to be converted from a hex string respresentation to raw value
+ * @src: Buffer to be converted from a hex string representation to raw value
  * @dst_size: size of dst buffer, or number of hex characters pairs to convert
  */
 void ecryptfs_from_hex(char *dst, char *src, int dst_size)
@@ -953,7 +953,7 @@ struct ecryptfs_cipher_code_str_map_elem {
 };
 
 /* Add support for additional ciphers by adding elements here. The
- * cipher_code is whatever OpenPGP applicatoins use to identify the
+ * cipher_code is whatever OpenPGP applications use to identify the
  * ciphers. List in order of probability. */
 static struct ecryptfs_cipher_code_str_map_elem
 ecryptfs_cipher_code_str_map[] = {
@@ -1410,7 +1410,7 @@ int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
  *
  * Common entry point for reading file metadata. From here, we could
  * retrieve the header information from the header region of the file,
- * the xattr region of the file, or some other repostory that is
+ * the xattr region of the file, or some other repository that is
  * stored separately from the file itself. The current implementation
  * supports retrieving the metadata information from the file contents
  * and from the xattr region.
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 7000b96..53d0141 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -171,7 +171,7 @@ out:
 
 /**
  * ecryptfs_open
- * @inode: inode speciying file to open
+ * @inode: inode specifying file to open
  * @file: Structure to return filled in
  *
  * Opens the file specified by inode.
@@ -240,7 +240,7 @@ out:
 
 /**
  * ecryptfs_dir_open
- * @inode: inode speciying file to open
+ * @inode: inode specifying file to open
  * @file: Structure to return filled in
  *
  * Opens the file specified by inode.
-- 
2.7.4
