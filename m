From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] ecryptfs: replace BUG_ON with error handling code
Date: Sun, 15 Dec 2019 11:24:04 -0600
Message-ID: <20191215172404.28204-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

In crypt_scatterlist, if the crypt_stat argument is not set up
correctly, we avoid crashing, by returning the error upstream.
This patch performs the fix.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/ecryptfs/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f91db24bbf3b..a064b408d841 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
+	if (!crypt_stat || !crypt_stat->tfm
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
+		return -EINVAL;
+
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
 				crypt_stat->key_size);
-- 
2.20.1

