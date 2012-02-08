From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Copy up lower inode attrs after setting lower xattr
Date: Tue,  7 Feb 2012 18:12:44 -0600
Message-ID: <1328659964-31816-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45381 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab2BHAMy (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2012 19:12:54 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>

After passing through a ->setxattr() call, eCryptfs needs to copy the
inode attributes from the lower inode to the eCryptfs inode, as they
may have changed in the lower filesystem's ->setxattr() path.

One example is if an extended attribute containing a POSIX Access
Control List is being set. The new ACL may cause the lower filesystem to
modify the mode of the lower inode and the eCryptfs inode would need to
be updated to reflect the new mode.

https://launchpad.net/bugs/926292

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reported-by: Sebastien Bacher <seb128@ubuntu.com>
Cc: John Johansen <john.johansen@canonical.com>
---
 fs/ecryptfs/inode.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 19892d7..ab35b11 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1085,6 +1085,8 @@ ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	}
 
 	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
+	if (!rc)
+		fsstack_copy_attr_all(dentry->d_inode, lower_dentry->d_inode);
 out:
 	return rc;
 }
-- 
1.7.8.3
