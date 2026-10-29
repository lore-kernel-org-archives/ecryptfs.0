Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355981;
	b=wO/tjMhyByIjs63IXmjj1GaZYoOGS/LROaZCqPRwQblmh1uryGRfOxgLRQpLmGOUWoiD
	 sRfuYpUG++Ekw5nEzdN0hv8iJE1zqWrJt8jeIJ9W4u8fp6lrKaEHNtqclJFwN9cIf0mTa
	 TuxACdYklcokj74ZJxYjyAW/P35HdrGhMtOPv/f/mTk9GOzvJaTrGIEymzghs6VM1WVEH
	 nOsDNCKetFdIOu9jtNEDVxWG8QA7kPyShjSS7ozGbjzhcgKYDU5tVC/49NkyKSSJfnYvN
	 LUf0IDvdeDAlFS4HDqUm1ynnaVib3FoCIbDe5/tZqTieG68JgnNqU+NGkAzQIg1ryKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355981;
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
	bh=cQPjKdWMy7S1oYqCkDx7X4TDyODbJDGxE2F3oqdGrUM=;
	b=FBGl59069jyqjvHviFkogtw9AQfsX3Fup9eUEDULcneTlU9yJ/TEVYL5Xibfc2frHqmf
	 BHcx7WptSJbhYUyBWpNVg0LEYCEYTzqlKpamV3/LfzLUpj8U/M82IQwDUK8gMKNF5u/SH
	 OS6fRaKoHRZ3nSEzKrzAIGFiEdamPGcQW79TAQ9IYlJg2Qh84yDFqQbnWigHMGsG4ArAW
	 ebrZxdvWRw6uiv9mpy7BqVAOgffS8oayePaXe78Ha34fkWYU21Qhe0669Da3hYBr5fDT4
	 ski/S95Iuw1WVY9npCRH7dusrd4ibDsVxexQJIqUk4tob2/CK11/rdHcZJF8SNjOLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=SzYmS8Kt;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=rvf5gfM+;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9D606A320
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81B9D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=SzYmS8Kt;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=rvf5gfM+
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U9dYot1150468
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cQPj
	KdWMy7S1oYqCkDx7X4TDyODbJDGxE2F3oqdGrUM=; b=SzYmS8KtomEYRhXgVYxZ
	/WOyQDuLlLWpDlsL1jee8kgPSFdcAO6DbCuDZ0lTCRarvqp8bqw5WQMyZ0dtiiuv
	QqHyNVfhN95LecaXASZhekhVhX2Fgx0gS6EwvRzak0zJFB3EZcVBNg3Y537B5H9B
	sfU0yxOj4izwKCngXpcTSXinxhLNO7Xz3DFHUwVyX+pY4qWD3lVSEslnRTg8FJbQ
	LiUZ3mJkIMqP1rx68IBpui5+14936UYbjOlx5smVcGuv10TixnZKcIYl1/iDoJrT
	63jxeNyLAUhUmA2FUTIknkO6w9BRtktBogCH1kjSjrjbC0jdiHCm5ZJeoYavxi1X
	GA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hksu4v7p9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:52:00 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5364605e74bso34857371cf.3
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285520; x=1793890320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQPjKdWMy7S1oYqCkDx7X4TDyODbJDGxE2F3oqdGrUM=;
        b=rvf5gfM+pVHLaxNI44qTrcb1snfU+vrYUfRJiTMF/xI5l4IvrL0wQTDZGbAfzHA5vL
         xOfoSSEBPz4hUBj2nZe0c/8tW7NAooCCU9sjbMdekXbO8v5FdHFsfyeX//8MC6tqNFwS
         hSzQA1LRDBDRgiGauy/hATOtWgBCR0M3fBm8HNDQwKQKMb7ql8X5tv0dyunNBRy8VuOo
         w7myhc5ZfD31ZNqGzMQdd5mG+IQf04prH0zWZjLwZuxlF0bP/dt6GXS0mEzoc/ctwjh+
         zP8Oqwqof8TZ/QO0a5NgBjOVkNL66gA6+8+DHcLYqaKTD6WQYoMuFX3HrZurRiIW5TmA
         M0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285520; x=1793890320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQPjKdWMy7S1oYqCkDx7X4TDyODbJDGxE2F3oqdGrUM=;
        b=qCgVBQNRMkej8aWuz5QoRKwVSAfqM22KUJPacFvQwIDkbg8KWzpU5EHERu8247TKJM
         Wl6VR6JyvbQ5jn/nToO2PFiofUrf8LzqEJT0zpz13Zv3GS+44fD7vufbZAM4+Ynsjtyl
         rRnX7zxct7U0y3ZGI/slmOhSC0H5vdZBOSwy8eFznYbIKhO+NS9ewZMnn2Jh4Pdu8KZ2
         tm1PewHxlyyCRdK0S/YygYrDcYOFzXuyJTDN/fQitkFNrh2bLT2gEQ2bUU1uRCF/i6E+
         WNYrelY6sj00c6mi39Fve98PJtuvK4sOnAmhuica0v34fd7CT3HfjdCXaujBc9s0ChUs
         f5AA==
