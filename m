From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 08/12] ecrypt-fs: replace direct access of d_count with the d_count() helper
Date: Fri,  5 Jul 2013 10:48:19 -0400
Message-ID: <1373035699-40780-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Miklos Szeredi <mszeredi@suse.cz>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <andi@firstfloor.org>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>

Because of the d_count change made in dcache.h, all readonly references
to d_count have to be changed to use the new d_count() helper as they
shouldn't access its value directly.  There is no change in logic
and everything should just work.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 fs/ecryptfs/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5eab400..85f7f6c 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -358,7 +358,7 @@ static int ecryptfs_lookup_interpose(struct dentry *dentry,
 
 	lower_mnt = mntget(ecryptfs_dentry_to_lower_mnt(dentry->d_parent));
 	fsstack_copy_attr_atime(dir_inode, lower_dentry->d_parent->d_inode);
-	BUG_ON(!lower_dentry->d_count);
+	BUG_ON(!d_count(lower_dentry));
 
 	ecryptfs_set_dentry_private(dentry, dentry_info);
 	ecryptfs_set_dentry_lower(dentry, lower_dentry);
-- 
1.7.1
