Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356013;
	b=rHOODnYbd7xp6rGVD/dxry3H6IGfjA/onds8xX+r88RFHPGiRZaMEqDLdjnoUszWE3V4
	 TuML4Ul1NHkfgb/tO4uRMk8utOSUj4067S94CzxQIYNI6XTw/mMXedBCYDxZx4oIgwVf7
	 mT/tetnkqoFWY2+6DVrdc7BkTG8OlNriPARU8QZsqx+PvH1l8Q2xd89Hh+xtdBnUtADL5
	 eTuveRb4Hwlc40zvgZOsW3+9GyQs/ZO8THfMlb9uW8j6+iPAkHMp6W1YUHXcPFyrQWsT1
	 AnRQ8M8X31JQa5WYSutDJGcHxHjXNX5aEyaCQ9d/qZVVCeZD280+mgVGZLD7D9EFteQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356013;
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
	bh=TLCucmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=;
	b=xwVdJ6Q181Jnh9cjy60gl9+Wc4bWQ2aFIgAtA3VrSf77ZMEk4hC/75ZD2+MKdU02G4z4
	 p6rpY9/xZyQbRS0IHIfHkdoNKx/qVC3bgX+RmarS1UfZW9Y6EwcybE8QuiM6jcqNG6qFj
	 2cGkdkog5EKA1bw+wimDgVaxFB0mhG7fdOOBxsCka7ItMGSktCys5WBXhjqFhwjP0+WUj
	 XWR1gxas1E9eFOE3TO1H1azWhF0YPjGj4zgJAfscIPqpBztHJnQnD2bHf6p/FfyhtNB/d
	 FNVx9ntviwSiztF23koNhYQ2nnoiGO1Pu8Q/O+qS0eAE1XzAlwyviQ7ZcBfTZ8cf5Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="ZFQ2i/vq";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1WWcpU2A;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B4606A31A
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C9B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ZFQ2i/vq;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1WWcpU2A
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UAMsnN1239163
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TLCu
	cmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=; b=ZFQ2i/vqJB5DBB8UdZ0O
	TIQnwG1HIe3Cu45vAMoOwTusx5tGNrBGCv7gkjRvS4ifCrHsaza15ruVjRrOYURT
	fDf4oZSZREugswbTsVu9xFXpZtm/rP0ssUcJd3LqdhuNpbENjBsPbm1QR4LoqYcP
	Yr7Uy46ouex5SrLLoy/hr2Dkcc0Ju49tRWwZJSq4wGsZLLuQHJeBAi/HeMT18uB7
	15bnQ76fAF2PPxMP5E/MX65ORkPKaD0N3qAFOBdoXVUq8eAJkUEqscMTg/wngADZ
	iqD+hbF44wtpawd0TL8eDgpdWFXSXKH6eD7cAAgH9t5Eg9q2hCbiNaLTVGQdE7ew
	cg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hm4y6ss09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:59 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338974c0ceso30773601cf.0
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285518; x=1793890318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLCucmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=;
        b=1WWcpU2ArLEIn7Nu02R0pPDD12/wvqmgK8w9+91+nA4auq664YC8JQaGy0fDor1CMS
         G+ULhLGouHiBI7FcSXsNp07dbdGsYAiUyX8SRg3OVf5vTs+/zUPc+0Y1mhr+GMWKHh+m
         JgNljajHdGS6SXhEpXLtRJfNgj8Bsxghe81ZDEXPyXpbnkEnu8ss6oeOrBEKDZuAimGG
         pPE10sQEhwl6xqdPT1ENFv42D/8yWBRa2Ec9OA5XlBVVh8dJWdQHqdUNCVfsE5gKfUGU
         CqZRQEMKZP86rbJOK0ejI8u6pyyQ1C/19ZCCnWex/Nne+cNdmrrlamFHHulAkfCjRvVM
         KDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285518; x=1793890318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLCucmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=;
        b=caCRd9w9RN1XwGMNLz3rkuC0huG4GATQ76Xa4uCGYUnS1B/xjd1LUwiF929cmKdhO+
         7BY7Y8WJyYHOZ5hieVxKLR0dDrWnzClyloJ+BxQxWh+iHAftkW1SIZqDXJ7MFsXy9Fyw
         EQX9xe8VvNgfkDsRMKKI1GBCDbFpWexNO+Z243H3K7YKvP7wmpjHfxfOjVMCJB5XwOGR
         2TC6BbpGmDTcz6mKTE6FGaVFTzhtL65a5W6lWs2//6RlTCuaMZ6HbLrfVtxetmk2NCJo
         QIO5EpYQC51/tsz2JMhz+APJuPDMWUnhl2fCmRwV+nB2WHXUy0t6vFXtMRQlQ6h273Ar
         HTJw==