X-Gm-Message-State: AFq9FYJHKhxkWkkMZY0DgsosoYTyPwnp7cSF/ucFcgtADLMIds9pAFqb
	MKwQUiJrw88mLvMHSPDXoE3MtEmZCExdW1IG37+dGSFxaGogQSDULHh9SFf2Xh0EhLffB5YQhJr
	e01lJxBmCbl4xQOlw7En3pQ59AkowNa5LcxdLyWeFr3RZSCRSI2yJlwRx4ziov2NqPe0=
X-Gm-Gg: AYBFou2q7o5yCBKR7AbfVIqWmItTQi1ywt3XTb/cWvH7b2gprZHIH8itpSi28p/Qrc/
	4XSSLvHVKLvNdOz1j5jL1KASU2eX7HesvKyoIv4IKyzKXc5y/o8tQT25S18Rn1u+YT5JmcSAjod
	mUWeb3UrV/GoalV/di9C6ezJBjs36oX86sKy8p3IYuv+QtZM2JdDqBAkeVezkCfbgwIvtl+7Yj8
	xacduzfVgzcJPCSsjEFXZtomNybKXxkOfAp+XN256wNLIEWxyaKNK2itzIeVF+PE3zSId3lIW+Q
	v5wfyu+GG7y/Prk84oi2zTS5gaQw3z8S/d8HqiYHAY/Wz35ZNwu3gaSZ9Puv9IlOAd2VKzc6Yp2
	qMIiguybvjufxJvICrV7KBGgY7+r1lbtNwo2z3+ULBmA8nxIQ+BTli3LvYmE+UdAp2ddTxZULfE
	76wCODHp+HRGv1OWY=
X-Received: by 2002:a05:620a:17ab:b0:93e:60e8:c9ad with SMTP id af79cd13be357-944089dc305mr880516585a.12.1793285520239;
        Thu, 29 Oct 2026 07:52:00 -0700 (PDT)
X-Received: by 2002:a05:620a:17ab:b0:93e:60e8:c9ad with SMTP id af79cd13be357-944089dc305mr880512185a.12.1793285519690;
        Thu, 29 Oct 2026 07:51:59 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:58 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:28 -0400
Subject: [PATCH v2 7/9] ecryptfs: zero the tail of the last folio in place
 on truncate
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
Message-Id: <20261029-ecryptfs-folio-v2-7-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=3389;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=tfML2l/4cmHk3rjgjwPjbvyNbIjUB+q3HfZTghlUFyQ=;
 b=PF43qTififwjcXJsXJOD3gXoOymbNv1ze4bqNcgFDjb/PnkpWSOyQOUsq946gDd23ZgIQJsoM
 8st4Kt+ZMD1Ct2LLvC7TEkMvsesO9zlX2vYiCfBfyUPrpy3Bfu1SKr1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=10 phishscore=0 bulkscore=10
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iNAVkfhIxJG3Pjo41fOzCBnfHGjXXDgg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX00oeOCOjzVPT
 rDygU1nXTLzG7lUXG1wGum0iJrufdtUxoCoqbJv83taR3bQK6lZOODE6u+hgWNY33LitkaZDHHR
 wEjGWs6p7C2lJgsq5tEYlfI3VXV2quniw8IVt/wnLITHVCYwzDCu
