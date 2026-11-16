Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866909;
	b=3HrJSJtI6KLVIdru/rwkLLH8nwCpEoRz+V2qG6Yi3yY709IY6vfwveY20jOfLe7Q6275
	 h/Wh3WhEtbjqptFmbn47C24Dk1/Ne1X7tX2jJZw9kT/8Cuv2Xhe7He0mUGnO9YWsus7cg
	 pvT05/8OFuJqhzlxDM6ZXEomh/tq32j8Vxw6NlUOt0pUxq4xI8FEd5eegDgEx7+BrA38T
	 dI054njIlefnXoMKa1tJ0Qz4fQSAhmlPa2RGgdV0m39lpNyBiEhcWmE+gXqD4h6+5KdO+
	 zW3t5Y031ebAjFtHu5h5lZ8r6NS5BNIoIwI1IX18iklR/0PyYfY3xVRwMV6NhZf5aFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866909;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
	b=ULU+Lu4EqMQovvSQ7uo1JM6QEAfUFgcLYAUrH9Bp8GaEkmSh5Eajy3mHrMxRrl+iVmk+
	 TnJvE8qKfeOkyraTmnXGvpmK0F5KNe+Z4zbCAHimMssfpl3Lwx6MqzGB2eEUWHhKH+SC1
	 NQP1jZSrnN8gr0UeSgj21jr+1Kmh4iL+/ih9hwtbIvRQ+IDsrIO+gsPlXkEuPsC5nDwpB
	 Q9NKsOwuqeEZMjWEPmdEI7M49dB/BE1tWbBKIP7WNkZZEzomRJiepEaqkQSSQgxdIclbH
	 ZJMFBRcDpL0MWi8NpYpesBUvRL5qO2wyIjEhStjY3iQwlKjr9cLniXPTvHriWb3H5Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=g1uYpVHL;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=A5bNOKur;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E9606A894
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 277E9606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=g1uYpVHL;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=A5bNOKur
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLZ6B54119755
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=fvdZ
	2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=; b=g1uYpVHLXkmPtJxsznmb
	m3sbjsW3kye1M0hAQx6FurwADTFhnoci25vpWmip+qK0CIAW9LEsGjmS4a5U/rGt
	9Ja/PLFTxqhlk/y/bVOF00YEJhjLJ3w1cH5xywFrdX/NgCmVRS5bjD9MXKsiRoTa
	Ul0ZoqShg+7s+OzZL+Mzw7bECYPAwsgJSQWv15LbiTA8hd+0xWKlTRdmvVYNC2CT
	rpNF5MCYOih13SQCWD7BxGb3vHUQ7q7Kny0tw+Mf1V5i5cfq5SusuMUcTr7DjsIr
	Ph1iCGvLeXITbk6PXhB2+Cw7bSjN1xqhBTWbDlh4Ba5S9Sn7O5QYWa76biBW+7uL
	uA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598uajn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:27 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so1111682385a.1
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866906; x=1795471706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
        b=A5bNOKurBe67pZksfY/cMKRFnYSTWkd43Rr8wfcrHW9O+IcVXQNy7/Yp5SnW7CU152
         eLiTrIP4SYYm5OzBw5YCmasugp5RJdzBQowX/o29vFo8+vJ+4+KitwAEY6ugagR0I1kc
         xcHrFS6rtQgRcO9h5DmWO8WCXKBzdDUAMay1NQCcUn061tzzmwOOaJzrFmXwi3+VVmoo
         LPT76Al1RX8ltHk7+zMAC9m4zImg1K72wZegXL7sIx+UIt5b2oRkDASLpTXepNnTFm+G
         /Tjx55S7x+C0I09Pj5xhNlqgZeDQPLm4g+f+I/dUyyBfPmLNHXlprS/Z2/GydCfvfyLg
         Lk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866906; x=1795471706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvdZ2wXoPKfuFGzoqROpXRZBlZnCnmXihJIuOJE2Ti0=;
        b=bMjwd4ZN5ZaQCTs6v2ttVO7GI6vvD6pR2QOdSJLOpVmXD6+eLPvgxYwlcUAiuqqO5g
         LPCnnastL8e1wNOVfOtbIRusnLqNzfpryuts8WbxRPfXrETbkfZO6y6GNHE/xZpzOwH0
         1fF+BuPMjxDErksNs1x/lXC+Tc3QqwPCMLQf88DCl9MVg6l7reayRFGh68V+jH8Ry7dg
         U/EpzSLe0h7zT++go1dHlSH7tV7BWZ49bRoqprGJe+2Cn8YPYYY84oyF22JIccRgpgCq
         t5RjUSnn2yx/rySEQMVIKHM2JYmQdXqGtRynbCQClCxcFPwPlQNJ8ieocYtvI1LZIyFF
         BquA==
