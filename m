Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356037;
	b=UKt70P6x9wZ9xnr+r2qcMBmYrTt2RsXclWNBkJ0QGg1rh+oHh2CnsmujL/wxLu03sJuH
	 mwz0Sv+b5nWGK8FW9f8dq/mit8/JvSVUQ7k0wfXrGshsbeHVj/wuDkUuAKhUCdro0XriR
	 pADX3mQVDPM+QiyAdoz9XXPg5QG4pe+MTmpvGhITTgcoBBFRfP59DzjnO4bFR0m1FVw4d
	 wfF+bEGVuJIWUNrtRtxcHHBg2x10mGm2KiGGITTwHFDPIgfMiQ/IF0fvvsqc0VjunkfoY
	 ev81kbPXI7QudGRENALYWPDAOWsCLgUUvfLFfOmnkY7EGA0dviynJeHjietKPZ6ERMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356037;
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
	bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
	b=EtJpAxsymWc/hzFXWEB2Jjay7p/QGE2ZcQsjEsklcwDqqopFI+ujSJHbYmhI9m+JE891
	 8lQMhggU6Fj8PUmIsiMfg8/TMUTYg7WYmGiCuY3Mhfn+Me/6NJ8Vf1r3Nf1bykQQ9EZpu
	 y7Wolz3LrKhdeKMX8EuciK4KdCAgs4tVPGSfC2jef1dGXL5sIOBcjJuMpatWvy88TGnsC
	 ztLqVt5qtNUM0zUpy9W4lpU40LZM8Mplgl+qvpOJZSxPGvyw/oGcnySjw4tmqAW9tQPy8
	 g6vJqXzQiZCVN5ZkplEEthtUGKlO72VcOOrHW6UqgkvPb2UsFfdcU2bLcGBGDAZUeeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="QJ/IO6d2";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="VP08X/Zg";
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA293606A31D
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA293606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=QJ/IO6d2;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VP08X/Zg
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U9cbun4014566
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=fvdZ
	2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=; b=QJ/IO6d2DX/9Lryq5nlS
	mRi4jxNtnkLi8fxI8QdwAt0B3RL1ibRgIn/4E8XX/SHBSRfpIRCGRmJhFP1AJM/5
	knwWSMC+lKSMdFVmeIlhzKOTNsk3S2LBPAgfNqI6bcYTeylg6osNMcZ2d9HSnJHk
	DQBA541RR9RpfyCTGYIt7wQbXHGa8kXOg1fHblDUnAMI3TBkGf59YZAdKwCWVReN
	VGoUEl+5jxnRo1NRxmUzXK3MmVPwQSGgQXBpmSde/rxCF7AsF/KWs+IhvDoJ2WK4
	7jHDvzUE0lZz4KQlEme5NEAmOrb/obWzh8ct3/cU7ax3KPFen8BZhzK0VaY8h6IR
	9g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hm7tt0a0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:55 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso156623885a.1
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285514; x=1793890314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
        b=VP08X/ZgFVxfzFmuwyx3aYs+6+VnxGD4HrxYXBvdDqJJeTzjv7DMUR0w7y3S10N7ro
         ChOSC4nxlDsydDKDA/qMfCNAMC9JZs621CRlnPUYz39jC8vjGrzlU9aExBW5UWIBfWWa
         ekPFZc3HtJ7EqWRE1LXsx7SeFegPXu3LKs0QfU1maogZhOGnw6lW5m4nghBf3ISZJa/2
         5edWUQPMfDYh75nvUPwEIfeQJKInEaRlSx4wBRlgIMEYDcxW2l+5T5R7vqLfpl49pPNH
         tCW1kb5vgmpgX8Czoi94iktBybZEloHQUCHJ2JfNcD1ULrb2WzBxzYkkRSN8TKVwYEay
         UIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285514; x=1793890314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
        b=iW7Bh69DcOxYixMlBl3FUTIvjHSIEhli2fxjGIKXh8rQ9gihKkHO/41mEGcyfcGm7c
         ZAE3ttzxNwDDioA25vclk3GAPpsIgnRMq/LBmchOd3aoQ9Nef0BUw25cmTRlk6Hd/Krd
         PYBqY27O5RCZ45HwvvN0b7VoBSda1AZhF2bXLDQtjGjOP21NWoLj3P61up57h/kS9YGA
         EwFyKSHcL7jKSeIfeP7XfugiDDKaWv7c63C2i3bTye/1Ff4qVwjcQcGGrpDG8576MIPA
         avwfhbpvXstU5JZnFskJWvDslDGQBMExS8frYCKee1mRCmEb9G2xOo3SfyzziqzIBqCY
         H3LQ==
