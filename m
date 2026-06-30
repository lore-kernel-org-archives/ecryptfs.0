Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A14335BA;
	Tue, 30 Jun 2026 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788938; cv=none; b=VoRbVDXKSam4Yw3CbBc0X0c9OEQeXx0ncUZb8bkSb86ZXbGdmXU6oZNWPyQMTYa6sqCxi++4S7mNkNZBVCtrrB2BL1G1gtcxyNmR812qjFMbXqxJGK4315BoovEDHaszF+heSDYKn4sOIOWMeHpn0/L25OKRbY2PCwP1bUotkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788938; c=relaxed/simple;
	bh=slw3+1d1AUDEXSMeU6dphnINjshHjWO/4nxCGNQli8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gtqDLlOt7cg2AIzdMt+lMqd5UXWeuBhmZNW8jhNlxaY1YUuZm1OVg+dpx6nlWbd71sHJ+Ap67gupWCgWZFVG4IcAYMzLzPQM1fel+OU2FM3WrYWe4PBl2x2b5tASd6V6Et9bOSMnV9imZv3wMqDXdrqB/I/mCN2bmGIr3FPnSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SJKJIsTN; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SJKJIsTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782788889;
	bh=KPb/2h0Xk8U80S/tAGQc0KcuYDHPodzeTMQLWtU3Sa8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SJKJIsTN7/RiMW+oxD06TKGgXF7JxzfKBGZ10LjQ0BmMJVTzSJhN0kWbMYsp3+3jY
	 vbxD/0FioJpxBOODJ7k2vHnmxyv782b0tVovqhe3jI3k9VStJcp3vYnXcCF7PCih0v
	 PLNBCDWS5WWoR9vrGKwn7CnNL9tDavjiyzL9NS+A=
X-QQ-mid: zesmtpgz6t1782788884t6581a756
X-QQ-Originating-IP: MiLW8mVajUG1dJRfoCvQsErk4ilnrVA3NmRMM1maNzw=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jun 2026 11:08:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9253823417470678511
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Yichong Chen <chenyichong@uniontech.com>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: avoid heap allocation for inode size write
Date: Tue, 30 Jun 2026 11:08:00 +0800
Message-Id: <20260630030800.191457-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mft0p/jwYreVjCK34gg7Fq6EzK/J/0dRRgOR3nKNChJeEd8JW/vKuQiV
	ORvJ6nyTZPgDLAyy7h0BOyP/D5GFWEtJqPbj2Yubbk+gQ0RP92Rj841gYq85//nsLCMC7Hp
	dICN5Vk6is4LQg2PosHOm74BnKsRtdIN992XHwkoKbnBeILftx5mcR3rGS1b+SwFwi4P8jG
	bDC/TG0gvdW3uKgabGsvl2hIPJQ+Ckshp1NXb4Dj7chRVqZCwGhZgUFy7jujxTn7RINieK8
	FV1PxNfEt/He20HZacpE0+ABS1uBJWdO1OE0T3PMcg/K03dN6n0fJmfTu/PpbaoIdm1C60O
	Lh0ath5aTBrUeQLowORIzQoiS+uAoUHHcGX19PGchhRz3dvSfhQH5FvkWZbYQ0wrdNNnYuD
	fuTmwrnjnj4f4dvv9FpTQZIP8QnpEsVSmDJ3/jCDUsTibOR7PuVh1XYw2H00/DiCmWEbEkj
	sYQSdg0uWczJsytGSRWrAHAaZYziG6WC/rZH3TQz2vjiRlOeNLnJtMuVPPl401yxZs64uru
	ezPvMVKDDSU4wsrTtzAq8GSGjkej7bG0klcLtwkdBtucgQlAC4ZZ6rqIXu7q8tr/uV/SJFR
	6+cwUSb8cb22tbEzsrGFsONksR2KPnCBDLlwdwUwZ1l1kRL0RkRJOML6O36PF2PP3EHaP1H
	JMQDhF7F9G+RybvfOsTMvIhvMkvrRr7uHd9dn8vi3W9iZD8M8PASH1KbJfiMdD3Osl5Kkun
	rnLJ22vKGusZKKw0nNSnpiruIkx08cmGnMF+HXDtqjstiJRS1x3fGQuQQk/JLs7EbqfuYNV
	qtNjt6OiQOLtyDURzEVL7PasPm+YsmOajhmNLLA/8VC6KJMORbsy+PBGY2Zt5nyQbyD22DA
	Uuc3obvasrM/+4sml7JIjDzJrrRMJigPp+Cw6YJyjyyURaEzkZhk6N6bHPBNltFPqnb2fjc
	FqIiDMIr4Gdl5hIu6ppka6M+HE5zeZksEs5vngFncQYQ0Rhx0YpBJhq9/IsQduxBPujR+Xh
	zBUvN0E+pcRAdMIz3P6S7HEyPEjC8=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

ecryptfs_write_inode_size_to_header() allocates an 8-byte buffer only
to write the encoded inode size to the lower file header.

Use a stack __be64 value instead. This avoids an unnecessary allocation
and removes a failure path without changing the data written to disk.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/ecryptfs/mmap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 2c2b12fedeae..0222f98143ab 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -355,24 +355,17 @@ static int ecryptfs_write_begin(const struct kiocb *iocb,
  */
 static int ecryptfs_write_inode_size_to_header(struct inode *ecryptfs_inode)
 {
-	char *file_size_virt;
+	__be64 file_size;
 	int rc;
 
-	file_size_virt = kmalloc(sizeof(u64), GFP_KERNEL);
-	if (!file_size_virt) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	put_unaligned_be64(i_size_read(ecryptfs_inode), file_size_virt);
-	rc = ecryptfs_write_lower(ecryptfs_inode, file_size_virt, 0,
-				  sizeof(u64));
-	kfree(file_size_virt);
+	file_size = cpu_to_be64(i_size_read(ecryptfs_inode));
+	rc = ecryptfs_write_lower(ecryptfs_inode, (char *)&file_size, 0,
+				  sizeof(file_size));
 	if (rc < 0)
 		printk(KERN_ERR "%s: Error writing file size to header; "
 		       "rc = [%d]\n", __func__, rc);
 	else
 		rc = 0;
-out:
 	return rc;
 }
 
-- 
2.51.0

