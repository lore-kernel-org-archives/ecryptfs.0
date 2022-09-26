From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 21/30] ecryptfs: implement set acl method
Date: Mon, 26 Sep 2022 16:08:18 +0200
Message-ID: <20220926140827.142806-22-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiIZPX6 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 26 Sep 2022 11:23:58 -0400
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, linux-security-module@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

So far ecryptfs didn't implement get and set acl inode operations
because it wanted easy access to the dentry. Now that we extended the
set acl inode operation to take a dentry argument and added a new get
acl inode operation that takes a dentry argument we can let ecryptfs
implement get and set acl inode operations.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/ecryptfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 740312986388..c3d1ae688a19 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1129,6 +1129,21 @@ static struct posix_acl *ecryptfs_get_acl(struct user_namespace *mnt_userns,
 			   posix_acl_xattr_name(type));
 }
 
+static int ecryptfs_set_acl(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct posix_acl *acl,
+			    int type)
+{
+	int rc;
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	struct inode *lower_inode = d_inode(lower_dentry);
+
+	rc = vfs_set_acl(&init_user_ns, lower_dentry,
+			 posix_acl_xattr_name(type), acl);
+	if (!rc)
+		fsstack_copy_attr_all(d_inode(dentry), lower_inode);
+	return rc;
+}
+
 const struct inode_operations ecryptfs_symlink_iops = {
 	.get_link = ecryptfs_get_link,
 	.permission = ecryptfs_permission,
@@ -1153,6 +1168,7 @@ const struct inode_operations ecryptfs_dir_iops = {
 	.fileattr_get = ecryptfs_fileattr_get,
 	.fileattr_set = ecryptfs_fileattr_set,
 	.get_acl = ecryptfs_get_acl,
+	.set_acl = ecryptfs_set_acl,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1163,6 +1179,7 @@ const struct inode_operations ecryptfs_main_iops = {
 	.fileattr_get = ecryptfs_fileattr_get,
 	.fileattr_set = ecryptfs_fileattr_set,
 	.get_acl = ecryptfs_get_acl,
+	.set_acl = ecryptfs_set_acl,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.34.1

