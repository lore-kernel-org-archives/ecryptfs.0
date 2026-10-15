Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FF376BC1
	for <ecryptfs@vger.kernel.org>; Thu, 15 Oct 2026 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028178; cv=none; b=GkoYIu+69M2ob99QWmOSiByhtU7vRtvyS+2me53OO5+G/boOgVOzBn6PlIvDhwQBV6v85mN3b9sDQr93QduqNT8UYSUb9oDIp6nnKKlKE4c0TjT6N4nCzndgImqXEpaTKgJAQm8TWL/vYpLSm9cdXCNDwVi0Hu4QphGieM1th4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028178; c=relaxed/simple;
	bh=6PcH1Ets7fX231wFfBtuXYP4Cc7vyT3z7PrZWJpJABQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbwX3crppXruqmj77LSvBNtdGQPNqV4SOhckmgJbcCVv3ie6HSIs8U+cPSkymw73uP5+8Ov4hem1yVsGdduM9OPgzG05DYpRhwqmiWrhVMiLG2nO/AQV/xkwZL9kP1esY3BNUHmYgJjpCIkQLfstbcbX99Is2fSUkiUoeRNvIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=N+/4d9M6; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TIRMWw4+; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="N+/4d9M6";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TIRMWw4+"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0YC0u3488534
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=j+lf
	0GVqDtMILeKjsssb4awbeFEUGRe4e2YBARUs3gM=; b=N+/4d9M6Rf6MLpdtZ6mT
	EgKG2UOHojZAZW70l0tBlCmpQNc/f7ClU7uwPAzxF86XmT5EMB0oYhL/3pvG1kTg
	IIatWWoUFispV9z0PoitEO84VXvp/ikyIiyuaDWzjLYYagGxa9o3rk1KCMq920n4
	k0VbfEA+ogGUtFV1yLYGHyc5ovd+NS0gqYu9FuPnZ6OmLEQYewIQCnPI3T56dWaw
	bIWKCn9f8XbJm19hZ8Zd45RqpcQqaeEhYjOIw5wNUaS9xx7cKDmEmqW9NDXGHoaJ
	xcyLSiX07mRW+qVyofil2ywpCOEKxo8rJzKPgJQeTBHhbXaC9lKq1POu6RE0YMaV
	bA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4haerutxk2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 21:36:14 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5339253dc3fso104950941cf.0
        for <ecryptfs@vger.kernel.org>; Wed, 14 Oct 2026 18:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792028174; x=1792632974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+lf0GVqDtMILeKjsssb4awbeFEUGRe4e2YBARUs3gM=;
        b=TIRMWw4+0kJPg+VNUATRNZZ/uPvP0WZi3enfE3VKixearw7E6CyWZbyoRWESD/i5Yw
         dts5NSdWMdc4lhUb5lQtz8lJ10Pf2DI0djIiI7SWJwyCIekPWDNhGTIZCtQMgSB/VbrQ
         CYSO+d/iFQbH5eEw8Vmz/Lo0CHZf/EME/Yun5iNHZt3hftiHWS68kxfAo57hJi6boYG6
         VYXBJzRLZZfHWAzUyYK+5N7lJT7+ctHxPvc6XaFVuTZG5aDq8JUPHYcXm6SzKR9RQ/Yn
         3LcwRVsbI+bjAhu3ceg7c10fI58ZsJHAKTQkiITmv4E/b0JmtJIC80dzbJNGl7P9a57z
         RgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028174; x=1792632974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+lf0GVqDtMILeKjsssb4awbeFEUGRe4e2YBARUs3gM=;
        b=JNNTpJQtZZHIuVjHuhM6ym1JN9BUMI+qmx9YWHyEmnRc9ouodf3b3iTl/nzPfnUyfh
         Epxqg//6dsxU3VtggAXG1lzfkTveCdAi99+WUWxasTYoDHl7/gm0r+DIx0TNmNlEBpDV
         Cs1IYluNZS8Q5U+mD9D3Wy3QfceVAGkEBFdFzb0Yk1Z7wwiFQVrV21Xsw7+3iWFguSJl
         bWW6o8QUcNybT4Vymr8h8zrgQm1430qeQs7tDMREsSUA6KsNfQC0SzMZ1tFrQ0OCI8Qo
         PYxArw8RnXk9XdMW1CtY9txTd1aKpI0EpYAGIZ4vGTyT+7Eq+QW7eF+uDM5eGeGZ1pGc
         N+Rg==
