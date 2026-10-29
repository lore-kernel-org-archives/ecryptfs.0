Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356090;
	b=snN3QhrxWoveAwjOPjcdBadTfKLtae2r6QaMx6ULOo8M+e1EsSWpzhI291eHnhwPuFxj
	 G2M+ue9NxdcmEg+0Q/YsgCMB5/fzi/iBuLKle6gK4zKrJpbArGXY2hnWKwEiufqz7E7+G
	 MBedNkeRYRvk7zbBZjv59Wk0sPTOYcFtpPeA+XDaqGtIWYbzsXJktVCQxV4GC/GuetDrG
	 2bGbcaf0dYTNxqbz3fDZ0N84UuclWv25l3sImcnXqnrmUR99+PXBxK3wz5cGRHE/hFMJV
	 LreBijLUlI7mIAB+eE3Y7LGYqtCZJoZttF2zbUZf7W7rOmxYSxvLHczg+HsYALUvS6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356090;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
	b=5j23zi3XjpttBfyaRKQLfP1q4aadCcY6WdOxLm1kwTf6Iq7BCyT1RgyZngAXVBgnFNIO
	 Jid4NpqfmWZ/RSXlTMW9DKVKGE96EnkgOFlT9QdwfmKg+xh0yUrft8lkHbTANA4MsA++T
	 GM9PRl7EuZoXiWBMwJ7NqASebhWuk5VH2doTzSvmEWeQuuOkdI/uEoG5Ygq5gBmivW+sp
	 GtnS7DW4dypDHZxoO8iGevPBfXa/rijf7jiocw69Bnkf9b2tAXv/hz7DDv46TRtmTKJpf
	 HnC+KKgT2ovY4pPrio3TqhiBzJ72c6Ux6PD+rUFzoIfe3zgvkQ60szeAz3Wh+EuN5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=USiiBghH;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fDvGCPEI;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335D60A2629
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3335D60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=USiiBghH;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fDvGCPEI
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U7utoq3859885
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=60pH
	mj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=; b=USiiBghHauYrBcMLTYEP
	0Hja1/JhbzTNZVclHeokS2UDMFr/KgpoLip0BcdrBhBNNMrRI6FE65lgrLcjMG+f
	HQj5o1kFnLnDRdmGc8tbbIdy5N6g0tKS7eOw+ppQsp63IUQimasoWQrRf+gLuNj4
	SDs36/OEUSgJSgSuQ22TpC9NRjBrQ61GRxAf6qv8P4nmN5jLvkycjcJKwlfWGBws
	ww06QOC6Sj8PSYXTs2T47Bw3LF5hVHVuiKVTCYp96McXRLoHPo9WnxFEOHduEXwp
	3FvTxJnfmOUPGFNF2n9PEMw2N9z4T7qdxmChHhveSVdJA+nUr7ARnIy+hbsvOo31
	iA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm64518jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:47 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b92acedd9so32219896d6.2
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285507; x=1793890307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=fDvGCPEI+HOCDA7IwmeQ4w6kYAvBKbndElZlCu1ktO37nalZOnKc8eAB0o5pH5fq4i
         pgiHLLVwre/7JWCrh7Xt15VM7dzk6Ee2hNStuDFmvttHKKJvySO4hAvonaxdZFMWipaP
         a8PAW6p8Mx30FZAR2XpZutp2YY7Q9fTNJgd0d6NaXGaiSaV/LVHWmswuTXZeHjLuysxB
         3KBwWu2zZNlNfFgOXaXAq/fGLwQeKZmovGEuKOzBmdJURdPQ+0uN8swKQQXxHaOKoj5t
         e1hPGsu1VqtAroa/vMiJAFfrFDzFZ00WzcYk9Hfm0FAbCahwAYdWTdUc9WBbw0NC/yBE
         ELVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285507; x=1793890307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=YVo/xYih6v6IK9IXAYcYrX9fWOy8mX0kwM6fB+jXmsmmY9Z+fDoCeulYTIbIjbEMeW
         qbz2ruh9Sns+xUMk1Fi+UCvIK9Q1eIv8xNGEa++rz0nwEnBe1T9gqkmTxbKSLSad7/bV
         caC/Qh2boiKgkPxqAISQueLtibpf1ynmu7w+WwX0+ZeQosrAzC9i8hw7XxqLtejLmyq3
         0rRZZ9kJK8ZRhIgpIMjW+oVOlsh3JMyAW10WHL/J6nPJqB30dz/5BiyKdc4+pIV6kdnx
         3PzKYaXcFOFumzxYnOq2cbOe0AhRRD0HncAceKy2zKaKIFQzso6Sb04rcKLXIw5iJvOG
         UzuQ==
X-Gm-Message-State: AFq9FYJjaVGbQld0MgsmIy6rIQk7wXlvVqO+HeHNdYY1IvlC8CMtZ7bN
	H1ams2gDekJ1hGR2bM/C7HpMd4KpFJOypIgAa3dZmpptUm3nGYYwtOY9DHgG33x+8xxCJB/GrD/
	rs0kfrG4J0z820F8x0nYOF5WD2lN/NQxbdc7kFcAQdcpZ/amr5RB1CU9o0Fo7BY0BFHY=