X-Gm-Message-State: AFq9FYK+9GSReGpNKAlKYJQFdjvwnbwMshDYw5xip7npm4eG+/hXxcA4
	7NVaDi6DwLh0WqRVjXFha5ci9F2/kv/6FIMithOZQJ3KZ3FPm4KbQyZA6H4xyullcqGtcU97Odh
	yE2MLRMjkx7KT2VWPd8BTE85VPhOqcmYjnVEnWjVbA4KeevSMiLH82U2SUMWigZDBTQg=
X-Gm-Gg: AYBFou2Z0SF4jb/mTCVr3v2MSF7pNgrDKcoVmfzGTF1Jeq2ZxBhCZVKC30Z4ElTuRTH
	7IbQZKh9lrcnJOj0XN1L3nCb0uZjj11KQ1sXlOsGJ1eImGHWSa/n9DoYwrqJCqXMkjfRaPkk7MI
	Wsh2CeAP8a2AKSop659SkKLkSk5KjtblEORVs6TcUEQKHWVj0iL22JoNP9ENM6tivTCiDiQelnu
	Ufm1CBkFhVbTumWllmB1hUNP7Ar7QizTocZxHo7zSdhaGchBs8bymrJX85kJy4sI4s0YbcIiIIo
	r18Ljr+rZFQR5j12jKtYADINa9qo0PXs1hDd3U4MDGoRy/A+tfcyrZxieHISJAkzIXJkwZnjokZ
	CPXG8GIrxBWXl0GvyEC/J+pzKpA99q0u7iWuQzk3/QNWyDzct045J41+xxMtAho6l8zipbO0ds7
	Vd
X-Received: by 2002:a05:620a:3193:b0:93f:2463:f784 with SMTP id af79cd13be357-94408de768fmr877074485a.66.1793285518334;
        Thu, 29 Oct 2026 07:51:58 -0700 (PDT)
X-Received: by 2002:a05:620a:3193:b0:93f:2463:f784 with SMTP id af79cd13be357-94408de768fmr877071085a.66.1793285517762;
        Thu, 29 Oct 2026 07:51:57 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:56 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 29 Oct 2026 10:51:27 -0400
Subject: [PATCH v2 6/9] ecryptfs: use sg_init_one() instead of
 virt_to_scatterlist()
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
Message-Id: <20261029-ecryptfs-folio-v2-6-dc53f1d47d9c@columbia.edu>
References: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
In-Reply-To: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=11895;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VlDnCX3i7mGZvNYBW4J8FKMLFtRDtsIQljRKRABgp+k=;
 b=Y+yVHxA8DO1e5hZPA0G9YqUs9z29AEcax9swsaDeqTKeQY7V9FMssiYNT5hxljZR1ELS6pHMQ
 KjCkdAEDLkZBysn/8rKW2Zl2FdTZ9LC3I24JF0ZDwavo1YQKmvmAcsO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=10 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5xLClIFgrWmDOidv8x3f7EmQIM6MGxHD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfXyAtQB6mq5gtT
 m8spXmplcs68yZzUd6yhrSdT3rFL6qpzF/STfMm41/Hcgwn8gfvHPR9LbC4fgqLUkgOWWlLkxV4
 7Ia4F1mzyAfzLJ6Bz6g34siRGrN1u8a7CAXjyHpce+kNcsl3lUsw
X-Proofpoint-ORIG-GUID: eQzOgSa3Q8JKJ6cUlXI24uTq4h0YIJDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX7FhSlutOx4pC
 /cwGNuNgQhPFxR2BmnyM2CMSYoDe54FDtnVPEbMuUWsimlC+MaRZ7waEbFftN0qYwTvrS2cUBoG
 /bkaIKlDs9mrVLtUhRb8i4NYARnYhg3Yq9iFbFMXwqkOJxo1DbpB9Rchwx0B0dpHNFfwSCgFkh1
 TLvPbbWXHuGXEmp35q0pu7GmLLaPnOYWGYmxZd5t2Z2RKtYZjiOUTVYe3yVFmCzD6VY8X6DhnYw
 qT4DeY3zZXzy4Xz7olH4sLPtS6Fj6hHrRoZxPP4fOE8sodmYbegLA6xbw4qOJiR8UA6zr4jZjoA
 qq/aAo8PRdwcjr2lM2CX71Lp5hfgVGvsLGSeQKBsuGhQbLWpIOQGjTsmMSDpvmWJeOb3WjJrdGz
 05lSSR9ct0aYMA2q9J9Hz6cF1HjLSEm+OWiNzs7HaNaTQM3h0QvcH6ItEObQhqxpSaLuR04C6QY
 /K39FIbeFmZhr130Ftg==
