From: Andrey Pronin <apronin@chromium.org>
Subject: [PATCH v2] ecryptfs: sync before truncating lower inode
Date: Wed, 26 Apr 2017 11:02:15 -0700
Message-ID: <20170426180215.42572-1-apronin@chromium.org>
References: <20170418233649.78805-1-apronin@chromium.org>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36559 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932616AbdDZSCS (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Apr 2017 14:02:18 -0400
Received: by mail-pf0-f178.google.com with SMTP id 194so3575812pfv.3
        for <ecryptfs@vger.kernel.org>; Wed, 26 Apr 2017 11:02:18 -0700 (PDT)
In-Reply-To: <20170418233649.78805-1-apronin@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, gwendal@chromium.org, dtor@chromium.org, Andrey Pronin <apronin@chromium.org>

If the updated ecryptfs header data is not written to disk before
the lower file is truncated, a crash may leave the filesystem
in the state when the lower file truncation is journaled, while
the changes to the ecryptfs header are lost (if the underlying
filesystem is ext4 in data=ordered mode, for example). As a result,
upon remounting and repairing the file may have a pre-truncation
length and garbage data after the post-truncation end.

To reproduce, make a snapshot of the underlying ext4 filesystem
mounted with data=ordered while asynchronously truncating to zero a
group of files in ecryptfs mounted on top. Mount ecryptfs for the
snapshot and check the contents of the group of files that was
being truncated. The following script reproduces it in almost 100%
of runs:

cd /tmp
mkdir -p ./loop
dd if=/dev/zero of=./file.img bs=1M count=10
PW=secret

LOOPDEV=`losetup --find --show ./file.img`
mkfs -t ext4 $LOOPDEV
mount -t ext4 -o rw,nodev,relatime,seclabel,commit=600,data=ordered\
 $LOOPDEV ./loop
mkdir -p ./loop/vault ./loop/mount
mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=aes,\
ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache\
 ./loop/vault ./loop/mount
for i in `seq 1 100`; do echo $i > ./loop/mount/test.$i; done
sync
for i in `seq 100 -1 1`; do truncate -s 0 ./loop/mount/test.$i; done &
sleep 0.1; sync; cp ./file.img ./file.snap; sleep 1
umount ./loop/mount
umount ./loop
losetup -d $LOOPDEV

LOOPDEV=`losetup --find --show ./file.snap`
mount -t ext4 -o rw,nodev,relatime,seclabel,commit=600,data=ordered\
 $LOOPDEV ./loop
mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=aes,\
ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_passthrough=no,\
ecryptfs_enable_filename_crypto=no,passphrase_passwd="$PW",no_sig_cache\
 ./loop/vault ./loop/mount
for i in `seq 1 100`; do
  if [ `stat -c %s ./loop/mount/test.$i` != 0 ] &&
     [ `cat ./loop/mount/test.$i` != $i ]; then
       echo -n "!!! garbage at $i: ";  cat ./loop/mount/test.$i; echo
  fi
done
umount ./loop/mount
umount ./loop
losetup -d $LOOPDEV

Signed-off-by: Andrey Pronin <apronin@chromium.org>
---

Changes since v1:
 - Switched to datasync=1 for ecryptfs_fsync_lower() in truncate_upper()

 fs/ecryptfs/ecryptfs_kernel.h |  1 +
 fs/ecryptfs/inode.c           |  6 ++++++
 fs/ecryptfs/read_write.c      | 22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index f622a733f7ad..567698421270 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -689,6 +689,7 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
 				     pgoff_t page_index,
 				     size_t offset_in_page, size_t size,
 				     struct inode *ecryptfs_inode);
+int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync);
 struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index);
 int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
 				 size_t *length_size);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5eab400e2590..a96988ba6928 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -827,6 +827,12 @@ static int truncate_upper(struct dentry *dentry, struct iattr *ia,
 			       "rc = [%d]\n", rc);
 			goto out;
 		}
+		rc = ecryptfs_fsync_lower(inode, 1);
+		if (rc) {
+			printk(KERN_WARNING "Problem with ecryptfs_fsync_lower,"
+			       "continue without syncing; "
+			       "rc = [%d]\n", rc);
+		}
 		/* We are reducing the size of the ecryptfs file, and need to
 		 * know if we need to reduce the size of the lower file. */
 		lower_size_before_truncate =
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 09fe622274e4..ba2dd6263875 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -271,3 +271,25 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
 	flush_dcache_page(page_for_ecryptfs);
 	return rc;
 }
+
+/**
+ * ecryptfs_fsync_lower
+ * @ecryptfs_inode: The eCryptfs inode
+ * @datasync: Only perform a fdatasync operation
+ *
+ * Write back data and metadata for the lower file to disk.  If @datasync is
+ * set only metadata needed to access modified file data is written.
+ *
+ * Returns 0 on success; less than zero on error
+ */
+int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync)
+{
+	struct file *lower_file;
+
+	lower_file = ecryptfs_inode_to_private(ecryptfs_inode)->lower_file;
+	if (!lower_file)
+		return -EIO;
+	if (!lower_file->f_op->fsync)
+		return 0;
+	return vfs_fsync(lower_file, datasync);
+}
-- 
2.13.0.rc0.306.g87b477812d-goog
