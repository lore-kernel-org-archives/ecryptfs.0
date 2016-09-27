From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ecryptfs:  add missing \n to end of various error messages
Date: Tue, 27 Sep 2016 05:18:02 -0700
Message-ID: <20160927121802.30574-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34944 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933534AbcI0MSJ (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 27 Sep 2016 08:18:09 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, some error messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ecryptfs/keystore.c | 2 +-
 fs/ecryptfs/main.c     | 2 +-
 fs/ecryptfs/miscdev.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3cf1546..11d39ab 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1326,7 +1326,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 	if ((*new_auth_tok)->session_key.encrypted_key_size
 	    > ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES) {
 		printk(KERN_WARNING "Tag 1 packet contains key larger "
-		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES");
+		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES\n");
 		rc = -EINVAL;
 		goto out;
 	}
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 6120044..3c41b35 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -426,7 +426,7 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 		mount_crypt_stat->global_default_cipher_key_size);
 	if (!cipher_code) {
 		ecryptfs_printk(KERN_ERR,
-				"eCryptfs doesn't support cipher: %s",
+				"eCryptfs doesn't support cipher: %s\n",
 				mount_crypt_stat->global_default_cipher_name);
 		rc = -EINVAL;
 		goto out;
diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index e4141f2..595e684 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -383,7 +383,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 		goto memdup;
 	} else if (count < MIN_MSG_PKT_SIZE || count > MAX_MSG_PKT_SIZE) {
 		printk(KERN_WARNING "%s: Acceptable packet size range is "
-		       "[%d-%zu], but amount of data written is [%zu].",
+		       "[%d-%zu], but amount of data written is [%zu].\n",
 		       __func__, MIN_MSG_PKT_SIZE, MAX_MSG_PKT_SIZE, count);
 		return -EINVAL;
 	}
-- 
2.9.3