X-Authority-Analysis: v=2.4 cv=cpQOAF4i c=1 sm=1 tr=0 ts=6ae470eb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=rhbNDiOmHe9WM6CdvIYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=10 impostorscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.22.0-2610190000 definitions=main-2610300041

Every caller passes a kmalloc()-ed buffer or an array inside a kmalloc()-ed
structure, which is physically contiguous and so fits in one
scatterlist entry. Use sg_init_one(), which can't fail, drop the
two-entry arrays and their length checks, and remove
virt_to_scatterlist() and the unused ECRYPTFS_MAX_SCATTERLIST_LEN.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/crypto.c          |  46 -----------------
 fs/ecryptfs/ecryptfs_kernel.h |   2 -
 fs/ecryptfs/keystore.c        | 114 +++++++++---------------------------------
 3 files changed, 25 insertions(+), 137 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 6a014872e919..f0e67b48917f 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -149,50 +149,6 @@ void ecryptfs_destroy_mount_crypt_stat(
 	memset(mount_crypt_stat, 0, sizeof(struct ecryptfs_mount_crypt_stat));
 }
 
-/**
- * virt_to_scatterlist
- * @addr: Virtual address
- * @size: Size of data; should be an even multiple of the block size
- * @sg: Pointer to scatterlist array; set to NULL to obtain only
- *      the number of scatterlist structs required in array
- * @sg_size: Max array size
- *
- * Fills in a scatterlist array with page references for a passed
- * virtual address.
- *
- * Returns the number of scatterlist structs in array used
- */
-int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
-			int sg_size)
-{
-	int i = 0;
-	struct page *pg;
-	int offset;
-	int remainder_of_page;
-
-	sg_init_table(sg, sg_size);
-
-	while (size > 0 && i < sg_size) {
-		pg = virt_to_page(addr);
-		offset = offset_in_page(addr);
-		sg_set_page(&sg[i], pg, 0, offset);
-		remainder_of_page = PAGE_SIZE - offset;
-		if (size >= remainder_of_page) {
-			sg[i].length = remainder_of_page;
-			addr += remainder_of_page;
-			size -= remainder_of_page;
-		} else {
-			sg[i].length = size;
-			addr += size;
-			size = 0;
-		}
-		i++;
-	}
-	if (size > 0)
-		return -ENOMEM;
-	return i;
-}
-
 /**
  * crypt_scatterlist
  * @crypt_stat: Pointer to the crypt_stat struct to initialize.
@@ -438,8 +394,6 @@ int ecryptfs_decrypt_page(struct folio *folio)
 	return rc;
 }
 
-#define ECRYPTFS_MAX_SCATTERLIST_LEN 4
-
 /**
  * ecryptfs_init_crypt_ctx
  * @crypt_stat: Uninitialized crypt stats structure
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index d828040ade89..301744f0f819 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -544,8 +544,6 @@ int ecryptfs_encrypt_and_encode_filename(
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	const char *name, size_t name_size);
 void ecryptfs_dump_hex(char *data, int bytes);
-int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
-			int sg_size);
 int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_rotate_iv(unsigned char *iv);
 void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index a0989e3c8aef..b147ddb0055d 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -602,8 +602,8 @@ struct ecryptfs_write_tag_70_packet_silly_stack {
 	struct mutex *tfm_mutex;
 	char *block_aligned_filename;
 	struct ecryptfs_auth_tok *auth_tok;
-	struct scatterlist src_sg[2];
-	struct scatterlist dst_sg[2];
+	struct scatterlist src_sg;
+	struct scatterlist dst_sg;
 	struct crypto_skcipher *skcipher_tfm;
 	struct skcipher_request *skcipher_req;
 	char iv[ECRYPTFS_MAX_IV_BYTES];
@@ -758,24 +758,9 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 	}
 	memcpy(&s->block_aligned_filename[s->num_rand_bytes], filename,
 	       filename_size);
-	rc = virt_to_scatterlist(s->block_aligned_filename,
-				 s->block_aligned_filename_size, s->src_sg, 2);
-	if (rc < 1) {
-		printk(KERN_ERR "%s: Internal error whilst attempting to "
-		       "convert filename memory to scatterlist; rc = [%d]. "
-		       "block_aligned_filename_size = [%zd]\n", __func__, rc,
-		       s->block_aligned_filename_size);
-		goto out_free_unlock;
-	}
-	rc = virt_to_scatterlist(&dest[s->i], s->block_aligned_filename_size,
-				 s->dst_sg, 2);
-	if (rc < 1) {
-		printk(KERN_ERR "%s: Internal error whilst attempting to "
-		       "convert encrypted filename memory to scatterlist; "
-		       "rc = [%d]. block_aligned_filename_size = [%zd]\n",
-		       __func__, rc, s->block_aligned_filename_size);
-		goto out_free_unlock;
-	}
+	sg_init_one(&s->src_sg, s->block_aligned_filename,
+		    s->block_aligned_filename_size);
+	sg_init_one(&s->dst_sg, &dest[s->i], s->block_aligned_filename_size);
 	/* The characters in the first block effectively do the job
 	 * of the IV here, so we just use 0's for the IV. Note the
 	 * constraint that ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTES
@@ -794,7 +779,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		       mount_crypt_stat->global_default_fn_cipher_key_bytes);
 		goto out_free_unlock;
 	}
-	skcipher_request_set_crypt(s->skcipher_req, s->src_sg, s->dst_sg,
+	skcipher_request_set_crypt(s->skcipher_req, &s->src_sg, &s->dst_sg,
 				   s->block_aligned_filename_size, s->iv);
 	rc = crypto_skcipher_encrypt(s->skcipher_req);
 	if (rc) {
@@ -830,8 +815,8 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
 	struct mutex *tfm_mutex;
 	char *decrypted_filename;
 	struct ecryptfs_auth_tok *auth_tok;
-	struct scatterlist src_sg[2];
-	struct scatterlist dst_sg[2];
+	struct scatterlist src_sg;
+	struct scatterlist dst_sg;
 	struct crypto_skcipher *skcipher_tfm;
 	struct skcipher_request *skcipher_req;
 	char fnek_sig_hex[ECRYPTFS_SIG_SIZE_HEX + 1];
@@ -950,15 +935,8 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 		goto out;
 	}
 	mutex_lock(s->tfm_mutex);
-	rc = virt_to_scatterlist(&data[(*packet_size)],
-				 s->block_aligned_filename_size, s->src_sg, 2);
-	if (rc < 1) {
-		printk(KERN_ERR "%s: Internal error whilst attempting to "
-		       "convert encrypted filename memory to scatterlist; "
-		       "rc = [%d]. block_aligned_filename_size = [%zd]\n",
-		       __func__, rc, s->block_aligned_filename_size);
-		goto out_unlock;
-	}
+	sg_init_one(&s->src_sg, &data[(*packet_size)],
+		    s->block_aligned_filename_size);
 	(*packet_size) += s->block_aligned_filename_size;
 	s->decrypted_filename = kmalloc(s->block_aligned_filename_size,
 					GFP_KERNEL);
@@ -966,15 +944,8 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 		rc = -ENOMEM;
 		goto out_unlock;
 	}
-	rc = virt_to_scatterlist(s->decrypted_filename,
-				 s->block_aligned_filename_size, s->dst_sg, 2);
-	if (rc < 1) {
-		printk(KERN_ERR "%s: Internal error whilst attempting to "
-		       "convert decrypted filename memory to scatterlist; "
-		       "rc = [%d]. block_aligned_filename_size = [%zd]\n",
-		       __func__, rc, s->block_aligned_filename_size);
-		goto out_free_unlock;
-	}
+	sg_init_one(&s->dst_sg, s->decrypted_filename,
+		    s->block_aligned_filename_size);
 
 	s->skcipher_req = skcipher_request_alloc(s->skcipher_tfm, GFP_KERNEL);
 	if (!s->skcipher_req) {
@@ -1014,7 +985,7 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 		       mount_crypt_stat->global_default_fn_cipher_key_bytes);
 		goto out_free_unlock;
 	}
-	skcipher_request_set_crypt(s->skcipher_req, s->src_sg, s->dst_sg,
+	skcipher_request_set_crypt(s->skcipher_req, &s->src_sg, &s->dst_sg,
 				   s->block_aligned_filename_size, s->iv);
 	rc = crypto_skcipher_decrypt(s->skcipher_req);
 	if (rc) {
@@ -1632,8 +1603,8 @@ static int
 decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 					 struct ecryptfs_crypt_stat *crypt_stat)
 {
-	struct scatterlist dst_sg[2];
-	struct scatterlist src_sg[2];
+	struct scatterlist dst_sg;
+	struct scatterlist src_sg;
 	struct mutex *tfm_mutex;
 	struct crypto_skcipher *tfm;
 	struct skcipher_request *req = NULL;
@@ -1655,28 +1626,12 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 		       crypt_stat->cipher, rc);
 		goto out;
 	}
-	rc = virt_to_scatterlist(auth_tok->session_key.encrypted_key,
-				 auth_tok->session_key.encrypted_key_size,
-				 src_sg, 2);
-	if (rc < 1 || rc > 2) {
-		printk(KERN_ERR "Internal error whilst attempting to convert "
-			"auth_tok->session_key.encrypted_key to scatterlist; "
-			"expected rc = 1; got rc = [%d]. "
-		       "auth_tok->session_key.encrypted_key_size = [%d]\n", rc,
-			auth_tok->session_key.encrypted_key_size);
-		goto out;
-	}
+	sg_init_one(&src_sg, auth_tok->session_key.encrypted_key,
+		    auth_tok->session_key.encrypted_key_size);
 	auth_tok->session_key.decrypted_key_size =
 		auth_tok->session_key.encrypted_key_size;
-	rc = virt_to_scatterlist(auth_tok->session_key.decrypted_key,
-				 auth_tok->session_key.decrypted_key_size,
-				 dst_sg, 2);
-	if (rc < 1 || rc > 2) {
-		printk(KERN_ERR "Internal error whilst attempting to convert "
-			"auth_tok->session_key.decrypted_key to scatterlist; "
-			"expected rc = 1; got rc = [%d]\n", rc);
-		goto out;
-	}
+	sg_init_one(&dst_sg, auth_tok->session_key.decrypted_key,
+		    auth_tok->session_key.decrypted_key_size);
 	mutex_lock(tfm_mutex);
 	req = skcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req) {
@@ -1699,7 +1654,7 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 		rc = -EINVAL;
 		goto out;
 	}
-	skcipher_request_set_crypt(req, src_sg, dst_sg,
+	skcipher_request_set_crypt(req, &src_sg, &dst_sg,
 				   auth_tok->session_key.encrypted_key_size,
 				   NULL);
 	rc = crypto_skcipher_decrypt(req);
@@ -2173,8 +2128,8 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
 	size_t i;
 	size_t encrypted_session_key_valid = 0;
 	char session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
-	struct scatterlist dst_sg[2];
-	struct scatterlist src_sg[2];
+	struct scatterlist dst_sg;
+	struct scatterlist src_sg;
 	struct mutex *tfm_mutex = NULL;
 	u8 cipher_code;
 	size_t packet_size_length;
@@ -2249,27 +2204,8 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
 		ecryptfs_printk(KERN_DEBUG, "Session key encryption key:\n");
 		ecryptfs_dump_hex(session_key_encryption_key, 16);
 	}
-	rc = virt_to_scatterlist(crypt_stat->key, key_rec->enc_key_size,
-				 src_sg, 2);
-	if (rc < 1 || rc > 2) {
-		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
-				"for crypt_stat session key; expected rc = 1; "
-				"got rc = [%d]. key_rec->enc_key_size = [%zd]\n",
-				rc, key_rec->enc_key_size);
-		rc = -ENOMEM;
-		goto out;
-	}
-	rc = virt_to_scatterlist(key_rec->enc_key, key_rec->enc_key_size,
-				 dst_sg, 2);
-	if (rc < 1 || rc > 2) {
-		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
-				"for crypt_stat encrypted session key; "
-				"expected rc = 1; got rc = [%d]. "
-				"key_rec->enc_key_size = [%zd]\n", rc,
-				key_rec->enc_key_size);
-		rc = -ENOMEM;
-		goto out;
-	}
+	sg_init_one(&src_sg, crypt_stat->key, key_rec->enc_key_size);
+	sg_init_one(&dst_sg, key_rec->enc_key, key_rec->enc_key_size);
 	mutex_lock(tfm_mutex);
 	rc = crypto_skcipher_setkey(tfm, session_key_encryption_key,
 				    crypt_stat->key_size);
@@ -2296,7 +2232,7 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
 	rc = 0;
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%zd] bytes of the key\n",
 			crypt_stat->key_size);
-	skcipher_request_set_crypt(req, src_sg, dst_sg,
+	skcipher_request_set_crypt(req, &src_sg, &dst_sg,
 				   (*key_rec).enc_key_size, NULL);
 	rc = crypto_skcipher_encrypt(req);
 	mutex_unlock(tfm_mutex);

-- 
2.39.5

