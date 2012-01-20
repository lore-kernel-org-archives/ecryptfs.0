From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 3/3] eCryptfs: Replace miscdev read/write magic numbers
Date: Fri, 20 Jan 2012 13:29:12 -0600
Message-ID: <1327087752-17310-4-git-send-email-tyhicks@canonical.com>
References: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33440 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab2ATTaC (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 20 Jan 2012 14:30:02 -0500
In-Reply-To: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Sasha Levin <levinsasha928@gmail.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

ecryptfs_miscdev_read() and ecryptfs_miscdev_write() contained many
magic numbers for specifying packet header field sizes and offsets. This
patch defines those values and replaces the magic values.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 fs/ecryptfs/ecryptfs_kernel.h |    5 ++
 fs/ecryptfs/keystore.c        |    5 +-
 fs/ecryptfs/miscdev.c         |   86 ++++++++++++++++++++++------------------
 3 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index a9f29b1..a2362df 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -151,6 +151,11 @@ ecryptfs_get_key_payload_data(struct key *key)
 					  * dentry name */
 #define ECRYPTFS_TAG_73_PACKET_TYPE 0x49 /* FEK-encrypted filename as
 					  * metadata */
+#define ECRYPTFS_MIN_PKT_LEN_SIZE 1 /* Min size to specify packet length */
+#define ECRYPTFS_MAX_PKT_LEN_SIZE 2 /* Pass at least this many bytes to
+				     * ecryptfs_parse_packet_length() and
+				     * ecryptfs_write_packet_length()
+				     */
 /* Constraint: ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTES >=
  * ECRYPTFS_MAX_IV_BYTES */
 #define ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTES 16
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index ac1ad48..8e3b943 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -109,7 +109,7 @@ int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
 		(*size) += ((unsigned char)(data[1]) + 192);
 		(*length_size) = 2;
 	} else if (data[0] == 255) {
-		/* Five-byte length; we're not supposed to see this */
+		/* If support is added, adjust ECRYPTFS_MAX_PKT_LEN_SIZE */
 		ecryptfs_printk(KERN_ERR, "Five-byte packet length not "
 				"supported\n");
 		rc = -EINVAL;
@@ -126,7 +126,7 @@ out:
 /**
  * ecryptfs_write_packet_length
  * @dest: The byte array target into which to write the length. Must
- *        have at least 5 bytes allocated.
+ *        have at least ECRYPTFS_MAX_PKT_LEN_SIZE bytes allocated.
  * @size: The length to write.
  * @packet_size_length: The number of bytes used to encode the packet
  *                      length is written to this address.
@@ -146,6 +146,7 @@ int ecryptfs_write_packet_length(char *dest, size_t size,
 		dest[1] = ((size - 192) % 256);
 		(*packet_size_length) = 2;
 	} else {
+		/* If support is added, adjust ECRYPTFS_MAX_PKT_LEN_SIZE */
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING,
 				"Unsupported packet size: [%zd]\n", size);
diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 1145c58..349209d 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -218,6 +218,29 @@ out_unlock:
 	return rc;
 }
 
