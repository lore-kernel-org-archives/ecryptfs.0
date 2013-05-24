From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 5/5] eCryptfs: Decrypt pages in-place
Date: Fri, 24 May 2013 16:55:58 -0700
Message-ID: <1369439758-10261-6-git-send-email-tyhicks@canonical.com>
References: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36656 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3EXX40 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 19:56:26 -0400
In-Reply-To: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

When reading in a page, eCryptfs would allocate a helper page, fill it
with encrypted data from the lower filesytem, and then decrypt the data
from the encrypted page and store the result in the eCryptfs page cache
page.

The crypto API supports in-place crypto operations which means that the
allocation of the helper page is unnecessary when decrypting. This patch
gets rid of the unneeded page allocation by reading encrypted data from
the lower filesystem directly into the page cache page. The page cache
page is then decrypted in-place.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ec640eb..35b409b 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -586,8 +586,7 @@ int ecryptfs_decrypt_page(struct page *page)
 {
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
-	char *enc_extent_virt;
-	struct page *enc_extent_page = NULL;
+	char *page_virt;
 	unsigned long extent_offset;
 	loff_t lower_offset;
 	int rc = 0;
@@ -596,19 +595,12 @@ int ecryptfs_decrypt_page(struct page *page)
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
-	enc_extent_page = alloc_page(GFP_USER);
-	if (!enc_extent_page) {
-		rc = -ENOMEM;
-		ecryptfs_printk(KERN_ERR, "Error allocating memory for "
-				"encrypted extent\n");
-		goto out;
-	}
 
 	lower_offset = lower_offset_for_page(crypt_stat, page);
-	enc_extent_virt = kmap(enc_extent_page);
-	rc = ecryptfs_read_lower(enc_extent_virt, lower_offset, PAGE_CACHE_SIZE,
+	page_virt = kmap(page);
+	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_CACHE_SIZE,
 				 ecryptfs_inode);
-	kunmap(enc_extent_page);
+	kunmap(page);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to read lower page; rc = [%d]\n",
@@ -619,7 +611,7 @@ int ecryptfs_decrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_CACHE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = ecryptfs_decrypt_extent(page, crypt_stat, enc_extent_page,
+		rc = ecryptfs_decrypt_extent(page, crypt_stat, page,
 					     extent_offset);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
@@ -628,9 +620,6 @@ int ecryptfs_decrypt_page(struct page *page)
 		}
 	}
 out:
-	if (enc_extent_page) {
-		__free_page(enc_extent_page);
-	}
 	return rc;
 }
 
-- 
1.8.1.2