X-Gm-Message-State: AFq9FYK1BQO+IOs1AsaASEoLWdgRVYQVQMLtsIS1Bo2y0JXsXBezblgN
	O53+zU4kygGJDq0y0EgDytYZxzOszFqiw//lMbbz/Ma00yR/SQXieC8/hPIhP3bcQx+1Yr7eCUi
	oCFz7SxQRBBTbvOSzL9lSVl+wVGT2JqKQkK+2FEv32qbJmTot7Epk2qB0
X-Gm-Gg: AYBFou0rlsjhAdY/hCsOHZCV3caSyBfTcFgS2/niogY6QQTjUH7Botc9JOLxZmhrqEy
	923P2BwA5t5LMuR83fwqkliM0scVK/tK9BiURvBRTwjotovsSxmBN6Y9tGwoLOLdJBi5b17qQ3p
	ev6kqDr/yBKLZ+5Vp/AXAfPMfN4ezj5XZAfeh8rbuabdvDUueUaBWb6PSjhTbtyhPZhozylcUH2
	vbb4fG/bmJeNWkaoma31BDbk+tZUZi0Y96Qijo4kdf6RSfNc6ASPWUtipZ4hV1wBrflgoPo/Dba
	xAX2ZOYoQU+5oyPqjVK5eb2e23W/sbj5PCFTbQptLBapnVLArrnig2h8/ssG47qOdISjvdzCgcw
	DNB499CDfBFKJLM7dz4n6r5QpvuvWa3DdXZP4XXF3gUJA
X-Received: by 2002:ac8:5a16:0:b0:535:2c46:19bb with SMTP id d75a77b69052e-5359fb5a498mr309884481cf.41.1792028173862;
        Wed, 14 Oct 2026 18:36:13 -0700 (PDT)
X-Received: by 2002:ac8:5a16:0:b0:535:2c46:19bb with SMTP id d75a77b69052e-5359fb5a498mr309884301cf.41.1792028173414;
        Wed, 14 Oct 2026 18:36:13 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361279a933sm12657661cf.6.2026.10.14.18.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:36:12 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 14 Oct 2026 21:35:51 -0400
Subject: [PATCH 7/7] ecryptfs: refer to folios in comments and printk
 strings
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ecryptfs-folio-v1-7-f4412187b1d3@columbia.edu>
References: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
In-Reply-To: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792028164; l=11248;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6PcH1Ets7fX231wFfBtuXYP4Cc7vyT3z7PrZWJpJABQ=;
 b=2TOT/8RbFwmnZfnjenU+Q5wxDo1ENE28Y68xuVlXAucNsS97OlfUehUPZbHG/i30JloQWRXqF
 ZIdry0G8SFgDvZbyjNQLFgSKRuFL9c0rP+UYpTzC5KdSi+CWIWPiC2h
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: MxWgJWP-L8Y0bdrEUPZFtX7nTAzbuA5H
X-Proofpoint-GUID: MxWgJWP-L8Y0bdrEUPZFtX7nTAzbuA5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX1l1ruS4Ts8Dj
 KCWFXBBv6/e3VDR6/zaYNXscPUDj2gP3BlSxomsX2kBifj05UulHtZ/Ce7r2DKU4xT4t0IN2kkO
 AZfwjJx5r5OFdy4DEs9ocqzQbShtPwKfZxoRCg1mnqRgoMkNxVJAWmGYq0bIAZymspMPJ814TTM
 px6YICxk+yTXQvnB44MyC/cP6aXob/b62N5dBQm7y21ffy7zqXonenpCrOj8K+UDx8NO2TTRbDz
 O3930L0PI0rSO/O3TwsiEU1QYxk8OouxHcVjhDQrYqH48sRs1h7AHfwXl7NKROLFqOS6tHD7Wce
 Uaii0SzxpUi44aPujQ0k9YI7ORr3l8N2kIJYpW6qjeE4XDom4Et5sVvQjJEDBblarz5Rjj+V9I9
 DS6KVIsYlVEOzZY07qwrqw6JnBJr5xgxVrntYsNVfk5ijSPsOT0UMXopU8xV642M9yKs410BIa3
 rifWSWjzF2s30U5vS/g==