+/*
+ * miscdevfs packet format:
+ *  Octet 0: Type
+ *  Octets 1-4: network byte order msg_ctx->counter
+ *  Octets 5-N0: Size of struct ecryptfs_message to follow
+ *  Octets N0-N1: struct ecryptfs_message (including data)
+ *
+ *  Octets 5-N1 not written if the packet type does not include a message
+ */
+#define PKT_TYPE_SIZE		1
+#define PKT_CTR_SIZE		4
+#define MIN_NON_MSG_PKT_SIZE	(PKT_TYPE_SIZE + PKT_CTR_SIZE)
+#define MIN_MSG_PKT_SIZE	(PKT_TYPE_SIZE + PKT_CTR_SIZE \
+				 + ECRYPTFS_MIN_PKT_LEN_SIZE)
+/* 4 + ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES comes from tag 65 packet format */
+#define MAX_MSG_PKT_SIZE	(PKT_TYPE_SIZE + PKT_CTR_SIZE \
+				 + ECRYPTFS_MAX_PKT_LEN_SIZE \
+				 + sizeof(struct ecryptfs_message) \
+				 + 4 + ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES)
+#define PKT_TYPE_OFFSET		0
+#define PKT_CTR_OFFSET		PKT_TYPE_SIZE
+#define PKT_LEN_OFFSET		(PKT_TYPE_SIZE + PKT_CTR_SIZE)
+
 /**
  * ecryptfs_miscdev_read - format and send message from queue
  * @file: fs/ecryptfs/euid miscdevfs handle (ignored)
@@ -237,7 +260,7 @@ ecryptfs_miscdev_read(struct file *file, char __user *buf, size_t count,
 	struct ecryptfs_daemon *daemon;
 	struct ecryptfs_msg_ctx *msg_ctx;
 	size_t packet_length_size;
-	char packet_length[3];
+	char packet_length[ECRYPTFS_MAX_PKT_LEN_SIZE];
 	size_t i;
 	size_t total_length;
 	uid_t euid = current_euid();
@@ -305,15 +328,8 @@ check_list:
 		packet_length_size = 0;
 		msg_ctx->msg_size = 0;
 	}
-	/* miscdevfs packet format:
-	 *  Octet 0: Type
-	 *  Octets 1-4: network byte order msg_ctx->counter
-	 *  Octets 5-N0: Size of struct ecryptfs_message to follow
-	 *  Octets N0-N1: struct ecryptfs_message (including data)
-	 *
-	 *  Octets 5-N1 not written if the packet type does not
-	 *  include a message */
-	total_length = (1 + 4 + packet_length_size + msg_ctx->msg_size);
+	total_length = (PKT_TYPE_SIZE + PKT_CTR_SIZE + packet_length_size
+			+ msg_ctx->msg_size);
 	if (count < total_length) {
 		rc = 0;
 		printk(KERN_WARNING "%s: Only given user buffer of "
@@ -324,9 +340,10 @@ check_list:
 	rc = -EFAULT;
 	if (put_user(msg_ctx->type, buf))
 		goto out_unlock_msg_ctx;
-	if (put_user(cpu_to_be32(msg_ctx->counter), (__be32 __user *)(buf + 1)))
+	if (put_user(cpu_to_be32(msg_ctx->counter),
+		     (__be32 __user *)(&buf[PKT_CTR_OFFSET])))
 		goto out_unlock_msg_ctx;
-	i = 5;
+	i = PKT_TYPE_SIZE + PKT_CTR_SIZE;
 	if (msg_ctx->msg) {
 		if (copy_to_user(&buf[i], packet_length, packet_length_size))
 			goto out_unlock_msg_ctx;
@@ -391,12 +408,6 @@ out:
  * @count: Amount of data in @buf
  * @ppos: Pointer to offset in file (ignored)
  *
- * miscdevfs packet format:
- *  Octet 0: Type
- *  Octets 1-4: network byte order msg_ctx->counter (0's for non-response)
- *  Octets 5-N0: Size of struct ecryptfs_message to follow
- *  Octets N0-N1: struct ecryptfs_message (including data)
- *
  * Returns the number of bytes read from @buf
  */
 static ssize_t
@@ -405,29 +416,25 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 {
 	__be32 counter_nbo;
 	u32 seq;
-	size_t packet_size, packet_size_length, i;
+	size_t packet_size, packet_size_length;
 	char *data;
 	uid_t euid = current_euid();
-	unsigned char packet_size_peek[3];
+	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE];
 	ssize_t rc;
 
 	if (count == 0) {
 		return 0;
-	} else if (count == (1 + 4)) {
+	} else if (count == MIN_NON_MSG_PKT_SIZE) {
 		/* Likely a harmless MSG_HELO or MSG_QUIT - no packet length */
 		goto memdup;
-	} else if (count < (1 + 4 + 1)
-		   || count > (1 + 4 + 2 + sizeof(struct ecryptfs_message) + 4
-			       + ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES)) {
+	} else if (count < MIN_MSG_PKT_SIZE || count > MAX_MSG_PKT_SIZE) {
 		printk(KERN_WARNING "%s: Acceptable packet size range is "
 		       "[%d-%lu], but amount of data written is [%zu].",
-		       __func__, (1 + 4 + 1),
-		       (1 + 4 + 2 + sizeof(struct ecryptfs_message) + 4
-			+ ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES), count);
+		       __func__, MIN_MSG_PKT_SIZE, MAX_MSG_PKT_SIZE, count);
 		return -EINVAL;
 	}
 
-	if (copy_from_user(packet_size_peek, (buf + 1 + 4),
+	if (copy_from_user(packet_size_peek, &buf[PKT_LEN_OFFSET],
 			   sizeof(packet_size_peek))) {
 		printk(KERN_WARNING "%s: Error while inspecting packet size\n",
 		       __func__);
@@ -442,7 +449,8 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 		return rc;
 	}
 
-	if ((1 + 4 + packet_size_length + packet_size) != count) {
+	if ((PKT_TYPE_SIZE + PKT_CTR_SIZE + packet_size_length + packet_size)
+	    != count) {
 		printk(KERN_WARNING "%s: Invalid packet size [%zu]\n", __func__,
 		       packet_size);
 		return -EINVAL;
@@ -455,25 +463,25 @@ memdup:
 		       __func__, PTR_ERR(data));
 		return PTR_ERR(data);
 	}
-	i = 0;
-	switch (data[i++]) {
+	switch (data[PKT_TYPE_OFFSET]) {
 	case ECRYPTFS_MSG_RESPONSE:
-		if (count < (1 + 4 + 1 + sizeof(struct ecryptfs_message))) {
+		if (count < (MIN_MSG_PKT_SIZE
+			     + sizeof(struct ecryptfs_message))) {
 			printk(KERN_WARNING "%s: Minimum acceptable packet "
 			       "size is [%zd], but amount of data written is "
 			       "only [%zd]. Discarding response packet.\n",
 			       __func__,
-			       (1 + 4 + 1 + sizeof(struct ecryptfs_message)),
-			       count);
+			       (MIN_MSG_PKT_SIZE
+				+ sizeof(struct ecryptfs_message)), count);
 			rc = -EINVAL;
 			goto out_free;
 		}
-		memcpy(&counter_nbo, &data[i], 4);
+		memcpy(&counter_nbo, &data[PKT_CTR_OFFSET], PKT_CTR_SIZE);
 		seq = be32_to_cpu(counter_nbo);
-		i += 4 + packet_size_length;
-		rc = ecryptfs_miscdev_response(&data[i], packet_size,
-					       euid, current_user_ns(),
-					       task_pid(current), seq);
+		rc = ecryptfs_miscdev_response(
+				&data[PKT_LEN_OFFSET + packet_size_length],
+				packet_size, euid, current_user_ns(),
+				task_pid(current), seq);
 		if (rc) {
 			printk(KERN_WARNING "%s: Failed to deliver miscdev "
 			       "response to requesting operation; rc = [%zd]\n",
-- 
1.7.8.3
