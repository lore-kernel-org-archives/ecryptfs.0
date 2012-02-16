From: Li Wang <liwang@nudt.edu.cn>
Subject: [PATCH 2/3] eCryptfs: Remove redundant IF statement
Date: Fri, 17 Feb 2012 00:36:49 +0800
Message-ID: <1329410210-2712-2-git-send-email-liwang__26315.4486813166$1329381755$gmane$org@nudt.edu.cn>
References: <1329410210-2712-1-git-send-email-liwang@nudt.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <1329410210-2712-2-git-send-email-liwang@nudt.edu.cn>
In-Reply-To: <1329410210-2712-1-git-send-email-liwang@nudt.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@nudt.edu.cn>

ecryptfs_write_begin(mmap.c)
1  ...
2  if (index != 0) {
3	if (prev_page_end_size > i_size_read(page->mapping->host)) {
4		...
5	}
6	...
7  }
The IF statement in line 2 is redundant since the IF statement in line
3 deduces that.

Signed-off-by: Li Wang <liwang@nudt.edu.cn>
---
 fs/ecryptfs/mmap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 27c0da8..59a8e57 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -368,8 +368,7 @@ static int ecryptfs_write_begin(struct file *file,
 	}
 	/* If creating a page or more of holes, zero them out via truncate.
 	 * Note, this will increase i_size. */
-	if (index != 0) {
-		if (prev_page_end_size > i_size_read(page->mapping->host)) {
+	if (prev_page_end_size > i_size_read(page->mapping->host)) {
 			rc = ecryptfs_truncate(file->f_path.dentry,
 					       prev_page_end_size);
 			if (rc) {
@@ -379,7 +378,6 @@ static int ecryptfs_write_begin(struct file *file,
 				       prev_page_end_size, rc);
 				goto out;
 			}
-		}
 	}
 out:
 	if (unlikely(rc)) {
-- 
1.7.6.5
