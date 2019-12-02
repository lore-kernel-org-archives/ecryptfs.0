From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] fs: introduce is_dot_dotdot helper for cleanup
Date: Mon,  2 Dec 2019 18:10:13 +0800
Message-ID: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>, Tyler Hicks <tyhicks@canonical.com>
Cc: linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

There exists many similar and duplicate codes to check "." and "..",
so introduce is_dot_dotdot helper to make the code more clean.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/crypto/fname.c    | 15 ++-------------
 fs/ecryptfs/crypto.c | 13 ++-----------
 fs/f2fs/f2fs.h       | 11 -----------
 fs/libfs.c           | 12 ++++++++++++
 fs/namei.c           |  6 ++----
 include/linux/fs.h   |  2 ++
 6 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3da3707..36be864 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -15,17 +15,6 @@
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
-static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
-{
-	if (str->len == 1 && str->name[0] == '.')
-		return true;
-
-	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
-		return true;
-
-	return false;
-}
-
 /**
  * fname_encrypt() - encrypt a filename
  *
@@ -255,7 +244,7 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
 	const struct qstr qname = FSTR_TO_QSTR(iname);
 	struct fscrypt_digested_name digested_name;
 
-	if (fscrypt_is_dot_dotdot(&qname)) {
+	if (is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
 		oname->name[iname->len - 1] = '.';
 		oname->len = iname->len;
@@ -323,7 +312,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
 
-	if (!IS_ENCRYPTED(dir) || fscrypt_is_dot_dotdot(iname)) {
+	if (!IS_ENCRYPTED(dir) || is_dot_dotdot(iname)) {
 		fname->disk_name.name = (unsigned char *)iname->name;
 		fname->disk_name.len = iname->len;
 		return 0;
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f91db24..6f4db74 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1991,16 +1991,6 @@ int ecryptfs_encrypt_and_encode_filename(
 	return rc;
 }
 
-static bool is_dot_dotdot(const char *name, size_t name_size)
-{
-	if (name_size == 1 && name[0] == '.')
-		return true;
-	else if (name_size == 2 && name[0] == '.' && name[1] == '.')
-		return true;
-
-	return false;
-}
-
 /**
  * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
  * @plaintext_name: The plaintext name
@@ -2020,6 +2010,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 {
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
 		&ecryptfs_superblock_to_private(sb)->mount_crypt_stat;
+	const struct qstr file_name = {.name = name, .len = name_size};
 	char *decoded_name;
 	size_t decoded_name_size;
 	size_t packet_size;
@@ -2027,7 +2018,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 
 	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) &&
 	    !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)) {
-		if (is_dot_dotdot(name, name_size)) {
+		if (is_dot_dotdot(&file_name)) {
 			rc = ecryptfs_copy_filename(plaintext_name,
 						    plaintext_name_size,
 						    name, name_size);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a0..3d5e684 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2767,17 +2767,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
 }
 
-static inline bool is_dot_dotdot(const struct qstr *str)
-{
-	if (str->len == 1 && str->name[0] == '.')
-		return true;
-
-	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
-		return true;
-
-	return false;
-}
-
 static inline bool f2fs_may_extent_tree(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/libfs.c b/fs/libfs.c
index 1463b03..876b1b6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1291,3 +1291,15 @@ bool is_empty_dir_inode(struct inode *inode)
 	return (inode->i_fop == &empty_dir_operations) &&
 		(inode->i_op == &empty_dir_inode_operations);
 }
+
+bool is_dot_dotdot(const struct qstr *str)
+{
+	if (str->len == 1 && str->name[0] == '.')
+		return true;
+
+	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(is_dot_dotdot);
diff --git a/fs/namei.c b/fs/namei.c
index 2dda552..7730a3b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2458,10 +2458,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 	if (!len)
 		return -EACCES;
 
-	if (unlikely(name[0] == '.')) {
-		if (len < 2 || (len == 2 && name[1] == '.'))
-			return -EACCES;
-	}
+	if (unlikely(is_dot_dotdot(this)))
+		return -EACCES;
 
 	while (len--) {
 		unsigned int c = *(const unsigned char *)name++;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c159a8b..e999826 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3627,4 +3627,6 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+extern bool is_dot_dotdot(const struct qstr *str);
+
 #endif /* _LINUX_FS_H */
-- 
2.1.0

