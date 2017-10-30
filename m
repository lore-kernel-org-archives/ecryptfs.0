From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ecryptfs: remove unnecessary i_version bump
Date: Mon, 30 Oct 2017 11:01:31 -0400
Message-ID: <20171030150131.2587-1-jlayton@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

There is no need to bump the i_version counter here, as ecryptfs does
not set the MS_I_VERSION flag, and doesn't use it internally. It also
only bumps it when the inode is instantiated, which doesn't make much
sense.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ecryptfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index efc2db42d175..b59b083379ea 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -64,7 +64,6 @@ static int ecryptfs_inode_set(struct inode *inode, void *opaque)
 	/* i_size will be overwritten for encrypted regular files */
 	fsstack_copy_inode_size(inode, lower_inode);
 	inode->i_ino = lower_inode->i_ino;
-	inode->i_version++;
 	inode->i_mapping->a_ops = &ecryptfs_aops;
 
 	if (S_ISLNK(inode->i_mode))
-- 
2.13.6

