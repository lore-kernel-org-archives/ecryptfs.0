From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 3/5] eCryptfs: Simplify lower file offset calculation
Date: Fri, 24 May 2013 16:55:56 -0700
Message-ID: <1369439758-10261-4-git-send-email-tyhicks@canonical.com>
References: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36652 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab3EXX4Y (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 24 May 2013 19:56:24 -0400
In-Reply-To: <1369439758-10261-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Now that lower filesystem IO operations occur for complete
PAGE_CACHE_SIZE bytes, the calculation for converting an eCryptfs extent
index into a lower file offset can be simplified.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 4185584..3547708 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -407,15 +407,15 @@ out:
 }
 
 /**
- * ecryptfs_lower_offset_for_extent
+ * lower_offset_for_page
  *
  * Convert an eCryptfs page index into a lower byte offset
  */
-static void ecryptfs_lower_offset_for_extent(loff_t *offset, loff_t extent_num,
-					     struct ecryptfs_crypt_stat *crypt_stat)
+static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
+				    struct page *page)
 {
-	(*offset) = ecryptfs_lower_header_size(crypt_stat)
-		    + (crypt_stat->extent_size * extent_num);
+	return ecryptfs_lower_header_size(crypt_stat) +
+	       (page->index << PAGE_CACHE_SHIFT);
 }
 
 /**
@@ -517,9 +517,7 @@ int ecryptfs_encrypt_page(struct page *page)
 		}
 	}
 
-	ecryptfs_lower_offset_for_extent(&lower_offset,
-		page->index * (PAGE_CACHE_SIZE / crypt_stat->extent_size),
-		crypt_stat);
+	lower_offset = lower_offset_for_page(crypt_stat, page);
 	enc_extent_virt = kmap(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_CACHE_SIZE);
@@ -612,9 +610,7 @@ int ecryptfs_decrypt_page(struct page *page)
 		goto out;
 	}
 
-	ecryptfs_lower_offset_for_extent(&lower_offset,
-		page->index * (PAGE_CACHE_SIZE / crypt_stat->extent_size),
-		crypt_stat);
+	lower_offset = lower_offset_for_page(crypt_stat, page);
 	enc_extent_virt = kmap(enc_extent_page);
 	rc = ecryptfs_read_lower(enc_extent_virt, lower_offset, PAGE_CACHE_SIZE,
 				 ecryptfs_inode);
-- 
1.8.1.2
