From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 07/16] cramfs: Tell the VFS that readpage was synchronous
Date: Fri,  9 Oct 2020 15:30:55 +0100
Message-ID: <20201009143104.22673-8-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

The cramfs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cramfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 912308600d39..7a642146c074 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -916,15 +916,14 @@ static int cramfs_readpage(struct file *file, struct page *page)
 	flush_dcache_page(page);
 	kunmap(page);
 	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
+	return AOP_UPDATED_PAGE;
 
 err:
 	kunmap(page);
 	ClearPageUptodate(page);
 	SetPageError(page);
 	unlock_page(page);
-	return 0;
+	return -EIO;
 }
 
 static const struct address_space_operations cramfs_aops = {
-- 
2.28.0

