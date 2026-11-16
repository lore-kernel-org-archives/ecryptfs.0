Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866905;
	b=wUiDblfLxiGrwssIbLVTJt+zIcfyOXpxKH33vD7+44lceyXZR/hkNpUrHbPjg7kOMa7o
	 Y1lDKJ7OcGkl2sqfaVwtUlTOnGsdJzS6uw7X5LfptGZP3Q8xT023y2XktkpAM//JpFWvM
	 9cCYQ2wrd9e7e1yT0+Sdzm0oC4T8ydPhFy9J9r3w9DEgm5/taVvnunGio5yivsrIPUWc6
	 6qPDQSeKKXbgf9ig6zi1sIFuZHIscct7dpPqsAX1tMFDXznQM2KLF9dAjw85U8c5VUqV3
	 F0ffpTA0HJ2VP49NRyi2YlKCJgfvWbUTve4L0QJuf2LXELyDqI3u2brm0we7lOhhOHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+BUUSRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=;
	b=4j5cw3u5SjHebuVo0VtvseWK4yHR1xVPTWQELOPGpFi6otOjtG8DKNF+rP0gJCp+mfBO
	 O7mW5nJk4brgLqD4ebRjgvAdbHAooMcEMDE5vxKBliKJdoPr4wfWQGeHSXTWBJrkv2sZY
	 gvL25r8sjHElgS0+5O9puKiaTppmIoA+33ahQwEOF2rlglAsPPmsPjz52Gu/9FR8FVlO8
	 uxh/r7KqNaE+9qj8pDrW7OXJPryFG3345LEomI4Fjt5+gJ6zNyWBG5bU/Zf61nkPSFWj3
	 FfdlLPTJo0iUx5oswE+6KZGpki0PuB8oAbUyMo+O8FzVCOosD9WM4Oh9xoquTk0BBRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XCfCoTmS;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=RZHzNF76;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C58606A898
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C58606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XCfCoTmS;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=RZHzNF76
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYs7k4118979
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=+BUU
	SRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=; b=XCfCoTmSY5EFYB4UlYO3
	80KSJrmAjvpCy13G/7eRM9eEXwpIlRuFzA4kHNFsO20yTgGsDX5QMA5i5OSPcnmG
	qhny2iVdJOhrv+AUOEannZXhta/zsceJI8wJmWaA+onHIlxCnIAN9Kw2j5hBPEdC
	2dznpzvcnDH7fk6rjBjQuawSp/HKgLSLMJduBGNbw8OnviEitOL/2ix5f9ItVZFD
	ZQbGQgl2EMCJkapkA+2vHjy5b+uoUP+EvFRIsM72S/2PM81B5MZRRmOkFKn57H1H
	41kPqEZmb9eV4lwpj5QErk73vRRmX+aLGn1Uldy4be1zMyfUJMfDYJMTrwStNDXw
	Pg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598uahu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:23 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so1199808885a.3
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866903; x=1795471703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+BUUSRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=;
        b=RZHzNF76vicFbD9HdD3cNyFfDayJNjPNAPA+hdOgJn/PM0eKjHCwhQaMuUTp4B5S+U
         r3q3Azj8VK/Uebbl0Kp6VmEU2JQl/TRSnxHCGd57nqKAIi9MO128FfcEqVOhu2HBznN6
         37IhREefrt+Rdn8nXmuoIbxn0tT1RoEkHyhD0Q+yazKfNsAoikgLBJ85OWQUucU48imM
         Sti0AQgiYTfANigQd5PMOdihtUPg+NQ41dmdQ+UZ1/3buSafeUiNmI5I2m3/btjYBOhn
         HKssHx5XGp1QcaxY9/Ql+SbVln5V0D15Ofz+AoTckst9CQhaCWNXzOtIMi429affJDIJ
         67wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866903; x=1795471703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BUUSRwCH/JdV2kxSN0x89NUf4xI3ym93qQBVLdW8AU=;
        b=HUFhq0lu8CwLqBg3eQ5JEQ+NgN8R+GrJaFnXobM8c2otkJBhGBFEelH69Eq2oGGz7L
         yQe24FvIqJYo3pxgwlehxvJkehCDSLmIvMxglO/R9IC1KN0OC/ZPFHDEsRY9uvL3phj8
         euvGmHLLLtyZWD6rB0EJuNDyV2WmRzZCd9eFiE5EDJ6wc5bzc3BkodiZVfp/df1Xroh1
         dUGeGzP5VsF9c7MII/2P9XRrgGjTZ+4qbxMPRYvunHckvq8mhOGM623J3hf5tswVPiOk
         jXGN6D9cOnJ457oRs+tv+HaGeqyqbKuBT1H8RaNrde5yQsfgduiVaI9m88xxKqdO0A6R
         N5tQ==
X-Gm-Message-State: APuU4Z8WeFOWOrds/2BPysjpxDJYcXzxzY63B4ZgBXSnmaPvL/R4Qhr9
	uwpE7fOdp8XmBuwmtSxHmiU4p23/NjZcsnp9ISZC0OPhJZtENmJ1w0rgOaJV8+7Vw5bbic3XJIl
	Kq+JPNORRk8f3uClSr8eqOqaqmDWfsJ4E8QQzfOtZOS8nbPi6DgMzg4OODuXNWkOG
