From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 1/3] eCryptfs: Sanitize write counts of /dev/ecryptfs
Date: Fri, 20 Jan 2012 13:29:10 -0600
Message-ID: <1327087752-17310-2-git-send-email-tyhicks@canonical.com>
References: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33427 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab2ATT37 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 20 Jan 2012 14:29:59 -0500
In-Reply-To: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Sasha Levin <levinsasha928@gmail.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

A malicious count value specified when writing to /dev/ecryptfs may
result in a a very large kernel memory allocation.

This patch peeks at the specified packet payload size, adds that to the
size of the packet headers and compares the result with the write count
value. The resulting maximum memory allocation size is approximately 532
bytes.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Cc: <stable@vger.kernel.org>
---
 fs/ecryptfs/miscdev.c |   56 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 940a82e..0dc5a3d 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -409,11 +409,47 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	ssize_t sz = 0;
 	char *data;
 	uid_t euid = current_euid();
+	unsigned char packet_size_peek[3];
 	int rc;
 
-	if (count == 0)
+	if (count == 0) {
 		goto out;
+	} else if (count == (1 + 4)) {
+		/* Likely a harmless MSG_HELO or MSG_QUIT - no packet length */
+		goto memdup;
+	} else if (count < (1 + 4 + 1)
+		   || count > (1 + 4 + 2 + sizeof(struct ecryptfs_message) + 4
+			       + ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES)) {
+		printk(KERN_WARNING "%s: Acceptable packet size range is "
+		       "[%d-%lu], but amount of data written is [%zu].",
+		       __func__, (1 + 4 + 1),
+		       (1 + 4 + 2 + sizeof(struct ecryptfs_message) + 4
+			+ ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES), count);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(packet_size_peek, (buf + 1 + 4),
+			   sizeof(packet_size_peek))) {
+		printk(KERN_WARNING "%s: Error while inspecting packet size\n",
+		       __func__);
+		return -EFAULT;
+	}
+
+	rc = ecryptfs_parse_packet_length(packet_size_peek, &packet_size,
+					  &packet_size_length);
+	if (rc) {
+		printk(KERN_WARNING "%s: Error parsing packet length; "
+		       "rc = [%d]\n", __func__, rc);
+		return rc;
+	}
+
+	if ((1 + 4 + packet_size_length + packet_size) != count) {
+		printk(KERN_WARNING "%s: Invalid packet size [%zu]\n", __func__,
+		       packet_size);
+		return -EINVAL;
+	}
 
+memdup:
 	data = memdup_user(buf, count);
 	if (IS_ERR(data)) {
 		printk(KERN_ERR "%s: memdup_user returned error [%ld]\n",
@@ -435,23 +471,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 		}
 		memcpy(&counter_nbo, &data[i], 4);
 		seq = be32_to_cpu(counter_nbo);
-		i += 4;
-		rc = ecryptfs_parse_packet_length(&data[i], &packet_size,
-						  &packet_size_length);
-		if (rc) {
-			printk(KERN_WARNING "%s: Error parsing packet length; "
-			       "rc = [%d]\n", __func__, rc);
-			goto out_free;
-		}
-		i += packet_size_length;
-		if ((1 + 4 + packet_size_length + packet_size) != count) {
-			printk(KERN_WARNING "%s: (1 + packet_size_length([%zd])"
-			       " + packet_size([%zd]))([%zd]) != "
-			       "count([%zd]). Invalid packet format.\n",
-			       __func__, packet_size_length, packet_size,
-			       (1 + packet_size_length + packet_size), count);
-			goto out_free;
-		}
+		i += 4 + packet_size_length;
 		rc = ecryptfs_miscdev_response(&data[i], packet_size,
 					       euid, current_user_ns(),
 					       task_pid(current), seq);
-- 
1.7.8.3
