Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5E33939D
	for <ecryptfs@vger.kernel.org>; Thu, 15 Oct 2026 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028174; cv=none; b=GqRA2XiE9P5NM1ee/KFcdaF4j6lDjuQ7zRJZFjxCyR9GsSJe/xX2y4XyGaRNHrURF8XZlY4A5ot/tc+GZ4Tfiq/YjX9Bd8XBfBEr5Bd4WT3NCbvqfwikCp0VlbLrOeTGzXvBfQfTdzxzDmuHddPh+Ick1MdWd1mItP2is4JGwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028174; c=relaxed/simple;
	bh=An8YAI40XTeu7sFYJ7stWLk4oSytgbyqmqAEZJZ4u6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNc6SJucLSLThZS4n9vWpe9DzsfdQybRxjEwroLFfphT5BEBVWm5MmX93/T7et0a3QOVxHPpHuaJyKpDkeIIeXMXXOqyPt4xFF2BE4XoPzdBtNFszhnndJ+iRmNh8z+usL0PnRQxLfbb2VZwgfKhA/ooXp5S+l2J/LPgZtjELF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tooQikKC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CiZjwkaw; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tooQikKC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CiZjwkaw"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0Y3wm3200229
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=fvdZ
	2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=; b=tooQikKC5d+k3ypVtZlv
	7Ao9xbvTFDAxExLaVkGPYmL4V8RdxhP2P8/irM/fNAmKZKSNuFYzIpeE73Ma8DH8
	rjyCn4rE16dvX3yxWzSsN/qC0IRNzsTYdyvVl/+XmNfJHkuOy2Xattwj0tM7iNnw
	AyisDNBEuZDdeDdJ4hK+wRd1cCqZ7ndutt1DjJT2LsTAThdGYKLw4UCj9Qo1u8Im
	TOL707krS5Emn10qaarGmfAWzjSXvEcyFBfnS0JcxRU6K1KT1JmVRBwgWD1OKiyI
	ybRFMuE0J7OME7W0cWcSKCZpOLHxuct/fhWZwnnSCLhijj7XKsWW1FxUE/iosxQB
	kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hah571h34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:09 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535252004e9so112845081cf.1
        for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 18:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792028169; x=1792632969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
        b=CiZjwkawGs8W4kRAv8aj6zk55VltGMkah1Dunsx6zuGHrYQu4eMxQpKJ6Whf9NDEpX
         iD3RVEtkjXJeVBvn45js2Toyz7qCIGblqvrhSDQ5v7rlHDuLLFL4AopDSJjjM6DYxO3X
         yeEcnPgDH0agFYu7Xu0hJRjsiHCeGeKO5eBRqD5T9AAZrBOgksvGlWveQJMHUHYDsnyP
         uQ4tR8l0kdGjYbg5p7ABcMO0YOCj2u3a6xcVfYxshnmnGhVsnK0t8NyulQu/pFUOxDdU
         fzXDQiwO2nKdOQsh4mA+fCKRHhTDM1Gx2nzegJjA4RD942sPgTPHc58eG3WNkXNKGemi
         plgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028169; x=1792632969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
        b=ZfN6UfiFA4FhrWlp5g2kyxSbFEbnEhhbLe5lc6w3JAw0eZN9c2Qljs35jkShZ43kDJ
         GTCQTr+xU30A7+CksosCRgYNRwGZcsZDXrv3DgWpkKX6RW43/0IGgmt45Q1xpQ4UinUd
         3R2Ot8qqV8M9Y4FQvtl9T8ZRsf7cSeoP8kB5tCsoCNIiq5i1Y5i83Z1lrIIZ79wPdr3Q
         JPi/9TO8RVB6jmc/Mdihv10XyCvp5OT+T8uUkaYjJMd6XecEC0GmATRPZW9WfBxPKjje
         I7m+PEgbyRdktOx72zD+1LFvZKpMLrpv605oJRhQWWXBaoXMNKjROY2Qq9e/oQx8hIYM
         pMDg==
X-Gm-Message-State: AFq9FYI1r1n+dy6EhffHPrHWZ2tt7EE1DnjNYglxhfFKTjEXOYhRsYOW
	hvjuqHc04xBJTs6FQxR8G4o5z4fjfvxCZklMiY/chwgcGRmwmUeuCkk4lHPxpn1nSSDS0U4avI6
	ecAh5KNOI4BTIMsiYATWZyioKGWDKKJgwozAroU2m/InHtZA6DdRff3mz
