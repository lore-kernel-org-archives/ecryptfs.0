Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D033939D
	for <ecryptfs@vger.kernel.org>; Thu, 15 Oct 2026 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028176; cv=none; b=COsXBhHK0MjsKGKVcmhxNBVH33pjRBtUblngObfJ1fDbr9U0pWLkQLBCXoADl945MOcunjvs7PYYnzYHC1LcsKdia/ZiwyZcPG1BX+4YaiLjgWzfqmOGHCC7uxKEkaPCrd2Oh1CKkDyvts80eNGatLmadh1Grw26ZtlfSJsLxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028176; c=relaxed/simple;
	bh=dpyPor1HE2C8ownermUufqSOGZIYIIGWs13NnCBnXVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPu/fHuBWkMeiJaF9B3+6PEcLfQs7CcacyT9BI0ZJ6orNL/ifEjZKx0x0L8Ywm6NqKiENYY9yxI2dSgvyRIdrXWGwighqvDnUA9RW17HpMHBvWEsWMkxKdpxhZGIdmUU0SsdKmqs67glAwZ/VMXD014M+7pPxm/QFzGHB3+c1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Nhgkt3oj; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=0slG20WH; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Nhgkt3oj";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="0slG20WH"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0YC0t3488534
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=nUqe
	ufPiZAFqGAtXO75pV+Nn0nSwQlh52k7PgmYZMqQ=; b=Nhgkt3ojMakdoUSfqAT4
	JNETTgry1/fIytNX2/+FB+Ndnt/KcBB+Z75g+gTjdp5ifFZe5Kt0zJXafWwOuRoj
	xyr+xfCnMOG3uiAK7XrAkYjc+1KYCue6of0f1Cg7p0Pwto+5LoQsrBp57j7N200x
	bJoUwEliKd7lBRc8p20j9UwOsEBW+63dxZRGm2x06EIIuxxxLP7GMEpviIHDl3HG
	WP7ZUZz8VeEdmDcZ2Lxd0LHLJdB7L/Ohay42AhsHhwA4vy8BAyyCxwbyhh7GPB+F
	3lMiY5UfOOoudMIRlWoyYzfDe2j/gSsT7ifBkp1yZyL66GehIgaHUIYPCX8SuMAg
	CQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4haerutxjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:13 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-535252004e9so112845761cf.1
        for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 18:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792028172; x=1792632972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUqeufPiZAFqGAtXO75pV+Nn0nSwQlh52k7PgmYZMqQ=;
        b=0slG20WHsxMo7RoytCEkTMTx/uY4mPySyDuSPhkJBc+iZc23tNHWGzxjUQ9cy+Lxj1
         A7HTCOOkC+j26gaetpvx10WAhkJ5efg8k/13XMbTpXvfFx/dmlUWKAOW4j5mPfRS1hIo
         BUv9BoE4gTyvqSKGC6yOW29F8KiNDpmzz5zoEicjNMRpGIEpYFfjXhQPWtV8IcSCCPrf
         OPn8d6YVaaDN0Xqk5q6YLvJOIDLpmyTi7f2ekG3eFLZvyJN4shyI5uRa07YjXKEWB8Nc
         fwkU4TMcFALIYZc3Vl/Cf8bCnd4/3ZtKzcKPWpSwk70t/XbYsIpRtF3v5PwAYeqeEvtz
         vtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028172; x=1792632972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUqeufPiZAFqGAtXO75pV+Nn0nSwQlh52k7PgmYZMqQ=;
        b=d0k4FzDtr3Hhdc+wS0hUYo5izljUnJSIIbvyYX90qyY/9bAr6aDO14zmHkUW0oNWjV
         72nWCg/50JifhJ20EWLk3hJxgel2OLwQzUZXzAZ2Onh9EOLjK/Aev5VRsZKPpyPrk5xw
         pdOkEYtllllj5gtBeAH468Wlucw/UzMQk9w9kAXqKlXvs3coVzzoSMRcLsOqvrjQn/Lo
         AYtskWqSMC8AuQgqIh/JbOhdJHR/r8uWdro2fpKGHxwQz2/g3Tw7o8ExqRz2hWsS3Fwq
         qO8KFfEcTkRw9O5OqfcxiDK3O7Oi2aC+YX/+XVu0UQgSLaqy8j2gB6mJ2s+NouaN81JD
         hDHQ==
X-Gm-Message-State: AFq9FYIgodoHd6xTstU8h3hl0XrjaWzUj7Sm7LhYduhUciivw+CrsJVz
	lrUKm8+s4jXLmy+VYuxJIQOD4Cxh5ecHbpMT32tm3Aj6tSysEmpWxCXRoKTiz2NPfuEadAgprdN
	iE+7bPi8kG2QAvZqLaNwYVP86Exufq6NsS2E/kwKPyRPmMd5eaiIdzp7kd8gE3kyI
