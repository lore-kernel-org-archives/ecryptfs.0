Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866912;
	b=OzOvdGOcXyYpVaqcQqCWVMKX0CrP3aK778bf5rID+Rr+/86TH5Cw2o0zqTFCr8xvFa+g
	 Ku/h80lQnCFf5AClGGLrZR+IPVt4k2PmHHyRUB36tgUQD7UQoy77SAQw3fKcwDRfKH3xb
	 Tvu/2pWuESfIq4pvua9/SXSQB44a5ElHOu8Wn9/fFB+TxPFzJSyL7wXCFi8B22jCu4OEL
	 yBdqWlyRSSvRuFWpDUXIFvGtSZgjXrAbZngTov0fyF9VbO53Yz3V9K0WmnWsW7ueQGCaU
	 hy5KkmNzMMWQJDHbfHjvPF0Pc+luClcccHb8EtS99OK3grH3IBhjBKbpMHzXlyivzRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866912;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TLCucmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=;
	b=nQ/mSX6qYc7JloWgGlvdYoG0gNyrtkGBPyL9OvBkoj9kGL+r1IdwfWqkEREwmWw6gYS3
	 /1WQyc23rsTrBPhclRNZWC/qc4CygM7Oy1YHoFDScPXym87H9ui/VLXHEjkOLsAUhsg4w
	 Amh39O9zpopQ22fgqUwsprL9oqFzHdxW6hE47BNei7suKRDCbbYf0oghMvpuMtMvSiKD7
	 zsEOBsB4/xn8XIlipp/y2mXLHAHG7ubG5YOAJiJ9EiKzcsLz8LJZrH8rE3b4hgHaf/zZU
	 dGjy0qFlYwQQ5QSv0G68TFT9/xzOsCFWsq3zHwEo4YDKlT0Obk3pYCW0yEGIAaZs4FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="V/iJtvKs";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=KrNP6RGx;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C409606A33D
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C409606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=V/iJtvKs;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=KrNP6RGx
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYkTA4118921
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TLCu
	cmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=; b=V/iJtvKsucsaaPCKMQEs
	7cAgW/QX+5U2qrxAettTu2ao5x5ENVLGBA7JLqtL2VkdUKYsWR0pd8WNOKqxb01E
	WrOdPa4k4azpVBhDxOsxya1rK7+QA6FNcFvIrFXuAo/GeOnZnuMZcWqKyYWEu4z+
	cRjRYZSnhKJ2JCKS9L/srDZIcpb7rJw0ypTqxT8PO1iTF2eoMq3zOQM2NFvNgUc4
	vzMd1RFhCs8Q3xtsRssYNeVfyRwEHT/y727mzY0r3Tcx2tDLcZdnWPkggPNV6v3W
	01bY6wkCEGy7MKtaTQtCSOKOmCo2negCmJkwPw0rHvRvv9vf7psfDAt1R+qIgef/
	DQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598uak6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:29 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91eacf20364so79469496d6.0
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866909; x=1795471709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLCucmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=;
        b=KrNP6RGxdLoTead7NEFi0lGMHPcsB6RPA2kNwFvxiA3d4ScbcFCMFkati2KuVQswOb
         M340mQ1Eo+jrDVUZCFYrJ7sQMpGhhouE6shyescpxDKRX2BPo1MLS2AuM0Z3+x5TstoI
         QmRwE/5F2eh2hqTDriSyRwLf+EEjXKZNeWkCBjBXFz6BlkhCrfPw+haxIC5SyqkPZynT
         Lj0IugJ3/bvACTLue1xVKjo8Er+IhkwBo3s3PDuG+8uMrfo2HyrN8C01GCbSgoy7YNwK
         V9jimKW2KunrIexnaRN9R3DjfDbnRlGWk1OL2Cu3ZQGbL0KDp/UUcKSFP4WKHZKDhRGT
         AktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866909; x=1795471709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLCucmL89h6Y343vyk/BSzJ/L9xsssqYgiwpO26BJsY=;
        b=sJeKAcKuPQ7BsJ1ndGzhWLj9XC0UlgWy1VUmnz06nlMhfXHnUfvPPwnS9buNpQVZ/t
         nUVpEddty3bg5zdJonZLNcm4rCHNko4GzG7M3l+9tGzRTlLNXXjyjsmcoIXV9QNPCKUG
         OnySxYTa8LV7FOVSI3/qqC/Wqp5cUjHuNTkbz8VTuFauoLMO6s92slOzpv0jefxPFaXq
         8HDNXG0G1nsHyKwf+FrHWlU7UsnhPrclnRCRk+7Zka1PAHMqEnAncXj9cO0Y8RLkLjP2
         Qmmxq42dkIQCBYCp5fgfKlfQs1dr1+QjtrPPcEFoUFfB2vh/vcXNRNq+zVxsBSz+K92q
         Si4Q==
