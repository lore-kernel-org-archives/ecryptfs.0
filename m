Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320736EAA4
	for <ecryptfs@vger.kernel.org>; Thu, 15 Oct 2026 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028175; cv=none; b=oPoPNVoKtLmsKgqW6zihxmaPxTzoj5sd6ln0fIA5KCeowPuJv+t+GAqT/bd6KjoIzTB1f/GPQGk7gfA+dZKAp7s5LhEMc48NAW+7LMaOUa9E4tOgJo8ZwI4B+FRSyVTQMNMULwZg+DO8me6J2g6mgbHfqvdqT4OUnOOKnkv91Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028175; c=relaxed/simple;
	bh=er8ymplFfYqEnLxom8tSPRU6ZlytcMLnZe85UPmHTQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpOtMNI/pJCf74cqz/+gAJWbI0eHmc8fNo/7vT9AQs9C0Z39Wdh8EwnpIy7VIy2BewkxYIGyDYZdMlPyjOswpkAIUe9koI0kyUrw8NiSp/vfLP8dJatcNCvzgcP2pxTyFfKgYX3zhUY4w8fTd2QHOGSKXzvu4wf2lfkpWgkXKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=N4g2TO9w; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=LkaN2W56; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="N4g2TO9w";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="LkaN2W56"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0XNQA151119
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=j9Z8
	aXxjpfO6Ieq+ZDlgA4I+jpH1RBcz6BK8jn/k5cQ=; b=N4g2TO9wDTOMNS5l2EQF
	qW9arS2J7RMX7a3LFRgM59OmaXQhi3sb69Uhexb8NSr+5BvzxnMLORjRS/OTIFuI
	kroWR+zWgid5e6+zWzIl+XYDnry+CW3AbOaw7pSfgopW+buO3H6VTWQmjRO8nF5M
	BslQyRzdtiemiVjcrU4e5Lu7ZPxBTnXAXy/5NXa0iguDXUEb1o9d2e0ibmmcCLG0
	ecpukcVsGvAje0BQ4E/3rmLmLnBJPYJ79EQ0KJpfr1cY6oCM/7Ko9dKimqwALLA/
	efrAhpmh/7tLWtVSnLfR5pn9jorZXKoLrCnxv2Ho318a0YbZ0ig54Jv42VpOFVsk
	VQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hafacana3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:12 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5350ec54bf6so97577831cf.2
        for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792028172; x=1792632972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9Z8aXxjpfO6Ieq+ZDlgA4I+jpH1RBcz6BK8jn/k5cQ=;
        b=LkaN2W568xc9kxLG46JiA0gvMO7LGFXhvN6RH5Pku5/Y8CUcaWz7BwVrq4qbe2Vrqz
         HEfjbInWicLtcCIzS4V4Pq9vyXnDvNht7vndfvoHzKzIah1lXEZIzXidmZhfj10ocj8o
         ugaAxFI67PXgh1/SyC2cYzs/hK9DG2vS/c1LHwi9gZaoo7wT15HXrSPxZsxRlP04tiA1
         hB8A5inWLR15sasMRqSIKjjGpyloOoY8n8qNy/3W+K+HIhPi0DWnScUq/klEISRehD4l
         A5PdvFLtJAhC8QFiy3KSg0We3HKrPJDbgmk3kXm/vM63wjWlydBsej/somfwstDJC5gA
         ukmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028172; x=1792632972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9Z8aXxjpfO6Ieq+ZDlgA4I+jpH1RBcz6BK8jn/k5cQ=;
        b=WYo8PiFDSfDyrGXrB6IzfbIf48eCj80JZabrEVENgQuR++5gUbnqxVk0yBATFlUoVB
         lXM16lzedRmW0+dtv7WCqUYHVTlgT7Gt4CYjyAv06DmKU2IXeoELtAtsU2Xa/YtzaK8L
         AUDgxHKeTdONRJ0aPyi3c5V4vfuc2v9WGy12rE+Ya292at/KwVV+TJd1HRwcIA8w8Cp0
         VZXX61yJ/WzEjaCektKH2ckX3/20xPPVe0FE41JVG97YUkkIXbc67MjnmmkH4hGjskiI
         PILnGEFsZ4mYAJji9krowL4UcnsmobFJOwCzMdVdrP3u8qzdqG00aZJ8k05AMn+/pBI9
         yEiw==
