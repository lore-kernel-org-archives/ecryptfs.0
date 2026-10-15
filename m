Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDA35CB95
	for <ecryptfs@vger.kernel.org>; Thu, 15 Oct 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028171; cv=none; b=VH76WQ7+E4EMiH3Dz5FErdiNgic1jQiQHYLb513SBGNw3HPyRAm1D3AyjoxySjo+hNeuEusIP++ACYu1P2c2KdKNMErLL6ahvADyIBDdc04gW3IZLCq1NqYkGAqslaZAuGoJGyO75Ze8uowOyuYM1T9ubnwpJ89H5mL/iEKcqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028171; c=relaxed/simple;
	bh=T4QrZ3adcg+C37as6mmDumzk+z+eyTFJtocTDMVoBdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4UgV04wP/nE8CxK19J1dTvOs/U8D0DicOsGBZjtc8+p/FU7qlYs35yrA8Sr8VOTCSN2ra58/JcLXDwFsbUQl/FcLrBrM2VHMIq00oKR2zkF55NnWnEpPvXBrnO3+buaSuy0T+fIzfpkkD/ftFdE2iC9grIt4M+RNJ3nyFVwYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=iTcgt76b; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MOegK1gc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="iTcgt76b";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MOegK1gc"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0Y8sg3488507
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=u/pC
	V29vBmEHa+Fns6Ic2sV/v7me91bBixE7FOXpkZI=; b=iTcgt76b2OSyjt2eYzc6
	+iv/hzNL1YM53Qon39xyqTJESDHBP24qiAqq28sXAgIOodzuTz8gU5Ad1aevvmfV
	isyPPpUbXwyBJC/yfdlKIFRjgE+0mZrup70OG2cIb0UKDKCHFW39KZZHT662JiNs
	7nV9HBC21pb8ruHcDNbixH5dETEp4Kd/1QsqL05Tf4bVdV/8MtVjk6EN5aYrnDVU
	thkPW4c5lf3MUpS0+n6DzTslpIvms2dzq7IXgDoGti+Q8gDPBvHzkNxlxmoP++G/
	vw78wtIK+6MUqrnJgSGJ1uPAZuyNSu+gqpSVGWwTt24r6QYJmiMlvi/B4Io9cA+d
	Gw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4haerutxjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:08 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5352436cd78so9297721cf.0
        for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 18:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792028167; x=1792632967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/pCV29vBmEHa+Fns6Ic2sV/v7me91bBixE7FOXpkZI=;
        b=MOegK1gcHOtUdeOHyIydXEHLWGzEx2kZThzfq/Wx8SWPcpWGN/YE7qISVarUCZsCAW
         lUpjrnQ7cQ5XJOGU9PDBc1zkkWBCyvZbB4zwSgHGzjUgeVnePvW6ZjA3pYq/kYsDQVH+
         dIc2wWFwibfPLZa10KD2ZwLB8fEPtiF8St1AhCofvxuC2VG9zmwss3bZIrTanx4ZpStZ
         eU+i3ysknwwB9oo3kwqTXx32Dvnncog5NaP1yqHvZWg+lN08ZPI1MB0m8hvDl6kriodX
         YyhIGejw371PsBT6gN7y0VfSRpy6NmkdrYDwuKP+NQaODUkuyH2Yr3koQzD7n/VQuG/K
         LKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028167; x=1792632967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/pCV29vBmEHa+Fns6Ic2sV/v7me91bBixE7FOXpkZI=;
        b=xn8Stff3D+e0wUlGvK/T4j70+SBIVuKf3fZ3s696cVwL8oGG96LbmPecsnVwadp8Jm
         /iFGAjghWo4s3GGdyykIbtBGNBtkXnpjsrtcpvVRBaOeny0Zp+mfsOlFbABHAXfa5KC3
         2h7VdW8ZE4IVhWUFwiMr6mU2vC1+cwTlCUf471jeyHxRSAVwA7wg5ASQcZ5IFWoAmAaU
         7PFjzv6HtQF3NGMetnKHIZnVHNoblwuAaR291lfMGSUVi0FmTxDCo2fFjnRVeYyPkmp/
         YEw/ERbOgx2mq2KRr6PT+s1dsP5IjLja8xQ8WzwwAQjTF6z0BNL4sk1NwscSvPJeBypK
         SGNQ==
X-Gm-Message-State: AFq9FYJ6FQ4nGRoIUDr5O5jvfpQc8MpSVP7Rh+P7n4gNBJoBJD5VhnV9
	GW8JcCaos0yn/XpyBFpWV6a0l6rIzoOvdIoozZo4y8opZgm8utwnPDA2esuwdC8NavE1ph7+J19
	ISAu67WeR8BVBkHFXxtHAlrvkJJWkRZmnhyaZrXHfCmnq9Winbpo6zqwe