X-Authority-Analysis: v=2.4 cv=E5xYNqdl c=1 sm=1 tr=0 ts=6ad02e0f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=grxN3znV8bAwAY1ShfsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfXzpFND4VqU+sr
 NAR6VGZ6201gx4p7rBKo8Nw3AjVpWuSoaxsGm55kXqvelb3ie7hLRuKP/pz1cmy5ZSCSfl3wJ5E
 SX+cYt6U1DIQT+r2T58kluPGc56ObsDztCLnJJ9dYO7Oxr9X4fYo
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 adultscore=0 spamscore=0 lowpriorityscore=10
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150006

Update the comments and printk strings to refer to folios instead of
pages. While at it, join the strings that were split across lines, use
pr_err() for the printk(KERN_ERR) calls among them, and fix the block
comment style.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/crypto.c     | 17 ++++++++---------
 fs/ecryptfs/mmap.c       | 36 +++++++++++++++++-------------------
 fs/ecryptfs/read_write.c | 36 ++++++++++++++++++------------------
 3 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index bbaeb9a38db0..d426dc95517c 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -214,7 +214,7 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 /*
  * lower_offset_for_folio
  *
- * Convert an eCryptfs page index into a lower byte offset
+ * Convert an eCryptfs folio index into a lower byte offset
  */
 static loff_t lower_offset_for_folio(struct ecryptfs_crypt_stat *crypt_stat,
 				    struct folio *folio)
@@ -263,9 +263,8 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 	rc = crypt_scatterlist(crypt_stat, dst_sgp, &src_sg, extent_size,
 			       extent_iv, op);
 	if (rc < 0) {
-		printk(KERN_ERR "%s: Error attempting to crypt page with "
-		       "page_index = [%ld], extent_offset = [%ld]; "
-		       "rc = [%d]\n", __func__, page_index, extent_offset, rc);
+		pr_err("%s: Error attempting to crypt folio with page_index = [%ld], extent_offset = [%ld]; rc = [%d]\n",
+		       __func__, page_index, extent_offset, rc);
 		goto out;
 	}
 	rc = 0;
@@ -279,8 +278,8 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
  *        decrypted content that needs to be encrypted (to a temporary
  *        buffer; not in place) and written out to the lower file
  *
- * Encrypt an eCryptfs page. This is done on a per-extent basis. Note
- * that eCryptfs pages may straddle the lower pages -- for instance,
+ * Encrypt an eCryptfs folio. This is done on a per-extent basis. Note
+ * that eCryptfs folios may straddle the lower pages -- for instance,
  * if the file was created on a machine with an 8K page size
  * (resulting in an 8K header), and then the file is copied onto a
  * host with a 32K page size, then when reading page 0 of the eCryptfs
@@ -341,10 +340,10 @@ int ecryptfs_encrypt_folio(struct folio *folio)
  * ecryptfs_decrypt_folio
  * @folio: Folio mapped from the eCryptfs inode for the file; data read
  *        and decrypted from the lower file will be written into this
- *        page
+ *        folio
  *
- * Decrypt an eCryptfs page. This is done on a per-extent basis. Note
- * that eCryptfs pages may straddle the lower pages -- for instance,
+ * Decrypt an eCryptfs folio. This is done on a per-extent basis. Note
+ * that eCryptfs folios may straddle the lower pages -- for instance,
  * if the file was created on a machine with an 8K page size
  * (resulting in an 8K header), and then the file is copied onto a
  * host with a 32K page size, then when reading page 0 of the eCryptfs
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index d841610644ed..305231cd5336 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -188,16 +188,16 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 					folio->index, 0, folio_size(folio),
 					inode);
 			if (err) {
-				printk(KERN_ERR "Error reading page; err = "
-				       "[%d]\n", err);
+				pr_err("Error reading folio; err = [%d]\n",
+				       err);
 				goto out;
 			}
 		}
 	} else {
 		err = ecryptfs_decrypt_folio(folio);
 		if (err) {
-			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
-					"err = [%d]\n", err);
+			ecryptfs_printk(KERN_ERR, "Error decrypting folio; err = [%d]\n",
+					err);
 			goto out;
 		}
 	}
