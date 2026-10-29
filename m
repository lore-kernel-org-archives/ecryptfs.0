Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355990;
	b=XHJFQrtTlwuGjPv/daMCODOZTlvhVOsHjUUFTYWFAHYihiHwsfPvplaMtqB85MJBrK0Q
	 +TE5qfTNBbXqBJnnPRKQhjNv+++DvfCFBQsIT4x6X0N92rFTIJb8uYV5C5xqu6UxD3/Hd
	 VNWaPzQPiGlJ8oi1HRBIGdwodzSCWm3YTJ0c6G3i5y/P2NDz2DcpGgOfjVhqxDTL+GVW7
	 RVFobku56FBtz9hgVIzIDj+fgbgztecmFZ+BTe8sOSqkgWmdTInb+yiwKThmlJOL05M7c
	 Ct2Ktr7AcTt2tGRSWoitwpOTDH1A+P7rB4E/U7Xw4gYTSus9kGk/Y7ycq5/EzP5KBfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1HR2RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=;
	b=fe0PARAdrP3FH/2TQ0VyfwF7DL2cEGVlGCoaxDzkK1J3b8TdwQrwtb/7rtNlxyp329xD
	 rYt/RxCLJuFR8jaAM9z/MPbIjJIjhJ+kjc0IhPDIH5caSmC2KEYKYtmFbpEo2cKcScHDF
	 7dxVI32ZNn7+tcS3NUy5Mq3fFVd/+moEAtB9PZSwCiJV16p0/iQplA1TVsAC7jP7SdGDh
	 9adZwFK7GTZ56UH4QjL3f/89mI2Rs7czKrrTlaisv/KQrLZrtXPF2cRfTQSSXWN6U9MRo
	 Rr6wjLS09c3ZG8eouqT9uJP8tulsnsmpPIVVebKJZNvUhIRc5rBwjmeqVhle+W7EwcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HhhReTgD;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=HXSidAgM;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B027606A324
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B027606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HhhReTgD;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=HXSidAgM
Received: from pps.filterd (m0167067.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UALIvr916757
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1HR2
	RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=; b=HhhReTgDrLkQruN7aUNG
	DofxGBTMk5hDDO+/pZbH+JBE/apyBBdXryOnYB8oR4t7J2EfAnyzDBURJSJji6xb
	OSHYztc+rKRCJNGSoHZsjBZ8orqhtigfSvtggvopw83LnsDHZ1XStqvl1ZdnLWCD
	hdNgllwZQBMQdw76VZv7SGxHrjTOmFfS7774R9ZSzY97TwhGeuviTb0vSZld5yqx
	RtvrCkVxReibIJM/CoWN7CxzBAg6y7OQC951DmwViBLM3dwrl1Ca3B+9vUDESGmT
	NsFF1swkIa4q2jvlYbnAorCj0eUg4SEf+amLsbxcHQMV/cP4T07vvVat7caZHm7T
	tg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm80dg65h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:52 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf6c528aso301573085a.0
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285512; x=1793890312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HR2RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=;
        b=HXSidAgMWIUtyX2xnUuiL0B3P6LpcTB+P8jhIEaj7BZgkCg6WHWfhSZjiZExpuMVs0
         x+On9pqHPGjYbZS+MM1BEYmK2M+aSfO4DRlvrnMHZqWKLzVdB8nk6EBPe1lu03t+N5F0
         Th0zeHlb1WIBF8zLwg2HwmoPnEGKKnIWoPNcPRfalGfw1DCn4aiC1ZL/qKfCgp8iMFw1
         G+WtFpGIkGd69QcmCc2B5fhZ/sTxQI6pWahPv5O0LEudCthp+2ZXqNJ+AkONzqTSFBrT
         IrXTlitWAFhaLHf3miW4Ot8pOSXnGZ4G4norLbcDq2u1E80WXP10ceRAZaSg0+sy8a7P
         L+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285512; x=1793890312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1HR2RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=;
        b=bwJvzR0gayqjyLWAK9hB6rmLSLUisdFCbHDkNYgjOEOErgARqwjOPJ42Z3i/wSzBCv
         7x7mOBRoQTl51csUEHJMxexg6qSm+8oUvP4nDF/DJoNsr9JE6gLTQDRfDjR2jP+jcplm
         ptIVkrHvriVXsTSTGP1C7hJZ6Xhvva97rO7CeMcpbpcMZ/1N/UaBphYSeG6DUueNdwKI
         CgjjoLllEEa5gZAMXKh8gHHjQ/c+cWy7w3Tb2ybDTZ056fARJ1NsKgR8lNvvO9O8ywzG
         QfWn6ppEa5HomQp5et0kjvpZ1/IGKvbGzbbbn4NCyDJ4hTp3CZwBXB545eP6I47zKrgf
         DyhQ==
X-Gm-Message-State: AFq9FYIZfbt+OEF9FfMiNEzEmx/j9IBKOsOQyb2MtOG++u1MG3N5VowM
	R0rKl1JeaTxrXSTFvMiT7Kv/WHSATtgk5hoJgnsaMSi9aBapQXJgEJzStjM97Mh86y0UHcZrfDe
	G8u5QCVGQzrmRawgJPTfMuBnyX+ZGt0+ZBZYlMfKs6Y15DgamznoNMzuxaLygOd1ufgE=
X-Gm-Gg: AYBFou1JXJ0sG/CUbLm/lzZgvObj8f8N/QoVTYkmfTl9P0yOT0UtJmnAxUMW4/wtp2Q
	28idfXP/7afXZKv7fM0pqMgMAuQBKwW/HYD/ltmBjWqqTK7d0VEd5BxdKr5bZEhAf6He39kuOO7
	G4oHBWbuvC/ADTHyaCkB+DibUWLJBlvh/8KRFzVrPbYa6FdCccT+wTVCiexGj+oPhuamBcZHEph
	OOmmoaBBvYGuDYycx8ZidCW9rSiGPFu5mLb0MiFFRohtrDLg5vf5uBO7ZusuBbrrT5ewpH4bICX
	SSN+LYzXJGgnn3tK5l7cuVUh/vAu1Qv4+AvEhrZxOWmmmbC53iHkaG/aJw80U93Aq+fL4nmjlPo
	H5xWGupeOn13JHqFXkEo/CkdBVXTuL3vtzg5bCA4Zaj1Z4X2srQkI8K4jr3OhLmwWfsQKkti8A+
	7Ux6mReZ+VzwYLzAI=
X-Received: by 2002:a05:620a:29c5:b0:93a:13aa:1b9 with SMTP id af79cd13be357-94408a475d0mr830783785a.30.1793285511950;
        Thu, 29 Oct 2026 07:51:51 -0700 (PDT)
X-Received: by 2002:a05:620a:29c5:b0:93a:13aa:1b9 with SMTP id af79cd13be357-94408a475d0mr830780385a.30.1793285511499;
        Thu, 29 Oct 2026 07:51:51 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:49 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:24 -0400
Subject: [PATCH v2 3/9] ecryptfs: remove struct ecryptfs_page_crypt_context
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
Message-Id: <20261029-ecryptfs-folio-v2-3-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=1031;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8nNsMMmNdcqVbMlIKq9eZpT/6NpoMNBQA7psRulhB58=;
 b=aH2XlqA31DHhsbm8uLd7YnTx7DS7PIp8H7XgnW3As3CUub2Pr6bDLEmH84ou25JNjhBbh7HeN
 6wXmsvOn6wJCMAlKkBV14GuDxdA0y8TO4mqIPFiP4FL4MSCrsmQxqna
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=10
 lowpriorityscore=10 adultscore=0 bulkscore=10 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: YuyhxvBb-vBgj3KMyONhtCr33eCnfmbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX5+v9idoDTelG
 jqafx3MpCOHYhZ2ek3SxjIN1m2Rv/TbgKG2f5WkaGFtRrG5VTz21vFOt+IL9WcNUbqYaHbTC7Ye
 2vnRyhC0tif0TP1dLP/HyAT2EU0lfuMpZzioFJv3MeLvxl3AE7sbOuD/WU2ToHHO0kdnQf1opPJ
 ihc7PL1rCoyQYK0Kp0B7IoxwmDY3FxozO3o7AGu9nrYgswE0BXuVtWw+axBavti/X2Y0LHcEIrv
 FtmS3Nv1jgvXYdPOf3UVigmqSI4VXmjJ0pq/Yd7YCwXIZFaQY1ivl1DGLVgP8JHrLKLguO1geX2
 buDCX9qeXXl/Ova80n0R89SukxS1MM1wnoRzjc5PYVrHtu1l8k1o15Jp+rjA63h7oANz9RLfAwl
 6ZHPAx/DnOYy991Wh4A1OY0mP5znBmErSIpnJinPzyk5l3fcbLq/dc1yPYeH85y2d2f7nSOd7XP
 p6kkvPh+rli7nFhmnGw==
X-Proofpoint-ORIG-GUID: 0XQOeCalGzEkkKu7LskQ_fWt2C9CEiiO
X-Authority-Analysis: v=2.4 cv=BKEmP1QG c=1 sm=1 tr=0 ts=6ae470d4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=5seVXgKEpYMQFUWKuG8B:22
 a=4zUkhEILHW4tcmWJkwUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX3V+2A/blAAAl
 XBTWjYbw59TBRDHsxg6kpDyqLorv7Z7kM0gL1Y+bvCyVzdAbsM7F5pPgbvk/NKaBttCO4W2p+NV
 jPe+fZw4Hfcv46+7prgdZ7D4EHz4/ZUMuNnQYg07/0Lr3idXkuzV
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=10 suspectscore=0
 bulkscore=10 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

This has been unused since commit b6c1d8fcbade ("eCryptfs: remove
unused functions and kmem_cache") in 2007. Remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/ecryptfs_kernel.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4315c18ba1cd..d828040ade89 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -64,17 +64,6 @@ struct ecryptfs_auth_tok_list {
 struct ecryptfs_crypt_stat;
 struct ecryptfs_mount_crypt_stat;
 
-struct ecryptfs_page_crypt_context {
-	struct page *page;
-#define ECRYPTFS_PREPARE_COMMIT_MODE 0
-#define ECRYPTFS_WRITEPAGE_MODE      1
-	unsigned int mode;
-	union {
-		struct file *lower_file;
-		struct writeback_control *wbc;
-	} param;
-};
-
 #if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
 static inline struct ecryptfs_auth_tok *
 ecryptfs_get_encrypted_key_payload_data(struct key *key)

-- 
2.39.5

