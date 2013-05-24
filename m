From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 2/5] eCryptfs: Read/write entire page during page IO
Date: Fri, 24 May 2013 16:55:55 -0700
Message-ID: <1369439758-10261-3-git-send-email-tyhicks@canonical.com>
References: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36650 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab3EXX4X (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 19:56:23 -0400
In-Reply-To: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

When reading and writing encrypted pages, perform IO using the entire
page all at once rather than 4096 bytes at a time.

This only affects architectures where PAGE_CACHE_SIZE is larger than
4096 bytes.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 66 ++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e8976c0..4185584 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -490,6 +490,7 @@ int ecryptfs_encrypt_page(struct page *page)
 	char *enc_extent_virt;
 	struct page *enc_extent_page = NULL;
 	loff_t extent_offset;
+	loff_t lower_offset;
 	int rc = 0;
 
 	ecryptfs_inode = page->mapping->host;
@@ -503,12 +504,10 @@ int ecryptfs_encrypt_page(struct page *page)
 				"encrypted extent\n");
 		goto out;
 	}
-	enc_extent_virt = kmap(enc_extent_page);
+
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		loff_t offset;
-
 		rc = ecryptfs_encrypt_extent(enc_extent_page, crypt_stat, page,
 					     extent_offset);
 		if (rc) {
@@ -516,25 +515,24 @@ int ecryptfs_encrypt_page(struct page *page)
 			       "rc = [%d]\n", __func__, rc);
 			goto out;
 		}
-		ecryptfs_lower_offset_for_extent(
-			&offset, ((((loff_t)page->index)
-				   * (PAGE_CACHE_SIZE
-				      / crypt_stat->extent_size))
-				  + extent_offset), crypt_stat);
-		rc = ecryptfs_write_lower(ecryptfs_inode, (enc_extent_virt +
-				extent_offset * crypt_stat->extent_size),
-				offset, crypt_stat->extent_size);
-		if (rc < 0) {
-			ecryptfs_printk(KERN_ERR, "Error attempting "
-					"to write lower page; rc = [%d]"
-					"\n", rc);
-			goto out;
-		}
+	}
+
+	ecryptfs_lower_offset_for_extent(&lower_offset,
+		page->index * (PAGE_CACHE_SIZE / crypt_stat->extent_size),
+		crypt_stat);
+	enc_extent_virt = kmap(enc_extent_page);
+	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
+				  PAGE_CACHE_SIZE);
+	kunmap(enc_extent_page);
+	if (rc < 0) {
+		ecryptfs_printk(KERN_ERR,
+			"Error attempting to write lower page; rc = [%d]\n",
+			rc);
+		goto out;
 	}
 	rc = 0;
 out:
 	if (enc_extent_page) {
-		kunmap(enc_extent_page);
 		__free_page(enc_extent_page);
 	}
 	return rc;
@@ -599,6 +597,7 @@ int ecryptfs_decrypt_page(struct page *page)
 	char *enc_extent_virt;
 	struct page *enc_extent_page = NULL;
 	unsigned long extent_offset;
+	loff_t lower_offset;
 	int rc = 0;
 
 	ecryptfs_inode = page->mapping->host;
@@ -612,26 +611,24 @@ int ecryptfs_decrypt_page(struct page *page)
 				"encrypted extent\n");
 		goto out;
 	}
+
+	ecryptfs_lower_offset_for_extent(&lower_offset,
+		page->index * (PAGE_CACHE_SIZE / crypt_stat->extent_size),
+		crypt_stat);
 	enc_extent_virt = kmap(enc_extent_page);
+	rc = ecryptfs_read_lower(enc_extent_virt, lower_offset, PAGE_CACHE_SIZE,
+				 ecryptfs_inode);
+	kunmap(enc_extent_page);
+	if (rc < 0) {
+		ecryptfs_printk(KERN_ERR,
+			"Error attempting to read lower page; rc = [%d]\n",
+			rc);
+		goto out;
+	}
+
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		loff_t offset;
-
-		ecryptfs_lower_offset_for_extent(
-			&offset, ((page->index * (PAGE_CACHE_SIZE
-						  / crypt_stat->extent_size))
-				  + extent_offset), crypt_stat);
-		rc = ecryptfs_read_lower((enc_extent_virt +
-				extent_offset * crypt_stat->extent_size),
-				offset, crypt_stat->extent_size,
-				ecryptfs_inode);
-		if (rc < 0) {
-			ecryptfs_printk(KERN_ERR, "Error attempting "
-					"to read lower page; rc = [%d]"
-					"\n", rc);
-			goto out;
-		}
 		rc = ecryptfs_decrypt_extent(page, crypt_stat, enc_extent_page,
 					     extent_offset);
 		if (rc) {
@@ -642,7 +639,6 @@ int ecryptfs_decrypt_page(struct page *page)
 	}
 out:
 	if (enc_extent_page) {
-		kunmap(enc_extent_page);
 		__free_page(enc_extent_page);
 	}
 	return rc;
-- 
1.8.1.2
