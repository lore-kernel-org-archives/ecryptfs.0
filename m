From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] fs/ecryptfs/messaging.c: remove null test before kfree
Date: Mon, 16 Jun 2014 20:06:12 +0200
Message-ID: <1402941972-5166-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org

Fix checkpatch warning:
WARNING: kfree(NULL) is safe this check is probably not required

Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/ecryptfs/messaging.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index e57380e..286f10b 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -434,8 +434,7 @@ void ecryptfs_release_messaging(void)
 		mutex_lock(&ecryptfs_msg_ctx_lists_mux);
 		for (i = 0; i < ecryptfs_message_buf_len; i++) {
 			mutex_lock(&ecryptfs_msg_ctx_arr[i].mux);
-			if (ecryptfs_msg_ctx_arr[i].msg)
-				kfree(ecryptfs_msg_ctx_arr[i].msg);
+			kfree(ecryptfs_msg_ctx_arr[i].msg);
 			mutex_unlock(&ecryptfs_msg_ctx_arr[i].mux);
 		}
 		kfree(ecryptfs_msg_ctx_arr);
-- 
1.8.4.5
