From: Tim Sally <tsally@atomicpeace.com>
Subject: [PATCH 1/1] eCryptfs: check for eCryptfs cipher support at mount
Date: Thu, 12 Jul 2012 19:10:24 -0400
Message-ID: <1342134624-31564-1-git-send-email-tsally@atomicpeace.com>
References: <20120711171152.GA16475@boyd>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120711171152.GA16475@boyd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com, dustin.kirkland@gazzang.com
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Sally <tsally@atomicpeace.com>

The issue occurs when eCryptfs is mounted with a cipher supported by
the crypto subsystem but not by eCryptfs. The mount succeeds and an
error does not occur until a write. This change checks for eCryptfs
cipher support at mount time.

Resolves Launchpad issue #338914, reported by Tyler Hicks in 03/2009.
https://bugs.launchpad.net/ecryptfs/+bug/338914

Signed-off-by: Tim Sally <tsally@atomicpeace.com>
---
 fs/ecryptfs/main.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index df217dc..aee998d 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -279,6 +279,7 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 	char *fnek_src;
 	char *cipher_key_bytes_src;
 	char *fn_cipher_key_bytes_src;
+	u8 cipher_code;
 
 	*check_ruid = 0;
 
@@ -420,6 +421,18 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 	    && !fn_cipher_key_bytes_set)
 		mount_crypt_stat->global_default_fn_cipher_key_bytes =
 			mount_crypt_stat->global_default_cipher_key_size;
+
+	cipher_code = ecryptfs_code_for_cipher_string(
+		mount_crypt_stat->global_default_cipher_name,
+		mount_crypt_stat->global_default_cipher_key_size);
+	if (!cipher_code) {
+		ecryptfs_printk(KERN_ERR,
+				"eCryptfs doesn't support cipher: %s.",
+				mount_crypt_stat->global_default_cipher_name);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	mutex_lock(&key_tfm_list_mutex);
 	if (!ecryptfs_tfm_exists(mount_crypt_stat->global_default_cipher_name,
 				 NULL)) {
-- 
1.7.10.4
