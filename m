Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356154;
	b=pLQWQqGA1olsDDl6xkP1C7WEPUmaP0zypH8I+m7u42aV8pm5zwT29e8clhCR5W49y+4t
	 45AjUY+VAukmftixy9bAgjpZ53t6O8wnCRRbYr8aucAn/XDviRrGVfweDfuvDG3rgkXFQ
	 E73DCVxk1WzaTDqR88f1j6af8yiPmSk4Ymnwd2hHfrDlKWEJzBgiNOnjkV2EJTgLqRbrD
	 hVeFenb77SFsKKOlmZQL67yLa8XfvI/D5EWYMKDOEdbFriN5b0/Qg3QALXxVXIes2VBlr
	 I+n1qMtObeU7kx3MADUpqoMzY3Xfri7vdTh8bNU3bEXqeXu5Lpv4rPCKYe+MwTMM6EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356154;
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
	bh=GJ5b+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=;
	b=a9DRE6Ibj+9M/gyqWf6DsbfLeviToehcr8H14hzohhKiPfg7ZaWhePY1Xhik6lHsMf2E
	 chXMhplLDdIWXGSlEYElow3ugLhI1c3EdQTGRfyAEIfuSnEMEhfH7l2U5gSXXyBsJYtcH
	 9TViAd7NM+U8Q+745zHxBLPCasPHxrxkEj7cb+LtG1EvKQhOLinx4zA3AdFrcpilAJmNE
	 ZMmS3z0cvO7DZNpF+Y2yHUz7NdYyKfAnCKF2s1tZXUpgRBOf+04nuXz0sVRtTtV6YWxIe
	 dGChKIg+tw/dnrGx0HjRsoUdd5Ov87id+PtCT3h8MRjqtO/OrrUek/1nQLmbuoOL43Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=W6PN7z1Q;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=S8dqNKkb;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294C606B81F
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F294C606B81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=W6PN7z1Q;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=S8dqNKkb
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U6vbLw3771306
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GJ5b
	+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=; b=W6PN7z1QevOZ/TQPt6P7
	YauJ0XQdc1Gk7Wi7vRZY7seNNRRBCotEhBpM9Mqi7D7FdgH/VVxjsIjpN+B2Oo1u
	JY27TWoaV76R6q6A2tYvh8IG0M5AkBsybLhNlql+DWcEG8l58TN7QxVq0asStVv3
	8duINhWDnE37eU5mH+rXyX6f0a9Y/aS3L3GYZhZFlOQROKoYie9WenUHjADhKkTS
	V21gCO9HDER1Q4UC3JC8BJS6Yl2wz+2B3arJ8ngJbWf16nrh7TLnINXsCFSjhwBf
	KHtshqbHokC6xEP64qTJzmREC/RWDlayXSgVBhwCeUCYT8AmUhJy4hJeQTbzVnDP
	Iw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm7k00fv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:57 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-943e8ff02d0so215393885a.2
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285516; x=1793890316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ5b+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=;
        b=S8dqNKkb5sfSOSp88+eCIZay3gaJmXVL4lPeLDxxUAYgfVGuI0eJrLSRAh72NXJaDi
         VkZ4lR5cj8s/Br6PCQh8zKeCh1NAY9j/a01VkO46GVjP5llIq9YpaMo8AmngAtGLohWC
         jutr3POpBI7gmViMaDLCK3ODTgmI8l51E6WZQutz4sWBzUTghgBg9GO6jiCMxHFbKrMs
         G/JfpJoGYZUD84nCsC7Q5KXsxWlVUHSqLb6gl1Av/0SwICfRFRuoLsESm1X3uVH7DtFr
         orRt7qDmv+3QoJ6t09SJSh/APriKhqBOnwDYAgTi07ISbKfpe8/XtQALo56MhqpH/XhR
         H2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285516; x=1793890316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ5b+6wmoMaOFvcGByrVJwisKvHFAIIDntUfxnLnHrQ=;
        b=aypTOMyXVSgRQn6+kYxmrVw8A4sI6ev5/ij6AdwvNhyRzys95qzHn2iGgxzZZMjYsx
         NgFbke8a8EAYXjYLsJASsEaEfJZDUsXN2MN/SU0I5DfYOnxq1fMoeebjsEyrJ3jjCdtG
         wuySYL5SDbBMjAS2z+qnCez6ao7oJKTR2tNXGdwF1iJlEk3erww0ePQL9RTrO7heVOw1
         4lHfyur9GCD/C2FSnrIdfxMvCWZfDPbIjFTuRnrmoLF9PDwZW9us+oBupHj/ACDivVi4
         pZedua1Ofamk+I5B3c80ZL/zDzu0RLjrZTP6WUJaMI7hT3qYAhV4TeOCkBqGGpgtKiUz
         9DFw==
