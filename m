Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356031;
	b=PuAU/2r60tMiZPuLwQTIPPXyIs+2/3tevSLQpLlnRt8cFqBvfz66f6M81yMnNFStvtrM
	 oXlIOChTjboy13P3u14pCVAGkY4ZS/cb7xvdJb/60mVavxjf/KkSlkZKyGiZv6kWqCpAE
	 txFlj/B88bzdcCRWfnOMFOJ8YHrAbMpC50k04HeNExNA+fQ3hgVIeTw8S2Q2QbUj9ghfb
	 WeAOLsrLl/OulpeHoxvamSiXXCnedkmN0mfxmB0jDMQGHxs762H16OYGSHt31DtBbCBcn
	 A/6hG7ufVbTIilVaEwOqTS9YlH5csi6Y29NX6lT5rWNhh/c1oX8uIaQXWE1//B6+JHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356031;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MGw3BytAYYXwog3YzUbCFMTej27aBtumbxYPUU7c8pI=;
	b=XGdieNScnQwrcOsy+Svrxg4UBsqgHQRpp12Y/GbWhg7tI1y0BhrxoDk9OaPTeHSFAADT
	 LUhUFCZ0ImDXsJW6yOBW0Y9J/C8P/TjSXWHTARtj+xfqRPgYjYV3JOfb8vdncVb3BKiEz
	 LKZEcyekKQgf/jbqzrBGxKu2vbOUWU/X7xPbx3x7WMsMBh7T5sSRtuYL6+edEdb6B09rK
	 Z4oCbPsOffZ2llv111wXGNRCWy3f3dLMiZhy+TPt9NIm3rFEUxk7mRTwuBlzjkI4K/YAh
	 WKBu+sseVs+DeDshtZ/jgfq5zAGXVDhHLltxN0eXSACQu32X3m+5xMtEl04MCqkD+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qRQgxQYf;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="vWaA0os/";
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44F606A31C
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E44F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qRQgxQYf;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=vWaA0os/
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8bhcd1029292
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=MGw3
	BytAYYXwog3YzUbCFMTej27aBtumbxYPUU7c8pI=; b=qRQgxQYfaNhFpXufvuPu
	9YNUE8sL8H2cGPgk5dw3fJWai99uQXERbNUZrYEVDr4Q9Wa/mZ9dsUpAWy8zf/Pu
	i9LC7DFGsrfhG+uGWd4OLB23iDP4lhvxrK2nBOf05Q9az6/T8EvNmtXAaQ7p33Od
	hUCAdAeR8Q/TvXk8MV+6ldjEztxXXnr5BLdXcT36g7PpM+zembP51SueDWrG43vs
	i0SbiDuVqw++qNlGozLFOqFub1JOVInUA94OVJC7rKl1COk89Bk2PJ0OvsXF9mxE
	kaCfG9lc7mMJPWiFhtTVYGcm/aKmXu4Y+shtZyD889Zdi89ePexyLPXQTDwTXy1R
	rQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm7q0rc6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:49 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c046843f1so34034006d6.1
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285509; x=1793890309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGw3BytAYYXwog3YzUbCFMTej27aBtumbxYPUU7c8pI=;
        b=vWaA0os/dlfVOmNMQaVYAbJlZDhgEddEH5dVNV9se/Tp+bHf9GWjzVrhYbKKyi2HWV
         1mGuK5+aFZ4RJorHnxK3llgXY0BZGeX/UwuuYotQCSR6RoT2X2mPGE/md7ddopDoKQnS
         Ok+IewwscMmFkuFHhn4hbhYrSIMVHUV3a6LT6ZnXoF5RyhC3Z2TyDon1GdylrvV9HQcu
         6WNv8YEzxrActzdaje5etXg5gxU+3ogPg5O0b/kCHTLZvucNUu8IIfhF4u40mBd/a937
         +fUreGXfnQAA0uqGB5lnez4hQZhGUKzlfzapKxJYZE9Qjz5IYn9HQRfOcZ1oNCHb0xtT
         dwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285509; x=1793890309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGw3BytAYYXwog3YzUbCFMTej27aBtumbxYPUU7c8pI=;
        b=vf/dfcec//KtMix0fCe0nN06k8N6cL5QJMqjGf3/tHtLyATlLU3AswR8PTj/bMaThF
         W0j4cqKFFj/ylxShfUO3q3MByL+XOs4C0qhvODS6g/+2Ohx6JNUOrrjv7bPV4e8meE9+
         +aP47KXdm6FxdgEjf0lEjktj0pmR3VSsNaTiJ3zANjpuybLv+jxJLynIlaGlCrTCdOk3
         tmjitOUwoBQOisBP2WPV6l0uDBATx0oDGArhp2xvQzZeStM6bQWQITz6oeGyG4DtpF/C
         sfjJljjqygwINQKq2CzX2gqSqzVmiC+EJn7sLzZEHddSEMS/VDfPpPKAtKN9QpSoycRh
         xwdg==
X-Gm-Message-State: AFq9FYJSkUPACKrgWW/7M4yRtdxQ/A20ws2PXj0wR3FQfZDfFA0d4/pV
	+h88faJAOcG3tgS/kEtzSqhq7kDFZ0Maw6aaZCej/zGTQqYWIqbXupxMIMeMhp0sevRS3KPQCex
	bTBGdGvbXWoXrEXj9FKMlUiN0jO633TuPLftTNYHtSw2StU5/R8Je6E1kHyaWI0j6qJc=