X-Gm-Gg: AYBFou3LufsGaqFTNH72I11WK2WYKuVvopI2OgdANfrRlxqjbYFt+OPKwNqJ3V7luY8
	6nQltOoUN7brnCLHu3eKVIxj4QH+DI6JvY0l/xsus0HQ7X2BC2XkmOttO+hJDn+YEV2KJo0/o0T
	CjL6B2z5nFhkVPua1Mx6INKn3ZfzA+B8OfzNClWm7xTvydKHB4yShmuTLDBKRHEQP3HOXrNKTUG
	T5KvYMOmsdsfTXfajIxELPeHQIK/++6u4iR9qT8QDYL8LaVa9NI5vpucY0eUQ2vmVYDvCKHlXs+
	lyFtuRDA1hO9a2WoXQVIu2U2QWlgJtuv2fHG/6eY9FUigCeN7K8h7UFUGLWS8D4UmhosQltNYr4
	3TPzoEZDCtaPaaGf9Ajb2gbZvo3ZWs/BsDMmB5dNB58PfF0bYBT5jm/kvrqZjWrgNxdG2xY0+ZX
	c9SL/7oLcNTOeJ7aOfcdTq
X-Received: by 2002:a05:620a:199e:b0:93f:26f6:6bab with SMTP id af79cd13be357-9494bb76ff3mr1959301585a.18.1794866902803;
        Mon, 16 Nov 2026 14:08:22 -0800 (PST)
X-Received: by 2002:a05:620a:199e:b0:93f:26f6:6bab with SMTP id af79cd13be357-9494bb76ff3mr1959297085a.18.1794866902376;
        Mon, 16 Nov 2026 14:08:22 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:21 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:07 -0500
Subject: [PATCH v3 01/10] ecryptfs: write from the right offset in
 ecryptfs_write_lower_page_segment()
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
Message-Id: <20261116-ecryptfs-folio-v3-1-1aba8e620eda@columbia.edu>
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
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=1534;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8Nz9Xv25MqfERbysf6jE5yhp7runCvsoFyhssOE8ZqE=;
 b=YSWHWjqVm/aXu2+0BIhr176Uk7LNmJVnPY7NZOSaiXT1hUctM7vw3CitrApYmY74EL/cvlqEl
 8SEBxp2ZeMtDY1Z8YUKXjcIoqKArtu9zOTlq+hKxZQCfnTt5OmFC1nW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfXyLb761EqhAde
 EFAOaO2APkTVdgpgjSCyXVa6fN6A+7NJ3DlmuWIIwlU9DkE6PX6LSV2VReBhzqi8kykLdh09HdA
 9iasIyIDuYnK47BlH6+sPfJ+X5f5gUWVvAYeFsfeiAasWvf3FXW7
X-Proofpoint-ORIG-GUID: 7wisgf4qfA6oOYRYG6IQXZ7O6utAY_u7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX3zGubRk9PrK5
 DVMO9ZOHAkltsq6NYgpqNcGI+9QE6WZeWhS5/aht2A3QBoUsWx4DgA07lGGgLeRh8uPgk7+RzT4
 3KZ4Gc22wgTmV/k88EbK7xc3RJ/rVVIPnxGMR3iXuADLRGhJ1IqTgEmrBE1cTgo2u9yMlP2T7vZ
 id4QWFk5DVJsZxcxbE7Qdcoh6d7SGvy/cj/5S4GsLW0Bc0GMYiTD7PP0y5mX8q3QG/KciLdTyh5
 NQntHXwu4FY07RHTdcaJYF3L8/vYAQJuGzdKP4B1GrV/2YcvPuP20fTTgSTgmxSIG1mYh/Cscu4
 dxhRUHGqBxquw1AgbKoZJmtLU/XZ8qj6vqYkMKuVFQgO533p9DL0whYKObUp6Uqw7BsN2mLsDBS
 1SJAu0hiKdrNlEV2vOBs70Q0QVYxF8jVZQtNWBk+tU6RrCxPJLUqKuLsts6Pg+Svj8UPaQjvEqu
 HZUAWFXIAXH6QW1RpdQ==
X-Proofpoint-GUID: 7wisgf4qfA6oOYRYG6IQXZ7O6utAY_u7
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb7ed7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=w15lwMz24VFeALwmIwgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

ecryptfs_write_lower_page_segment() writes part of a folio to the lower
file at offset_in_page, but takes the bytes from the start of the folio
instead of from offset_in_page.

ecryptfs_write() calls it with a non-zero offset for a file that is not
encrypted, which is possible with the ecryptfs_passthrough mount option.
For such a file, ecryptfs_write() is only called when a truncate extends
the file, to write a zero byte at the new last position. The lower file
gets the first byte of that page instead. If the page already holds
data, the last byte of the file reads back as that data once the page
has left the page cache, although it should be zero.

To fix it, map the folio at offset_in_page.

Fixes: 13a791b4e63e ("eCryptfs: Fix data corruption when using ecryptfs_passthrough")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index b3b451c2b941..e7319216a2f1 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -63,7 +63,7 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
 	int rc;
 
 	offset = (loff_t)folio_for_lower->index * PAGE_SIZE + offset_in_page;
-	virt = kmap_local_folio(folio_for_lower, 0);
+	virt = kmap_local_folio(folio_for_lower, offset_in_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
 	if (rc > 0)
 		rc = 0;

-- 
2.39.5