X-Gm-Message-State: AFq9FYKLRGeVJQipn+X3JOUBlTfpzQ6FrWJ4pZXiveaxAXIg9f9zbYlw
	oI3N70i7H+8DInvXexAYYUdOjTGpjzHFaZJnjPZF3knOpg9wkiSpOqXGD+23sxCkUUaI1e/uK7p
	A0haE/YXIlRIibCyyrh/Dc3IQz88hBjs0oq7xvNucD+8MTNfR345m33ysq6HrF8d8Tgk=
X-Gm-Gg: AYBFou3AnSxtOsWsUlcOqgQG6YGFx1skhAqZGputL2Fs9HtSQjbVLtWAtwKe582prQW
	oMEaBG++xzfpqJJ5Pscg2Tei7xIGhRTVGcOIBdP524+eso5VMdMzIGT0teNpj+ctmmr5avgvVDZ
	BCS2aiVVwEpWITfGDxvqmJpSyeaF54L0kmYgB+2sObqoh5pnkiVMJXi23hGUDy7K2D0358n3al9
	RW20oe70cIoH4bvIh0zifUQ4E3y/kao7Y8Ep5U8BFMz3wZQpZagewEj3ruLHXr0xmn9hoU0BndL
	f23+jjqwAGsETo/PM3O/uLd+zjnjulO5JRrTyQiYHP3U0Y+hJFbHHHMguJlCWejycHjsegfnpUX
	XG9yKvhC++sWElp5nkHcg/PLy01+Q/0bmk5DkxaU1f/Qm1MbPw019lNKBLB7FXmS4TQQ4Iu+nZ4
	zJP1QlA5mdxKzQczs=
X-Received: by 2002:a05:620a:1a19:b0:93e:e111:2778 with SMTP id af79cd13be357-944133591eemr413699385a.14.1793285514148;
        Thu, 29 Oct 2026 07:51:54 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:93e:e111:2778 with SMTP id af79cd13be357-944133591eemr413696085a.14.1793285513645;
        Thu, 29 Oct 2026 07:51:53 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:25 -0400
Subject: [PATCH v2 4/9] ecryptfs: use a folio and a buffer in
 crypt_extent()
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
Message-Id: <20261029-ecryptfs-folio-v2-4-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=6214;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=An8YAI40XTeu7sFYJ7stWLk4oSytgbyqmqAEZJZ4u6A=;
 b=+n5y1ufKS1plUMz00VQ5uUcrV8EZTGGn0yJVgHU3+KCNE99J01y2pIP74Fz/m2pkaeX7WOSPH
 rmyNrySnZQ4Dr5Hk1lOmP7Fe3xWLkcAnVMQcXLxQnjQHcycv2eq2x3M
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=10 malwarescore=0
 priorityscore=1501 bulkscore=10 impostorscore=10 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZORQNMYqiLdH52UIUefj2PXCzLk3yhfX
X-Proofpoint-ORIG-GUID: uGNGqbxjPHrFHd3xTKE4rhVLQmTFUdh4
X-Authority-Analysis: v=2.4 cv=GfuCDgXL c=1 sm=1 tr=0 ts=6ae47103 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=YUWrOzf3Fweq1H2EzuoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX9hbuq/LLsX9Z
 kbAI+4RVQyRK2+fW0sCYiUX4mj2MHgSOI5psFy0L5IhodLa0U/mhkXLP5JuflnehXT/Vf77ksyZ
 B98TBMu71/MXt8n8TY2rfLCpUO05kHZScyAZs+a+JeEk52XDDcXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX9+DELMUKFEa9
 +CuBMBFcnxlTIqakacTcTSjImeBsqxvhdU1YGF747exJvd625f6flP2idpP1692AojMOEAS445e
 TWrCP0ubneVfVAK6abkyTkFEboJphuGyV+aoN/Y0w22nYpYYmCmp10psQVnaVcxFy/9ACs4rxxv
 FQ1fqURq81XtCGYvR74pP3E4lhYlr3dTnKZ9RMUq7V/uk3jQm/7HygIrH9pz5I63UotzISb70of
 qA731rLAbak89+R1bKzjG+5rups478FSas5irLXrQ7kExQMnudPcYdBTyA/LtjTTO6Bv9r/1n6G
 Ua6K87xmUf2m30P0yDn7LjH/VzgF5BApxJ7h1LTfgBVkQDzgulM9V9X6bDszQjwCQZBzAC2iFhr
 GxK1s9DXdfIjwVrM1VQYTrC7R+90ITrGL/oyF7yaInUa8hlVLGetXpsy2damWHxQBdqUXm9kXhf
 WXlhmEfHnAsysNtLmVw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 lowpriorityscore=10 priorityscore=1501
 malwarescore=0 bulkscore=10 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

crypt_extent() currently takes its source and destination as pages, so
ecryptfs_encrypt_page() and ecryptfs_decrypt_page() have to pass
folio_page() of the folio they are given, and the ciphertext buffer in
ecryptfs_encrypt_page() is allocated as a page to match.