X-Gm-Gg: AYBFou2+rErrklqW0qfayX4sQ3kDe9Ct0BILIMSm2TGMt4enO+VGPWOKqqRzuFcwZlj
	QFZ2tVMSYpyZlhgNwW4qTbzkysl35PeFtNLCAyc8C2lIJkv58TyUo/2VWy9oKst4czL7qt+4eo+
	tAdD4hgHSOQ3WUi+r4bvhkPZudWnN0UvgP873dRLBCb4WedEEROw6EqJDeO8sqPr5rXUzUoCPq4
	hR6+V8Zjs8ZySxvIilhKQcjMvNIYSNgK6OnhZi9zv4lrkAfwVuXuwkt6mPiRb8xryFDssicCHTU
	vZzJcYwCTKN9yWNYUohiYEHlFtFnUZBMV3il/Vt09ybl4kDvdY1T9FbMpCeNbabckzXHJdv7npN
	wcyjsc7j1/VhRBRtxTN5C4iJAUD3qpnBJ8OjJyfLN0yllhvmX5fOhNogVUkSsKgGyCmL/c64nqW
	l87iLTMpRJ4wiqeaQ=
X-Received: by 2002:a05:620a:2907:b0:93f:34c9:9248 with SMTP id af79cd13be357-94408cf4109mr886616785a.22.1793285508924;
        Thu, 29 Oct 2026 07:51:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2907:b0:93f:34c9:9248 with SMTP id af79cd13be357-94408cf4109mr886613185a.22.1793285508491;
        Thu, 29 Oct 2026 07:51:48 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:47 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:23 -0400
Subject: [PATCH v2 2/9] ecryptfs: keep the folio locked while
 ecryptfs_write() writes it out
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
Message-Id: <20261029-ecryptfs-folio-v2-2-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=1456;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RFR1FzT010wbKCiX8EdHBWtcRcxwB1aPkK+Mmqg8Yz0=;
 b=l3bCNQnSwEryOzEQmY5HiywhzsjfoSFgUgm3g3A4JHgDQcxZDRMSDVvlI+lkXzOUW4Pt+9mLj
 25xR9NzMkpKBDZwsucJ8CwJ0EKJe+Py1Fo0sqoXh8ygoxZkhG3RySl3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 impostorscore=10 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: TSpmc4KeRr20OVD9VNaRMWXJyhUA8V5B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX6djQ6yjbCLBG
 le05btYKw94BMmCalai8BQv6oC04i/9LUhlDgukXMnvSo2xMC3BmrPXs6463NO9YvIAD3kFgqNK
 liUPd8MfiigP/e5KPU+pxYZmB9oudkrF2ZkE26uoX+Fu6rb05NmJ
X-Proofpoint-ORIG-GUID: IXPKF2BvseDtjgGei7s7A_Gu2F-f6Ye8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX8k8UEHgJqAW6
 +oHZ0UVyejr1QZ6ab9a7JEl4Ir6Xe3pg6Z9NGUNFANfGqPveLfz5NQrXSBPJgHnNVFXn71CCXto
 4vwMoa8hTFZdAhCrbk+ILYe1VqIiHYNtR7jmtjyd2z+3oDP6tlecU+ytiFF1GIZnNnOR5bBSDex
 SoQ9hK41KzAzggkP8qCuKl8FUsauiHsoDdHw6SM3p+fcR+EnUWfUaUFE0SrANuKPZCPsVCcAvS7
 ukN9c1SD761qY1aZnujkdLKDvGEjx2Jx05ZwxBUDsZI8A4JhJKX6xP3/cRWnt5N6EGjdf+RCP+p
 2FLitTk+PZtzYzth9HwcL029KHJ/xPgLeBjCJRMUNk94YWxfCgPKjLd2nMZJG1iePs0WKQPteAu
 ckDFUOJ4pFBtR5UJP9xbbupTuCt/e4kikumHlAXk+HpZNaUb74nQMiP1KPEr1MbMlgguiJy/Jde
 uhvimwqVFP+Xc+FEI+Q==
X-Authority-Analysis: v=2.4 cv=cpQOAF4i c=1 sm=1 tr=0 ts=6ae470fe cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=lBfB42ZMJ1NEXrBLYOAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=10 impostorscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.22.0-2610190000 definitions=main-2610300041

ecryptfs_write() unlocks the folio before writing it to the lower file.
If that write fails, the folio stays uptodate with data that never made
it to disk, and reads return it until the folio is evicted. Keep the
folio locked until it has been written out, as ecryptfs_writepages()
and ecryptfs_write_end() do, and clear uptodate if the write fails.

Fixes: 16a72c455a67 ("ecryptfs: clean up page flag handling")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/read_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index b3b451c2b941..a31f1e90c40e 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -166,7 +166,6 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 		kunmap_local(ecryptfs_page_virt);
 		flush_dcache_folio(ecryptfs_folio);
 		folio_mark_uptodate(ecryptfs_folio);
-		folio_unlock(ecryptfs_folio);
 		if (crypt_stat->flags & ECRYPTFS_ENCRYPTED)
 			rc = ecryptfs_encrypt_page(ecryptfs_folio);
 		else
@@ -174,6 +173,9 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 						ecryptfs_folio,
 						start_offset_in_page,
 						data_offset);
+		if (rc)
+			folio_clear_uptodate(ecryptfs_folio);
+		folio_unlock(ecryptfs_folio);
 		folio_put(ecryptfs_folio);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting "

-- 
2.39.5

