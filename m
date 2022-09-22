From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 25/29] ecryptfs: use stub posix acl handlers
Date: Thu, 22 Sep 2022 17:17:23 +0200
Message-ID: <20220922151728.1557914-26-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiIVPSn (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 22 Sep 2022 11:18:43 -0400
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org

Now that ecryptfs supports the get and set acl inode operations and the
vfs has been switched to the new posi api, ecryptfs can simply rely on
the stub posix acl handlers.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ecryptfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c3d1ae688a19..bd6ae2582cd6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1210,6 +1210,10 @@ static const struct xattr_handler ecryptfs_xattr_handler = {
 };
 
 const struct xattr_handler *ecryptfs_xattr_handlers[] = {
+#ifdef CONFIG_XFS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
 	&ecryptfs_xattr_handler,
 	NULL
 };
-- 
2.34.1

