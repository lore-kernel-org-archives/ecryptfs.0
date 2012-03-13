From: Li Wang <liwang@nudt.edu.cn>
Subject: [PATCH] eCryptfs: Fix kernel bug for writing mmaped non-eCryptfs file
Date: Tue, 13 Mar 2012 19:39:49 +0800
Message-ID: <1331638789-3770-1-git-send-email-liwang__15330.1829043359$1331610339$gmane$org@nudt.edu.cn>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Message-Id: <1331638789-3770-1-git-send-email-liwang@nudt.edu.cn>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yunchuan Wen <wenyunchuan@kylinos.com.cn>, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@nudt.edu.cn>

eCryptfs did not handle the writing for mmaped non-eCryptfs file.
Instead, it put BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED))
on ecryptfs_writepage call path. This patch enables eCryptfs to
deal with such case, to fully support non-eCryptfs operations as it
claims.

---

To make the bug present

cd cipher // enter eCryptfs cipher text folder
echo "123" > foo // make non-eCryptfs file
cd ..
mount -t ecryptfs cipher plain -o ecryptfs_passthrough // allow for non-eCryptfs files to be read and written from within an eCryptfs mount
cd plain
run the following program

int main()
{
	int fd = open("foo", O_RDWR);
	char * addr;
	addr = (char *)mmap(NULL, 256, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	add[0] = '3';
	munmap(addr, 256);
	close(fd);
	return 0;
}

Signed-off-by: Li Wang <liwang@nudt.edu.cn>
Signed-off-by: Yunchuan Wen <wenyunchuan@kylinos.com.cn>
---
 fs/ecryptfs/mmap.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 10ec695..a4be0e9 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -65,6 +65,32 @@ struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
 static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	int rc;
+	struct inode *inode;
+	struct ecryptfs_crypt_stat *crypt_stat;
+
+	inode = page->mapping->host;
+	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
+	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
+		size_t size;
+		loff_t file_size = i_size_read(inode);
+		pgoff_t end_page_index = file_size >> PAGE_CACHE_SHIFT;
+
+		if (end_page_index < page->index)
+			size = 0;
+		else if (end_page_index == page->index)
+			size = file_size & ~PAGE_CACHE_MASK;
+		else
+			size = PAGE_CACHE_SIZE;
+
+		rc = ecryptfs_write_lower_page_segment(inode, page, 0, size);
+		if (unlikely(rc)) {
+			ecryptfs_printk(KERN_WARNING, "Error write "
+					"page (upper index [0x%.16lx])\n", page->index);
+			ClearPageUptodate(page);
+		} else
+			SetPageUptodate(page);
+		goto out;
+	}
 
 	/*
 	 * Refuse to write the page out if we are called from reclaim context
-- 
1.7.6.5

