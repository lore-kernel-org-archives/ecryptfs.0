From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 11/16] jffs2: Tell the VFS that readpage was synchronous
Date: Fri,  9 Oct 2020 15:30:59 +0100
Message-ID: <20201009143104.22673-12-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

The jffs2 readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 fs/jffs2/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227..959a74027041 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -116,15 +116,17 @@ int jffs2_do_readpage_unlock(void *data, struct page *pg)
 	return ret;
 }
 
-
 static int jffs2_readpage (struct file *filp, struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
+	ret = jffs2_do_readpage_nolock(pg->mapping->host, pg);
 	mutex_unlock(&f->sem);
+	if (!ret)
+		return AOP_UPDATED_PAGE;
+	unlock_page(pg);
 	return ret;
 }
 
-- 
2.28.0

