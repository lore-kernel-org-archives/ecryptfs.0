From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/13] 9p: Tell the VFS that readpage was synchronous
Date: Thu, 17 Sep 2020 16:10:39 +0100
Message-ID: <20200917151050.5363-3-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgIQPLm (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Sep 2020 11:11:42 -0400
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>

The 9p readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/9p/vfs_addr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..506ca0ba2ec7 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -65,7 +65,7 @@ static int v9fs_fid_readpage(void *data, struct page *page)
 	SetPageUptodate(page);
 
 	v9fs_readpage_to_fscache(inode, page);
-	retval = 0;
+	return AOP_UPDATED_PAGE;
 
 done:
 	unlock_page(page);
@@ -280,6 +280,10 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 		goto out;
 
 	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
+	if (retval == AOP_UPDATED_PAGE) {
+		retval = 0;
+		goto out;
+	}
 	put_page(page);
 	if (!retval)
 		goto start;
-- 
2.28.0

