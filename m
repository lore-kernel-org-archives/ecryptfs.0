From: Abhijit Pawar <abhi.c.pawar@gmail.com>
Subject: [PATCH 2/2] fs:ecryptfs basic code optimization
Date: Mon, 12 Nov 2012 14:18:14 +0530
Message-ID: <1352710094-3705-1-git-send-email-abhi.c.pawar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Abhijit Pawar <abhi.c.pawar@gmail.com>

crypto.c: modified if() check in ecryptfs_encrypt_and_encode_filename(). It will evaluate only once and we use that evaluation result again later instead of re-evaluating the condition.

Signed-off-by: Abhijit Pawar <abhi.c.pawar@gmail.com>
---
 fs/ecryptfs/crypto.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ea99312..b5e4836 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -2086,6 +2086,7 @@ int ecryptfs_encrypt_and_encode_filename(
 	    || (mount_crypt_stat && (mount_crypt_stat->flags
 				     & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES))) {
 		struct ecryptfs_filename *filename;
+		bool flag = false;
 
 		filename = kzalloc(sizeof(*filename), GFP_KERNEL);
 		if (!filename) {
@@ -2113,10 +2114,12 @@ int ecryptfs_encrypt_and_encode_filename(
 				    & ECRYPTFS_ENCFN_USE_MOUNT_FNEK))
 		    || (mount_crypt_stat
 			&& (mount_crypt_stat->flags
-			    & ECRYPTFS_GLOBAL_ENCFN_USE_MOUNT_FNEK)))
+			    & ECRYPTFS_GLOBAL_ENCFN_USE_MOUNT_FNEK))) {
 			(*encoded_name_size) =
 				(ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE
 				 + encoded_name_no_prefix_size);
+			flag = true;
+		}
 		else
 			(*encoded_name_size) =
 				(ECRYPTFS_FEK_ENCRYPTED_FILENAME_PREFIX_SIZE
@@ -2131,11 +2134,7 @@ int ecryptfs_encrypt_and_encode_filename(
 			kfree(filename);
 			goto out;
 		}
-		if ((crypt_stat && (crypt_stat->flags
-				    & ECRYPTFS_ENCFN_USE_MOUNT_FNEK))
-		    || (mount_crypt_stat
-			&& (mount_crypt_stat->flags
-			    & ECRYPTFS_GLOBAL_ENCFN_USE_MOUNT_FNEK))) {
+		if (flag) {
 			memcpy((*encoded_name),
 			       ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX,
 			       ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_SIZE);
-- 
1.7.7.6
