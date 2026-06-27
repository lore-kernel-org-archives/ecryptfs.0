Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1A1A262D;
	Sat, 27 Jun 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782550986; cv=none; b=eDP7psuLoAr/B3A5uaOXlFwilZvLZ/nKQYHihQzZw/iLqQjclDUADx6UHZ4GZhnrXxterrbPBAfERgxI257pMOGfFCzHCjXP6IU/T4bwMmlD6eXJMIQysRjUOR228mV8aR2Qadfe7Ap7avMzedvF8JbS1swdm4t8nYsfCw7ak/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782550986; c=relaxed/simple;
	bh=GTf603+mx4Kcdyu/zkPc1CHCKGuqjTSMSy0LLnNVYHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhOkcnPP3Egy0CG7yuX2Up7TyfL0vuEtmaXG9QBn/1e6llE489f0zk71+BLglSRiDgqhNsKtOdpXqXr0tAQ7hqIHiMSt4Y3cW2yBsFlrHbThfdk6MGfMtixhe5imbQUOY8ZjMdiypFpWwfAuzC9NMqbg2qVsmDuUpW6Im4p0cvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lq+M/2fk; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lq+M/2fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782550936;
	bh=YsTFc2NrD73tEZN08fQu5xcF+mihbSilrm0+76GG2Q0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lq+M/2fkbXPl29+yXlBAiVTrqnOvMI0vMwS1nlQQILrPycA8yX2vgHS+QcMruo1w8
	 3rGNu2rVli98C57A0Zprb9hd+UGBhHSP+UkVJx3mw5C1tm7Hz+kWEZkBLQezxv7afQ
	 vKMWxBYo5jggjWhDxTboq+pbHBBRGfDd/5RnZkhI=
X-QQ-mid: esmtpsz11t1782550931tfcec1184
X-QQ-Originating-IP: NDYiPb7sVuO/PzbSo87Ze0LTz4KHsOu6JEYXD709grs=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 17:02:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4111563685710702774
EX-QQ-RecipientCnt: 7
From: Yichong Chen <chenyichong@uniontech.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Yichong Chen <chenyichong@uniontech.com>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: validate packet parser buffer lengths
Date: Sat, 27 Jun 2026 17:02:08 +0800
Message-Id: <20260627090208.27774-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ONalwM1aM/hinUhff7q/uIjulIg6SU1B98EhJw08yEUf+HsLcJlayyF0
	qctukkUMmWnKb6B667Jev1dv6CJljfY4/QH0gMxQejp7QEL/M24O/DrSsxVno2E8QsRTyvX
	zi/9QNljbmVp6cznHrpaE2xkMNBFWLAM/e4gotO81rRuPPR7/i2cgvwXDmqZ2sceZTT8Gcz
	HalIO2QOE3NZEOWwpLGoQoBrRV7DF1jhaNCRXC/Y/GnuvqSgWRPkn47fkamTY3hSsteGqiv
	KkAdMKBGFNYkOezCAY0pYYbigV7KLKFoRT2vU6Ue3FD74MTl5JMQILKbYxhDOtKLxRXlxTo
	ZZt6yDW9Qadm3l4lF+WPHp8dnBn7IKqDD+JhrFiXDti+FNIMMCHOb+cEK7nzW2gJuuux1RL
	2mhx6Q/hRtN4d2pwHzCNSXqrOm44GztvqwZfZB5ECJqmdlhpBBC1Pb23VjjphAB0Tv7fD70
	EY5f8fqXdcgmgzHNsj4mWawrriEQ040kNRj97ENc7z+VXceEAhXNsjm7Oe1oFkUJFM6tfTO
	JxQuqs3LSOZrKAxbyOK0wcZ4HGFuNF2f5Txe1KPdkw+6NS5NwDinapOrMTPVQluPiGYXvxi
	NNkhHwqKO4lChc+LRQHLg6S1XqjoJbHirJSRLliGDvNit52a+jYLdue5UDXe8mwzPGverB0
	ikVRUUf5f6TGgV2r5+Tscl7ODKLKpfYUHZVoUcPL1pMPrQw05k3cDoP7Tip9b4nd9UwUB4z
	XUpwpfmpHKjzBgrpls+hlPz6DIrMFQAuzOoyEq+AKbLQKP7O5Y0IL98jeChtzaD3BKqRf9N
	O/ANdmlUldedLn2Cpf/RbzButVwXJgNvQzvn6BwqTY1kZU2yVcAWhLzfB148MBjQHJGYdpI
	uE8DQ+eF1cV63mQjhGwdCkj7uo3/eKLfsswR7QNtMTRaJqVwlGOmFme4G1RH7E1aWEd/NJK
	OuBqcsygfbsLTvggh0l3XNyaGDCbLGurBTpQTio8YU2rNjZ+jIVu9FH8vJCPK1Sqyj+4+lu
	Ez044CraqCTpVsgTP3UbCLPwFN8p1fi7m22YooHTr+c0vdq1we
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

ecryptfs_parse_packet_set() receives a pointer into the file header,
but it calculates the remaining packet buffer size from PAGE_SIZE - 8.
For version 1 headers the packet set starts later in the header, so
this can overstate the available buffer.

