From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ecryptfs: use print_hex_dump_bytes for hexdump
Date: Fri, 17 May 2019 12:45:15 +0200
Message-ID: <20190517104515.10371-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org
Cc: Tyler Hicks <tyhicks@canonical.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

The Kernel has nice hexdump facilities, use them rather a homebrew
hexdump function.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ecryptfs/debug.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 3d2bdf546ec6..ee9d8ac4a809 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -97,25 +97,9 @@ void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
  */
 void ecryptfs_dump_hex(char *data, int bytes)
 {
-	int i = 0;
-	int add_newline = 1;
-
 	if (ecryptfs_verbosity < 1)
 		return;
-	if (bytes != 0) {
-		printk(KERN_DEBUG "0x%.2x.", (unsigned char)data[i]);
-		i++;
-	}
-	while (i < bytes) {
-		printk("0x%.2x.", (unsigned char)data[i]);
-		i++;
-		if (i % 16 == 0) {
-			printk("\n");
-			add_newline = 0;
-		} else
-			add_newline = 1;
-	}
-	if (add_newline)
-		printk("\n");
-}
 
+	print_hex_dump(KERN_DEBUG, "ecryptfs: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       data, bytes, false);
+}
-- 
2.20.1

