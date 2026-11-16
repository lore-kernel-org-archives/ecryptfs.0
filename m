Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866915;
	b=UsnDQgc0wKW8KmEzIEqJ4k98Epc/HB3k1294YuzkoFHRLzgQIMWRSFi7/tVpZBdsICvc
	 r1IC2hPLn77VbqvavU9zhxoLZafI4d1b9Wxg9mXI1pjwnelhU9O0AtyuhcsZaqD4RdSHK
	 DJEthUmOusQmRFtIlraLd7WBWDy0RupVQJh9cHqs4zYH5DHyE8Q+V++ZcIvvIbeTLA1Ny
	 YVw5hL3zGyV0xcXUFO0A5w2gCi8BB1mEdo6d6NFtYnp95DNnA34fGmzsLM5YYkVqRHdCz
	 /ti3mGeg3AFq8lY7G9kdPx4UYCXKx4g+0qKekHQdmZs8EyYkwZZmfj4jwc7EP4H+z5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866915;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MfrodZ+vmY6ItwdAcNnP6Ro7yOb/7bLr9QT5eCmeHrk=;
	b=dIhlHffyM15+vZKJ2Wr7/g4MntzRE5gNbD9FrQls5l8Mh+HE0LANp41pKiqPLS2eyo7m
	 s2ScL8I+lRlQIB4aLIwytfSjWYPEi2BC8nEoOCeY8WnFhiEkahhyCpegCj5HITci8kq+j
	 VBmxag87Y2pbGeExlI4cGCANt+Fj/5VvwoMT1TARc1mUK4xdG0YX56otuGbPCSRlC1lFI
	 Vpq+Xn3yDksuQYK6SrAlKK+XKYtjvJnjXNRM+gNm/t7fOw/pjD/KRq+Mu4lscNqs9bUqh
	 BVqXtQHYPEWfHpQXKmARHRqx/G34OEK/V228gvRVw3SeyD5uoV4U926krE/LQxL2tRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=P3o46maC;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=D5i146Wt;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6B60A261B
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E6B60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=P3o46maC;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=D5i146Wt
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYk2b237730
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Mfro
	dZ+vmY6ItwdAcNnP6Ro7yOb/7bLr9QT5eCmeHrk=; b=P3o46maCptDLVSaglNtF
	ZFD+eLMB3MiByWj684Uuj1ssfn1z+Hhwmu4s7PPFAxxeAQu0lbhPAbD2iiP7iBh4
	lkN36EhE2DSTs5LCRTMTUpVODAuiRdz8+X+zzaMkjFNYHg2grFDCUP1bOzS0S16e
	DRHx/l/c6bcxDZmH43n1UUytG6IYTLfbQ1RKP5TrtaN5I4URfiL+biQ0yPN0ecmS
	YyMCIGe7KDWoxzKIKP4A5+90V+vHpQ5ojfbL0fb0nX1XfE8pG2dmxuA2MF5RBzdC
	YWVkLPOoKsHgQNYEvgsHElUMiGx2hYNRsdKiwKL3TqcTPYLOsDgN7/+FZFU5mFCx
	Yg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059dkbbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:30 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so383763285a.2
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866909; x=1795471709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfrodZ+vmY6ItwdAcNnP6Ro7yOb/7bLr9QT5eCmeHrk=;
        b=D5i146WtoByJ1WjMGZww8vAA6AYWgHfFz4i5BCC9/8YLijKhbR9Vyq6HUSGg4rg387
         q0bMJlO2OCsgtJuA9RELykax1mRpI+cNPFKgm+SgHNZV6lD6QV/lWJN54IX4drFcpqEA
         MHWvSlrRL9E11rpPJm3dOskw+uj4ASUJg0GM6eq4pCLRzx+GQO9CnpZTwdVX3R8AA97t
         XAOUWsmTNXmFTV0vXSFQSIizImD9QpOlmT7girnDhL2WUdFyfa/6EAlkIK4UQIgPZdd0
         0Hk5iJoP657Qe+MyUS2nvrVsxCoLtcI07ZjFTGQ6dv7MG02WZKsDioM21ar0KVuQsUli
         iaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866909; x=1795471709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfrodZ+vmY6ItwdAcNnP6Ro7yOb/7bLr9QT5eCmeHrk=;
        b=SG4nAUMRfF6vLXRfYccEpOWmIRz4EMPYd0GHE1OlDiXYKoVTxwbzBrHqK3FQyRz+Gh
         aaOI8IPq26nqBzJUjyN0t/mUL1nCE+qHEckTGQsWhr0d7RKwfkR5Dyrog8V9Q4hk6hxe
         VPAvRKI4k5btyFSwvLkPVFACRtx1OWDSVf/B+W8le+splhwkN3k9LE1gr/MhZVTZmN5T
         4fS7t3fbbKRL4qHY3syO/UBmnQTbsbBL1vBqBuE6egW9PioSSE0sPiY75xQFzL+KxkAC
         JrGiWi8UEn4By8QjfO0UNPSp207LHubjxqk+K4N2yMSKu9ZkZyvdVAd9fWZECz7KKo0x
         x4dg==
X-Gm-Message-State: APuU4Z9wjwPSi8ZLAyAuD+/+5YD9loz4ux15Oml5D+W19B6JH2NYEI9n
	1AcVUaGa8Q7VZDYWh+lbt1qyHf2oM9aqqxq+rBLGsd99TExcv7U5BF+D8Kr9fgyA5LcZC6zPdUi
	ztDfjbzFXjjF+BKWBburho3F/acY+4YuYMAPLoMkeH27vnyW1H4mu8c2c
