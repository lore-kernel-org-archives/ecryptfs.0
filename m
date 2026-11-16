Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866910;
	b=D5O4G7dfVHfCApidwMX7LjFuEJ4zqVsNeR6F0dV3OAVfZ15QE2Vn+slSGCRpAu5mDEcf
	 Bylc6IiarA4UoYR67TObIoK/tuw40oHG8F5FYa8nzFStkAUP6R23PAo/kYX1Bnf960aPL
	 V5dp4A3RxEVCpIWeGA1eZU3efSHiBnSYVDQkgH8D9yEqCx8oI0cnqyMHtGhtB+TRE+3wk
	 Vptepwfgka83fWnUT6j0iLVJfJV6WStxuOEM9+Pbcm+cSR+f4bV8Bgva2kjFZwUpjFGGX
	 k8OSMkI2LxfHjvTHx1cjyzL7Z2vmHUCGUS6f/XYoAAm1KiqhNTHPQu4gr2cUK6kLJwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866910;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GJ5b+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=;
	b=DenX6ZGq6t4mrPfuXegBge4YPptp+1n0CJu/hWIMywqlhGPcZZM7ecFTFnIVfO9ENqge
	 DbFMMXIsY8TxW/xSXFXaPSHCl3VNNlJEnRkFo6YcucapeFlJEcclPUoylL1RVoMofxLsX
	 WkWVXG0+p0HqDPo6TrOGceBsiDfPjKvVUrAA0CTqZ1zQJI52yt2gDNEUUosueef6V6415
	 5HuaM7OVpd7ioX0oUnR79as9m9tpEariSOzjmtyvaRqr0mTlAqQ071nk1iop6U6imw0dN
	 3j5fOQW8qwu9GfgCtF90dIdcXCsNlrUExjEodycjVUumbqemGyEC/TvToGhPpvCDdmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=LNO9rj1g;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=rtKkYSYm;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339860A2610
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0339860A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=LNO9rj1g;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=rtKkYSYm
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYr5D3519950
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GJ5b
	+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=; b=LNO9rj1gZc0/snOrs1Yd
	ZhuU8buOzqnNHthTEsF5yivVdkx0FDLxB5twFcb0Y2TA9NJMdebjcNKSNXfPedBy
	fpNR7csrycmEOwhJsTS/494sJsjsJKgNKZBnkLF15fCS4ddty3I1a35ammoL27Q5
	5l+bKwjCuKQF8DwYtKMPYr+v+3kGNcaEW0JAO5BAJ/K+avC6rkNrSwqUE4e8oLYY
	QkcrgZSt6YZaOx3uBV1BGkfN4r6j/b6eM3VTjRKlJlrdZP6pgV3Qyfx24UDlGzDM
	PM+iCurx0Fze5C91KhQysgaQ4nOPhWwFw0yIY7sjTQuT9ldZRdGTiNsAUzH23gVB
	Hg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059yb6xd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:27 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94961ed97d6so60349485a.1
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866907; x=1795471707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ5b+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=;
        b=rtKkYSYm2F78Q+cKiyuYMV11pzVqcFCYbUBmxux9uwppvbuBIsFFkN8DDDWQOgl8+P
         zEa+ZIS5vVz638LSKRtupn+7V9ep8fcp4PFROuJiYZQUjxSvdRAEMumVNfTGkWLF7GUZ
         8nstlbX1scDwl3BaOSgPsIDY4bl+ghgWEBXktYPJ3cbQ2UMC1R02VHy4KIFvD2+v8n2v
         0ajfnDlXofbqlT1/HBPd4uwhAsUuxRuBYA3x1hkko4t0dvMJ3oBA5wqAF4lyzkDAtt8r
         AJ0nHNxkITHvfZcPs1HRnRhAeYeYsFlhV/uQQfbXvHKoKtPQsGWAK7VNpOWp6iUALSF+
         ArfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866907; x=1795471707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ5b+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=;
        b=J+BSn53VUdxM0o/P0ZnrxvFOZeNI2PPQLM9Of/4XhAjnLrHmlGPoS11qc5ZnhEFdyA
         GdieytvVmhgYttXyI1F6UkTQDsYf7CFI+dX5yNn9PPujki7bglorfZbZBaSzAbkM4TF8
         I/VoRAnnH43fFT3CN6DgieOZWjvwYRLR9TmouVn6cEOeGCpn77MW8DH99U3t/h3gTdo7
         P6jXt0fW+qlmfM5nfL8QE+kFSQFQ3ykeRjn5PiyCxKg5v2HvDSReu6eesi/aIa3OeKb1
         f8nD2riARzyj5GQzf3bbQrCgzh8paNezjgaiNB5AOO1r8XdWhyWMp8YE6iFKB//Ih9zy
         6O8Q==
