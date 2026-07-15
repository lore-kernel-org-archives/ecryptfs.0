Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52C35F5F7;
	Wed, 15 Jul 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104626; cv=none; b=Jjvg0ZDUkhnfwsiNdwP1lw/uaN0hQat8BTvYKgec9SBkWzVjJ6giHtQTu/vMGSqeRoa6BBlhYXAvy4tuyA8Zei2Moc3IobL5vfyHFG1x0J6cgz3RaY+fYTCJpbZENHrompM/5CxQWZXrQ3M0jW0cDJu6RKdeJdjs6tzU+Cpq77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104626; c=relaxed/simple;
	bh=tj5tIHJCz8dv/kOvhKzlR98MO/Z8HHSGV2BDJx6CROY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzstZBSE2Ex9BcXj37bIwgd43pMibez5FekrQuyHwTYjFEi9OnMezTB316+qmW5KRr2slQzKXyqwBhQdovAAM1+r1k7qtPT3MTa1Hji/J8qhr2eRqIrQogqjip7PGA2xPy5UJXm8avlV3jcCLQLA4EydrTrEr+doqiInpsFNfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt6uRldqI1JHGA--.26200S2;
	Wed, 15 Jul 2026 16:37:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tyler Hicks <code@tyhicks.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] ecryptfs: validate encoded packet length extent
Date: Wed, 15 Jul 2026 16:37:02 +0800
Message-ID: <20260715083702.29471-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt6uRldqI1JHGA--.26200S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF17JryxKFWUtrykZw1rXrb_yoW8CF4rpF
	1rCa43Xw15tw4UCr4UGan5Wa1UWa9xJw18KrWxXw10ywsrCFyfK3y29390gayrAFW8J3yU
	KrZ8tryfCF12yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeKsjUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ecryptfs_miscdev_write() accepts a six-byte write as a minimally sized
message.  It then copies two bytes from the packet-length field at byte
offset five, although such an input supplies only the first byte.

Copy only the bytes covered by the current write.  When the first byte
selects the two-byte encoding, reject the message unless it also supplies
the second byte before calling ecryptfs_parse_packet_length().

Fixes: 8bf2debd5f7b ("eCryptfs: introduce device handle for userspace daemon communications")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 fs/ecryptfs/miscdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 5a7d08149922..a99e16db8243 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -360,7 +360,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	u32 seq;
 	size_t packet_size, packet_size_length;
 	char *data;
-	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE];
+	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE] = { 0 };
 	ssize_t rc;
 
 	if (count == 0) {
@@ -376,11 +376,17 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	}
 
 	if (copy_from_user(packet_size_peek, &buf[PKT_LEN_OFFSET],
-			   sizeof(packet_size_peek))) {
+			   min_t(size_t, count - PKT_LEN_OFFSET,
+				 sizeof(packet_size_peek)))) {
 		printk(KERN_WARNING "%s: Error while inspecting packet size\n",
 		       __func__);
 		return -EFAULT;
 	}
+	if (packet_size_peek[0] >= 192 && packet_size_peek[0] < 224 &&
+	    count - PKT_LEN_OFFSET < ECRYPTFS_MAX_PKT_LEN_SIZE) {
+		ecryptfs_printk(KERN_WARNING, "Truncated packet length\n");
+		return -EINVAL;
+	}
 
 	rc = ecryptfs_parse_packet_length(packet_size_peek, &packet_size,
 					  &packet_size_length);
-- 
2.43.0