The source is a page cache folio, so pass it as one and set up its
scatterlist with sg_set_folio(). The destination is not: it is a
temporary buffer that is only needed to be able to write to the lower
file. There is no reason for it to be a page or folio. Convert it to a
buffer instead, with NULL meaning the operation is done in place on
the folio, which is what ecryptfs_decrypt_page() does.
ecryptfs_encrypt_page() can then kmalloc() it and write it out without
mapping it. Allocate the buffer with GFP_KERNEL. There was no reason to
use GFP_USER as it had previously been doing.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/crypto.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e67119b6029c..9b8b0c5a81cd 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -271,8 +271,9 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
  * crypt_extent
  * @crypt_stat: crypt_stat containing cryptographic context for the
  *              encryption operation
- * @dst_page: The page to write the result into
- * @src_page: The page to read from
+ * @folio: The folio to read from
+ * @dst: The buffer to write the result into, or NULL to crypt the
+ *       folio in place
  * @page_index: The offset in the file (in units of PAGE_SIZE)
  * @extent_offset: Page extent offset for use in generating IV
  * @op: ENCRYPT or DECRYPT to indicate the desired operation
@@ -282,14 +283,12 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
  * Return zero on success; non-zero otherwise
  */
 static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
-			struct page *dst_page,
-			struct page *src_page,
-			pgoff_t page_index,
+			struct folio *folio, void *dst, pgoff_t page_index,
 			unsigned long extent_offset, int op)
 {
 	loff_t extent_base;
 	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
-	struct scatterlist src_sg, dst_sg;
+	struct scatterlist src_sg, dst_sg, *dst_sgp = &src_sg;
 	size_t extent_size = crypt_stat->extent_size;
 	int rc;
 
@@ -297,14 +296,15 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 	ecryptfs_derive_iv(extent_iv, crypt_stat, extent_base + extent_offset);
 
 	sg_init_table(&src_sg, 1);
-	sg_init_table(&dst_sg, 1);
-
-	sg_set_page(&src_sg, src_page, extent_size,
-		    extent_offset * extent_size);
-	sg_set_page(&dst_sg, dst_page, extent_size,
-		    extent_offset * extent_size);
+	sg_set_folio(&src_sg, folio, extent_size,
+		     extent_offset * extent_size);
+	if (dst) {
+		sg_init_one(&dst_sg, dst + extent_offset * extent_size,
+			    extent_size);
+		dst_sgp = &dst_sg;
+	}
 
-	rc = crypt_scatterlist(crypt_stat, &dst_sg, &src_sg, extent_size,
+	rc = crypt_scatterlist(crypt_stat, dst_sgp, &src_sg, extent_size,
 			       extent_iv, op);
 	if (rc < 0) {
 		printk(KERN_ERR "%s: Error attempting to crypt page with "
@@ -321,7 +321,7 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
  * ecryptfs_encrypt_page
  * @folio: Folio mapped from the eCryptfs inode for the file; contains
  *        decrypted content that needs to be encrypted (to a temporary
- *        page; not in place) and written out to the lower file
+ *        buffer; not in place) and written out to the lower file
  *
  * Encrypt an eCryptfs page. This is done on a per-extent basis. Note
  * that eCryptfs pages may straddle the lower pages -- for instance,
@@ -338,7 +338,6 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
 	char *enc_extent_virt;
-	struct page *enc_extent_page = NULL;
 	loff_t extent_offset;
 	loff_t lower_offset;
 	int rc = 0;
@@ -347,8 +346,8 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
-	enc_extent_page = alloc_page(GFP_USER);
-	if (!enc_extent_page) {
+	enc_extent_virt = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!enc_extent_virt) {
 		rc = -ENOMEM;
 		ecryptfs_printk(KERN_ERR, "Error allocating memory for "
 				"encrypted extent\n");
@@ -358,9 +357,8 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = crypt_extent(crypt_stat, enc_extent_page,
-				folio_page(folio, 0), folio->index,
-				extent_offset, ENCRYPT);
+		rc = crypt_extent(crypt_stat, folio, enc_extent_virt,
+				folio->index, extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -369,10 +367,8 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	}
 
 	lower_offset = lower_offset_for_page(crypt_stat, folio);
-	enc_extent_virt = kmap_local_page(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
-	kunmap_local(enc_extent_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to write lower page; rc = [%d]\n",
@@ -381,9 +377,7 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	}
 	rc = 0;
 out:
-	if (enc_extent_page) {
-		__free_page(enc_extent_page);
-	}
+	kfree(enc_extent_virt);
 	return rc;
 }
 
@@ -432,8 +426,7 @@ int ecryptfs_decrypt_page(struct folio *folio)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		struct page *page = folio_page(folio, 0);
-		rc = crypt_extent(crypt_stat, page, page, folio->index,
+		rc = crypt_extent(crypt_stat, folio, NULL, folio->index,
 				extent_offset, DECRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error decrypting extent; "

-- 
2.39.5