X-Gm-Message-State: APuU4Z/cPJvtjUjNG7cwWYuv8H6+zfTu2AZ7IXv0aslArM3qC9pl2k+M
	x1ztqS9y2GeB1Wfv4z85tLH9m52Cq8zsQIrjsjiwiIkCSiOgO6AkiG5CZnWbvHmD0Fk1TMkcsDh
	A1Qr5Mi0LxFyquZhFVC8LPHeYTY8Zr6DOr8lNqS47rw7sNcESieRUBwEO
X-Gm-Gg: AYBFou0z9ER29J8pkPxS5DiwEll2/KJoaANB+gX/adx8Vy7RGYzCG5g6hYRjl+Aq3Nu
	367x8W1nMsuQ3E0+n64Az6QYXU7qPGovNGg8b2sj7Rh/a+HB7gIM7iO28ZN7G173WqbyH2YvyOG
	G6BDQ84bkFzXxYoAZQz6TkEH8kWMCPwKaCpfI10JM0xqjjmzChPlXUNyEVz4HEXkA8QYhUVXjEr
	IAwVcL2azWl/yPAY/Ge6Wdp8r97yY2dFA9jLlT0Lo6YTi7XjhSpoCltR8/P2AZVG0Pq2U+udhiA
	Dqxk5f14f00Y0lRDXFDQSfrW3RYJHyA1NHzzJnYtjKAFfc8SctOFUvkVLLxgw2iLQlok84l0TPr
	LMCuQySltW1LygT7e8YTcS5c1DRrg8bJ1aqxwxPgVZVTGiiE2lksDx+M628Kke4o3yo73AMWKtE
	+keWTczwUqU+J9/naRBM8X
X-Received: by 2002:a05:620a:4414:b0:93f:17d1:9428 with SMTP id af79cd13be357-9498b7a98e5mr162041285a.14.1794866907412;
        Mon, 16 Nov 2026 14:08:27 -0800 (PST)
X-Received: by 2002:a05:620a:4414:b0:93f:17d1:9428 with SMTP id af79cd13be357-9498b7a98e5mr162037185a.14.1794866906984;
        Mon, 16 Nov 2026 14:08:26 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:26 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:12 -0500
Subject: [PATCH v3 06/10] ecryptfs: use kzalloc() for the header buffer
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
Message-Id: <20261116-ecryptfs-folio-v3-6-1aba8e620eda@columbia.edu>
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
        Randy Dunlap <rdunlap@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=2395;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=DAdtTEUZtFUeBHnOkeUrYySm2NLUFnvIrS8WFRdGNlU=;
 b=2Gur6D1IhzZI1dG2RB+f56W6Lxau5cLBMNZrXaK/3t9K3+X162zSFS7g+mRXxaQ+KX09DnJY/
 VCpT6M96z1zD1LWP0JBdYx+y1vpm9602AVxXCx+cYewqMgd+PtoDxB2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX3pL5xzUJpOVp
 e5IjgS8O5HoHrj8vDlfnpdD223sJsq0tnDpDXurIjeIjJv7jg5Z8oFQqvPT+DbOPf62BexVbj/K
 hS5/iSsZMuzCSg9SdIJF9zZCyUqLHjvMEFI7tjIxLStWGvggtHaNbI3zBqfHph71jGTeG2mGl30
 YK+qqAKf/sVg+kTKH9vbYDy13Uyz+LHcg1MsDYDLj+qYMX+ly7Esf6Pat5VWsr7Z9EHgul/yz5W
 C/AHxOZ96V+x7kdyH4yCkoovCQvxm77p4Nv/+tOYh286QZDBX/vo+a1vlEfT4wIZIip5rdsXrkE
 8Ef5B/NGSj3vU0fuJK82AEOH9pVnr2bl2iVIcRs8TXZ9PKJeaEDwZhp+JPlOUzX7Yw+1zwlPzMF
 4s6kOdz8QFtMs32HRCGcAaWBwyklknJsYGFCm1/Z0PwotZXjig4TazzOpizkcjt3ipsSUymnNE0
 oTlbvjUSTBLKgag+Ekw==