X-Gm-Gg: AYBFou2H/weZi8tvBQ5y9rWDLi3pJed+XHFhhXLMp04w9j0DXZNqIEVqE3/sJTTqSPx
	PH750bSrY2CrgDN7G/dKF2orrEGzSx98b73+wy5X8Pqb6dnsGspWz20s6KehmYdyGt2y10e5SaJ
	uJYPjszlZIvCcFmVeLHuV//fNcgDjyeV3gyaiu4G7B80chsysjVeXLlP9IAS9x3XhX1R41Z3ovT
	DGnWDyANLxg3MSEgOa7xLax1sUVDDQPZoWTM4la/k03doYG7mFHigT3WWOkvplUKfgFU3odag5B
	xxSYwbZJBjdoXIuroxB+W8FOPYES/y/BRRyr/5MuSyXYZfUijR851jB1cKLZ/cZa2DS1ngW1YF0
	CIeIz5HWRCRJ+OCkY1D0zNbroMOaBrfJtzzEQ9uvyIf3iSnJ6oxJdNmuRc704xxHB26FAU5ZIj5
	ZPPcjvtwKNXLRnYFA=
X-Received: by 2002:a05:620a:2611:b0:93c:6507:a6e2 with SMTP id af79cd13be357-94408de7631mr837871585a.65.1793285506858;
        Thu, 29 Oct 2026 07:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2611:b0:93c:6507:a6e2 with SMTP id af79cd13be357-94408de7631mr837867885a.65.1793285506347;
        Thu, 29 Oct 2026 07:51:46 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:45 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:22 -0400
Subject: [PATCH v2 1/9] ecryptfs: reject zero-length encrypted session keys
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ecryptfs-folio-v2-1-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=1720;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=a+HBd1agQSrDWNNuzP/HbD49+xH+YgjHAS6T3xiz06c=;
 b=wAYF+u7froYMQ9mKuuSsj8W+yYgbnMf0aGrGakJYXq/pZNQAqt/Q5v54YS9zGszXpQYi8c/lI
 MCLyabBMaXEC7hJmycnnkVoWfJXR/tlrtv3wkdVQtg4B36wUrv2h7+f
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=10 phishscore=0 lowpriorityscore=10
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: AmSCdcgcGv9GfC00jVwo8p9PBQkFv0oI
X-Proofpoint-ORIG-GUID: c8z9C1z926Zba8z2FOrAMuH-VkCEFkMC
X-Authority-Analysis: v=2.4 cv=GfuCDgXL c=1 sm=1 tr=0 ts=6ae47139 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=aH2rPlVYf5PhSe4MZfIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX69iEv90qtxCj
 3coDk66sGMU3IuTfpngu+fKeRpQpnU4IDwND8egTBC3BR34drl0J9hnVmGmfNpe0pDOtk1fU6F8
 1EHIq7WQu7kUAyEm9Kcy3wbVRditikByxoPwiNVwTe9ejbeHzLiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX95xMdqtA700U
 mQoqxXPGBHymuPm/TYfIrVtflUMIea9nrMWdBBky0nSUYFafdgI35UkxIymPe+k1xarTvaEeiX+
 F3oowA4UcMBAeqqiBNFhX0fYko/lQuR2Sn4wsi7bDaAS68exQxqM50s0h4MVAwVHp4ecx3lobPO
 9LOrKvhL2YtjHOx8S4c0oyOZtM0Cbe1AhpYJQbj4ofGx5yVvpZzxR28J9lZ3E4RU7E6EB4KSQi2
 6EIlkn0srOGkm8Nn4J4aa4+i5enwiWjGvpZaoqCszdzNHPczvgYyZaZiLfB8bxvvNnVsD7e2+jm
 PfZxqI1WaYrMn8n0rrit3wV9X2miL/kWS0vrhykeUBNvzjWRsPBTgYjrgh5wYeKvYllUoUaST4q
 2pMiSoAg/EJTp9jpjRFMoWhhUI0VxxSTC4YiouI2auDi4sa2SM+zDLLzC1MXhyc1OlAhSzFC929
 RN955vTY0X8jYc/dPGw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 lowpriorityscore=10 priorityscore=1501
 malwarescore=0 bulkscore=10 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

parse_tag_1_packet() and parse_tag_3_packet() accept a packet that
contains no key, leaving encrypted_key_size at 0. The decrypt path then
fails its scatterlist check but returns 0 anyway, so the file ends up
with an all-zero session key. Since file headers are attacker
controlled, someone without the passphrase can plant a file that reads
as plaintext of their choosing and encrypts anything written to it
under a known key. Reject these packets.

Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261014-ecryptfs-folio-v1-0-f4412187b1d3%40columbia.edu?part=4
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/keystore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index c2ba230c71fd..a0989e3c8aef 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1250,7 +1250,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		       "rc = [%d]\n", rc);
 		goto out_free;
 	}
-	if (unlikely(body_size < (ECRYPTFS_SIG_SIZE + 2))) {
+	if (unlikely(body_size <= (ECRYPTFS_SIG_SIZE + 2))) {
 		printk(KERN_WARNING "Invalid body size ([%td])\n", body_size);
 		rc = -EINVAL;
 		goto out_free;
@@ -1384,7 +1384,7 @@ parse_tag_3_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		       rc);
 		goto out_free;
 	}
-	if (unlikely(body_size < (ECRYPTFS_SALT_SIZE + 5))) {
+	if (unlikely(body_size <= (ECRYPTFS_SALT_SIZE + 5))) {
 		printk(KERN_WARNING "Invalid body size ([%td])\n", body_size);
 		rc = -EINVAL;
 		goto out_free;

-- 
2.39.5

