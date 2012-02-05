From: "Li Wang" <liwang@nudt.edu.cn>
Subject: [PATCH v2] eCryptfs: Write optimization for non-uptodate page
Date: Sun, 5 Feb 2012 23:33:51 +0800
Message-ID: <528455107.21568@eyou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Message-ID: <000801cce41b$927ae800$b770b800$@edu.cn>
Content-Language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, wenyunchuan@kylinos.com.cn, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

ecryptfs_write_begin() grabs a page from page cache for writing. 
If the page does not contain valid data, or the data are older than 
the counterpart on the disk, eCryptfs will read out the corresponding data 
from the disk into the eCryptfs page cache, decrypt them, 
then perform writing. However, for current page, if the length of 
the data to be written into is equal to page size, that means the whole 
page of data will be overwritten, in which case, it does not matter whatever

the data were before, it is beneficial to perform writing directly.

This is especially useful while using eCryptfs in backup situation, user
copies file
out from eCryptfs folder, modifies, and copies the revised file back to
replace the original one. 

With this optimization, according to our test on a machine with IntelR Core
T 2 Duo processor, 
iozone 'write' operation on an existing file with write size being multiple
of page size will 
enjoy a steady 3x speedup.

Signed-off-by: Li Wang <liwang@nudt.edu.cn>
Signed-off-by: Yunchuan Wen <wenyunchuan@kylinos.com.cn>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

--- 

Changes from v1:

The new version adds the code to handle short copy issue which may occure
in iov_iter_copy_from_user_atomic(). The idea is to let ecryptfs_write_end()
return zero,
in order to give iov_iter_fault_in_readable() a chance to handle the page
fault 
for the current iovec, then restart the copy operation.

 fs/ecryptfs/mmap.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 10ec695..c6f665e 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -350,7 +350,8 @@ static int ecryptfs_write_begin(struct file *file,
 			if (prev_page_end_size
 			    >= i_size_read(page->mapping->host)) {
 				zero_user(page, 0, PAGE_CACHE_SIZE);
-			} else {
+				SetPageUptodate(page);
+			} else if (len < PAGE_CACHE_SIZE) {
 				rc = ecryptfs_decrypt_page(page);
 				if (rc) {
 					printk(KERN_ERR "%s: Error
decrypting "
@@ -360,8 +361,8 @@ static int ecryptfs_write_begin(struct file *file,
 					ClearPageUptodate(page);
 					goto out;
 				}
+				SetPageUptodate(page);
 			}
-			SetPageUptodate(page);
 		}
 	}
 	/* If creating a page or more of holes, zero them out via truncate.
@@ -512,6 +513,13 @@ static int ecryptfs_write_end(struct file *file,
 		}
 		goto out;
 	}
+	if (!PageUptodate(page)) {
+		if (copied < PAGE_CACHE_SIZE) {
+			rc = 0;
+			goto out;
+		}
+		SetPageUptodate(page);
+	}
 	/* Fills in zeros if 'to' goes beyond inode size */
 	rc = fill_zeros_to_end_of_page(page, to);
 	if (rc) {