Pass the actual packet set buffer length from the caller and use the
remaining length after each parsed packet. Also fix the tag 11 packet
exact-fit bounds check and reject too-small tag 70 packet bodies before
subtracting fixed metadata sizes.

Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Fixes: 9c79f34f7ee7 ("eCryptfs: Filename Encryption: Tag 70 packets")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/ecryptfs/crypto.c          |  2 +-
 fs/ecryptfs/ecryptfs_kernel.h |  3 ++-
 fs/ecryptfs/keystore.c        | 32 +++++++++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 74b02b55e3f6..e67119b6029c 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1197,7 +1197,7 @@ static int ecryptfs_read_headers_virt(char *page_virt,
 	} else
 		set_default_header_data(crypt_stat);
 	rc = ecryptfs_parse_packet_set(crypt_stat, (page_virt + offset),
-				       ecryptfs_dentry);
+				       PAGE_SIZE - offset, ecryptfs_dentry);
 out:
 	return rc;
 }
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index f4f56a92bd56..7d2488a10b17 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -580,7 +580,8 @@ int ecryptfs_generate_key_packet_set(char *dest_base,
 				     size_t *len, size_t max);
 int
 ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
-			  unsigned char *src, struct dentry *ecryptfs_dentry);
+			  unsigned char *src, size_t src_size,
+			  struct dentry *ecryptfs_dentry);
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
 ssize_t
 ecryptfs_getxattr_lower(struct dentry *lower_dentry, struct inode *lower_inode,
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index ebebc9551f1f..888599739274 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -894,6 +894,12 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 		       "rc = [%d]\n", __func__, rc);
 		goto out;
 	}
+	if (s->parsed_tag_70_packet_size < (ECRYPTFS_SIG_SIZE + 2)) {
+		ecryptfs_printk(KERN_WARNING, "Invalid packet size [%zd]\n",
+				s->parsed_tag_70_packet_size);
+		rc = -EINVAL;
+		goto out;
+	}
 	s->block_aligned_filename_size = (s->parsed_tag_70_packet_size
 					  - ECRYPTFS_SIG_SIZE - 1);
 	if ((1 + s->packet_size_len + s->parsed_tag_70_packet_size)
@@ -1537,7 +1543,7 @@ parse_tag_11_packet(unsigned char *data, unsigned char *contents,
 	}
 	(*packet_size) += length_size;
 	(*tag_11_contents_size) = (body_size - 14);
-	if (unlikely((*packet_size) + body_size + 1 > max_packet_size)) {
+	if (unlikely((*packet_size) + body_size > max_packet_size)) {
 		printk(KERN_ERR "Packet size exceeds max\n");
 		rc = -EINVAL;
 		goto out;
@@ -1704,6 +1710,7 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
  * ecryptfs_parse_packet_set
  * @crypt_stat: The cryptographic context
  * @src: Virtual address of region of memory containing the packets
+ * @src_size: Size of the packet set buffer
  * @ecryptfs_dentry: The eCryptfs dentry associated with the packet set
  *
  * Get crypt_stat to have the file's session key if the requisite key
@@ -1714,7 +1721,7 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
  * conditions.
  */
 int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
-			      unsigned char *src,
+			      unsigned char *src, size_t src_size,
 			      struct dentry *ecryptfs_dentry)
 {
 	size_t i = 0;
@@ -1736,7 +1743,11 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 	 * added the our &auth_tok_list */
 	next_packet_is_auth_tok_packet = 1;
 	while (next_packet_is_auth_tok_packet) {
-		size_t max_packet_size = ((PAGE_SIZE - 8) - i);
+		size_t max_packet_size;
+
+		if (i >= src_size)
+			break;
+		max_packet_size = src_size - i;
 
 		switch (src[i]) {
 		case ECRYPTFS_TAG_3_PACKET_TYPE:
@@ -1751,12 +1762,16 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 				goto out_wipe_list;
 			}
 			i += packet_size;
+			if (i > src_size) {
+				rc = -EIO;
+				goto out_wipe_list;
+			}
 			rc = parse_tag_11_packet((unsigned char *)&src[i],
 						 sig_tmp_space,
 						 ECRYPTFS_SIG_SIZE,
 						 &tag_11_contents_size,
 						 &tag_11_packet_size,
-						 max_packet_size);
+						 src_size - i);
 			if (rc) {
 				ecryptfs_printk(KERN_ERR, "No valid "
 						"(ecryptfs-specific) literal "
@@ -1768,6 +1783,10 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 				goto out_wipe_list;
 			}
 			i += tag_11_packet_size;
+			if (i > src_size) {
+				rc = -EIO;
+				goto out_wipe_list;
+			}
 			if (ECRYPTFS_SIG_SIZE != tag_11_contents_size) {
 				ecryptfs_printk(KERN_ERR, "Expected "
 						"signature of size [%d]; "
@@ -1793,6 +1812,10 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 				goto out_wipe_list;
 			}
 			i += packet_size;
+			if (i > src_size) {
+				rc = -EIO;
+				goto out_wipe_list;
+			}
 			crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
 			break;
 		case ECRYPTFS_TAG_11_PACKET_TYPE:
@@ -2480,4 +2503,3 @@ ecryptfs_add_global_auth_tok(struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	mutex_unlock(&mount_crypt_stat->global_auth_tok_list_mutex);
 	return 0;
 }
-
-- 
2.51.0

