Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274483A543F
	for <ecryptfs@vger.kernel.org>; Thu, 17 Sep 2026 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620232; cv=none; b=R89L6Ay1wKQSPd3+vh69IWHH3lrHBBoSgJBQsovw6fVjJ9pxJQXteNFRjMNDsbCqXwMAd6ypQk+KgLLD2w0+sUCl40FVxoBk5/eZwmd0dVtPFol9XTn5vAdJRIHJunrfbuFVF1pe76kuy6zYQoWFSDQ46e/KMAJZtHDCR2WnYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620232; c=relaxed/simple;
	bh=bvxNinmhhArVjCNyHtBoEX2+g0Xz/lQjyb7Hd/sVE8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VE1tUaOe8l83fLLUGcmf8j6Sb9i+lufYwDRX3+4isP7UTPgLhI4OYd5YGSAYf4Dm09BdwLJM85BzdOtx1N8yuNQMCKDdyOOYz+7G42QRBJDru4NQPVzYkidxmLTMnAOCErodTr9R034iXp0CmbgDQuRbcBTRuVVmsUeGXjz7GrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7R7fXMo; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7R7fXMo"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so385236a91.1
        for <ecryptfs@vger.kernel.org>; Wed, 16 Sep 2026 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789620230; x=1790225030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=adrTALwJCdcmS4nJH3ZIST48L5iXRSGsY1/xx0Jbnik=;
        b=R7R7fXMoUUKi3MBE8SCzPrJ2GG+XxmRDvJpQv7DfRtmVLWfYlWZO8W7ap+Bhqk+caK
         fRjhAU7JSaQLQJSGzLtLTldHV1kSGrPJxbDN8ACwPA3pRtPc5fw0vH3H23LizOvegohe
         H1JN4ReDkQoRGyAE0RIwIhRogbMPYaSAoKrray7ma2tvuY6pL/P+NQiSrFfQGG2/mOYW
         HJJNBxsLRJ/iJFwu4IgSNVo8PIv/cuUVUTCgLfBGLOh+RIjsdcfB/UBWlCS0t/Y36IjV
         CDTnkz/2bYYbY1+z5bGXGxkpeVfRXiKy0caKRRW6I1ui/ZW5smJMF+k3+mllYX10TGoX
         HmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620230; x=1790225030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adrTALwJCdcmS4nJH3ZIST48L5iXRSGsY1/xx0Jbnik=;
        b=ZuJS1FmAhAwuUFuFK9Mec0yW9pvRuLG0sazNk44wSWjxtavOAHs7Tldjka+MohX+Eg
         XeZDbKJAHtCF7K9sJA9E4aguNIyzBnXKiq6EBniq2f3bx6wJT8GBOnJq+bhPb1xWyCl+
         HHmxQ9+/fGURjvX41IJ1enchBc/k9ZyR5bDAj8As7qgFZLXAYZkSnKK8ExypYV4bjZYM
         oY1wZGDw6nr3thcxJBm7QPY28V8XwGnR/VVjbsRc3ab+OepUk0mASL4VDbk1O5BwpkDC
         FP7Crfw/aB72aXfna9ketAcEnTANTit273AiocyNMQ7JXisjMTO7Wf4VN59Hz1iyNIvB
         PUFA==
X-Forwarded-Encrypted: i=1; AKwUvBzucsW85vYVMy8RiF8yn4yqn9LVV1fyoWzGV/XhjdPsh/EJeG2IXkbTk9NxlS/n69GGwSKgd4wnCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nDG1kEwcFh0aOqOIk6N00+0f01BaUS2ZyKuVhmM8A496TLan5Q
	te8iUEtj3SvhU7Lzj+IMFaliVliz9HuxaqYTWaoTaZPDNW6685KF0T28
X-Gm-Gg: AYBFou1tbGEOEvom+zYMsJlTHV+r46BHRBPEkzFq1+Ut0BvjxCMzOXE3jiWwkRIjJhL
	+8746o60lOLsgia23DDL6mBEv1mjm6kiX9GQ09V4ecxy3APASo1wvFc/qPkMjJM3+RwQWkakvVW
	D6gT2etZEpZHieqKDKn6H2PJnCHeSeGa0ZI2c8Zls0GZXw1po+V8UEgiAHQ3NfwmkIlR8tQtpdI
	X2h4tN9wMOUYjrB+n9xcny783NaOMMUAjOse5ZJppApOtOqtfUPti5CJbcS/1nCgNFle5HMgArQ
	UWROokDs3E390ksc9dnGdiwyCJVVv6Sm94ZXqnYbhro6P54Us9euElpBnLbnrgmU3EvXQSL3vWR
	gQG4p1OP0U4wDw9wQEneWtKMe8K/cYcCUdknPJ+emNwed0hhkCpWPPovj8K58zTDeV1YaU7R51R
	rCJM3iFUCs6BwYECurMIJ7ENZGCSDtIL2tARczRMt/hvXmfiRmFbHIHw8duJ89ViAvzYYZ9gmqO
	oe8LiPbPL75uly9x/eHzWTnx6mmuzhhDf/dLz1SUzCk5Oj+5Atsjpc=
X-Received: by 2002:a17:90a:6c8f:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-39e345b3c87mr3872140a91.23.1789620230172;
        Wed, 16 Sep 2026 21:43:50 -0700 (PDT)
Received: from casta ([2401:d800:9045:4f1a:4e6d:4c1f:5b78:9e96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360a6c8asm3038405a91.13.2026.09.16.21.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 21:43:49 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: code@tonyhicks.com
Cc: blum@kernel.org,
	rdunlap@infradead.org,
	chenyichong@uniontech.com,
	zhangzekun@huwawei.com,
	ebiggers@kernel.org,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com,
	Nguyen Duy Nhat Anh <neganhat@gmail.com>
Subject: [PATCH] fs/ecryptfs: fix slab-out-of-bounds read in ecryptfs_verify_auth_tok_from_key
Date: Thu, 17 Sep 2026 11:43:26 +0700
Message-ID: <20260917044326.41276-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bounds check in ecryptfs_get_key_payload_data() to ensure the
key payload datalen is at least sizeof(struct ecryptfs_auth_tok) before
returning the pointer. This prevents out-of-bounds reads when userspace
supplies a short payload via add_key().

Reported-by: syzbot+b9529ebe6a9394ddf825@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b9529ebe6a9394ddf825
Signed-off-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>
---
 fs/ecryptfs/ecryptfs_kernel.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..3baccd4143e8 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -124,6 +124,9 @@ ecryptfs_get_key_payload_data(struct key *key)
 	if (!ukp)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)ukp->data;
 }
 
-- 
2.55.0

