From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/7] namespace: add kernel doc for mnt_clone_internal()
Date: Wed, 14 Apr 2021 14:37:46 +0200
Message-ID: <20210414123750.2110159-3-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhDNMjC (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:02 -0400
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>, David Howells <dhowells@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org, linux-cachefs@redhat.com, Christian Brauner <christian.brauner@ubuntu.com>

From: Christian Brauner <christian.brauner@ubuntu.com>

Document mnt_clone_internal().

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 02f415061efe..7ffefa8b3980 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1271,6 +1271,22 @@ bool path_is_mountpoint(const struct path *path)
 }
 EXPORT_SYMBOL(path_is_mountpoint);
 
+/**
+ * mnt_clone_internal - create a private clone of a path
+ * @path: path from which the mnt to clone will be taken
+ *
+ * This creates a new vfsmount, which will be a clone of @path's vfsmount.
+ *
+ * In contrast to clone_private_mount() the new mount will be marked
+ * MNT_INTERNAL and will note have any mount namespace attached making it
+ * suitable for short-lived internal mounts since mntput()ing it will always
+ * hit the slowpath taking the mount lock.
+ *
+ * Since the mount is not reachable anwyhere mount properties and propagation
+ * properties remain stable, i.e. cannot change.
+ *
+ * Return: A clone of @path's vfsmount on success, an error pointer on failure.
+ */
 struct vfsmount *mnt_clone_internal(const struct path *path)
 {
 	struct mount *p;
-- 
2.27.0

