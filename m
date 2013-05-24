From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 1/5] eCryptfs: Use entire helper page during page crypto operations
Date: Fri, 24 May 2013 16:55:54 -0700
Message-ID: <1369439758-10261-2-git-send-email-tyhicks@canonical.com>
References: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36648 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab3EXX4W (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 19:56:22 -0400
In-Reply-To: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

When encrypting eCryptfs pages and decrypting pages from the lower
filesystem, utilize the entire helper page rather than only the first
4096 bytes.

This only affects architectures where PAGE_CACHE_SIZE is larger than
4096 bytes.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f71ec12..e8976c0 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -450,10 +450,11 @@ static int ecryptfs_encrypt_extent(struct page *enc_extent_page,
 			(unsigned long long)(extent_base + extent_offset), rc);
 		goto out;
 	}
-	rc = ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page, 0,
-					  page, (extent_offset
-						 * crypt_stat->extent_size),
-					  crypt_stat->extent_size, extent_iv);
+	rc = ecryptfs_encrypt_page_offset(crypt_stat, enc_extent_page,
+					extent_offset * crypt_stat->extent_size,
+					page,
+					extent_offset * crypt_stat->extent_size,
+					crypt_stat->extent_size, extent_iv);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to encrypt page with "
 		       "page->index = [%ld], extent_offset = [%ld]; "
@@ -520,8 +521,9 @@ int ecryptfs_encrypt_page(struct page *page)
 				   * (PAGE_CACHE_SIZE
 				      / crypt_stat->extent_size))
 				  + extent_offset), crypt_stat);
-		rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt,
-					  offset, crypt_stat->extent_size);
+		rc = ecryptfs_write_lower(ecryptfs_inode, (enc_extent_virt +
+				extent_offset * crypt_stat->extent_size),
+				offset, crypt_stat->extent_size);
 		if (rc < 0) {
 			ecryptfs_printk(KERN_ERR, "Error attempting "
 					"to write lower page; rc = [%d]"
@@ -558,10 +560,10 @@ static int ecryptfs_decrypt_extent(struct page *page,
 		goto out;
 	}
 	rc = ecryptfs_decrypt_page_offset(crypt_stat, page,
-					  (extent_offset
-					   * crypt_stat->extent_size),
-					  enc_extent_page, 0,
-					  crypt_stat->extent_size, extent_iv);
+					extent_offset * crypt_stat->extent_size,
+					enc_extent_page,
+					extent_offset * crypt_stat->extent_size,
+					crypt_stat->extent_size, extent_iv);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to decrypt to page with "
 		       "page->index = [%ld], extent_offset = [%ld]; "
@@ -620,9 +622,10 @@ int ecryptfs_decrypt_page(struct page *page)
 			&offset, ((page->index * (PAGE_CACHE_SIZE
 						  / crypt_stat->extent_size))
 				  + extent_offset), crypt_stat);
-		rc = ecryptfs_read_lower(enc_extent_virt, offset,
-					 crypt_stat->extent_size,
-					 ecryptfs_inode);
+		rc = ecryptfs_read_lower((enc_extent_virt +
+				extent_offset * crypt_stat->extent_size),
+				offset, crypt_stat->extent_size,
+				ecryptfs_inode);
 		if (rc < 0) {
 			ecryptfs_printk(KERN_ERR, "Error attempting "
 					"to read lower page; rc = [%d]"
-- 
1.8.1.2