X-Gm-Message-State: AFq9FYJPBLrJUTsuktfhVDR5GHC04VVWuE9jU8zK+w7v9D9ylwBByYWG
	fg3QLQtdjHKXleaOtLCtpjQo8ulD1/5SvCK0L2R2ftcvNFYx0hR+eFg7hg1ct+hvqtGV/XxcchL
	cUWlT5Ope0BQaBaIsVXAfCm+3IGjKFFNfXnokDH/Cp+VfYaWU0M5C6zYw
X-Gm-Gg: AYBFou2oMoBo1jtXd0+vwX2gknJo6xbJsZOHmpqkRvxSOH1THAkabwpeXEI/pdkYq8i
	5DJRnTeIOZkXzaYJKPjURpJxHxgZUjQt7sei3/zOZlIUWS9BkGc6Mimyn6aDPnUzcfOtiBom/H5
	4tu6z+V/NEYnyNDiLXE0c3PWmR6zXQawcna0qhQq7KeDWcARrwbaEvEGO1GYjEmu0VFbGfsIhtW
	WUN54yYt2mIgi7UsMjURVbdtQ29dA0BOJFEgY0C68cka8cDX0VxLNawDBnQpOOfQfWYoQ5NIHhO
	Hlf7TTrS7EuaWR43+W2tQOlG+kBXFY2OlL/CMo7UtW2a4UMsYeLR585SIIuKqhUiK2q4IbPrkmw
	+qdn68LdDTO1bYj05jgsEIje7GvBOG0I6rroTVXD8sKcG
X-Received: by 2002:a05:622a:3c8:b0:532:c8ca:5a0b with SMTP id d75a77b69052e-5359fb5f51dmr272736531cf.50.1792028171779;
        Wed, 14 Oct 2026 18:36:11 -0700 (PDT)
X-Received: by 2002:a05:622a:3c8:b0:532:c8ca:5a0b with SMTP id d75a77b69052e-5359fb5f51dmr272736071cf.50.1792028170642;
        Wed, 14 Oct 2026 18:36:10 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361279a933sm12657661cf.6.2026.10.14.18.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:36:09 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 21:35:48 -0400
Subject: [PATCH 4/7] ecryptfs: use sg_init_one() instead of
 virt_to_scatterlist()
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ecryptfs-folio-v1-4-f4412187b1d3@columbia.edu>
References: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
In-Reply-To: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792028164; l=11895;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=er8ymplFfYqEnLxom8tSPRU6ZlytcMLnZe85UPmHTQE=;
 b=YawgOdPRVoDmbLFJx0jT2hRnWuJ77pnalWc/GkTtJFc0aKyJdZn4wZTFSylHYyQBviyVWJFNJ
 EppCi6OxBJDB8RE3cZW3zN84SXYJe9rEl0sPHpNzp7wWM6aqWiP+I/7
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=ANXknWx0 c=1 sm=1 tr=0 ts=6ad02e0c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=rhbNDiOmHe9WM6CdvIYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX8UWhhn039W83
 pqu1pOgeksXED2+FzSQ2C+gD6taoqXv9TC0y/la4tlC2PKHowyf0yH8fgyF3Led5BB60QxynWlr
 Qu99YUuQls4F34Ypu4x60hIIg+iiNrEitTlJ+GpbVhkG+mbXiHwDmORi9e4z/Ll4+/yz+FMETjD
 3xmEbevDvagvLk3Au0umqif+qF+010jzo+9W0+wx0T2DhpClmIzOip/mPJylF+J+eEpopWS4xmG
 bIe6fDaWrziKRDKnHvtXcG+R8R3jKn7X/8Hex0plrfV93QNp0D1ppG2VqkkeIIWgu/CZF3N7M4f
 j1nv+sNzaoKh9bdZb2pon+RuFAwIjgGirm/myPAuZTxSEZ8VnalfK4t2tIltxGK7hy4rNszFJ2W
 3IqDQDSEIWVmIGImKGP3wsSNmcgaSN/2ZZQP65o6a5hRPP0sw6Ueyt74r9QteHP98TONi34fDAH
 /DXOOwKZOIEg2ru2PTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfXyNpuUGy1hxl9
 W5ZQbR6/uxwJAYzGOOUoNQMevnxDwkbJIQrMGJ2RRx/lyvsjyetjTtgF2xRiDErYMJA0Q/1AwSx
 Cd2khFQaZ4hyuVRvjKT3qTGMVlW4TtlhljNeFDmdTI9ikVpU+cCc
