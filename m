Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4564071CA;
	Mon, 20 Jul 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548590; cv=none; b=PdcmBspG4HOjh+zFvWOx3SYBfHgpPtyPSXCcegVQbhpyTBCw13/8Z6n9+fPGfSmBpMIPhaUyazYaNd5czjySwslpOg1v9krxYCz5WKcmlHET9kzLT6Avrtpe130l4tCTPVS4g962JQ5lQrVeDS0eyXOmUV815yH4h+0+Y8Yhgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548590; c=relaxed/simple;
	bh=MWtnJZ1NiFv1kc36EpYZBpO+qly1+Vg1gFwrxTtEOC4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VUqKK96P70BpWPRq74RVNQx11SPsuuVgKbcVJoIuDdKX3ecEpVXWOs79V3rAGbuHzHzkNdlNBCJ059ozKA35ekmWCQDKHrY7Rrp8zFvRlAZCx2nMIeFsdnn6o0s4tBfVM7MKIinbss330TycUSMewUjshkmpX2Q9DuNNE/hPI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB35T_oDF5qodaIAA--.63033S2;
	Mon, 20 Jul 2026 19:56:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tyler Hicks <code@tyhicks.com>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] eCryptfs: bound the packet-length peek to the user buffer
Date: Mon, 20 Jul 2026 19:56:24 +0800
Message-ID: <20260720115624.5426-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB35T_oDF5qodaIAA--.63033S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48urWxJw1fGr15urWfKrg_yoW8Cr4DpF
	1Fka43Xwn8tw4UCF4UC3Z5XF4UWa9xJw18GrZ7Zw10kwsrZFyfKFWa93yqga4rCFW8J34U
	trZ8KrWFkF1ayaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-B_UU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ecryptfs_miscdev_write() accepts the minimum one-byte packet-length
encoding, but always copies the maximum two-byte encoding from userspace
before parsing it. A six-byte message therefore reads one byte beyond the
submitted user buffer.

Zero-initialize the peek buffer and copy only the packet-length bytes
present. The existing exact packet-size check still rejects truncated
two-byte encodings after the parser determines their encoded length.

Fixes: 8bf2debd5f7b ("eCryptfs: introduce device handle for userspace daemon communications")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260715083702.29471-1-pengpeng@iscas.ac.cn/
- drop the redundant explicit two-byte encoding check
- retain only the bounded pre-parse copy identified by the reviewer
- rebase onto v7.2-rc4

 fs/ecryptfs/miscdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 5a7d08149922..68804399a5df 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -360,7 +360,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	u32 seq;
 	size_t packet_size, packet_size_length;
 	char *data;
-	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE];
+	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE] = { };
 	ssize_t rc;
 
 	if (count == 0) {
@@ -376,7 +376,8 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	}
 
 	if (copy_from_user(packet_size_peek, &buf[PKT_LEN_OFFSET],
-			   sizeof(packet_size_peek))) {
+			   min_t(size_t, count - PKT_LEN_OFFSET,
+				 sizeof(packet_size_peek)))) {
 		printk(KERN_WARNING "%s: Error while inspecting packet size\n",
 		       __func__);
 		return -EFAULT;