X-Gm-Message-State: APuU4Z+Iryl0K4JDenIanntrzQ/OYuAvYXa31CNuPHR+Oy1DR7TWTpRn
	F9jAx3mc0vVuEM9uJtonOrCPT5ZEfJFDmZIsODX/dxOjdaE1nLpWrF8BTlKqSvMxn8e8EIm2+9t
	EiWMg7Psds7uacgUH+8iuDIPkELwLC3fg9gWm5K194vPG0HTMtM3niArB
X-Gm-Gg: AYBFou1TOdgCwb7i8YWHz0ePdgeY2Ohe6cbo3OsYPVzJXmApB3mouWAczt1zDIfGcJA
	BJXg4wRr7tUD9be8BGEzmAk0F/DwWzjb6NnpUWZkwIWHX5RDMtc4F6f0WsnrykZCOY8wQ+xoHjP
	JftF/z0daC1gjYqNvgyjXW+KWIqo7R8FU1BcnI+kfTiluyeg3znUsGq/hMPmE30Qp+BCUgssHHX
	HilkJ+S1qWuSYe03dAHmv1dM9+Znd+ggVWVNJqkTW+QXuJH2Z0LBEEBcj0r8elwqFdgb5Q5RuEr
	g+hcvV1d1PaLQf5ihIMnkUbkA/7WY1ZtlZF01cKe89iLcE4phF9APmAuUhfMkUA5pSHUWEcWZDA
	/xr99IVmby1hIlWWV5s4KTTEoVNcNcdqyujg5yR6Wd77oPE78xhvgXv5Ynpv9VV+lxlDiL6OAX2
	3qJZ9LWtJ4McX8sgVBp1YR
X-Received: by 2002:a05:620a:6c84:b0:93f:3120:6c71 with SMTP id af79cd13be357-9494bbf73afmr1926074985a.44.1794866908683;
        Mon, 16 Nov 2026 14:08:28 -0800 (PST)
X-Received: by 2002:a05:620a:6c84:b0:93f:3120:6c71 with SMTP id af79cd13be357-9494bbf73afmr1926071385a.44.1794866908184;
        Mon, 16 Nov 2026 14:08:28 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:27 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:13 -0500
Subject: [PATCH v3 07/10] ecryptfs: use sg_init_one() instead of
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
Message-Id: <20261116-ecryptfs-folio-v3-7-1aba8e620eda@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=11895;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VlDnCX3i7mGZvNYBW4J8FKMLFtRDtsIQljRKRABgp+k=;
 b=s5+wznyEl0etqn7N9GmLoLd98/pE/hX/In0QQ5lbf24GS5AOeUELrxVhkLWpOCeZhoUCid9f5
 NhU2F76jv5iAP2umHErTy6nvEGUMc2lJkh3XxExamHBeIRg+o8hqjcQ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX31hGOvg7htlQ
 CTdyTmrxCr8v7ZAvlPDSEZY+5EAlUAvd/qscRIT3zRPpqyJeJVMU1AJyFJ2ItnNinldFBoxfZYp
 IScm02ikPJBPW+OhSbkfLjZDF3vj7rfW6AId4i1atPiLamO9kB82
X-Proofpoint-ORIG-GUID: dPlfK_jZWsaEKIdqU7wCF0EfnPPUwR42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX7rlChAbGrlUR
 FTgGrruFG8s3bXLWCmSX/NQLtQDfsdlhDtQpRoCzRxDs615F5i7LZe6+sFkZmckgMBf3ac5Tf3X
 3+wZ2IjTRwVDrmDVxX5UeVBI445uWBrtj6Yv9dkPzp9mqMcAkZ2yeN6HOF/8bQIk4N0zz5++K1u
 Zqo8ixE9Zl9bmevsx6WgrELMg34qATTh8Xwj1X16ZDHkbDLAzBDrgLXd2NpPCkC18X4ive3fCAQ
 OETGZCv0x0aBQTzKElRNOoC/6FGz9N4AEzMO0ithbikbYDGBxAGq1e4zqi52yg20NcORn2kEOby
 8jYy2ReXwzeil9Ds6scUdhzLEhKMOjq5UC49lqxbHjTG7pljsojsicWkIJ4c+UyO6yJLIT/vHAz
 5vABDQC3oqyw516AxbS6Z/zwiwKqCMfXQC10+rYgzxAmzV97EMblvUZZyrQzuImbswZ5Pb0xTwV
 Z9FL5Yog7yVSZcgN7Kg==
X-Proofpoint-GUID: dPlfK_jZWsaEKIdqU7wCF0EfnPPUwR42
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb7edd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=rhbNDiOmHe9WM6CdvIYA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

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

