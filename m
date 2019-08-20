From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ecryptfs: fix a memory leak bug
Date: Tue, 20 Aug 2019 00:16:40 -0500
Message-ID: <1566278200-9368-1-git-send-email-wenwen@cs.uga.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Tyler Hicks <tyhicks@canonical.com>, "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

In parse_tag_1_packet(), if tag 1 packet contains a key larger than
ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES, no cleanup is executed, leading to a
memory leak on the allocated 'auth_tok_list_item'. To fix this issue, go to
the label 'out_free' to perform the cleanup work.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 216fbe6..4dc0963 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1304,7 +1304,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		printk(KERN_WARNING "Tag 1 packet contains key larger "
 		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES\n");
 		rc = -EINVAL;
-		goto out;
+		goto out_free;
 	}
 	memcpy((*new_auth_tok)->session_key.encrypted_key,
 	       &data[(*packet_size)], (body_size - (ECRYPTFS_SIG_SIZE + 2)));
-- 
2.7.4

