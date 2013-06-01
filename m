From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] eCryptfs: Cocci spatch "memdup.spatch"
Date: Sat, 01 Jun 2013 11:39:36 +0200
Message-ID: <1370079576.29224.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org


Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -247,14 +247,13 @@ int ecryptfs_process_response(struct ecr
 		goto unlock;
 	}
 	msg_size = (sizeof(*msg) + msg->data_len);
-	msg_ctx->msg = kmalloc(msg_size, GFP_KERNEL);
+	msg_ctx->msg = kmemdup(msg, msg_size, GFP_KERNEL);
 	if (!msg_ctx->msg) {
 		rc = -ENOMEM;
 		printk(KERN_ERR "%s: Failed to allocate [%zd] bytes of "
 		       "GFP_KERNEL memory\n", __func__, msg_size);
 		goto unlock;
 	}
-	memcpy(msg_ctx->msg, msg, msg_size);
 	msg_ctx->state = ECRYPTFS_MSG_CTX_STATE_DONE;
 	wake_up_process(msg_ctx->task);
 	rc = 0;

