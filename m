From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/13] fuse: Tell the VFS that readpage was synchronous
Date: Thu, 17 Sep 2020 16:10:45 +0100
Message-ID: <20200917151050.5363-9-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgIQPL0 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Sep 2020 11:11:26 -0400
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>

The fuse readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6611ef3269a8..7aa5626bc582 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -850,6 +850,8 @@ static int fuse_readpage(struct file *file, struct page *page)
 
 	err = fuse_do_readpage(file, page);
 	fuse_invalidate_atime(inode);
+	if (!err)
+		return AOP_UPDATED_PAGE;
  out:
 	unlock_page(page);
 	return err;
-- 
2.28.0

