From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/9] Use %pd in eCryptFS
Date: Tue, 10 Dec 2013 15:26:48 +0000
Message-ID: <20131210152648.4916.63963.stgit@warthog.procyon.org.uk>
References: <20131210152612.4916.80435.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766Ab3LJP0w (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 10 Dec 2013 10:26:52 -0500
In-Reply-To: <20131210152612.4916.80435.stgit@warthog.procyon.org.uk>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>

Use the new %pd printk() specifier in eCryptFS to replace passing of dentry
name or dentry name and name length * 2 with just passing the dentry.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tyler Hicks <tyhicks@canonical.com>
cc: ecryptfs@vger.kernel.org
---

 fs/ecryptfs/file.c  |    4 ++--
 fs/ecryptfs/inode.c |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index b1eaa7a1f82c..c705360e2b16 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -230,8 +230,8 @@ static int ecryptfs_open(struct inode *inode, struct file *file)
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
-			"[%s]; rc = [%d]\n", __func__,
-			ecryptfs_dentry->d_name.name, rc);
+			"[%pd]; rc = [%d]\n", __func__,
+			ecryptfs_dentry, rc);
 		goto out_free;
 	}
 	if ((ecryptfs_inode_to_private(inode)->lower_file->f_flags & O_ACCMODE)
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c36c44824471..87ad33e091e9 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -250,8 +250,8 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
-			"[%s]; rc = [%d]\n", __func__,
-			ecryptfs_dentry->d_name.name, rc);
+			"[%pd]; rc = [%d]\n", __func__,
+			ecryptfs_dentry, rc);
 		goto out;
 	}
 	rc = ecryptfs_write_metadata(ecryptfs_dentry, ecryptfs_inode);
@@ -313,8 +313,8 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
-			"[%s]; rc = [%d]\n", __func__,
-			dentry->d_name.name, rc);
+			"[%pd]; rc = [%d]\n", __func__,
+			dentry, rc);
 		return rc;
 	}
 
@@ -418,8 +418,8 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 	if (IS_ERR(lower_dentry)) {
 		rc = PTR_ERR(lower_dentry);
 		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
-				"[%d] on lower_dentry = [%s]\n", __func__, rc,
-				ecryptfs_dentry->d_name.name);
+				"[%d] on lower_dentry = [%pd]\n", __func__, rc,
+				ecryptfs_dentry);
 		goto out;
 	}
 	if (lower_dentry->d_inode)
