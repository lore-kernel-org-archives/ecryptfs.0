Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866904;
	b=N+w7vX/xdBp7Y6aM5IQlON5sJtyW6z2jE+7FM9oTh+xnXFrcgcTpDpC78oN7jOAxFuQo
	 z9W5FTQvoR0Wnl7vnAtwjSdUZnZcNvoaDCd3MASCsp6DvZHCy2sfDXfa9idvS22DtZx6P
	 xbovKOO8PnuNT6o/um7FapAs6MezMyCR75ABo6lxdjPzdCHbghdOfTQe+cLL4ARBg/GS7
	 eSlQ2nVvBNQHCxJZHNOSPn3Coy48vVeNPOIzQOGdq6uox6oO7ZBu+x6QwVaF/pHhhmreL
	 TUpRdi8pxI37zzRV9fvwou3Et9wME+TjNQE37S0yOtz8wORqLwQFGP3xUw/haFjRhhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866904;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jCQCdjWXGwSTK6KbBHTCoC610xQNusLZzaXj3lRu9vY=;
	b=QfZbxroo9yCmaJ08GyeM1LPfBtgR5ECx5gRGaU5VOmWDgCNWbqdpCBDfjTVedNWoYzrV
	 3DJZwbHo5e2y6oEuYl5NE7GqewZb0jNKA3dJU3KCe4RKRR6Jw9gejJRQxCdQbYGRgvTT7
	 JsEXYBUJFb4LXf39zNebFdLPxfmIaWT8pPJuIO/TEOW3Ig/1HNJn7mWKUDFXAYndan4fV
	 qn8v/Z9Jw9YEqTZG6XIQcOmcS5iHGkhz9XstezfBg/VCjI6o9vrkZCC959M+PiGS9m0Xo
	 QGhJG1BRUdVP7r1QoXpUNpTbFnITS1gNDvtofoKs1FK710jlx6ZEtp2O6J30k0xfbEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Jj0cwWoT;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ywkyBbYi;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F606A884
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB8F606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Jj0cwWoT;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ywkyBbYi
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYk2Y237730
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=jCQCdjWXGwSTK6KbBHTCoC610x
	QNusLZzaXj3lRu9vY=; b=Jj0cwWoTPJ1LT1nEtYVY+g6wopvZb2ugEOPQhvYuZD
	rZXjEdPYzTBKd0n/Xn2H0QkYSXsJO/OUQU+SG9NXan49oxGdVH3tQCnG/gj7tMz/
	3L6Eh/do8aRZfoMXmalg6p7RAsCNIzgG0FVlNk9wo0DHSKmsyfPVtP/NQI0Ctmpp
	H7raP/Dx74Sy2BfJbdthP9WDn2DDVzGz2lEkkrpAHqIDRLHcIQv62vB8EAxUJd2D
	+55kJzkTDg4LUOlHrKKY/4VyAScWN0dBbcVdYdR2QMXnkXNXe176zsyOFAEbqW6B
	Z9ZV+K15NNLLDng6fzrtofQSHdK/dm0t/zgeBR6EZsNg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059dkb9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:22 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f26dd2165so1199804885a.3
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866902; x=1795471702; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jCQCdjWXGwSTK6KbBHTCoC610xQNusLZzaXj3lRu9vY=;
        b=ywkyBbYiDRW95M2a1ooFhISBYvF1tXOptyQi7HDLEkFUXXONSwX6hV7R7lTFoz56Uz
         akFYtpT6+6oofBGA4+/eAZOtRk+uFEq8mQ9v35mjU2bZvbqq0KyprgbdXYx/Cx2TA1c+
         STT3MbbzNNJC1/kFeFcCAF5qf9FVlZZXn646vqlzWmogftWIai51xrQs8L7r0RFVhI8T
         1Uc5628GUP09rlftVMCrKqIMEhGzAcolNqb+b2SqPomvYxOEv5LMZb636LH4IgHAU+2Z
         d1vF3xmEp0PYpZgxXwS2EktTfBSiI5u552QYEs8MRmgYZnFKPxhoix1dXY/+wSK4JGvf
         cp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866902; x=1795471702;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jCQCdjWXGwSTK6KbBHTCoC610xQNusLZzaXj3lRu9vY=;
        b=hH0Y/6xoNQQp3HiPJDeQHCBAyj+nIiLrtQglTdKTHopuYDEzy30SGFl9WkYn3R4SRh
         H1jNm+j7JXBXPVCMBN3INnkqT4QDaj+HpgUPVwwTtkMFvIhaN052PYpg+VUTIlPohc1R
         Bmz0Snd7X6tbj25lfKB8DgQe5laYuPmdQvOCTRXA7BBg3nB4+d6z5xcoQkTErjh9yHF6
         8tvqc4j1zX2Fxwqph/M7NHhdldMFiwNbAchNWFBEPqP3tFkeX+kSnwKPsSTesFizWY8c
         ThiQGw5oBqCWJH+LxXuwup7Bumnq07Bnek/8aY37axcIefp+QqkItgOPytkq9bzBjcQt
         pzOA==
