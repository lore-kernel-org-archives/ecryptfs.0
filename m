From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ecryptfs: fix a memory leak bug
Date: Tue, 20 Aug 2019 00:33:54 -0500
Message-ID: <1566279234-9634-1-git-send-email-wenwen@cs.uga.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Tyler Hicks <tyhicks@canonical.com>, "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

In ecryptfs_init_messaging(), if the allocation for 'ecryptfs_msg_ctx_arr'
fails, the previously allocated 'ecryptfs_daemon_hash' is not deallocated,
leading to a memory leak bug. To fix this issue, free
'ecryptfs_daemon_hash' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/ecryptfs/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index d668e60..c05ca39 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -379,6 +379,7 @@ int __init ecryptfs_init_messaging(void)
 					* ecryptfs_message_buf_len),
 				       GFP_KERNEL);
 	if (!ecryptfs_msg_ctx_arr) {
+		kfree(ecryptfs_daemon_hash);
 		rc = -ENOMEM;
 		goto out;
 	}
-- 
2.7.4