@@ -264,8 +264,7 @@ static int ecryptfs_write_begin(const struct kiocb *iocb,
 			rc = ecryptfs_read_lower_folio_segment(
 				folio, index, 0, PAGE_SIZE, mapping->host);
 			if (rc) {
-				printk(KERN_ERR "%s: Error attempting to read "
-				       "lower page segment; rc = [%d]\n",
+				pr_err("%s: Error attempting to read lower folio segment; rc = [%d]\n",
 				       __func__, rc);
 				folio_clear_uptodate(folio);
 				goto out;
@@ -291,8 +290,7 @@ static int ecryptfs_write_begin(const struct kiocb *iocb,
 					folio, index, 0, PAGE_SIZE,
 					mapping->host);
 				if (rc) {
-					printk(KERN_ERR "%s: Error reading "
-					       "page; rc = [%d]\n",
+					pr_err("%s: Error reading folio; rc = [%d]\n",
 					       __func__, rc);
 					folio_clear_uptodate(folio);
 					goto out;
@@ -307,9 +305,7 @@ static int ecryptfs_write_begin(const struct kiocb *iocb,
 			} else if (len < PAGE_SIZE) {
 				rc = ecryptfs_decrypt_folio(folio);
 				if (rc) {
-					printk(KERN_ERR "%s: Error decrypting "
-					       "page at index [%ld]; "
-					       "rc = [%d]\n",
+					pr_err("%s: Error decrypting folio at index [%ld]; rc = [%d]\n",
 					       __func__, folio->index, rc);
 					folio_clear_uptodate(folio);
 					goto out;
@@ -333,8 +329,10 @@ static int ecryptfs_write_begin(const struct kiocb *iocb,
 			}
 		}
 	}
-	/* Writing to a new page, and creating a small hole from start
-	 * of page?  Zero it out. */
+	/*
+	 * Writing to a new folio, and creating a small hole from start
+	 * of folio? Zero it out.
+	 */
 	if ((i_size_read(mapping->host) == prev_page_end_size)
 	    && (pos != 0))
 		folio_zero_range(folio, 0, PAGE_SIZE);
@@ -443,8 +441,8 @@ static int ecryptfs_write_end(const struct kiocb *iocb,
 		&ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
 	int rc;
 
-	ecryptfs_printk(KERN_DEBUG, "Calling fill_zeros_to_end_of_folio"
-			"(page w/ index = [0x%.16lx], to = [%d])\n", index, to);
+	ecryptfs_printk(KERN_DEBUG, "Calling fill_zeros_to_end_of_folio(folio w/ index = [0x%.16lx], to = [%d])\n",
+			index, to);
 	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_write_lower_folio_segment(ecryptfs_inode,
 				folio, 0, to);
@@ -465,14 +463,14 @@ static int ecryptfs_write_end(const struct kiocb *iocb,
 	/* Fills in zeros if 'to' goes beyond inode size */
 	rc = fill_zeros_to_end_of_folio(folio, to);
 	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "Error attempting to fill "
-			"zeros in page with index = [0x%.16lx]\n", index);
+		ecryptfs_printk(KERN_WARNING, "Error attempting to fill zeros in folio with index = [0x%.16lx]\n",
+				index);
 		goto out;
 	}
 	rc = ecryptfs_encrypt_folio(folio);
 	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "Error encrypting page (upper "
-				"index [0x%.16lx])\n", index);
+		ecryptfs_printk(KERN_WARNING, "Error encrypting folio (upper index [0x%.16lx])\n",
+				index);
 		goto out;
 	}
 	if (pos + copied > i_size_read(ecryptfs_inode)) {
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 611f74061441..a1949c769225 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -48,8 +48,8 @@ int ecryptfs_write_lower(struct inode *ecryptfs_inode, char *data,
  * @size: The amount of data from @folio_for_lower to write to the
  *        lower file
  *
- * Determines the byte offset in the file for the given page and
- * offset within the page, maps the page, and makes the call to write
+ * Determines the byte offset in the file for the given folio and
+ * offset within the folio, maps the folio, and makes the call to write
  * the contents of @folio_for_lower to the lower inode.
  *
  * Returns zero on success; non-zero otherwise
@@ -80,7 +80,7 @@ int ecryptfs_write_lower_folio_segment(struct inode *ecryptfs_inode,
  * @size: The number of bytes to write from @data
  *
  * Write an arbitrary amount of data to an arbitrary location in the
- * eCryptfs inode page cache. This is done on a page-by-page, and then
+ * eCryptfs inode page cache. This is done on a folio-by-folio, and then
  * by an extent-by-extent, basis; individual extents are encrypted and
  * written to the lower page cache (via VFS writes). This function
  * takes care of all the address translation to locations in the lower
@@ -133,10 +133,8 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 				ecryptfs_page_idx, NULL);
 		if (IS_ERR(ecryptfs_folio)) {
 			rc = PTR_ERR(ecryptfs_folio);
-			printk(KERN_ERR "%s: Error getting page at "
-			       "index [%ld] from eCryptfs inode "
-			       "mapping; rc = [%d]\n", __func__,
-			       ecryptfs_page_idx, rc);
+			pr_err("%s: Error getting folio at index [%ld] from eCryptfs inode mapping; rc = [%d]\n",
+			       __func__, ecryptfs_page_idx, rc);
 			goto out;
 		}
 		folio_lock(ecryptfs_folio);
@@ -146,11 +144,13 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 		 * pos: where we're now writing, offset: where the request was
 		 * If current pos is before request, we are filling zeros
 		 * If we are at or beyond request, we are writing the *data*
-		 * If we're in a fresh page beyond eof, zero it in either case
+		 * If we're in a fresh folio beyond eof, zero it in either case
 		 */
 		if (pos < offset || !start_offset_in_page) {
-			/* We are extending past the previous end of the file.
-			 * Fill in zero values to the end of the page */
+			/*
+			 * We are extending past the previous end of the file.
+			 * Fill in zero values to the end of the folio.
+			 */
 			memset(((char *)ecryptfs_page_virt
 				+ start_offset_in_page), 0,
 				PAGE_SIZE - start_offset_in_page);
@@ -176,8 +176,8 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 						data_offset);
 		folio_put(ecryptfs_folio);
 		if (rc) {
-			printk(KERN_ERR "%s: Error encrypting "
-			       "page; rc = [%d]\n", __func__, rc);
+			pr_err("%s: Error encrypting folio; rc = [%d]\n",
+			       __func__, rc);
 			goto out;
 		}
 		pos += num_bytes;
@@ -230,16 +230,16 @@ int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
  * ecryptfs_read_lower_folio_segment
  * @folio_for_ecryptfs: The folio into which data for eCryptfs will be
  *                     written
- * @page_index: Page index in @page_for_ecryptfs from which to start
+ * @page_index: Page index in @folio_for_ecryptfs from which to start
  *		writing
- * @offset_in_page: Offset in @page_for_ecryptfs from which to start
+ * @offset_in_page: Offset in @folio_for_ecryptfs from which to start
  *                  writing
- * @size: The number of bytes to write into @page_for_ecryptfs
+ * @size: The number of bytes to write into @folio_for_ecryptfs
  * @ecryptfs_inode: The eCryptfs inode
  *
- * Determines the byte offset in the file for the given page and
- * offset within the page, maps the page, and makes the call to read
- * the contents of @page_for_ecryptfs from the lower inode.
+ * Determines the byte offset in the file for the given folio and
+ * offset within the folio, maps the folio, and makes the call to read
+ * the contents of @folio_for_ecryptfs from the lower inode.
  *
  * Returns zero on success; non-zero otherwise
  */

-- 
2.39.5

