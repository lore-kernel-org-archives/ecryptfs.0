From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Invalidate dcache entries when lower i_nlink is zero
Date: Wed,  5 Aug 2015 17:02:13 -0500
Message-ID: <1438812133-28889-1-git-send-email-tyhicks@canonical.com>
References: <20150803052758.GA24915@boyd>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803052758.GA24915@boyd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>

Consider eCryptfs dcache entries to be stale when the corresponding
lower inode's i_nlink count is zero. This solves a problem caused by the
lower inode being directly modified, without going through the eCryptfs
mount, leaving stale eCryptfs dentries cached and the eCryptfs inode's
i_nlink count not being cleared.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reported-by: Richard Weinberger <richard@nod.at>
---
 fs/ecryptfs/dentry.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 8db0b46..63cd2c1 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -45,20 +45,20 @@
 static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	int rc;
-
-	if (!(lower_dentry->d_flags & DCACHE_OP_REVALIDATE))
-		return 1;
+	int rc = 1;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	rc = lower_dentry->d_op->d_revalidate(lower_dentry, flags);
+	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE)
+		rc = lower_dentry->d_op->d_revalidate(lower_dentry, flags);
+
 	if (d_really_is_positive(dentry)) {
-		struct inode *lower_inode =
-			ecryptfs_inode_to_lower(d_inode(dentry));
+		struct inode *inode = d_inode(dentry);
 
-		fsstack_copy_attr_all(d_inode(dentry), lower_inode);
+		fsstack_copy_attr_all(inode, ecryptfs_inode_to_lower(inode));
+		if (!inode->i_nlink)
+			return 0;
 	}
 	return rc;
 }
-- 
2.1.4
