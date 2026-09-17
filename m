Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850F3537C4
	for <ecryptfs@vger.kernel.org>; Thu, 17 Sep 2026 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620384; cv=none; b=fIM4uLnRwAYY0eSw8YkZXlWgS0mEFY82haA6blZbCKExYx0yQQjqp/vPmUx+cdCWoTgTrrxe4+A2uw3Z/zadZ7d4ZhyB0n6FDdWOnktNYmEVENKhb2bYXDgp0o3GkdfaUMtg3nvGqFe2QFJpBU5xHuOpw3s+FEzw+xj8+tZj3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620384; c=relaxed/simple;
	bh=bvxNinmhhArVjCNyHtBoEX2+g0Xz/lQjyb7Hd/sVE8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWdiEoI62EZTzdpnZ4h151JrHLF58Sur+IQS5OWSAdndumC5iP/TWG4+1/dndWYCcELPVsdxVTMnhdXlAFuWA/mwEsZCELgUOuEwil/gefin3GwfqXGzN/JxidMw7OyZT8HqSw19Eot2JZJolmHL15pJA3oYshY5Gjqfmvxki0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgB1bCvO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgB1bCvO"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so270418a91.3
        for <ecryptfs@vger.kernel.org>; Wed, 16 Sep 2026 21:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789620383; x=1790225183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=adrTALwJCdcmS4nJH3ZIST48L5iXRSGsY1/xx0Jbnik=;
        b=kgB1bCvOKkvYO63S23mxUs4tu9tbuNDC3DufSo5TuLxnvN5uSY6pgvwEWT5mZCE6ja
         utAQPhai8VLjXqaTBqNGMHNs2o/rIHLjvQG5T279CpePQsVo61sBvgYAZnAvHLcoeHnQ
         NqODEQj39kzp5zLCkYvzDmyGpEo96F1Zz6uCIquJCzzrLNsTwqBOnsMUbrU1WJxB4Zd4
         IFesJZGBjHjbapYNJIckkgSxcgANkXdHXpgWPikbKqrKLm1VLeorWKwSnWH8WGX7vSa5
         eMajtfYlNQXE0rd4kkPerweH9/yJ1YOYJ9/sg/v8eG8lU0MWYmER/Bz0aMIVEVbiV5pp
         yAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620383; x=1790225183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adrTALwJCdcmS4nJH3ZIST48L5iXRSGsY1/xx0Jbnik=;
        b=fobmCGIGszzq0oMnFRsHBh376ytW96tUPOTVcTbgWWisFJbZlvpWoQEgCvfUj7EFqx
         QL4UAakO/yQopI6tvVH5NX0TzNcNwFXYBdx5wMaLe+lq7WVFvY+s+fzQ8fL7gilYI90D
         bRW10aD8Cnl6TfaPB3UUMDCvZBLqrf7xMeD1KpWb4SSGuq+9kTxLCr9eALUd1l8NuvOU
         3svynDdhcVindTwALCnEA2uQy4GymGyjjgUhuacuMlctxLuebGlwr1mN7nAbuQDc2tbr
         hPGDaMXecwmFVq92y07U85gnmPpEY9X8Dbz1SmAUBNwzhFX9szSJWUw3yxoFDg7ola9l
         hXOg==
X-Forwarded-Encrypted: i=1; AKwUvBydv71JgCcrCfD6XFoyz5jhhzteASGEU3j2+xFL9okIAhT5aEqrWCa9IOWmOsbC+5hGGVXtm5kX9A==@vger.kernel.org
X-Gm-Message-State: AFuF++lFxKtlK78V5L307/UEWNa1HhiLcgLBUip16+c1g3KID6QDaWcW
	xi+Ad9clMOmA9sk9TJQQEtCBtzySTpBIXxo09KNYnwB+tipoduAR7jbn
X-Gm-Gg: AYBFou0qxv8h64u6obnFSu+u5hOAm0qK1p3RyrAaqFJDQ2DueVKFmcdURgwYB5lnwgC
	9njGA6cXdd6MdiwcaWoZDw7YmR0glHu11YKVJgBoR5y136RFBJ6eQdwrnChRO2trqMQCALIOsQ+
	4czbqWpgAVM80r+VRci+ZEAl0ECgMFvSyvXdJelAPSO6h8xffVuWBpdPPBc1vDPQ7SWNQM/ktld
	vnc4RDMMY1ZfppS8ALpx6Vcp13ol4rzJM0/j9b5HL7umIcXLorA5tr9FqilF4+UI0+AkRxgqQke
	gt/SRVl29ukWYeEB4GgA0zH08ByNvH/vh85apXNFiV7HW3i6oEPPYuxqTN4rC5Duig9liSt3zK0
	9K3//emYTrDSmozWauwuGGRQpSTouxRTSZCut+sXK75XWRb7YIyd2RKL0K6YFDkvonTjXglEI5I
	QZnEZojFhsbfnRQyWhG+BtrwYXt0tTqYEgc/5rIu1oSqOMP9j/CDtA0/2dwsMdRloYYtMqA0qAF
	6qezf9/V8OG2WF4DafZpHbulLmado/vmMjMA7WWpD8sS1J0BF6PLQ==
X-Received: by 2002:a17:90a:6096:b0:39e:1fb7:5676 with SMTP id 98e67ed59e1d1-39e1fb757f8mr7992415a91.5.1789620382745;
        Wed, 16 Sep 2026 21:46:22 -0700 (PDT)
Received: from casta ([2401:d800:9045:4f1a:4e6d:4c1f:5b78:9e96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360aa230sm2717236a91.14.2026.09.16.21.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 21:46:22 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: code@tyhicks.com
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
Date: Thu, 17 Sep 2026 11:45:58 +0700
Message-ID: <20260917044558.41677-1-neganhat@gmail.com>
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