X-Gm-Gg: AYBFou1QpjM3H0WcTMqFjHhlI01h9NU6WLLPGjPfgo1OlgAqdrFQXVLTj5DB8idUgL8
	uHLwOsEUNVLbx4YLf7FVreBztBk3tJ4cv8xQJxGMQ5QTRUuMUoorUTcDnp7sDHUyO8Gfhz93bRO
	IsicTEgkzY5B3PfsGqX+Buhgpqc/D2SIddfH/rUbyiAUVL7C56XnxowqoJdEl66wucjslcmaaR5
	y8qAVIhj/o5yKYvdw8lxL0huS7KAvKn0CiWpRDaD4rk5rz92WMSCmfYGvW0PlDqrJsdzeyTg2eq
	laTwQ1hi5uIpKpL6ryCVr3sXNv2+JWS6Y2Qb/kzyTTNtzkGP0nY0R10MIssTXslX1l1mdMB8oAh
	yGTmLSH8/fLz4hXIpMaFGF6ZRtf4gv17AoEfYFCRThezV
X-Received: by 2002:a05:622a:144c:b0:533:3bf7:49f0 with SMTP id d75a77b69052e-5359fa8cf25mr289627941cf.25.1792028167364;
        Wed, 14 Oct 2026 18:36:07 -0700 (PDT)
X-Received: by 2002:a05:622a:144c:b0:533:3bf7:49f0 with SMTP id d75a77b69052e-5359fa8cf25mr289627711cf.25.1792028166945;
        Wed, 14 Oct 2026 18:36:06 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361279a933sm12657661cf.6.2026.10.14.18.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:36:06 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 21:35:45 -0400
Subject: [PATCH 1/7] ecryptfs: remove struct ecryptfs_page_crypt_context
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ecryptfs-folio-v1-1-f4412187b1d3@columbia.edu>
References: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
In-Reply-To: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792028164; l=1031;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=T4QrZ3adcg+C37as6mmDumzk+z+eyTFJtocTDMVoBdo=;
 b=gfzeP7UmwFP9iX9lMhQaZ38Jh0KsFOvjEqgUTfbSq0p0ML/m1DUE+KqaSU4WOxcRhE7pr+DGT
 FSukF1CXkp5B7PwkxKG7+XKdGzLbGVtRx8MJthuV1qqZlkFNp6d3qVE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: gbv1FyeleU9gCZ05fOkzkhBvhNjUvlYC
X-Proofpoint-GUID: gbv1FyeleU9gCZ05fOkzkhBvhNjUvlYC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX18fv2wPSxcPb
 h0Q3RB+JiF32UngfvNLyJtIixpEJowf09kKtqPXiCvirbeMNn9+a/3xr0RW82Rhm7cBb4qtV13X
 n8dFp3PByZH1wCgXOXfn30XfmgYOqHqVtdUM5rH9lOBeZoLwiN0QLHTCFwoUSUPx4qXRuD2Jt6G
 pKIprOuw44WyRXL4QX+MB8juwUB4OZbAeFK6Qrl2KwFlSq3ebrsjm9AJBN9vPOwjRECJ3AQlefX
 fbQlR4oLtZxctjldpetq/x5tfDRXynNcep2KxA35o8hUi87dkPOoohiM7wZ+T8sSPEGnkUvbRAh
 Xa8PtFq0IHqUioOqNejnzGwBHjA3vftVplMIs3/s+KIhVyP43TmHl7Ucsh5OstxBZuprfvJTBmN
 96moZkAPnmKMHrvkjdttTRJ3uKLO3FsWk5UXGWMyt/GtLX5/7hbZxggc6CgWU7HG7oT4Ca1DCac
 eQCmKhhXMGm/hZmLdvQ==
X-Authority-Analysis: v=2.4 cv=E5xYNqdl c=1 sm=1 tr=0 ts=6ad02e08 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=evYo9j6yvagp6J0v32QA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfXxX5iOQLnDUrb
 Jsix0VMTM7YJkcAGDBBl2PwX9N9Od97L2r+P8WZ77hkwrc81taf9IGOKBO1iYYrRq/iIvTkkoOC
 3BPQnl62ZxAo2R9J044G1I/KGaiAA37Qbx+EinpTRervSCuirLrE
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 adultscore=0 spamscore=0 lowpriorityscore=10
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150006

This has been unused since commit b6c1d8fcbade ("eCryptfs: remove
unused functions and kmem_cache") in 2007. Remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/ecryptfs_kernel.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 3baccd4143e8..ff5cef83c79c 100644
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

