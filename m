From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: don't pass up plaintext names when using filename encryption
Date: Thu, 29 Mar 2018 00:32:47 +0000
Message-ID: <1522283567-4889-1-git-send-email-tyhicks@canonical.com>
References: <891ab33d-a140-0a6d-6907-ba226590eb3f@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <891ab33d-a140-0a6d-6907-ba226590eb3f@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>

Both ecryptfs_filldir() and ecryptfs_readlink_lower() use
ecryptfs_decode_and_decrypt_filename() to translate lower filenames to
upper filenames. The function correctly passes up lower filenames,
unchanged, when filename encryption isn't in use. However, it was also
passing up lower filenames when the filename wasn't encrypted or
when decryption failed. Since 88ae4ab9802e, eCryptfs refuses to lookup
lower plaintext names when filename encryption is enabled so this
resulted in a situation where userspace would see lower plaintext
filenames in calls to getdents(2) but then not be able to lookup those
filenames.

An example of this can be seen when enabling filename encryption on an
eCryptfs mount at the root directory of an Ext4 filesystem:

$ ls -1i /lower
12 ECRYPTFS_FNEK_ENCRYPTED.FWYZD8TcW.5FV-TKTEYOHsheiHX9a-w.NURCCYIMjI8pn5BDB9-h3fXwrE--
11 lost+found
$ ls -1i /upper
ls: cannot access '/upper/lost+found': No such file or directory
 ? lost+found
12 test

With this change, the lower lost+found dentry is ignored:

$ ls -1i /lower
12 ECRYPTFS_FNEK_ENCRYPTED.FWYZD8TcW.5FV-TKTEYOHsheiHX9a-w.NURCCYIMjI8pn5BDB9-h3fXwrE--
11 lost+found
$ ls -1i /upper
12 test

Additionally, some potentially noisy error/info messages in the related
code paths are turned into debug messages so that the logs can't be
easily filled.

Fixes: 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or plaintext name")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/crypto.c | 41 ++++++++++++++++++++++++++++-------------
 fs/ecryptfs/file.c   | 21 ++++++++++++++++-----
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 846ca15..4dd842f 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1997,6 +1997,16 @@ int ecryptfs_encrypt_and_encode_filename(
 	return rc;
 }
 
+static bool is_dot_dotdot(const char *name, size_t name_size)
+{
+	if (name_size == 1 && name[0] == '.')
+		return true;
+	else if (name_size == 2 && name[0] == '.' && name[1] == '.')
+		return true;
+
+	return false;
+}
+
 /**
  * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
  * @plaintext_name: The plaintext name
@@ -2021,13 +2031,21 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 	size_t packet_size;
 	int rc = 0;
 
-	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)
-	    && !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
-	    && (name_size > ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE)
-	    && (strncmp(name, ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX,
-			ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE) == 0)) {
-		const char *orig_name = name;
-		size_t orig_name_size = name_size;
+	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) &&
+	    !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)) {
+		if (is_dot_dotdot(name, name_size)) {
+			rc = ecryptfs_copy_filename(plaintext_name,
+						    plaintext_name_size,
+						    name, name_size);
+			goto out;
+		}
+
+		if (name_size <= ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE ||
+		    strncmp(name, ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX,
+			    ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE)) {
+			rc = -EINVAL;
+			goto out;
+		}
 
 		name += ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE;
 		name_size -= ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE;
@@ -2047,12 +2065,9 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 						  decoded_name,
 						  decoded_name_size);
 		if (rc) {
-			printk(KERN_INFO "%s: Could not parse tag 70 packet "
-			       "from filename; copying through filename "
-			       "as-is\n", __func__);
-			rc = ecryptfs_copy_filename(plaintext_name,
-						    plaintext_name_size,
-						    orig_name, orig_name_size);
+			ecryptfs_printk(KERN_DEBUG,
+					"%s: Could not parse tag 70 packet from filename\n",
+					__func__);
 			goto out_free;
 		}
 	} else {
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c74ed3c..b76a985 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -82,17 +82,28 @@ ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
 						  buf->sb, lower_name,
 						  lower_namelen);
 	if (rc) {
-		printk(KERN_ERR "%s: Error attempting to decode and decrypt "
-		       "filename [%s]; rc = [%d]\n", __func__, lower_name,
-		       rc);
-		goto out;
+		if (rc != -EINVAL) {
+			ecryptfs_printk(KERN_DEBUG,
+					"%s: Error attempting to decode and decrypt filename [%s]; rc = [%d]\n",
+					__func__, lower_name, rc);
+			return rc;
+		}
+
+		/* Mask -EINVAL errors as these are most likely due a plaintext
+		 * filename present in the lower filesystem despite filename
+		 * encryption being enabled. One unavoidable example would be
+		 * the "lost+found" dentry in the root directory of an Ext4
+		 * filesystem.
+		 */
+		return 0;
 	}
+
 	buf->caller->pos = buf->ctx.pos;
 	rc = !dir_emit(buf->caller, name, name_size, ino, d_type);
 	kfree(name);
 	if (!rc)
 		buf->entries_written++;
-out:
+
 	return rc;
 }
 
-- 
2.7.4