X-Gm-Gg: AYBFou23aSh/dQWhr9xO/GWlg6BuR23p27TsiwBixKwKSl9Pf4l6j7aVoe14Jc2MBJL
	vau1XmfH9hzsRVhGMofzzn3z+wFekhL3KJ+W3E8FBjBgFBfMReGeJ5wAqDXrwGozyaEoMkhVKr1
	VxRE3PQBHpDga0nwMIYRq4ydLEFgdIgoScUaakH6Px/qyMSLzi6Gscm2/9FPDa5VCCDckSOaY2b
	xmpIvnIGk04YTt1pSCjtU5jZzP+X3Zxl7U5nPh49q9lVp0Dvg69Lrnt1ezsTJfMAu3sUbQ9Cf2U
	qVlCV+JoPvrYxTusV4lZkG1MMDuDOjhOURI8iWYd0asgVriYlnBmqW5gJmSfB153p3rV3td13pb
	KouYyB5gq3XQDveDfV9eoyQjOhLWTerjWBMBL3U6JdiHv
X-Received: by 2002:a05:622a:6f15:10b0:536:141d:d427 with SMTP id d75a77b69052e-536141ddf79mr11219281cf.73.1792028168568;
        Wed, 14 Oct 2026 18:36:08 -0700 (PDT)
X-Received: by 2002:a05:622a:6f15:10b0:536:141d:d427 with SMTP id d75a77b69052e-536141ddf79mr11219151cf.73.1792028168085;
        Wed, 14 Oct 2026 18:36:08 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361279a933sm12657661cf.6.2026.10.14.18.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:36:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 21:35:46 -0400
Subject: [PATCH 2/7] ecryptfs: use a folio and a buffer in crypt_extent()
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ecryptfs-folio-v1-2-f4412187b1d3@columbia.edu>
References: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
In-Reply-To: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792028164; l=6214;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=An8YAI40XTeu7sFYJ7stWLk4oSytgbyqmqAEZJZ4u6A=;
 b=LYKjOjwmbIz3ivsTr7kWnMva16Dx39m8Xc//LzUCDhWwSP4cgk7ihhqyUXCRIvaJxoP3cny1k
 J/ImKSK/UZ5BGJzZHVfTNhI4y3xihDluTBMkMGCxGyiQPRHu8msu3p8
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfXysWTsEfEbu4H
 wPJmFFHttzkYerIEVhCO4lemlXBEzUWNUl6jZsPddIjiGReCBPOqsvK3+vOcFmvTLvrC956qu+T
 +QTK/Db9gTHebTpNY1Y8tc/822+Jl3kxhsLshh10dmghSwRA6Jy/CZWy23jgwowGwoOQXZRfVMK
 0Ye4bqMlQmQSYbP+9lT1UNiJNDowENd1DtLeP26fy3J2Ik5mbRVqsBU+kYNLQ6jJXbS1024NbSG
 /8KXpYoFVyQ8qihKTcurnfw+0QLKhLQKy5JDA0EcsC4nhWU3qehWwEBz5fSSvZUrLtrwdmdpt6v
 SgCGAu3M+1Bj56pvgLguEP99pUo3t2Pjehg69xfUQ0V4fRDIZErUy0Fny422HLVrpqPopgizl2p
 lMbfpuXbNB/WoDxHnPbnXL/NY/5Edz6SncM+a8zOLE8wRWUqGfNsj5eiRtNpNqR/YbfRjMfT/Iw
 8YiH7L8C/LiTlR2iNyA==
X-Authority-Analysis: v=2.4 cv=ZMJCCn7b c=1 sm=1 tr=0 ts=6ad02e09 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=YUWrOzf3Fweq1H2EzuoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: WP-kawRqkq16mSBp-12TNDP3yMGUIGA1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX4fZx4Zs6Tgaq
 yhr0kz0MRxvqTazravVCHcBxUSWfQOoVJvhCmk+O+4IkyFhYZkJkmowh1jsGE0C/J7Kv1GVUhFa
 a8yGMbYS05zjX4sJO6CF5YScBgtLHvA5gRt5kkHSPcNj8gjrxrTo
X-Proofpoint-ORIG-GUID: WP-kawRqkq16mSBp-12TNDP3yMGUIGA1
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 impostorscore=10 lowpriorityscore=10 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150006

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

