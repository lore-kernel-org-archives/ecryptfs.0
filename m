From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 3/3] ecryptfs: extend ro check to private mount
Date: Fri,  9 Apr 2021 18:24:22 +0200
Message-ID: <20210409162422.1326565-4-brauner@kernel.org>
References: <20210409162422.1326565-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDIQ0S (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:18 -0400
In-Reply-To: <20210409162422.1326565-1-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>

From: Christian Brauner <christian.brauner@ubuntu.com>

So far ecryptfs only verified that the superblock wasn't read-only but
didn't check whether the mount was. This made sense when we did not use
a private mount because the read-only state could change at any point.

Now that we have a private mount and mount properties can't change
behind our back extend the read-only check to include the vfsmount.

The __mnt_is_readonly() helper will check both the mount and the
superblock.  Note that before we checked root->d_sb and now we check
mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
this is only syntactical change, not a semantic one.

Overlayfs and cachefiles have been changed to check this as well.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ecryptfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 9dcf9a0dd37b..cdf37d856c62 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -569,7 +569,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	 *   1) The lower mount is ro
 	 *   2) The ecryptfs_encrypted_view mount option is specified
 	 */
-	if (sb_rdonly(path.dentry->d_sb) || mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
+	if (__mnt_is_readonly(mnt) || mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
 		s->s_flags |= SB_RDONLY;
 
 	s->s_maxbytes = path.dentry->d_sb->s_maxbytes;
-- 
2.27.0

