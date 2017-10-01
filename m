From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= 
        <jeremy.lefaure@lse.epita.fr>
Subject: [PATCH 08/18] ecryptfs: use ARRAY_SIZE
Date: Sun,  1 Oct 2017 15:30:46 -0400
Message-ID: <20171001193101.8898-9-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Using the ARRAY_SIZE macro improves the readability of the code.

Found with Coccinelle with the following semantic patch:
@r depends on (org || report)@
type T;
T[] E;
position p;
@@
(
 (sizeof(E)@p /sizeof(*E))
|
 (sizeof(E)@p /sizeof(E[...]))
|
 (sizeof(E)@p /sizeof(T))
)

Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
---
 fs/ecryptfs/crypto.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7acd57da4f14..2e78e851788e 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -36,6 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
+#include <linux/kernel.h>
 #include "ecryptfs_kernel.h"
 
 #define DECRYPT		0
@@ -884,8 +885,7 @@ static int ecryptfs_process_flags(struct ecryptfs_crypt_stat *crypt_stat,
 	u32 flags;
 
 	flags = get_unaligned_be32(page_virt);
-	for (i = 0; i < ((sizeof(ecryptfs_flag_map)
-			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
+	for (i = 0; i < ARRAY_SIZE(ecryptfs_flag_map); i++)
 		if (flags & ecryptfs_flag_map[i].file_flag) {
 			crypt_stat->flags |= ecryptfs_flag_map[i].local_flag;
 		} else
@@ -922,8 +922,7 @@ void ecryptfs_write_crypt_stat_flags(char *page_virt,
 	u32 flags = 0;
 	int i;
 
-	for (i = 0; i < ((sizeof(ecryptfs_flag_map)
-			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
+	for (i = 0; i < ARRAY_SIZE(ecryptfs_flag_map); i++)
 		if (crypt_stat->flags & ecryptfs_flag_map[i].local_flag)
 			flags |= ecryptfs_flag_map[i].file_flag;
 	/* Version is in top 8 bits of the 32-bit flag vector */
-- 
2.14.1

