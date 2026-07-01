Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57871310645;
	Wed,  1 Jul 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884087; cv=none; b=e+4fVcf9maR8ZaKWh/oNcdWL8YIxo8udaZ6n2hu2QXHyoSz9xW3TPhngwWQIP6IVHvnmkrlJApG54X9r1eaY/57gHOgnaGi4JTDcp6YzxX0TV7i/4M5qix6ZlOLfsf/JoO6C9skV5mvQaGOPc+QAikqxHiNWaKp+GbeN6QguIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884087; c=relaxed/simple;
	bh=6G9oGCz24AFRPAf3T4QOn66bYWyP04jmXJIUIi6e0u4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WH4fV9w6ZDnAESlHUk5JVp4c3sAdsBza57ERlSVFND8W/9aE3r54ZGUtNrHNuiZum6+iAaCLUV6gP8dGQJ2/nZo6L7XKaeUIIL7xUOeWY72/oaG2M0b5CXKig4Xn81h2OUZVSO86IbpOHWvmLgARDDGeZhOEi53Pn9F/0ejmsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=pZPBAksB; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="pZPBAksB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782884054;
	bh=/nIDIbBnzeNNkTqNEN15/MDbDqjka2kP6x3jGC14N/8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pZPBAksBT2DQPt5ZtzmrvL0UfKfRLTz/1SelyxSQG6hBj+xJYoW9u1LB3wPmNrQ/q
	 OjfVjwokqOSSwYUXjncKbvbounQxWqUyUcWLwetVkhvk4bC/pOe2cKBpCBX6cvnn93
	 vHXFn5eyCmSu6rJGvmdHTpa2M3xVgAdAkKXFcLb4=
X-QQ-mid: esmtpgz10t1782884049t30772dfe
X-QQ-Originating-IP: NwxSXWLl8ytx3B0LOFvxwbbuQcSo30buXyCND8dYLgg=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 13:34:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8761491513661411845
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Yichong Chen <chenyichong@uniontech.com>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ecryptfs: release message context on send failure
Date: Wed,  1 Jul 2026 13:34:06 +0800
Message-Id: <20260701053406.256772-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M4rL4XrBLbwKfmiEYevdX07UIuM+y8yvgspehXawRvkCxGRNnltNYfL3
	MvbI/LPe3xaobuivtMf0BVy1Au6DZZTfsPifoZ75a53poXkj4M4mIpW7Ng++OwmQxBr5cOL
	+rOVcpDVgwf/hQ35P5PUxj4BPgd36bIqP7fwkV+j42POtRgbCqQKTrMm2CMQOENsW/KiN4U
	y32sTpRYVP1ca+lvgNXhoqp/tgIDRtWd9zRrWV+rNF4NJUAchqr+NAXKu1idJ3GUe+Pun0a
	TOkloOCFxCIlIklVewnVYUegT+7iWAIK+SheeVcbjZFGU5iCaidir9e1uuW7JfVo6q8C/yj
	jj/tR1NS9Vg/pcJIvJMwJ2XC99O4ywjb3tLObcAZ1conp0Yb5QA+KtnmeedyQ3zL5BS2LZv
	O+QanmeoA4uCg/MYcbMiPQXUrEUm1zo5bqkl4E+Mg7BkUD0guOGn2cwzPJerwiGI74jyfe8
	Or3gQhWMCoAFOF0vyt4u1pQ3XMnFb5iCFWNZgh1S0AjKJMhtqkij8uCMbi9q9NhRR084O09
	npObU9RptGbb/f255geFoMMYqbn7P3qDRag8wxfKL7AOW1QXAMPhpO/ZG4Idr1yhJ8iUnQx
	ZwSvJsf9tNzasXhUEHO0jKseDjVdtKfnnBJJlC1weT1AErVG91G8hx8sIJPUT16QpTJNTT7
	U6hPu0fIaWP4MHRN7gf18EXN0sbyLDUoJy4mNglyFFVmEqOMEII1Tr3LwOaCRiY7WbE6RXG
	90LZIuk5xiBYY3evgCEZzrZjt+JVEUp62hrJlrMghIsb0sn4E1mPdpfrMCt3WdcK4DwqWso
	JmS1iTxj/GfNM3OODDSJSZuhWN0ssUtbLckkZJVCOkMijjEbBtbgk+Kot1Fk4niPz2+0eq/
	LqdwJHQfKzXFAEbwS1+gH7pI3R9OImOlMhsaFhXh9tniNx30oDcAWRmBIWtiGNv5XZIm15e
	0MqMPv1CadIKnJEsJelR79y/jMuIQWP1HNOFozVoLCTFE9aKPrmfuyBQMVFQ+CzvPZXYO1F
	lL/n/oXb2d5CUGbPbPjSSafqafAV91vxr+7mmwl9fRCVXbPcNdt8nPw6yez+rtsGg/vOneo
	OL7P15UzwaahriRx87yE15al2048GCJi3lW3rTI3Bi/
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

ecryptfs_send_message_locked() moves a message context from the free
list to the allocated list before sending the request to the userspace
daemon.

If ecryptfs_send_miscdev() fails, the context is left on the
allocated list and cannot be reused. Move it back to the free list on
failure and clear the caller's pointer.

Fixes: f66e883eb618 ("eCryptfs: integrate eCryptfs device handle into the module.")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
Changes in v2:
- Correct the Fixes tag as suggested by Tyler.

 fs/ecryptfs/messaging.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index 03c60f0850ca..d53c21e82365 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -284,9 +284,16 @@ ecryptfs_send_message_locked(char *data, int data_len, u8 msg_type,
 	mutex_unlock(&ecryptfs_msg_ctx_lists_mux);
 	rc = ecryptfs_send_miscdev(data, data_len, *msg_ctx, msg_type, 0,
 				   daemon);
-	if (rc)
+	if (rc) {
 		printk(KERN_ERR "%s: Error attempting to send message to "
 		       "userspace daemon; rc = [%d]\n", __func__, rc);
+		mutex_lock(&ecryptfs_msg_ctx_lists_mux);
+		mutex_lock(&(*msg_ctx)->mux);
+		ecryptfs_msg_ctx_alloc_to_free(*msg_ctx);
+		mutex_unlock(&(*msg_ctx)->mux);
+		mutex_unlock(&ecryptfs_msg_ctx_lists_mux);
+		*msg_ctx = NULL;
+	}
 out:
 	return rc;
 }
-- 
2.51.0
