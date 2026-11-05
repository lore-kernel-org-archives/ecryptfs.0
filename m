Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901849;
	b=SEzEHI9dVePT+bccN0PITMacrYxmz2U88dQ99vR9CPtRynG77TnKCNPYqU9IK6b7rYP2
	 zeOxMaX3xPYLVp7jkSTBdCWHfN48Vk5sZnbFuR6cMZIcgA472zaMecBS9R+EDO+lrH+rw
	 eNOG+1aj8jlQWSMbTZlt2NfCcfPxnQuZGm4y+TxgX70+BvvX1WiYKCWp3HCf2geFDrUGu
	 oLnHwX4XjnbRCWOm5rSQjPIBeSxv7QFygWFcIE+TZvaBX12ZcFSjhmhL9GTy/E+4PzJ/x
	 GgMn/ESQy6r5prAXXiTRCmehivW0NN/msrMtNC0YuASxPQVnbv5rX0FwRKvHUsNDyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XnmxEFlwrYLXPYbiM4rRFqk5iRr+FlXWIqL+SZFi5xA=;
	b=M4ijIlfAt8ewhsiNleCggPzGAgeozKzOt9QLyep88vrRKBLkuxDyu7+ePfh5mbVAbg2S
	 GAuUYOrkiChp/JI+d9SD+zUJtPZCNLbQ8NFCqvHvYV8n3D8k4CpEnPlzzQ57PEf1Nt0hy
	 7mmNqOeyYUVTR5NSRU7SvJE0e/i+W0aaFjw0lb6HefD+ynC/mMZ9i+i5ViFvMGUrMjXP+
	 pgDSQpvTQUBAZgiXFCHsH0ammib5sICcJ3bRAvlWmiXFUHkg6ZWGvfQw7kfdy0Q0GwbCi
	 N50ZvCC+LUc0Qp06iOU6ZIi+aMTbbT92NoyioIP4ZCxteIHWxTW7nRUTQf9ahtMj/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLgPglEV;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAE606A326
	for <ecryptfs@vger.kernel.org>; Thu,  5 Nov 2026 18:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCEAE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLgPglEV
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1230657a91.2
        for <ecryptfs@vger.kernel.org>; Thu, 05 Nov 2026 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793901848; x=1794506648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnmxEFlwrYLXPYbiM4rRFqk5iRr+FlXWIqL+SZFi5xA=;
        b=yLgPglEV7GIVD4E6i5KZiOI0zcHNXpKf7e278ayvsmQ+qjQ56E1zqMuh/choBfY4ld
         XRD2plRdXUfNrEVuTNrobS7Psfu3kXVCz8LfQ3ulWq/ZOT97B2qO2Kn5Q2cab4zV3GTI
         cGXxIinwB3b+zb7dOHnzw1BFttOEI14pRogyuDb2S5B3qJTHmS45wn8aINQrFt1gIiPp
         iGb/qo2jTitloBoFZdqILA6VKwrYSIcjjPhqDGJuaTTsUkME/OCt2o4BdHyhST0n73Tz
         c3MGTgAjCsRnnverO385lQL4+O+3VnrwhA83QTh2yHLOng4y/VFyRlvuIduNKFMFfwEv
         zYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793901848; x=1794506648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XnmxEFlwrYLXPYbiM4rRFqk5iRr+FlXWIqL+SZFi5xA=;
        b=UWFfBxuBNgTIWYMXxqLjJ9BQnKcCnIhlYF6L/P0UDFq90mQr5ifdJamgEhXmSaGytG
         ddVSDiOVfyduFsm8tFP4eJszAAOfmY93KYqL6BWVlrrMkoug4d0sD8B6Z9MNO6CQu1IV
         Hcme8L1rP+W0N3jTMzv6xo6hsvfez154dVsBQxP+x9LpEYCK9Dpipbfinao8OlXFNuZK
         iUT+r/92ngd4bA8lWlyYRme43G1oWn1tftnegwGUAyVV7vbPkY6IHUnlkCo7DAwinZve
         igr1V2BuMlhyaguotIN31HuCF8BpJD8o8RMqi9y2Uug+UrCJWjqCetnhFB3RiTSfA4ok
         hU7A==