X-Gm-Message-State: AFq9FYKraWTzKw3tKyTR78CLJMg7xfKBlE23G3cPM3B7Pe3PMiL0+PcF
	YbMASz1IDQeQEJaRD9JACd0ylOXrBXcB0/9dAauoyVpmGxrsOkX7U5S03VcnosV9MJ6gt2MSHUU
	EyITkt3rD3FwAHdQ+TPxBT1gcOnbZFwcS/31aBBG0+B2JuzlTTNlSSQz98g2VCwNe25I=
X-Gm-Gg: AYBFou0P2gDFy7y8QqLVSYuKk1RhdJ32ztDfFUVYJstHzuvZV1QpPkvi5aMyzKoL30U
	kuzhFZ6kse3Phz6tnGw9uPwRwIl4pAmFEDWLct412+BxoTqrfwzKEsF/kS4yqx7TOGcr7h5cETz
	RgxitlKCJVDhNxwWPdum35/44NIhVT0UgGmKNR6ZRqD7dzk1VJyFXVrLxDwBx46hlNAqFJwcWqh
	iQD6rq3cGqnXrDkrjMquSLZLoGPVsFOAC0WQDinCihxOG6jJtDkxzQth3mknLqbTxTRw8Bneub3
	ZVvBejqUvmBn8igmaxSzF+qmMv9WapCoZsiKdG1WPn5TJwcXaXvk0xpF7yI3v7BHDloccauY4+J
	f2NWsTgBEjHJHnaWBL+nmM928Gjut7eVpkFBftk2MVnqyUEZ9hMQ03gy1SqOd7yOokrtCgCdGI8
	TL
X-Received: by 2002:a05:620a:2a09:b0:93f:3bb5:545c with SMTP id af79cd13be357-94408a7256cmr836099385a.18.1793285516199;
        Thu, 29 Oct 2026 07:51:56 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:93f:3bb5:545c with SMTP id af79cd13be357-94408a7256cmr836094685a.18.1793285515659;
        Thu, 29 Oct 2026 07:51:55 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:26 -0400
Subject: [PATCH v2 5/9] ecryptfs: use kzalloc() for the header buffer
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
Message-Id: <20261029-ecryptfs-folio-v2-5-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=2395;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=DAdtTEUZtFUeBHnOkeUrYySm2NLUFnvIrS8WFRdGNlU=;
 b=o24NQhnQDAIrcPX9RZTlnQiildQbI/YdsC2gSCgzhEDQWYQawRwaX4juBMzihifGbQnh2uG46
 Tym3iKNpadoBv4OHUJV9ftIt6Ouuw4yyFlY03wYx/qFouA9/IcVqd3c
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=10 impostorscore=10
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _TeqkbEgp6Ce_Go6xz_H7g5fZHsqErtT
X-Proofpoint-ORIG-GUID: rLhS_wBJIvUYaogsFpHjR5BjHMVpZV53
X-Authority-Analysis: v=2.4 cv=GfuCDgXL c=1 sm=1 tr=0 ts=6ae47177 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=JWifYr5Owm72-P8M7WcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX7DtKctU2Fi9x
 C5P8AzPi94F/XgYesP5lk14v0lkRJfVL9K3xvUdSECCRyKATpHfJqoVKl6vdXcS85ZlDsOms1yS
 aIB5sOS36lKs/A3KlAng4SD0zK50cc+7/JcQ3gEQe4T8pWTriEXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfXysgKhMiwDqye
 KQ6DT4aGbpf3EQEy3mUy8G3OMqLxMm3H1S4+2JbdlPUTh/UGBhaQyV26yqR4oC5Z28CiB0gPuWn
 m9DAwEw579nCdV4RIR8lJBRvSg00J/QgiD3f3sX2Qt8ebwt718rDPrBHzJ6SaSzqnqsgb4pAndV
 0p5LWtTNdELkkBneczDbKR8YwlmNGQX+NUKoRhIs3gTJXc9YzzW601tH2hM7arDIEy3G/kZiMVm
 KJd7FCh5FRbZ/rIq0tk7is3e/Lzgd76f3FgjX/HqW86rx7kw/6Pj55zeMDOfGr6lrME4SqNm9Xn
 1VgWt2Me1gv4wJAHTwWXdHaW6I8TRumD06HxJQXfTIAxF/Cou07Sp2hTwmfOYhBIbXBfdFloYmj
 eMuCq5ZApcpl3HPfftMUaW36VHu3xtbCUdQaNfxB2a3Ft+9PWFR5SjSedfXFdWeKhnNWwJiINmi
 nxunxLW/cwpjPMIUJiw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 lowpriorityscore=10 priorityscore=1501
 malwarescore=0 bulkscore=10 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

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

