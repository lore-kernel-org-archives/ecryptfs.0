From: Douglas Leeder <douglas.leeder@sophos.com>
Subject: Re: ecryptfs and fanotify
Date: Mon, 20 Aug 2012 15:53:30 +0100
Message-ID: <195f26b0-6305-4808-b64c-15ad3de86612@abn-exch1b.green.sophos>
References: <5d3d0cdc-50db-4d60-8f9d-701acdbb86b0@ABN-EXCH1A.green.sophos> <CANT6BaPhaAOv3hg9CgoDa9JTp9vN60zf8bdAQX+dFp6YLSUwnA@mail.gmail.com> <F85176E33E12BA45BD553324E7858B300CE0A5@abn-exch1b.green.sophos> <20120814093124.GA12898@astaro.com> <502A2D77.50805@sophos.com> <94863d0d-4a43-427e-8c75-a6f8ced15ffa@ABN-EXCH1A.green.sophos> <20120814202739.GD5215@boyd>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000709040101020907050808"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx6.sophos.com ([195.171.192.176]:41951 "EHLO mx6.sophos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815Ab2HTOxf (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 20 Aug 2012 10:53:35 -0400
In-Reply-To: <20120814202739.GD5215@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler C Hicks <tyhicks@canonical.com>
Cc: Florian Westphal <Florian.Westphal@sophos.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Eric Paris <eparis@redhat.com>, "malware-list@dmesg.printk.net" <malware-list@dmesg.printk.net>, Eddie Garcia <eddie.garcia@gazzang.com>, Sergio Pena <sergio.pena@gazzang.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

--------------000709040101020907050808
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 14/08/12 21:27, Tyler C Hicks wrote:
> On 2012-08-14 17:01:14, Douglas Leeder wrote:

>> So I've looked at the path required for that and I guess it involves
>> passing file->f_flags from ecryptfs_open through:
>>   * ecryptfs_get_lower_file (main.c)
>>   * ecryptfs_init_lower_file (main.c)
>>   * ecryptfs_privileged_open (kthread.c)
>>
>> Does that look like the correct to you, Tyler?
>
> Yeah, that should be the full list.
>
> However, I don't think this approach will work with the current
> eCryptfs design. eCryptfs only keeps one lower file open per inode. That
> means that there could be 10 file descriptors opened for a given
> eCryptfs file but there is still only one lower file opened that
> everything is multiplexed through.
>
> I don't like the design, but it has been that way for years and I
> haven't touched it. For your approach to work, I think eCryptfs would
> need to be changed to have a 1-to-1 mapping of upper files to lower
> files.
>

I've attached my patch to pass the flags though, and apply the
FMODE_NONOTIFY flag to the lower access.

The other callers of ecryptfs_get_lower_file just pass in zero, so
will continue with the existing behaviour.

What do you think?

--
Douglas Leeder, Senior Software Engineer

________________________________

Sophos Limited, The Pentagon, Abingdon Science Park, Abingdon, OX14 3YP, Un=
ited Kingdom.
Company Reg No 2096520. VAT Reg No GB 991 2418 08.

--------------000709040101020907050808
Content-Type: text/x-patch;
	name="0001-Pass-the-f_flags-from-the-upper-open-to-the-lower-op.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Pass-the-f_flags-from-the-upper-open-to-the-lower-op.pa";
	filename*1="tch"

From 8d204f86caefbbbe918ecd36ff1dfeacaa71eefd Mon Sep 17 00:00:00 2001
From: Douglas Leeder <douglas.leeder@sophos.com>
Date: Mon, 20 Aug 2012 15:33:29 +0100
Subject: [PATCH] Pass the f_flags from the upper open to the lower open.

Ensure that if the upper open happens with FMODE_NONOTIFY set,
then the lower open also does that.
This should prevent the dead-lock with fanotify and ecryptfs.
---
 fs/ecryptfs/ecryptfs_kernel.h |    5 +++--
 fs/ecryptfs/file.c            |    2 +-
 fs/ecryptfs/inode.c           |    8 ++++----
 fs/ecryptfs/kthread.c         |    6 +++++-
 fs/ecryptfs/main.c            |    8 ++++----
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index cfb4b9f..651477a 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -668,8 +668,9 @@ void ecryptfs_destroy_kthread(void);
 int ecryptfs_privileged_open(struct file **lower_file,
 			     struct dentry *lower_dentry,
 			     struct vfsmount *lower_mnt,
-			     const struct cred *cred);
-int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode);
+			     const struct cred *cred,
+			     unsigned int upper_file_flags);
+int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode, unsigned int upper_file_flags);
 void ecryptfs_put_lower_file(struct inode *inode);
 int
 ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 44ce5c6..aa8aad5 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -232,7 +232,7 @@ static int ecryptfs_open(struct inode *inode, struct file *file)
 				      | ECRYPTFS_ENCRYPTED);
 	}
 	mutex_unlock(&crypt_stat->cs_mutex);