X-Gm-Message-State: APuU4Z9cen0DUJy6tKVi9ECO9hPLNyVFGxPVr/3i74nEIeaX20yFSdeB
	B4t1/rXnuXjCc9rSYtAiB8xMkKnVO7wFmXE43t/OTlHo1GMHHIvul5DG
X-Gm-Gg: AYBFou3gJp5xafQm+hqSctq1/z10DVahhyIDZHNCzI+EnW6PHFiymosVJm/nkbcp02u
	le0OJI8w1a20TpL1x9CP5lofkmSz4e+l844PNXlcpqInEeHEftt6rwVvM5GmfEK7NiO/0X/RIqK
	jbNZwLijnmm2LhCO8mr0krkPNkIs8AL5OIiUwuiQx68hb9AcvTi1SL4K9R57kIk2NlmiQX0pnFJ
	748tGBbcxntYcHlSU8GO6BFT94lwAtTsAk0wjApBlI095MMH0sCKSfwjau831vr2DvfpCWFPUmd
	FTvJ/+1ff9xk7b5tylAsasfpAEjHBPh8A7fYzfSN774nQaG8cvfiOdYiwlx3HjuPgab7Z/KdRo2
	ZG+faoDZxMxR0EOYKPN7bHfN3t4jMYZgQ95S0xDi9ZQbqkjaN+litc/udpm1jLlL8N2OQ26sZVJ
	F5QhRA4ur8aAll5Q0zTCDr/7abW0MMzy3hFNqkt+DzxJDhO0QqDT5H1kvos4hmGdBnQSrsD6BNR
	KBttVcBrdDzS0vL6Ql/h3T/PKHP2mC9L6GgVyZ+kWYf/gL70QtugX7Gv24WzuxLnKIEoDg9P0w3
	9MqQSVVfJgPwGGS6NpSDmVo8yJT6nbPvSf0Z4RHa128aFlD3j9GR
X-Received: by 2002:a17:90b:4d09:b0:3b0:cc6f:1046 with SMTP id 98e67ed59e1d1-3b0cc6f11cbmr1403236a91.67.1793901848105;
        Thu, 05 Nov 2026 10:04:08 -0800 (PST)
Received: from localhost.localdomain ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094d70a60sm4855031a91.1.2026.11.05.10.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:04:07 -0800 (PST)
From: Qing Zhang <diasyzhangqing@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@polito.it>,
	diasyzhang@tencent.com
Subject: [PATCH] ecryptfs: validate auth token payload length before use
Date: Fri,  6 Nov 2026 02:04:02 +0800
Message-ID: <20261105180403.675338-1-diasyzhangqing@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <6aec66fb.059f5055.2712e4.0000.GAE@google.com>
References: <6aec66fb.059f5055.2712e4.0000.GAE@google.com>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Zhang <diasyzhang@tencent.com>

eCryptfs treats user and encrypted key payloads as struct
ecryptfs_auth_tok without checking their length. Short payloads with
valid version and token type fields can pass verification and cause
out-of-bounds reads during file or filename encryption.

Reject undersized payloads in both payload accessors with -EINVAL
before any authentication token fields are accessed.

Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Fixes: 1252cc3b232e ("eCryptfs: added support for the encrypted key type")
Reported-by: syzbot+2e8c4ecc07730b29ae27@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=2e8c4ecc07730b29ae27
Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
---

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
 fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..4315c18ba1cd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	if (!payload)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (payload->payload_datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
@@ -124,6 +127,9 @@ ecryptfs_get_key_payload_data(struct key *key)
 	if (!ukp)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)ukp->data;
 }
 
-- 
2.43.7