X-Gm-Gg: AYBFou3eqoWW2PGwVmw+Qjqb1F9bMt8oTC2rk3m5rNeqoV4/WhTYf8QK7gU7jlv3ASg
	T+UnoIM7bsqICgAyyKze4e0t2r+39VQP+5Wqb7mxrVOcqC3xUiDEcrpkDljvNDZiUV6pclv4nZ/
	pGSxKRNx1fEUORe8cO78TC5hYn7yXwr0iG19vOnUcdCzXNc3nfgCVv0bvCZWPOqN61vITK71RC1
	zYUGuqq41e5zH+hkfBWiZKcttn3aBnWteuhj6DVN0WFNXxptgbiFGUKqKW0ylJ3Mz4knfcQi4+y
	B2BCUSGeB6tyuLUdYpGPjsVj5PZPGcJrcJN2+kVtTHNXSQZtMI+FDadLUShSUJ5BT2ORpG92wfy
	1oa7zlXW4S5fKwUck9oHzKvTRz+6Q6chQiZme9BdfVOBWwEe83K20toXtYVVEw/ouEuPvSUMVAu
	hy1TALAoMhWdTVQAazo3FQ
X-Received: by 2002:a05:620a:90d3:10b0:949:744e:12eb with SMTP id af79cd13be357-949744e1528mr716581685a.65.1794866909617;
        Mon, 16 Nov 2026 14:08:29 -0800 (PST)
X-Received: by 2002:a05:620a:90d3:10b0:949:744e:12eb with SMTP id af79cd13be357-949744e1528mr716578585a.65.1794866909227;
        Mon, 16 Nov 2026 14:08:29 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:28 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:14 -0500
Subject: [PATCH v3 08/10] ecryptfs: zero the tail of the last folio in
 place on truncate
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
Message-Id: <20261116-ecryptfs-folio-v3-8-1aba8e620eda@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=3672;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YU2D0h1+YiZ8zzlfyo96f+8NuGaYq6vNDpSn5r/Qj8Q=;
 b=3t3nFJecH20Q09ngSn+Y1yZUNXrl006bAUIgBb32KB9oci0ZPGg6emOGeeuYivABA+XnZz0LG
 vsKCdt1VuSkCKis2rlEiIM7Yz8A8rWs1nS9PZZoEONgCvshI/w+xQKW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: AFoEOK6IjWaSeatUZWsjBL88cC_HE1hR
X-Authority-Analysis: v=2.4 cv=Utf2pOwB c=1 sm=1 tr=0 ts=6afb7ede cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=dGUJCdGidsCb5_L8LY8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX2vCaeBFuYUER
 M7bFd7Ft3jSfm6/nS8tnT8/nZk2H7p02NWX4fQXLSur48iwNKn6LYrbrQmDA2wWNLAzNXRWmYa/
 Dv1tYIpwffGMOkYlY3+IeC89t5GV1FdJ63lRCgaHrGw9o9ZItVF68RrHFLUxcyZlr7fzIkejjqC
 xC8R3SLZaZU1+psVuXRvAr7LHwnjlxBBh/QdhiUNb6BMJA1BbOXsx4cYqsyqQ+Idqh0SJ/L6Qh5
 shKo0JCk1jBcuTE459NaxbqYZ1U7xveyKmvduk8f6VTrv0M0uyxsOE25v6fffhdXF0RqpXFovme
 me+7kukltDAnxyJy2mUoNK6fPg1dkpcPbsrupcIhlQgzsZwFKmngmo8tRr5QLWHH+/Q0dXHDNhL
 EPMKsDi8RJLlyIS2oXxYzalnTAdpJTzkZxxAU5UxmX27lW+KTlAXIDtS7Z0O+P2BJ4s/XxzF0wj
 V2GVMGxkTr9Q4UDmfTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfXyKLGyHimilrF
 a0i1ZREz402paG+U+CgqvKsSS0TAJamAzsJLRGtyk8d8z0uI/69jlES9cwoomtMgRfAFUknj6fw
 ojZ5d0eq0HzgU/S6dfrUMBhSUtGvEvFK61D0C/pb5x9Dr5wD1bgD
X-Proofpoint-ORIG-GUID: AFoEOK6IjWaSeatUZWsjBL88cC_HE1hR
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=10 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=10 suspectscore=0 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160087

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

A page-aligned new size has no tail to zero, so skip it. The old code
wrote out a full page of zeroes past the new end of the file in that
case, which the truncate then discarded.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/inode.c | 55 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 525297c7ebd8..ffab685688ab 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -718,6 +718,40 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
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
+	/* A page-aligned @pos has no tail to zero. */
+	if (!offset_in_page(pos))
+		return 0;
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
@@ -739,7 +773,6 @@ static int __ecryptfs_truncate(struct dentry *dentry, const struct iattr *ia)
 	loff_t lower_size_before_truncate;
 	loff_t lower_size_after_truncate;
 	struct iattr lower_ia;
-	size_t num_zeros;
 	int rc;
 
 	ecryptfs_iattr_to_lower(&lower_ia, ia);
@@ -788,19 +821,15 @@ static int __ecryptfs_truncate(struct dentry *dentry, const struct iattr *ia)
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