X-Gm-Message-State: APuU4Z9C6Xhd+pfpfkv846mf79WTosJykR5bjr9TMCISGA6UtggfFrPZ
	+USZ0MPIjpOO64dsiIW4PbtbGBCHkVYQOhSh1hQ3kZg9reNYdhNwMz52DgasSd9zg9tof5FPA+y
	RfGzqwoKEvRVHAAe7qNzJRth1DT64sJHqA+rV2DfC25m6uRpXYtEok6MB
X-Gm-Gg: AYBFou39eiQX2Ayx9V4lBpmzPJ41lgakE8rWXD17dQvgJm35fpHGT/X2DTKn+Pzo2JI
	mj/6BD466/b0C1G6CJs4lo0OAVbI8CYMl7uQtWZ0e8KNr1hfUVIC6uAjkrL29yx2oJHnXK5UWUa
	RY1ButnFRfDPnm9GKobbZNIAYdy5u2AgzCfwvBrQOYdszv1n12YVw2kP4uZPkto9Dd6bcoi6GgU
	+YbPr1pzPJoNtNt1JbjBBZrkeLhEuNpd1bNcxganC7CoVwz3g+aYDVV5XM9ued8wkTJVd18uz3i
	kVAC7E2o+aC24ThAG91/XEljg5MiK0QvbWytGsD0hvHqLXTSz6W/xpm56DO+iRYlmWUfTd7lhdE
	14EijjpDqCSITJdwsMgDVsz8wA9E2/gNB984AMQHIdwV+fdHGNl3YWnMWIDWmVN/+CLsJeQUUUM
	j28B5Q/0Asy8LjwOOK5vpg
X-Received: by 2002:a05:620a:2a14:b0:93e:d364:c9fe with SMTP id af79cd13be357-9494bbcc105mr1932853785a.40.1794866906519;
        Mon, 16 Nov 2026 14:08:26 -0800 (PST)
X-Received: by 2002:a05:620a:2a14:b0:93e:d364:c9fe with SMTP id af79cd13be357-9494bbcc105mr1932850485a.40.1794866906155;
        Mon, 16 Nov 2026 14:08:26 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:25 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:11 -0500
Subject: [PATCH v3 05/10] ecryptfs: use a folio and a buffer in
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
Message-Id: <20261116-ecryptfs-folio-v3-5-1aba8e620eda@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=6214;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=An8YAI40XTeu7sFYJ7stWLk4oSytgbyqmqAEZJZ4u6A=;
 b=7Ah1h4r4BRmc9DuQpyrYdBIEaGwlai3KMDIgA6XdL/gE5E31HW5pauE11NiiFROalnsKusdyK
 aHwj7d1bBjVAljCO2iWCItcKJaRbvQwDhK7nGXHyQgFvztND/x1ZXrH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfXwU1JTEmZSUVx
 sDGcKt4Q6Z80ouxXInINDebETuFcGbz+ZFG7+VEq2dh+C2QiyMVm/5PK+zvJJFHEXdpJGlxMGN3
 qgC3+0vNAtj6G8oQ0uVw/7xkGk3SdaLwu8cTyV2KWMvU9Fdpu6Oa
X-Proofpoint-ORIG-GUID: LKofSb2JYAxn_k3JdbDCCkLaxu79p5Sm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX9cdND/o+s9U1
 iKeWUDWsoYUEVl8Dtr2hckobeoHdT8v+Zu2iytTNSG2k/mPTetBNAaJyQ1r5czp3xBhdAUawt5K
 HM1Gz4Hibc4h2Gqd7OkcmkknXp20ft9lxBVX/HqN3XOFU7azPzZs0KQEABGPzcnUKnvoh91Y+nL
 JHhPuBrsnjDPPv/OEw0WC2ElWr1ASmVWI12Hr0cwwgDrjNPRR8V7hokBJ7t720mLmdXMzFhX53V
 No6LC60ZnrMUyTMn0qyGySYBDtCXXTMAyBXfUhyKIEhdzoOAXqpMPBkTNTbizFEuxCLXlvFikf3
 4GiIJsjjKnAxDKVsC90qU5p3mgWkGA0ZHvuLrEpVCslCb0EyJ+zFBH8fNRfTyOwoT117mT4SD7H
 54qTE3c0dLzlzFZaiCAZBH8czxHvNxg5sk6I4PP4nHr8x1qnms2YdoJ4MV2f5uE9ReNiE+oaEq2
 0Z9q2RzdFRuIDw76+bw==
X-Proofpoint-GUID: LKofSb2JYAxn_k3JdbDCCkLaxu79p5Sm
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb7edb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=YUWrOzf3Fweq1H2EzuoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

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