X-Proofpoint-GUID: s9DxErrGxdJMqF7PcoIF_oA-Sx7HdN9G
X-Proofpoint-ORIG-GUID: s9DxErrGxdJMqF7PcoIF_oA-Sx7HdN9G
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=10 suspectscore=0 malwarescore=0
 lowpriorityscore=10 phishscore=0 impostorscore=10 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150006

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
index ff5cef83c79c..6a74a2bfc833 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -541,8 +541,6 @@ int ecryptfs_encrypt_and_encode_filename(
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	const char *name, size_t name_size);
 void ecryptfs_dump_hex(char *data, int bytes);
-int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
-			int sg_size);
 int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_rotate_iv(unsigned char *iv);
 void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 51651314b7a6..051f7948cf52 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -595,8 +595,8 @@ struct ecryptfs_write_tag_70_packet_silly_stack {
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
@@ -751,24 +751,9 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
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
@@ -787,7 +772,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 		       mount_crypt_stat->global_default_fn_cipher_key_bytes);
 		goto out_free_unlock;
 	}
-	skcipher_request_set_crypt(s->skcipher_req, s->src_sg, s->dst_sg,
+	skcipher_request_set_crypt(s->skcipher_req, &s->src_sg, &s->dst_sg,
 				   s->block_aligned_filename_size, s->iv);
 	rc = crypto_skcipher_encrypt(s->skcipher_req);
 	if (rc) {
@@ -823,8 +808,8 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
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
@@ -943,15 +928,8 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
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
@@ -959,15 +937,8 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
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
@@ -1007,7 +978,7 @@ ecryptfs_parse_tag_70_packet(char **filename, size_t *filename_size,
 		       mount_crypt_stat->global_default_fn_cipher_key_bytes);
 		goto out_free_unlock;
 	}
-	skcipher_request_set_crypt(s->skcipher_req, s->src_sg, s->dst_sg,
+	skcipher_request_set_crypt(s->skcipher_req, &s->src_sg, &s->dst_sg,
 				   s->block_aligned_filename_size, s->iv);
 	rc = crypto_skcipher_decrypt(s->skcipher_req);
 	if (rc) {
@@ -1625,8 +1596,8 @@ static int
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
@@ -1648,28 +1619,12 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
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
@@ -1692,7 +1647,7 @@ decrypt_passphrase_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 		rc = -EINVAL;
 		goto out;
 	}
-	skcipher_request_set_crypt(req, src_sg, dst_sg,
+	skcipher_request_set_crypt(req, &src_sg, &dst_sg,
 				   auth_tok->session_key.encrypted_key_size,
 				   NULL);
 	rc = crypto_skcipher_decrypt(req);
@@ -2166,8 +2121,8 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
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
@@ -2242,27 +2197,8 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
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
@@ -2289,7 +2225,7 @@ write_tag_3_packet(char *dest, size_t *remaining_bytes,
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

