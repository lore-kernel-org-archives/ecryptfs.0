Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356007;
	b=ziLFZtM7QENc00Y7CGO4t7mNTemz43rvSZ9MO08iYBplAllfvLBI/AlT143smPslqer0
	 RW6CzmIcaxFUVl6NSYbcMqwIH3c+YG2zm8UuQ5bKZZXJDPSXa1Tw+UvEcsrF5c7dR/tEz
	 oEovR6LpAqrYQUyFHgWiG8QYXJCWIbZa6Z9Nt5INxZZUtt/qSjnRdax8JiRGWHwRqAYDa
	 8oFzwkYgVioGV2TXkXAdFLFLSKWkV07mgSN5ibQOdUQ8euJgPHcADT/Y/vWtc+YDn1MKj
	 ZprwmW+t0mjcDUvGV6REu7Nt0tC9qmXdAZjsLV3UTx8eyKefuhWoV4TH3rTQp4FzTFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=59Ozb7vPHHK8a62sFDWgZOfWdnPHAJYeNCW/LcPyMCk=;
	b=mr5M/Vwu+LDANtHjL591ibXmTOX9+G72BzBEPXaOqp1iOJ+JZdesl7d4NrOj1IrFzEr0
	 O0x1K2TXp8x8NY5dVJ9l8QIOUqlpY08I6fmSpJfeTqVlscrn4nX74twgfakySJhbvU78o
	 R9CM9tRKN6x52IZ99ZPFmT/XXRX0InucwT5aBqo+G7bJEWR+JdRYymf1GwtdTFhWt7oO1
	 mziEmN5uH/8tV30I4Bq3uz679wIvcURlLQrefJeNzhUGsH4DYhXNDJ98LxlkUWfjJ+fX/
	 dXkWFb8S9fQXhpKskAgAPTd7PJtATR7T5c28YOW0dD/s6NGIysSGib8EajuYPwN68zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nhc+FC4v;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=bxGxoOET;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160C606A31F
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 10:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7160C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nhc+FC4v;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=bxGxoOET
Received: from pps.filterd (m0167067.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UAL6qc916500
	for <ecryptfs@vger.kernel.org>; Fri, 30 Oct 2026 06:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=59Ozb7vPHHK8a62sFDWgZOfWdn
	PHAJYeNCW/LcPyMCk=; b=nhc+FC4vA/6tt68a/uzpF45cTcNXjM9fomuaWnrk24
	GABlqMOB9FLLM0zL5xBDE+JeCUGsR4Q45Fh+p9fwzb8tvmKPZSH2gHwxqVrUfiHB
	mB3q668KCodAp2WUS/FTAsEvwy1iiQpiW3Ud0EcPvjYzvT6k/sr55xc1pRoNVVZy
	4K532A7jwMz1QmmStaCC3S7eleunbLZy5Z+rEu/HF7AsxJQv1W7lALu/o/yWO3Sm
	U+ah4zasDjPtVlc9eHERw190gxz9xQBQMcgZzrI69th0Usr1Zfep0z58g4R3PwlI
	wM5TdxmR80vWQ43A3iNpAEi6VX3BxlsoBSjWCHXF7JlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm7k00ftn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 10:51:45 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb98809caso364268685a.1
        for <ecryptfs@vger.kernel.org>; Thu, 29 Oct 2026 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285505; x=1793890305; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=59Ozb7vPHHK8a62sFDWgZOfWdnPHAJYeNCW/LcPyMCk=;
        b=bxGxoOETAOgWOO1s7MdulElS+gLjRmbeIRlaw6tMgRLMKi8BaAYl5jw8Q/fashY3kX
         ZA+iEPpjyQBtD1A2RRjYbvlV+fPtHoA9YWlZclVldM+6NimZSSQPZACIjOyPAsDibOz7
         tEixvKSFkcu6MWxgLEqeu7hSs2dAK3NQsiWiL75UGpETFbR1S88WvKYZb/Tqq1kiF5zp
         oJHQC/d8z7+UOL+YwaAQX1sWyql4ZAzy+h+jPZXevhtFNFzDWhL5DFWI/SVr14JCLnz0
         XQpOhbvST5bDdEOzWJH/2hrmJ+qCiuAzt6nhainsupCAlo/DCnlvFpvMCg2dvDHF6Wbu
         Lt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285505; x=1793890305;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=59Ozb7vPHHK8a62sFDWgZOfWdnPHAJYeNCW/LcPyMCk=;
        b=WTIoPZOSBZAPP3GpcS2H2YoBoy1vDouMAlzfJGpJ+U0nIzTD2aGBbny/wchwN24nTf
         XYY5c0n8S/CRB3e4+j+rNwZ5iHneVO8sHJ1aC4oePVHtH5hJJbnLoOC7c8kecSh237Ga
         HvA5KNpDOigUU7JFWoTK8w5C8GxSC+/lJJQ+nwkFTzt+7xYk75KCmhqX9eA0e9I6ofIR
         15fgMqQ/CLCdaYFYU56sbkdGzmZvZBtaxFSJruJKM6NV+L0UvHKsfkhYcnRyYeePG4JD
         5+/i3M3kOQDFwVsH54xa+CIIJ+HBsFKq5nrlfdIcspqrb4J2qyTe2Wb2mVZsTrCQnR7j
         6KNg==
X-Gm-Message-State: AFq9FYLCOqA1a+gxNW+Nb6bl1t6Nrdk1tJPjMpbL0t4NFPCoZ6YGI+Pw
	e7qUnhLv5xdH+gpqAe2JhoNuzsTmjhdjgkHFVrNAnbyY3UW+bU+gRKZNLwG2EW+jXTNhU9qYaNI
	Cki/5S1KSCCiagEF4RNxcLLt2bmxO1sB4QLgv4RqnlfOXS3fOC8eAfiPx1F0FGgRzuwk=
X-Gm-Gg: AYBFou2RdIZ9orNF5OJIKl9B/3CnsfWmQHx+7+Itfi1+i9Lsaffc77ExPjBHOPkzUN2
	nHkJ/0hpmFIi8jhl0Mf/F1PfyiAkjMtHYxSBYYIBAGBL4Hkda2bbVeGavApasqyOJR8UF7BVQTy
	rOMA8xQ/cVpC3q6JFC/XCOhXN4uP7/Q9wE6NwEzmtZw2L6F4ocNqY22FYCsyFFl5NEpVsrM9JPp
	JQD9swt2+hY4vx6Iqc0Bifox7MCJ+LpYHq65jX5w/ncUOTL19HeS1/g6wusQnwvinIlPG/PSdOy
	rxMBZ9VR0oOoQVp4b2JuyWlnWFtQHlfYMyb+mz0JnBGOmzX7/wKyRcPTHR62JOEYp1YticzMYK1
	lxrlAViGJeQQ239ihw3rRIOJG5Oykm6RZLeVwWzVH208JpmJoDczvXqPZoZwzgmLraYhq72w/5K
	94q4xnBDoTl+Plj+g=
X-Received: by 2002:a05:620a:4107:b0:93e:f0b9:505a with SMTP id af79cd13be357-94408ceb986mr911546585a.58.1793285504515;
        Thu, 29 Oct 2026 07:51:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4107:b0:93e:f0b9:505a with SMTP id af79cd13be357-94408ceb986mr911542785a.58.1793285504013;
        Thu, 29 Oct 2026 07:51:44 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:43 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/9] ecryptfs: remove the remaining struct page usage
