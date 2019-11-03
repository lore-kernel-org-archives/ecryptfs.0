From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH][RFC] ecryptfs_lookup_interpose(): lower_dentry->d_parent is
 not stable either
Date: Sun, 3 Nov 2019 19:03:23 +0000
Message-ID: <20191103190323.GS26530@ZenIV.linux.org.uk>
References: <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191103163524.GO26530@ZenIV.linux.org.uk>
 <20191103182058.GQ26530@ZenIV.linux.org.uk>
 <20191103185133.GR26530@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191103185133.GR26530@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel@vger.kernel.org
Cc: Ritesh Harjani <riteshh@linux.ibm.com>, linux-kernel@vger.kernel.org, wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com, Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, ecryptfs@vger.kernel.org

We need to get the underlying dentry of parent; sure, absent the races
it is the parent of underlying dentry, but there's nothing to prevent
losing a timeslice to preemtion in the middle of evaluation of
lower_dentry->d_parent->d_inode, having another process move lower_dentry
around and have its (ex)parent not pinned anymore and freed on memory
pressure.  Then we regain CPU and try to fetch ->d_inode from memory
that is freed by that point.

dentry->d_parent *is* stable here - it's an argument of ->lookup() and
we are guaranteed that it won't be moved anywhere until we feed it
to d_add/d_splice_alias.  So we safely go that way to get to its
underlying dentry.

Cc: stable@vger.kernel.org # since 2009 or so
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 3c2298721359..e23752d9a79f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -319,9 +319,9 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 				     struct dentry *lower_dentry)
 {
+	struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
 	struct inode *inode, *lower_inode;
 	struct ecryptfs_dentry_info *dentry_info;
-	struct vfsmount *lower_mnt;
 	int rc = 0;
 
 	dentry_info = kmem_cache_alloc(ecryptfs_dentry_info_cache, GFP_KERNEL);
@@ -330,13 +330,12 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	lower_mnt = mntget(ecryptfs_dentry_to_lower_mnt(dentry->d_parent));
 	fsstack_copy_attr_atime(d_inode(dentry->d_parent),
-				d_inode(lower_dentry->d_parent));
+				d_inode(path->dentry));
 	BUG_ON(!d_count(lower_dentry));
 
 	ecryptfs_set_dentry_private(dentry, dentry_info);
-	dentry_info->lower_path.mnt = lower_mnt;
+	dentry_info->lower_path.mnt = mntget(path->mnt);
 	dentry_info->lower_path.dentry = lower_dentry;
 
 	/*
