From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 2/3] eCryptfs: Report errors in writes to /dev/ecryptfs
Date: Fri, 20 Jan 2012 13:29:11 -0600
Message-ID: <1327087752-17310-3-git-send-email-tyhicks@canonical.com>
References: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33433 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab2ATTaA (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 20 Jan 2012 14:30:00 -0500
In-Reply-To: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Sasha Levin <levinsasha928@gmail.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Errors in writes to /dev/ecryptfs were being incorrectly reported by
returning 0 or the value of the original write count.

This patch clears up the return code assignment in error paths.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/miscdev.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 0dc5a3d..1145c58 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -406,14 +406,13 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	__be32 counter_nbo;
 	u32 seq;
 	size_t packet_size, packet_size_length, i;
-	ssize_t sz = 0;
 	char *data;
 	uid_t euid = current_euid();
 	unsigned char packet_size_peek[3];
-	int rc;
+	ssize_t rc;
 
 	if (count == 0) {
-		goto out;
+		return 0;
 	} else if (count == (1 + 4)) {
 		/* Likely a harmless MSG_HELO or MSG_QUIT - no packet length */
 		goto memdup;
@@ -439,7 +438,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 					  &packet_size_length);
 	if (rc) {
 		printk(KERN_WARNING "%s: Error parsing packet length; "
-		       "rc = [%d]\n", __func__, rc);
+		       "rc = [%zd]\n", __func__, rc);
 		return rc;
 	}
 
@@ -454,9 +453,8 @@ memdup:
 	if (IS_ERR(data)) {
 		printk(KERN_ERR "%s: memdup_user returned error [%ld]\n",
 		       __func__, PTR_ERR(data));
-		goto out;
+		return PTR_ERR(data);
 	}
-	sz = count;
 	i = 0;
 	switch (data[i++]) {
 	case ECRYPTFS_MSG_RESPONSE:
@@ -467,6 +465,7 @@ memdup:
 			       __func__,
 			       (1 + 4 + 1 + sizeof(struct ecryptfs_message)),
 			       count);
+			rc = -EINVAL;
 			goto out_free;
 		}
 		memcpy(&counter_nbo, &data[i], 4);
@@ -475,10 +474,12 @@ memdup:
 		rc = ecryptfs_miscdev_response(&data[i], packet_size,
 					       euid, current_user_ns(),
 					       task_pid(current), seq);
-		if (rc)
+		if (rc) {
 			printk(KERN_WARNING "%s: Failed to deliver miscdev "
-			       "response to requesting operation; rc = [%d]\n",
+			       "response to requesting operation; rc = [%zd]\n",
 			       __func__, rc);
+			goto out_free;
+		}
 		break;
 	case ECRYPTFS_MSG_HELO:
 	case ECRYPTFS_MSG_QUIT:
@@ -487,12 +488,13 @@ memdup:
 		ecryptfs_printk(KERN_WARNING, "Dropping miscdev "
 				"message of unrecognized type [%d]\n",
 				data[0]);
-		break;
+		rc = -EINVAL;
+		goto out_free;
 	}
+	rc = count;
 out_free:
 	kfree(data);
-out:
-	return sz;
+	return rc;
 }
 
 
-- 
1.7.8.3
