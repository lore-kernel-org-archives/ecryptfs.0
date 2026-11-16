Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866906;
	b=0vrhfTFzCVmR9MrkdSOIQJETJwZcF0Kg0k2fIzGYeuv3/MTu0GGcXVxYxHq7lBO4Aett
	 vm16Rv2GEDPEfum+A7GF4u5mLMELZG2yYHyO4wBLkGDaO0OaryqXZ/csbcdLCZy4fHXOx
	 /01VioB0yRmQ+k7jdNKCF6WVEUaLBi8idx6YKYzHHXO0rgZOIscj7S9XAvRpdsrqsxgSV
	 wrH+gW9riRuf6xjiw52L+vrUV1QlgcMJNRZLt3mXjfEVUHD/GcBHzstb/hrHMYBOFITY/
	 FdsBAc38MGo/rMAFHmt0KcT3NsiImRNht9o5gL3fKlyBoXKj/Gxi3Izehxt75O9eYRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
	b=tOP8nm7RWM2rX+oUUutsXRMoSjm0rZfYbLVJ8K5gVYZW9r5DaMgCoG/4PJ9Srj2NG5uM
	 buSJL8eTQnr1/9rwnKHeZjOHz8P1FBmYXzh4UAmSgFyVP0M7xMpHVjP7Xmwq0Ntm2oDWJ
	 D99Aql0WheHoYrWEQjeMN7+S8YrRUeVpomNLtjIMLC+jMyqocnLT4/7um57mliLyqf5fW
	 RRycT9FXCkB6Rh2EPdXR5oYNJ2UHoTcFVC7GVlfMr1h7hbaAnbOn1LIvpeQONQVC+cx21
	 ESMRmYlaq30d4MsRpy8Kc+JDHqZlFQc7jiFH/Xs4SdJ6QMr11kDKjdXzLaUSxnDLmQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mI9AzHue;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iu1T06jW;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468D606A8A0
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9468D606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mI9AzHue;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iu1T06jW
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYrYq1009349
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=60pH
	mj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=; b=mI9AzHue1mrP9Pn96d3u
	9DqalThhYt33uJqu180jr534PpsMio/QdWisTR/60eTWrX8VcZxqBJyd/U7fIJlP
	EsUVOJnd9knkaadrQUS68WK+Iriuu6FzTonvT9c+pmUWfq5Wm593XlobQlG6Uj5H
	6QFtY7Vh2a1Xb8dSD7YJgkevsInDTBvQUtC/EGOIlFu7JJIe7+xAtYOT4dWZOzxm
	1l3BTw9IBAsVozKXPDE881xZm1LbxtYCk/H+8j7udAZGwfzpYeRisdY7N7gpaNQQ
	6iz5Lx8HlLhrgG0D6F9GDJkvsCStNmk7Ged2uOuu80U3ugm+0HVLo+2NSbmkOhHK
	GQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059qu88a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:24 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91eaad6eaeaso76577506d6.1
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866904; x=1795471704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=iu1T06jW8kEq0JVxfgo+z0sbMPNQkA+N4lLcjJi4K8Z8KaPGQrh0CEVIs4vhXc12ye
         Aja9L1Q8D8fJBVRV4gCvooIwGAMtgsUgMsA1dRahEn2QBQVOX24g5KymN0A2mlgwEXCp
         /5tbsU8pBawkuoF27KgTPjTXZKMttTYYBfQzg1hzuAKaS03+/c8EmDvriSwDSH8tOvCf
         0xoMs7QA5Xo9hNGU2sbLSshCQKAUMIGsPQDrezYsUWsEGe+6DiuUwWYYg/zfR0WUZgAN
         5tsMu50uz6Z6sXtaAi8QP2awXEXcVvFQnlY2TvxMWg4kDD44ToyVyiQvujnrmEC8HplA
         Q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866904; x=1795471704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60pHmj80O9kNL7Ma8kZphqBjE4OsplJ8ei65X/MZxII=;
        b=Gg8UBvC3SDjJ40aLQuzBJbIDtH4NDJ7dANdjoNWdxo7RsHSNU0Zqqf4ZsGXRBgCApf
         l9nUxH1I4dPs8oogKB7EU/jsMfbQ4XP/1sthbpc/BOzCoF82FrAlWBGCrLsOkLli3fPz
         7qFbE5mxQyfpckfENbu7jE3+Cd4bQFqNdJ2+5+Er8OOfnJ6uVTkpzG3AcBGAgcqtrziH
         rojMcubimgFOKmeVqw/4b8Bn7gBTh5vzbNX+j1BbwfI+XVgZbLz3Hi68/p1qtpUyDE3i
         67DMoqK366cVH1G4pdrx6BuBm7eCgI6enPZB8NaMvG1pb/uGw7lt/XPcg9B33iVImeDj
         WBOw==