X-Gm-Message-State: APuU4Z8rr6Oraslj36qmUXqEq+JzPzV6o59bED3OYA9dk+EUjrqUuBft
	dkxF1znVCjMvV0CtUMGFWbVHiTftp3SHqtmfjD+TfQJxzOBSVLoLQ7PZ5JRr0Ao/0IZ4zFtVaJs
	uZY0DoyyBzHSl6To98FSeqVloAN1XiMiDqIXwioEejCEusGg9k3GsA6o2
X-Gm-Gg: AYBFou2QKA12Su92w7A/ULkO6jhVASaaYdrijUiTb+r1ZBvf8IGjbMSn7MSJRVw2hMf
	3Y6aVYfM4bjcmvHTzuOiVNJxTQ1h2IA3Qx3gRSBYiYo1/kds4E9Ve8VipS9u2ADaOVCYHCrm04d
	/2c7HVRFRwhWCDd3sADgiZltYqRdx3CgziCfPUkVfB+1lg+rS7MeDrddLtcyVMvhxcfU4Txr3Su
	BD3I6+ehxuwQDYSOZrMYav6moOkCoyyDDnWKdeTc3k1a4GTfnZu0NY3IIBhFspn5ZJJp6GZGMj3
	JXwoeOxhgNM3IGMrZfmF3wmE9+vML0Of1etLCn15HCF5ZYQvHuKTtioVPt/RJw/6d9RJUg/DWMO
	/V2nAvWGcHcph0DoUZiQ04/JHPbFDVuTztyVcdMLn37zhblDS922nooClodU7Lcl7WkRY2vX9cq
	FzbbLOJ+NcMM+g7HTTRjuI
X-Received: by 2002:a05:620a:6cc1:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-9494bc57948mr1946977885a.65.1794866901696;
        Mon, 16 Nov 2026 14:08:21 -0800 (PST)
X-Received: by 2002:a05:620a:6cc1:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-9494bc57948mr1946974885a.65.1794866901277;
        Mon, 16 Nov 2026 14:08:21 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:20 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 00/10] ecryptfs: remove the remaining struct page usage
Date: Mon, 16 Nov 2026 17:08:06 -0500
Message-Id: <20261116-ecryptfs-folio-v3-0-1aba8e620eda@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAMZ++2oC/3XNQQ6CMBCF4auQrq3pFKToynsYFzCdSg1S0kIjI
 dxdwI3RuPyTN99MLJC3FNgpmZinaIN17RLpLmFYl+2NuNVLMylkDgIyTujHrjeBG9dYx3NFhUA
 kVCZly1HnydjnBl6u7w5DdSfsV2Vd1Db0zo/bxwjr7i8egQtusgwkFKoCnZ7RNcOjsuWe9MBWP
 8oPQR5/BLkIGg+pAZ0pfcQvYZ7nFyBUA7kDAQAA
X-Change-ID: 20261014-ecryptfs-folio-67e80ccec7f3
To: Tyler Hicks <code@tyhicks.com>, Erez Zadok <ezk@cs.sunysb.edu>,
        Phillip Hellewell <phillip@hellewell.homeip.net>,
        Badari Pulavarty <pbadari@us.ibm.com>, Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stephan Mueller <smueller@chronox.de>, Adrian Bunk <bunk@stusta.de>,
        Michael Halcrow <mhalcrow@us.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=3051;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=e9ns/mhrua12V9cs3nOxOTFGBfzridFhDLFScimnOns=;
 b=iBVxfPIBdPottMuKyPmmAPo79Z1TtTJ2eIEFxn5bup/BvRzKZWhGSUSVKFVGq+hcJWd/M6Hi1
 ABps9rU1r/nDCzVpL6RuvalHXWAsLG0wm+gt9MHin7ZrhDMws2bKUL2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: bOrSTx07ET7n3y3-GvbET989wXVSfzMx