Date: Thu, 29 Oct 2026 10:51:21 -0400
Message-Id: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAGld42oC/3WNQQ6CMBBFr0JmbU2nECCuvIdhAcNUxiAlLTQSw
 t0FXLt8yfvvrxDYCwe4JSt4jhLEDTuYSwLU1cOTlbQ7g9EmR42ZYvLLONmgrOvFqbzgUhMxFTa
 FfTR6tvI5g4/qx2FuXkzTUTmMTsLk/HI+Rjy8v/GISiubZWiwLBps0zu5fn43Ul+5naHatu0LL
 gdYgsEAAAA=
X-Change-ID: 20261014-ecryptfs-folio-67e80ccec7f3
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=2528;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=MHQHbr1BCeZw176BeIq+ezbLBqffStXmrVqOaMJ/nQQ=;
 b=APpNhk/GxBuPNTA1HtPJwEIP5w1L3UgpougRu8JilBee/ZtfG3Q/Dj7aPnByh50bWA4aRaP+K
 lDThVxwrrvIB656mxpXMe5TqSGeoZLqDZa7kmu+umjOJ9g6i/Fk6Fgw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=10 impostorscore=10
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OGskvZKi-d3GGGTnDRwiH8IlBlJ3D_UH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX4yH/jpzqn+R8
 GoAJBZzyTMtLgv9aCCnRWVNQQtnGSBx58B54ptR+8cuoe2QRYkDoPToP7/+kIgB5WM2OsPmYLj2
 q7mTXaXWR859egrSJIJomOHJKZlnsVqtQageqoLZt4ji8o5eaFwkQKKnShn4Y9zdbjYZJ4jOrF0
 UOng1yiWPiZ6CYUr7KckwEBRh1sV+nOjWY8BDj6sK/dS4RGPP7Ses/Tk3Mexn0Fq9SWaU1QMxNj
 XJoWBe0fJKbIVX5k23IOfQNDuZIlJtBXeLKCVTY9eSoyWKZaAYIABkXOd2+LtMy4qOkkC1kfuuc
 v4CtyqLZpYc/GnY9J7cNmqQQGut8R+u4TUayJ4U4deOjVpbrGdIBnzWYRmlvnCbhdHv4rnywORo
 dbomKem7GRDKlXupR5lWh4j8EFB1VVDut4VWuXGMKYnfE1cQLdjsJ90ZeyHi0svpHSv2+hmsguZ
 a0dW9l2k79mTxOXcfug==
