From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] fs: ecryptfs: crypto: Change return type of
 ecryptfs_process_flags
Date: Tue, 2 Jul 2019 23:17:24 +0530
Message-ID: <20190702174723.GA4600@hari-Inspiron-1545>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Change return type of ecryptfs_process_flags from int to void. As it
never fails.

fixes below issue reported by coccicheck

s/ecryptfs/crypto.c:870:5-7: Unneeded variable: "rc". Return "0" on line
883

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/ecryptfs/crypto.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 509a767..55a633e 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -864,10 +864,9 @@ static struct ecryptfs_flag_map_elem ecryptfs_flag_map[] = {
  *
  * Returns zero on success; non-zero if the flag set is invalid
  */
-static int ecryptfs_process_flags(struct ecryptfs_crypt_stat *crypt_stat,
+static void ecryptfs_process_flags(struct ecryptfs_crypt_stat *crypt_stat,
 				  char *page_virt, int *bytes_read)
 {
-	int rc = 0;
 	int i;
 	u32 flags;
 
@@ -880,7 +879,6 @@ static int ecryptfs_process_flags(struct ecryptfs_crypt_stat *crypt_stat,
 	/* Version is in top 8 bits of the 32-bit flag vector */
 	crypt_stat->file_version = ((flags >> 24) & 0xFF);
 	(*bytes_read) = 4;
-	return rc;
 }
 
 /**
@@ -1306,12 +1304,9 @@ static int ecryptfs_read_headers_virt(char *page_virt,
 	if (!(crypt_stat->flags & ECRYPTFS_I_SIZE_INITIALIZED))
 		ecryptfs_i_size_init(page_virt, d_inode(ecryptfs_dentry));
 	offset += MAGIC_ECRYPTFS_MARKER_SIZE_BYTES;
-	rc = ecryptfs_process_flags(crypt_stat, (page_virt + offset),
+	ecryptfs_process_flags(crypt_stat, (page_virt + offset),
 				    &bytes_read);
-	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "Error processing flags\n");
-		goto out;
-	}
+
 	if (crypt_stat->file_version > ECRYPTFS_SUPPORTED_FILE_VERSION) {
 		ecryptfs_printk(KERN_WARNING, "File version is [%d]; only "
 				"file version [%d] is supported by this "
-- 
2.7.4