X-Gm-Message-State: APuU4Z+zFH7vCe0PrJjteUFoGvT7NlSowMTr+1jzDQkXaxTLHPShfNKK
	FoYcVRkQHI9dNY/Ta449MpfStjBPojFucmEeYvPohKyqxsNigj/pDZS4BiSTk33zbXUujXzDiMx
	4mzQQYlE5WuFqXuIeQmybvoKwirBN4fBGjOAmcARM4Okwp9Ib/koytLCa
X-Gm-Gg: AYBFou2OYf/hlo8jMRmxlTPceqJXbH0We5BrlJNWJ7z3SXwg51215RE/1w9P1r2nnUn
	TTuepqKbTVY/w1RYSgPQOFAtf7IeDp2XfE7qb1wl3GDlfw6folnC9HidZn/UtERFjFUiIpL+1Yk
	poRy/8dhOddllslXrLTaeplqJLwWAmNbd2g8WVfmoW0XE14XLjZJawJgmsk6oGnz63uHC2vb0Mk
	CFLrSlk4M/6EV4qwe5E3J61deeSxTnX+wvXAhUwTD36Skk/Qi1gEjcpKuCNb68CJ5njUpihNyvz
	wQroHTUGc6v/NQTUZrz34ymG54j+T+VLZ7ISs4hLTFU6la2zU0EhUbMdW+cDSY3Nb0oozQNAR//
	ic98UQhvxI7MjKZAGrR7CfCIEH/+NRRN4slkpNwnNMDNaqYFmZ1+7RyVPfICQIQGZnOTOAUaNT6
	Zyx+s0BEZDX/uacwfD+Xy+
X-Received: by 2002:a05:620a:838d:b0:949:6ec7:68e1 with SMTP id af79cd13be357-9496ec77643mr1165872885a.18.1794866903961;
        Mon, 16 Nov 2026 14:08:23 -0800 (PST)
X-Received: by 2002:a05:620a:838d:b0:949:6ec7:68e1 with SMTP id af79cd13be357-9496ec77643mr1165869485a.18.1794866903580;
        Mon, 16 Nov 2026 14:08:23 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:22 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:08 -0500
Subject: [PATCH v3 02/10] ecryptfs: reject zero-length encrypted session
 keys
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
Message-Id: <20261116-ecryptfs-folio-v3-2-1aba8e620eda@columbia.edu>
References: <20261116-ecryptfs-folio-v3-0-1aba8e620eda@columbia.edu>
In-Reply-To: <20261116-ecryptfs-folio-v3-0-1aba8e620eda@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>, Erez Zadok <ezk@cs.sunysb.edu>,
        Phillip Hellewell <phillip@hellewell.homeip.net>,
        Badari Pulavarty <pbadari@us.ibm.com>, Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stephan Mueller <smueller@chronox.de>, Adrian Bunk <bunk@stusta.de>,
        Michael Halcrow <mhalcrow@us.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=1720;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=a+HBd1agQSrDWNNuzP/HbD49+xH+YgjHAS6T3xiz06c=;
 b=vTinei3NYNuv3Cv3rUkazssBbXmnH82BNwNm1+s3HPYI3+HUQp6/M/dmQBEJw0ok2epNOyPoC
 8UCEY0R5wgcAByL+q0yMda/FpXxWHZFvrR1bpWhrh7Qfsuzqq77OS2R
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=L/qI0OT8 c=1 sm=1 tr=0 ts=6afb7ed8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=aH2rPlVYf5PhSe4MZfIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: ePFGH-s7rgi8zw3ETr4IvwgKUpxAIeKs
X-Proofpoint-ORIG-GUID: ePFGH-s7rgi8zw3ETr4IvwgKUpxAIeKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX3/aGqB+d2094
 wrLnMuQfYnd6Uo8ViTWbpEiqWScdg2WjYlMWXZxHJwgC11HSwgxYJziJqtSbAa73fKWnCe4cwYK
 3qKwJGv1DtHWj2AhZbk2xUmTUedJcCfaUuYJUq38l+dsN24WVK/rJDFqE/sSVvWGK7FClv0VKOg
 DfZggbX1fCxKSYIVnWuNIsd3OqhGq5oQyvBFuaiCFmIb6TDgdrruc+DSwKaXJhelHcXygPcyONU
 c+PjPveOkLi9dnwW6wrRkX9RsGQE/NtDXkNJ6VriWeclMdeROdo99QO5WFez79QryGgADDXJ0a+
 BA0xIAdTEpIKJ5iTeE/T8ATEzgfC75g0MUjjz8+1BlS/DQ/F37mpKlBJc7UQCJ2mLGf2U5Dz0dr
 C6L2lsvuuqCtJUGy1RCoWsuqVD43TDFU+pwlwORSkKAho8r8+PpDYioC76VSn5jtheVvsQdRPBH
 Yi4EHQCjO9QEeTOjNRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfXynUyp1colaJh
 QYUIC3yAFo8l1pfkuSsC41QR1VTgTr9a5qF+KKtV8WbjJ7DyRKZn//wSw2MvxnDVR6KhM5PjXCB
 gL65guWWm05VOqQxBnHYYR8hu6luriFGVYBuSeRO0dfw/Rdf43rC
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160087

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

