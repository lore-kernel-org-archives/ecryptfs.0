From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Copy up POSIX ACL and read-only flags from lower mount
Date: Mon, 11 Jun 2012 15:46:45 -0700
Message-ID: <1339454805-23792-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48621 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab2FKWqz (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 11 Jun 2012 18:46:55 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Stefan Beller <stefanbeller@googlemail.com>, John Johansen <john.johansen@canonical.com>

When the eCryptfs mount options do not include '-o acl', but the lower
filesystem's mount options do include 'acl', the MS_POSIXACL flag is not
flipped on in the eCryptfs super block flags. This flag is what the VFS
checks in do_last() when deciding if the current umask should be applied
to a newly created inode's mode or not. When a default POSIX ACL mask is
set on a directory, the current umask is incorrectly applied to new
inodes created in the directory. This patch ignores the MS_POSIXACL flag
passed into ecryptfs_mount() and sets the flag on the eCryptfs super
block depending on the flag's presence on the lower super block.

Additionally, it is incorrect to allow a writeable eCryptfs mount on top
of a read-only lower mount. This missing check did not allow writes to
the read-only lower mount because permissions checks are still performed
on the lower filesystem's objects but it is best to simply not allow a
rw mount on top of ro mount. However, a ro eCryptfs mount on top of a rw
mount is valid and still allowed.

https://launchpad.net/bugs/1009207

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reported-by: Stefan Beller <stefanbeller@googlemail.com>
Cc: John Johansen <john.johansen@canonical.com>
---
 fs/ecryptfs/main.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 6895493..df217dc 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -505,7 +505,6 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 		goto out;
 	}
 
-	s->s_flags = flags;
 	rc = bdi_setup_and_register(&sbi->bdi, "ecryptfs", BDI_CAP_MAP_COPY);
 	if (rc)
 		goto out1;
@@ -541,6 +540,15 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	}
 
 	ecryptfs_set_superblock_lower(s, path.dentry->d_sb);
+
+	/**
+	 * Set the POSIX ACL flag based on whether they're enabled in the lower
+	 * mount. Force a read-only eCryptfs mount if the lower mount is ro.
+	 * Allow a ro eCryptfs mount even when the lower mount is rw.
+	 */
+	s->s_flags = flags & ~MS_POSIXACL;
+	s->s_flags |= path.dentry->d_sb->s_flags & (MS_RDONLY | MS_POSIXACL);
+
 	s->s_maxbytes = path.dentry->d_sb->s_maxbytes;
 	s->s_blocksize = path.dentry->d_sb->s_blocksize;
 	s->s_magic = ECRYPTFS_SUPER_MAGIC;
-- 
1.7.9.5