X-Proofpoint-ORIG-GUID: LTyOsays3og4SrjCFyhG4zC1JaRcDeVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX8AQifOpDmWPZ
 S3FLn2/+feTlLsZguSTl9TT6hJKJvjmAwV9xRJb5QF9MG30TCNLR1DhufJnmx7Wh3nVfVvVakLV
 8Y+VY3zYm/ferU2e3sgaCkOOiik60KLPCzRNOxnjxK7SGX5ptrS2KW8XBPuNplrVvMg7hx9ksjc
 1Yu6bT29BOGSfr54tDNBeT8RG/RpGLbYfYEHT2TeYEcUlnNaH6O8v1WQbRc9H6uEbrHJ5E4hAB8
 qAFfhZllpCE47sPU2MkQ54HIuhVJSM9ECYHbC++filFAsdUuHcMJJFgAiS1AxEiTcpU+UagheHb
 A7IemWXZ0lrZNl/AY9Krk5okzjS6j3sJqLnvsijD75iZLfVk4tTi/O8Al23AAMWaaQ6lK6ilRa7
 KURCj6V8Wz5rkjA02ybe+PPCP+71oGdxpz/IC9AUSjO+NUE9tqaK81TfaNvQYkaU79EH6qF43mO
 nglXNCDDytA4qhaTv4w==
X-Authority-Analysis: v=2.4 cv=cpQOAF4i c=1 sm=1 tr=0 ts=6ae470cb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=dGUJCdGidsCb5_L8LY8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=10 impostorscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.22.0-2610190000 definitions=main-2610300041

A shrinking truncate zeroes the rest of the folio that holds the new
end of the file by copying from the zero page through ecryptfs_write().
Zero the folio in place with folio_zero_range() instead, the way the
truncate helpers in other filesystems do, and encrypt it to the lower
file. This no longer bumps i_size to the end of the folio and writes
that to the metadata before the real size is written. It also removes
the last struct page usage in ecryptfs.

The folio stays locked while it is encrypted, as in
ecryptfs_writepages(), and is marked not uptodate if that fails, so a
later read goes back to the lower file instead of returning zeroes that
were never written out.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/inode.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 525297c7ebd8..2d6f4f440f65 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -718,6 +718,36 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
 	return lower_size;
 }
 
+/**
+ * ecryptfs_zero_tail
+ * @inode: The ecryptfs inode
+ * @pos: The file offset from which to zero
+ *
+ * Zero the folio that holds @pos from @pos to its end, and write the
+ * result out to the lower file.
+ *
+ * Returns zero on success; non-zero otherwise
+ */
+static int ecryptfs_zero_tail(struct inode *inode, loff_t pos)
+{
+	struct folio *folio;
+	size_t from;
+	int rc;
+
+	folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT, NULL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	from = offset_in_folio(folio, pos);
+	folio_lock(folio);
+	folio_zero_range(folio, from, folio_size(folio) - from);
+	rc = ecryptfs_encrypt_page(folio);
+	if (rc)
+		folio_clear_uptodate(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+	return rc;
+}
+
 /**
  * __ecryptfs_truncate
  * @dentry: The ecryptfs layer dentry
@@ -739,7 +769,6 @@ static int __ecryptfs_truncate(struct dentry *dentry, const struct iattr *ia)
 	loff_t lower_size_before_truncate;
 	loff_t lower_size_after_truncate;
 	struct iattr lower_ia;
-	size_t num_zeros;
 	int rc;
 
 	ecryptfs_iattr_to_lower(&lower_ia, ia);
@@ -788,19 +817,15 @@ static int __ecryptfs_truncate(struct dentry *dentry, const struct iattr *ia)
 	}
 
 	/*
-	 * We're chopping off all the pages down to the page in which
-	 * ia->ia_size is located. Fill in the end of that page from
-	 * (ia->ia_size & ~PAGE_MASK) to PAGE_SIZE with zeros.
+	 * We're chopping off all the folios down to the folio in which
+	 * ia->ia_size is located. Fill in the end of that folio from
+	 * ia->ia_size with zeros.
 	 */
-	num_zeros = PAGE_SIZE - (ia->ia_size & ~PAGE_MASK);
-	if (num_zeros) {
-		rc = ecryptfs_write(inode, page_address(ZERO_PAGE(0)),
-				ia->ia_size, num_zeros);
-		if (rc) {
-			pr_err("Error attempting to zero out the remainder of the end page on reducing truncate; rc = [%d]\n",
-				rc);
-			goto out;
-		}
+	rc = ecryptfs_zero_tail(inode, ia->ia_size);
+	if (rc) {
+		pr_err("Error attempting to zero out the remainder of the end folio on reducing truncate; rc = [%d]\n",
+			rc);
+		goto out;
 	}
 	truncate_setsize(inode, ia->ia_size);
 	rc = ecryptfs_write_inode_size_to_metadata(inode);

-- 
2.39.5