X-Gm-Gg: AYBFou0fiq9aYMMA0jdxE1ElV+z41PkrSNq3ac9dSG6F2kdOQLy45Lndo02MO4sCTDE
	qQ8qNJtUHQDrLbxBEhrswN0+hBLhq2R38Syj6fqWh4S0HoAxizFMAvFkZnnmcV4K6tq2MrjZXlO
	vINf+oz+meXEg38xoSnRp0HyREvFAHTYe7y7pBUh5R8cuR7U6KEC34QdQAFCV2Zp/azyH5PVaQQ
	4ctBC05RcFyAJdCU+LLUbj+AxAeL5kL0Fa3rbO2QjSHbi9yQXATB6h9hcmB0Fe1LejPGRR8AQzO
	kj6lCp5qw8CQZy7Jsh58UKrYajt28agkuiMyk0udUz793x55ASUACZs6I+dksGQSZipH6x23pb7
	1EJC1sM+a01NYyyRZDM19ZVlffigY1ax8FGhINydHlv85
X-Received: by 2002:a05:622a:4c89:b0:535:1a4b:a65c with SMTP id d75a77b69052e-5359fb432b3mr278930241cf.34.1792028172360;
        Wed, 14 Oct 2026 18:36:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4c89:b0:535:1a4b:a65c with SMTP id d75a77b69052e-5359fb432b3mr278929981cf.34.1792028171776;
        Wed, 14 Oct 2026 18:36:11 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361279a933sm12657661cf.6.2026.10.14.18.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:36:11 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 21:35:49 -0400
Subject: [PATCH 5/7] ecryptfs: zero the tail of the last folio in place on
 truncate
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ecryptfs-folio-v1-5-f4412187b1d3@columbia.edu>
References: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
In-Reply-To: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792028164; l=3119;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dpyPor1HE2C8ownermUufqSOGZIYIIGWs13NnCBnXVc=;
 b=WR4aIo7hnDYUyVN3rnUBUOLkZcAvHav0U1bSDERR+HydyNJNvDbpo82OxqXiWlFFVHs1tORa2
 my7Ygb/NJuAAb0D8m2NJQpNjk+xuz0IfampMrQAzCMr/OSMFivS3mOu
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: i9JqmrBtbQBoDCuHFLVeq37Txy8S1m8K
X-Proofpoint-GUID: i9JqmrBtbQBoDCuHFLVeq37Txy8S1m8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfXzBH5uR395vrN
 QDK0qKDRXMKKxiwqYm+cERMebATg9zy/IVgo0NO/w82ITwPnCQONlUEDEkH65rWcYhDUU6GHnue
 gwHS+80ObNbZlGWAEo6hq0j3LKhCs+LCC0bmHIvOutR3TXN0DLaGCty6zgWVemgrCIpIXJuCVSO
 1FuZyCKAdr9y4M/fXY9Wz71q9dN1dbslpWxGf7oKMnEkxnLlrfGl966erDlm+H1BUaL3tLRk3wp
 5cetN3GaMI9GP3pIz4CbZcj9nuMciWZfn2p2VHU4VEl4Ug1raU8qRt5hNSaz9hEkB7esiuccFD0
 O8n8+AydCWfLrpZ8ZXP9T8z4EfSqgY20Jqwu/Hcjf/HPxiSnEE99OcSOXfrqEzhgKopPHg+MpcY
 s8eQoP0n0A/apuBpsqjJYF+igsY4G0C+OmnCoSHrVchzvITdfMJJjgNUMIAaZDUp38YNuwCBXzo
 2IYFk5hx647gWGnfGRA==
X-Authority-Analysis: v=2.4 cv=E5xYNqdl c=1 sm=1 tr=0 ts=6ad02e0d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=dGUJCdGidsCb5_L8LY8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX5f/mGAK/2MHM
 anFZHSkSrUZPS7otmUreXBjgti6cppZJTg4HLyeqExOPqb2shsZ45gfOPpoHXSBVVcbcbvIkX/a
 kjnV6QlErQ9sXiQIZPHdB/U2BdDqsDFWsE0PWRbTWzFgijg1bYpy
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=10 adultscore=0 spamscore=0 lowpriorityscore=10
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150006

A shrinking truncate zeroes the rest of the folio that holds the new
end of the file by copying from the zero page through ecryptfs_write().
Zero the folio in place with folio_zero_range() instead, the way the
truncate helpers in other filesystems do, and encrypt it to the lower
file. This no longer bumps i_size to the end of the folio and writes
that to the metadata before the real size is written. It also removes
the last struct page usage in ecryptfs.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/inode.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 525297c7ebd8..c743b0f2ab4b 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -718,6 +718,34 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
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
+	folio_unlock(folio);
+	rc = ecryptfs_encrypt_page(folio);
+	folio_put(folio);
+	return rc;
+}
+
 /**
  * __ecryptfs_truncate
  * @dentry: The ecryptfs layer dentry
@@ -739,7 +767,6 @@ static int __ecryptfs_truncate(struct dentry *dentry, const struct iattr *ia)
 	loff_t lower_size_before_truncate;
 	loff_t lower_size_after_truncate;
 	struct iattr lower_ia;
-	size_t num_zeros;
 	int rc;
 
 	ecryptfs_iattr_to_lower(&lower_ia, ia);
@@ -788,19 +815,15 @@ static int __ecryptfs_truncate(struct dentry *dentry, const struct iattr *ia)
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