X-Proofpoint-ORIG-GUID: NQADDdr7qsH36AVPRx5o2ui71u-VZ7bA
X-Authority-Analysis: v=2.4 cv=MOv1C8Zl c=1 sm=1 tr=0 ts=6afb7edb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=JWifYr5Owm72-P8M7WcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: NQADDdr7qsH36AVPRx5o2ui71u-VZ7bA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX3kKoSLIL6fw5
 y/lRDttr/HFdK2Qkbg6bX03cy6ogEb87WIULgL5bcyP44FuKBPB/mswsL8+qYFmHwVOEL+TpZWY
 ZoCaqwptWygRR1aUa7MJT80AmN+XGZNKINX+5WgPXUFDLIG1ai6Z
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=10
 bulkscore=10 adultscore=0 impostorscore=10 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160087

ecryptfs_write_metadata() is only called when a file is created,
where ecryptfs_set_default_sizes() has set metadata_size to
ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE (8 KiB), or PAGE_SIZE if that is
larger. That is an acceptable size for kmalloc(), and the buffer is
only written out with kernel_write() or as an xattr, so it doesn't
need to be page-aligned. Allocate it with kzalloc() and remove
ecryptfs_get_zeroed_pages().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/crypto.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 9b8b0c5a81cd..6a014872e919 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -998,17 +998,6 @@ ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
 	return rc;
 }
 
-static unsigned long ecryptfs_get_zeroed_pages(gfp_t gfp_mask,
-					       unsigned int order)
-{
-	struct page *page;
-
-	page = alloc_pages(gfp_mask | __GFP_ZERO, order);
-	if (page)
-		return (unsigned long) page_address(page);
-	return 0;
-}
-
 /**
  * ecryptfs_write_metadata
  * @ecryptfs_dentry: The eCryptfs dentry, which should be negative
@@ -1027,7 +1016,6 @@ int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 {
 	struct ecryptfs_crypt_stat *crypt_stat =
 		&ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
-	unsigned int order;
 	char *virt;
 	size_t virt_len;
 	size_t size = 0;
@@ -1046,15 +1034,14 @@ int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 		goto out;
 	}
 	virt_len = crypt_stat->metadata_size;
-	order = get_order(virt_len);
 	/* Released in this function */
-	virt = (char *)ecryptfs_get_zeroed_pages(GFP_KERNEL, order);
+	virt = kzalloc(virt_len, GFP_KERNEL);
 	if (!virt) {
 		printk(KERN_ERR "%s: Out of memory\n", __func__);
 		rc = -ENOMEM;
 		goto out;
 	}
-	/* Zeroed page ensures the in-header unencrypted i_size is set to 0 */
+	/* Zeroed buffer ensures the in-header unencrypted i_size is set to 0 */
 	rc = ecryptfs_write_headers_virt(virt, virt_len, &size, crypt_stat,
 					 ecryptfs_dentry);
 	if (unlikely(rc)) {
@@ -1074,7 +1061,7 @@ int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 		goto out_free;
 	}
 out_free:
-	free_pages((unsigned long)virt, order);
+	kfree(virt);
 out:
 	return rc;
 }

-- 
2.39.5

