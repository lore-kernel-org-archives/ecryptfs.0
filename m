From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5/7] cachefiles: extend ro check to private mount
Date: Wed, 14 Apr 2021 14:37:49 +0200
Message-ID: <20210414123750.2110159-6-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347293AbhDNMjO (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:14 -0400
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>, David Howells <dhowells@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, linux-cachefs@redhat.com, Christian Brauner <christian.brauner@ubuntu.com>

From: Christian Brauner <christian.brauner@ubuntu.com>

So far cachefiles only verified that the superblock wasn't read-only but
didn't check whether the mount was. This made sense when we did not use
a private mount because the read-only state could change at any point.

Now that we have a private mount and mount properties can't change
behind our back extend the read-only check to include the vfsmount.

The __mnt_is_readonly() helper will check both the mount and the
superblock.  Note that before we checked root->d_sb and now we check
mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
this is only syntactical change, not a semantic one.

Here's how this works:

mount -o ro --bind /var/cache/fscache/ /var/cache/fscache/

systemctl start cachefilesd
  Job for cachefilesd.service failed because the control process exited with error code.
  See "systemctl status cachefilesd.service" and "journalctl -xe" for details.

dmesg | grep CacheFiles
  [    2.922514] CacheFiles: Loaded
  [  272.206907] CacheFiles: Failed to register: -30

errno 30
  EROFS 30 Read-only file system

Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/cachefiles/bind.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 7ef572d698f0..8cf283de4e14 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -141,8 +141,13 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	    !root->d_sb->s_op->sync_fs)
 		goto error_unsupported;
 
+	/*
+	 * Verify our mount and superblock aren't read-only.
+	 * Note, while our private mount is guaranteed to not change anymore
+	 * the superblock may still go read-only later.
+	 */
 	ret = -EROFS;
-	if (sb_rdonly(root->d_sb))
+	if (__mnt_is_readonly(cache->mnt))
 		goto error_unsupported;
 
 	/* determine the security of the on-disk cache as this governs
-- 
2.27.0