X-Proofpoint-ORIG-GUID: mT8HqdEwn5P17I0c1APQKsVIKKf1CmFX
X-Authority-Analysis: v=2.4 cv=BKEmP1QG c=1 sm=1 tr=0 ts=6ae470e5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=5seVXgKEpYMQFUWKuG8B:22
 a=bC-a23v3AAAA:8 a=yHkjf8DjpYn1_ea-2f8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfXy/PFbr5KPX7x
 DpN6E+R0lNGCBJSPBfS9B/t60PjIdTkpmRVMMub9KhDXU6jo0pEC9s0YFYWOMHjgwcRyTdgtheX
 7CYWDbk7IzmQWM/cHFahslmF5MXfzggrs8XiH0HL7plkcC3dEMNn
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=10 suspectscore=0
 bulkscore=10 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

Convert the page cache side of the encryption path to folios, and use
plain kernel memory for the buffers that were only pages because of the
old interfaces: the ciphertext block, the header buffer from
ecryptfs_get_zeroed_pages(), and the scatterlists built by
virt_to_scatterlist(). Also make a shrinking truncate zero the tail of
the last folio in place, as other filesystems do, instead of copying
from the zero page through the write path. After this, fs/ecryptfs has
no struct page usage left.

Two related fixes are included: the packet parsers now reject a
zero-length encrypted session key, which used to leave a file set up
with an all-zero key, and ecryptfs_write() keeps the folio locked until
it has been written to the lower file.

Ran cleanly with fsx and fsstress on ecryptfs over ext4 in the default,
xattr, and passthrough mount options.

---
Changes in v2:
- Patch 1 (new): Reject zero-length encrypted session keys in the
  tag 1 and tag 3 packet parsers, per Sashiko.
- Patch 2 (new): Keep the folio locked in ecryptfs_write() until it
  has been written to the lower file, per Sashiko.
- Patch 7: Hold the folio lock while encrypting the zeroed tail and
  mark the folio not uptodate if that fails, per Sashiko.
- Link to v1: https://patch.msgid.link/20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu

---
Tal Zussman (9):
      ecryptfs: reject zero-length encrypted session keys
      ecryptfs: keep the folio locked while ecryptfs_write() writes it out
      ecryptfs: remove struct ecryptfs_page_crypt_context
      ecryptfs: use a folio and a buffer in crypt_extent()
      ecryptfs: use kzalloc() for the header buffer
      ecryptfs: use sg_init_one() instead of virt_to_scatterlist()
      ecryptfs: zero the tail of the last folio in place on truncate
      ecryptfs: rename functions to refer to folios
      ecryptfs: refer to folios in comments and printk strings

 fs/ecryptfs/crypto.c          | 145 ++++++++++++------------------------------
 fs/ecryptfs/ecryptfs_kernel.h |  21 ++----
 fs/ecryptfs/inode.c           |  51 +++++++++++----
 fs/ecryptfs/keystore.c        | 118 ++++++++--------------------------
 fs/ecryptfs/mmap.c            |  60 +++++++++--------
 fs/ecryptfs/read_write.c      |  52 +++++++--------
 6 files changed, 164 insertions(+), 283 deletions(-)
---
base-commit: 8f6626bd6594a78f454d02b27b74a580c890cab9
change-id: 20261014-ecryptfs-folio-67e80ccec7f3

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