X-Authority-Analysis: v=2.4 cv=Utf2pOwB c=1 sm=1 tr=0 ts=6afb7ed6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=bC-a23v3AAAA:8 a=yHkjf8DjpYn1_ea-2f8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfXwqOuAREiCaSB
 +afc7rU6cWvmqCEWs8UUJcfFZ0Px3vplbcneepAMzKYpvPUJI1iUKqxGhiiAHKyKYMS4mZLkSM0
 dKKYS2gZbQ3ns0t+PntWjp8PbRX6OhmjJfiFiU7nq1Ek+EvxT7uZe4A1JFFI0BK7QuRRyQXDsuI
 G7TGkNKqNZFCghxbzdiZ8yuFc541yOqyMUr87gQtL8HRWJa1pvmMiGFr9ydfr3EiRnIi1ZlE3hb
 XRHriOD52+JCWNUvZs/gwcO9E5+ZENJ52p9YlK80iftTdePMQx2vn5QfOQr1qmMv0lV3SqQtXBk
 zIYnREVoIIM+gpTQKFkomXOycp+jyVn+akvup6gi+OUMjVbJOZ0iqfKlqVUOv8RJMWx+KmJ6fSy
 BcSCvwjnifVGH3A+TaeYIyE40T8gXdcvGyERxBSu1yO7B1jM+Wes/5wBWGmH8FIILunihAMqpXM
 edoEibyL+M/b10HrgbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX2EcAJANFM9Bt
 d03iGwx2Rs1PHo/HdsYrDbVr9JkRq2hooqMGK3j3iEWa18l5UMadibg/2uQqq4RLLDd4mo9oMcj
 qaiGRY5s6SKA4qe6nfB9O97+f4oyFIpW6BPuA3nh8N3btzBjhxAC
X-Proofpoint-ORIG-GUID: bOrSTx07ET7n3y3-GvbET989wXVSfzMx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=10 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=10 suspectscore=0 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160087

Convert the page cache side of the encryption path to folios, and use
plain kernel memory for the buffers that were only pages because of the
old interfaces: the ciphertext block, the header buffer from
ecryptfs_get_zeroed_pages(), and the scatterlists built by
virt_to_scatterlist(). Also make a shrinking truncate zero the tail of
the last folio in place, as other filesystems do, instead of copying
from the zero page through the write path. After this, fs/ecryptfs has
no struct page usage left.

Three related fixes come first. ecryptfs_write_lower_page_segment() now
writes from the right offset in the folio, which matters when a truncate
extends a file that is not encrypted. The packet parsers now reject a
zero-length encrypted session key, which used to leave a file set up
with an all-zero key. ecryptfs_write() keeps the folio locked until it
has been written to the lower file.

Ran cleanly with fsx and fsstress on ecryptfs over ext4 in the default,
xattr, and passthrough mount options.

---
Changes in v3:
- Patch 1 (new): Write from the right offset in
  ecryptfs_write_lower_page_segment().
- Patch 8: Skip zeroing the tail when the new size is page-aligned, per
  Sashiko.
- Link to v2: https://patch.msgid.link/20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu

Changes in v2:
- Patch 1 (new): Reject zero-length encrypted session keys in the
  tag 1 and tag 3 packet parsers, per Sashiko.
- Patch 2 (new): Keep the folio locked in ecryptfs_write() until it
  has been written to the lower file, per Sashiko.
- Patch 7: Hold the folio lock while encrypting the zeroed tail and
  mark the folio not uptodate if that fails, per Sashiko.
- Link to v1: https://patch.msgid.link/20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu

---
Tal Zussman (10):
      ecryptfs: write from the right offset in ecryptfs_write_lower_page_segment()
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
 fs/ecryptfs/inode.c           |  55 ++++++++++++----
 fs/ecryptfs/keystore.c        | 118 ++++++++--------------------------
 fs/ecryptfs/mmap.c            |  60 +++++++++--------
 fs/ecryptfs/read_write.c      |  54 ++++++++--------
 6 files changed, 169 insertions(+), 284 deletions(-)
---
base-commit: 8f6626bd6594a78f454d02b27b74a580c890cab9
change-id: 20261014-ecryptfs-folio-67e80ccec7f3

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

