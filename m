From: Li Wang <liwang@nudt.edu.cn>
Subject: [PATCH 3/3] eCryptfs: Remove unreached codes
Date: Fri, 17 Feb 2012 00:36:50 +0800
Message-ID: <529380713.15452@eyou.net>
References: <1329410210-2712-1-git-send-email-liwang@nudt.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <1329410210-2712-3-git-send-email-liwang@nudt.edu.cn>
In-Reply-To: <1329410210-2712-1-git-send-email-liwang@nudt.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@nudt.edu.cn>

The code segment handles the ECRYPTFS_VIEW_AS_ENCRYPTED option in
ecryptfs_write_begin(mmap.c) is unreached, since this option is
enabled only when eCryptfs is mounted with RDONLY.

Signed-off-by: Li Wang <liwang@nudt.edu.cn>
---
 fs/ecryptfs/mmap.c |   29 +----------------------------
 1 files changed, 1 insertions(+), 28 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 59a8e57..a4802a6 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -320,35 +320,8 @@ static int ecryptfs_write_begin(struct file *file,
 				goto out;
 			} else
 				SetPageUptodate(page);
-		} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
-			if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
-				rc = ecryptfs_copy_up_encrypted_with_header(
-					page, crypt_stat);
-				if (rc) {
-					printk(KERN_ERR "%s: Error attempting "
-					       "to copy the encrypted content "
-					       "from the lower file whilst "
-					       "inserting the metadata from "
-					       "the xattr into the header; rc "
-					       "= [%d]\n", __func__, rc);
-					ClearPageUptodate(page);
-					goto out;
-				}
-				SetPageUptodate(page);
-			} else {
-				rc = ecryptfs_read_lower_page_segment(
-					page, index, 0, PAGE_CACHE_SIZE,
-					mapping->host);
-				if (rc) {
-					printk(KERN_ERR "%s: Error reading "
-					       "page; rc = [%d]\n",
-					       __func__, rc);
-					ClearPageUptodate(page);
-					goto out;
-				}
-				SetPageUptodate(page);
-			}
 		} else {
+			BUG_ON(crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED);
 			if (prev_page_end_size
 			    >= i_size_read(page->mapping->host)) {
 				zero_user(page, 0, PAGE_CACHE_SIZE);
-- 
1.7.6.5
