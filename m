From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 05/16] ceph: Tell the VFS that readpage was synchronous
Date: Fri,  9 Oct 2020 15:30:53 +0100
Message-ID: <20201009143104.22673-6-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>

The ceph readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6ea761c84494..b2bf8bf7a312 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -291,10 +291,11 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 static int ceph_readpage(struct file *filp, struct page *page)
 {
 	int r = ceph_do_readpage(filp, page);
-	if (r != -EINPROGRESS)
-		unlock_page(page);
-	else
-		r = 0;
+	if (r == -EINPROGRESS)
+		return 0;
+	if (r == 0)
+		return AOP_UPDATED_PAGE;
+	unlock_page(page);
 	return r;
 }
 
-- 
2.28.0

