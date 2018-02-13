From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ecryptfs: Restore support for both encrypted and unencrypted file names
Date: Tue, 13 Feb 2018 14:36:08 -0800
Message-ID: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>

Commit 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or
plaintext name") was supposed to fix a situation where two files with
the same name and same inode could be created in ecryptfs. One of those
files had an encrypted file name, the other file name was unencrypted.

After commit 88ae4ab9802e, having a mix of encrypted and unencrypted file
names is no longer supposed to be possible. However, that is not the case.
The only difference is that it is now even easier to create a situation
where two files with the same name coexist (one encrypted and the other
not encrypted). In practice, this looks like the following (files
created with v4.14.12).

ecryptfs mounted with file name encryption enabled:

$ ls -li
total 48
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
$ grep . *
myfile:encrypted
myfile:encrypted
myfile2:encrypted
myfile2:encrypted

$ ls -li
total 48
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36
ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njbcIPoApxk7-E--
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02
ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCtJ70cm911yZ---
5252817 -rw-rw-r-- 1 groeck groeck 12 Jan 20 12:52 myfile
5252827 -rw-rw-r-- 1 groeck groeck 12 Jan 20 15:37 myfile2

$ grep . *
ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njbcIPoApxk7-E--:encrypted
ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCtJ70cm911yZ---:encrypted
myfile:unencrypted
myfile2:unencrypted

Creating a file with file name encryption disabled and remounting with
file name encryption enabled results in the following.

$ ls -li
ls: cannot access 'myfile3': No such file or directory
total 48
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
      ? -????????? ? ?      ?       ?            ? myfile3

Prior to commit 88ae4ab9802e, the file system had to be mounted with
encrypted file names first to create a file, then the same had to be
repeated after mounting with unencrypted file names. Now the duplicate
files can be created both ways (unencrypted _or_ encrypted first).

The only real difference is that it is no longer possible to have a
_working_ combination of encrypted and unencrypted file names. In other
words, commit 88ae4ab9802e results in reduced functionality with no
benefit whatsoever.

Restore ability to have a mix of unencrypted and encrypted files.
This effectively reverts commit 88ae4ab9802e, but the code is now
better readable since it avoids a number of goto statements.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ecryptfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 847904aa63a9..14a5c096ead6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -392,11 +392,11 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 	int rc = 0;
 
 	lower_dir_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry->d_parent);
-
+	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 				ecryptfs_dentry->d_sb)->mount_crypt_stat;
-	if (mount_crypt_stat
-	    && (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
+	if (IS_ERR(lower_dentry) &&
+	    (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
 		rc = ecryptfs_encrypt_and_encode_filename(
 			&encrypted_and_encoded_name, &len,
 			mount_crypt_stat, name, len);
@@ -405,10 +405,10 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 			       "filename; rc = [%d]\n", __func__, rc);
 			return ERR_PTR(rc);
 		}
-		name = encrypted_and_encoded_name;
+		lower_dentry = lookup_one_len_unlocked(
+			encrypted_and_encoded_name, lower_dir_dentry, len);
 	}
 
-	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
 	if (IS_ERR(lower_dentry)) {
 		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
 				"[%ld] on lower_dentry = [%s]\n", __func__,
-- 
2.7.4