-	rc = ecryptfs_get_lower_file(ecryptfs_dentry, inode);
+	rc = ecryptfs_get_lower_file(ecryptfs_dentry, inode, file->f_flags);
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 534b129..847ced2 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -246,7 +246,7 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
 				"context; rc = [%d]\n", rc);
 		goto out;
 	}
-	rc = ecryptfs_get_lower_file(ecryptfs_dentry, ecryptfs_inode);
+	rc = ecryptfs_get_lower_file(ecryptfs_dentry, ecryptfs_inode, 0);
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
@@ -309,7 +309,7 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 	struct ecryptfs_crypt_stat *crypt_stat;
 	int rc;
 
-	rc = ecryptfs_get_lower_file(dentry, inode);
+	rc = ecryptfs_get_lower_file(dentry, inode, 0);
 	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to initialize "
 			"the lower file for the dentry with name "
@@ -767,7 +767,7 @@ static int truncate_upper(struct dentry *dentry, struct iattr *ia,
 		lower_ia->ia_valid &= ~ATTR_SIZE;
 		return 0;
 	}
-	rc = ecryptfs_get_lower_file(dentry, inode);
+	rc = ecryptfs_get_lower_file(dentry, inode, 0);
 	if (rc)
 		return rc;
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
@@ -935,7 +935,7 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 
 		mount_crypt_stat = &ecryptfs_superblock_to_private(
 			dentry->d_sb)->mount_crypt_stat;
-		rc = ecryptfs_get_lower_file(dentry, inode);
+		rc = ecryptfs_get_lower_file(dentry, inode, 0);
 		if (rc) {
 			mutex_unlock(&crypt_stat->cs_mutex);
 			goto out;
diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index 809e67d..83e9914 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -122,6 +122,8 @@ void ecryptfs_destroy_kthread(void)
  * @lower_file: Result of dentry_open by root on lower dentry
  * @lower_dentry: Lower dentry for file to open
  * @lower_mnt: Lower vfsmount for file to open
+ * @cred
+ * @upper_file_flags: Upper file flags for the open
  *
  * This function gets a r/w file opened againt the lower dentry.
  *
@@ -130,7 +132,8 @@ void ecryptfs_destroy_kthread(void)
 int ecryptfs_privileged_open(struct file **lower_file,
 			     struct dentry *lower_dentry,
 			     struct vfsmount *lower_mnt,
-			     const struct cred *cred)
+			     const struct cred *cred,
+			     unsigned int upper_file_flags)
 {
 	struct ecryptfs_open_req req;
 	int flags = O_LARGEFILE;
@@ -145,6 +148,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
 	 * lower file is fput() when all eCryptfs files for the inode are
 	 * released. */
 	flags |= IS_RDONLY(lower_dentry->d_inode) ? O_RDONLY : O_RDWR;
+	flags |= (upper_file_flags & FMODE_NONOTIFY);
 	(*lower_file) = dentry_open(&req.path, flags, cred);
 	if (!IS_ERR(*lower_file))
 		goto out;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2768138..0ceebcc 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -117,7 +117,7 @@ void __ecryptfs_printk(const char *fmt, ...)
  * Returns zero on success; non-zero otherwise
  */
 static int ecryptfs_init_lower_file(struct dentry *dentry,
-				    struct file **lower_file)
+				    struct file **lower_file, unsigned int upper_file_flags)
 {
 	const struct cred *cred = current_cred();
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
@@ -125,7 +125,7 @@ static int ecryptfs_init_lower_file(struct dentry *dentry,
 	int rc;
 
 	rc = ecryptfs_privileged_open(lower_file, lower_dentry, lower_mnt,
-				      cred);
+				      cred, upper_file_flags);
 	if (rc) {
 		printk(KERN_ERR "Error opening lower file "
 		       "for lower_dentry [0x%p] and lower_mnt [0x%p]; "
@@ -135,7 +135,7 @@ static int ecryptfs_init_lower_file(struct dentry *dentry,
 	return rc;
 }
 
-int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode)
+int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode, unsigned int upper_file_flags)
 {
 	struct ecryptfs_inode_info *inode_info;
 	int count, rc = 0;
@@ -147,7 +147,7 @@ int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode)
 		rc = -EINVAL;
 	else if (count == 1) {
 		rc = ecryptfs_init_lower_file(dentry,
-					      &inode_info->lower_file);
+					      &inode_info->lower_file,upper_file_flags);
 		if (rc)
 			atomic_set(&inode_info->lower_file_count, 0);
 	}
-- 
1.7.9.5


--------------000709040101020907050808--
