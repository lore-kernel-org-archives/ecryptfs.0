Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866906;
	b=XSLZmmipiwZAuKxu94oQVWml4O3dDdizl2HP5hNQiAon3Zq1P6cTSQ6fIATgwe/PZJTw
	 SdGbqdrbyxLSmCrRNDGoJ2qaz8Qbo5sRXHW+ntA3pHF4iFeRkHyJAxKWhUyZoEp/HG9fU
	 I8pF1PVLWxZCt+r6ozRlgl1YPS0t+mJJsfstBhkQxQofsMYNDntOlW8o2oVFP4f9Qj+bZ
	 BcGA63FnCHTpK3+OKjuglUOHFJL8X1AMiL/3mbj8a2hFtySJOlpcOkmWfV3NYITJIdc9X
	 GcHXsSNOUgE9KlcmjxLmtawlA+rZGXUaQPQD4iz6NY2Whfog6VrKcPLuQl+KMD0/2HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=h6qrbwrtZcljA9LFxH48MjMm43hAmKf2WKcXHUtxuwM=;
	b=dkjd0HgE9U1I8O7KiaBwAOIpLdVKY7uVvddZD4KU2V09dXwiIsgF9U/g4iu/8W3EqmuI
	 D8SWLvFNOSrtGGXNppRCSM8klK62o8wunjR3ipjPOsLUoGIOL4BaGzfXsAGH68SdeRU9E
	 BU35qmH0NvBcFdciPJ/OENsW4T2sP8BoQ5ifotTidGMU+hjdtQshu3yFh2vHLfQBUlMvf
	 hmRS318nDEY9Vjbsg9oV2OcpYOp9RzEYxHNd3BSQZB/dVfe8FjD7UwoVHT8Ql8tsQCG1P
	 zNMbLFAB84zvVRGSg7TYyOFkSD6pXf9uIoortJbVGsboGdUSkL6AQ2WwZTWuO0R+ECQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=EqkY1e8n;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=CpB4E3BN;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B1606A8AE
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485B1606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=EqkY1e8n;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=CpB4E3BN
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYguN4118750
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=h6qr
	bwrtZcljA9LFxH48MjMm43hAmKf2WKcXHUtxuwM=; b=EqkY1e8nl9siwSYWqxWc
	fXDu4bAwmICzw0lkk6ZWt1HZJgyPXFnjBeDFvAFsnDn7b2A3zkunqNyJXcCCHHzT
	aqY7VLLURX7D0+OBCwkbtCf4TFr02d9TvN1pATqhk59RkH6Btw2AI4iEBN4MJh2R
	sNExPuSdkM/Pogz+Z0J2PQakS+/6HqKitSWTVaZ7kCWAYW3VempY/CDd+M+4j02j
	vBpQjnTwG7rj+jPdm5/ytBHAGU1kb7NAizD82Fm1sM6NgV05wA3wDSY5l0KdLYDa
	Wkr5A/rjiWzrKMOPY1RQPR+I/LiquTT0rBu8cmAJlWs5FIYspjYCTBVLBJSldaWw
	LA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598uaj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:25 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91ea5866643so34618426d6.1
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866905; x=1795471705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h6qrbwrtZcljA9LFxH48MjMm43hAmKf2WKcXHUtxuwM=;
        b=CpB4E3BNygdOQILjiRMQ1O6LQDRnQ04U/pVgu/Ktsvi7d3FQBe7GbG5dfxh4EaVFbI
         v4T+Ice04oXXbhsuXGcpgqlD/TDAnv+2s1dL6mHnyJR+RGih4Ma2qYx5A+tOpIk7rbcr
         5wVJHLy2IaMBKVQd5jf7WR516SDyA+zmkNHUygvAeNe8xuPvl8GSp1KY67pyRjTwheGV
         au+7JCIsXPUcZqLxUkJI1mresjN+Mj0J6Dg7YbzN89kLxvn5kyu+rhCg7jsp1NcD5DiF
         mqtsTRw72OoMZxfRG/xaFJRYRPw44OUxejgrrGQtHW1QiNgYVnVRz3zAV3nv/qYaJofm
         k9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866905; x=1795471705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6qrbwrtZcljA9LFxH48MjMm43hAmKf2WKcXHUtxuwM=;
        b=TYwUmgyS5nzFzrYjpipBiwe7JE0hUnb/b7jmK9wYq+QoeadeOKet/ZxaerwkxB96S+
         YeZBFOvWNeTpcmA1MvfqWIefAINyAXnNo3VqqTqrkd3uJXagATTsjNO43egWGkIY7Qz+
         kWcLyNC+g427ZwtVt1GAVum5RWDT23Z6YNXwrH5QvNVVsfKwaF2Ty59aGJzIO8sRlZvg
         iZmdRvHfANh8Cl4ev4xv9Btjz7uTH5J5BnRLpf3Up/mtaLxrkFFvOnayVe5duc2uzba4
         0pM7P0MuxRbZbuHHCs/a5w7Y4gnfExbWOp1wt1Epe+wXVp3kpY7f3qCcmcrK+GQD6mfI
         6uAg==
X-Gm-Message-State: APuU4Z8uKPnzfFi5QRLidGq1iQOSHt5wCHtgiJBO2nuRHl/4kctLlxbR
	STzJEBcOg2uaSZw2RJzDdl2f3CnaIEm+PS6GXPVP4A1lXGPRQXgGa3q2uiLBiXoc91PKPuUAq2m
	DcnynlSugnDhyFt8h8Wvhl4kQs+TOeVcWvwxpN2bfnXi6nW5bYPLjx8cP/nPrx4Up
X-Gm-Gg: AYBFou0blg8ZvZRr/AbqoC9Z+fNz1Jfc8fDRA4nyr2dyfnNdSNFgUHEkn8ecbRnSVkL
	FkVoA2OTiryXDDUyeXWHP8TUPzB1VUC944lhuDuliaNYasSCkThR7hegz9pdtZs23voKCSTrceM
	CMw7NnDG/OkV2Li5rzcDlY4nukQzu920CPad3zQ684c3rsOSocymMCHP/awM2JEXeb280bH6/G4
	eWtzoCufUgbeOze5ZkIHoybaO03oh+89UiLAqNIZ2knWk9buUiTV7j23W1iLLbIHnLxKPBGfaB+
	5U1ss0KsYNuikk0zSdofnZqfkHMJ5oQPBhvwfxBMqwuFS30ZiO6ItcKZbei3vXA1D6KgJlSh6RX
	CislvOKHteKw8WFnSiPRIxuyiDYvgwIQ2wHGk/RXSFoevvpYgtrHvD9sAWljrrK6BG3SZxRouzB
	a40idgody79Uek9h/Adyq4
X-Received: by 2002:a05:620a:46a6:b0:949:72f0:cc12 with SMTP id af79cd13be357-94972f0cfeemr1134764685a.64.1794866904829;
        Mon, 16 Nov 2026 14:08:24 -0800 (PST)
X-Received: by 2002:a05:620a:46a6:b0:949:72f0:cc12 with SMTP id af79cd13be357-94972f0cfeemr1134760885a.64.1794866904447;
        Mon, 16 Nov 2026 14:08:24 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:24 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:09 -0500
Subject: [PATCH v3 03/10] ecryptfs: keep the folio locked while
 ecryptfs_write() writes it out
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
Message-Id: <20261116-ecryptfs-folio-v3-3-1aba8e620eda@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=1484;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=+0JDVdRUE29ZtFD36S904yuUFtAM/8d2U5cw8KH4emw=;
 b=896NCJBFn2QUG7q/8PyhplXhW/jFIKw1a8o86pCl8ay8pwvPpvf3Uq0Vzog4t9ZEUN6zm/Wi3
 jSOLkYe1/rTB8OEWvWcdSl4xYgP0VnKO63WgHwu20sJ+W0w7VApqsEV
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX6j8ug5f7QHGM
 mhzJiNq76BP0f0hod9D3QJKu+Cu3Bj/bg7E45K1Z1J9/67VxNI8jrxAT9WcB97RvjwNcTRO4hZn
 Lxbyo+klPHlGytyxcZ1wlU/16r+AcgnETV8n2vTOPD4XVnhrK+t9
X-Proofpoint-ORIG-GUID: s_PCmxxntD7VraOkFQ-taoAz7V9I4NfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX1GYwblpl/sey
 4GGZ4ClO9NGdwvc/6uRereSCsolR/4lR7/DtOg1sFemuA5SJSn+T6JqdHU8QUi4s3EczZAJNAoy
 /IyHSxL5F6TijP02w4SDnFtLM7aGeJ+nvKt3bpMfVHj08XYUWU5S98b4Vw6piPuQixilacU++6o
 FnXQGYFPCzuZEOVGlM68I5SGOm1TxWQN7HH+QfCwyywneGtygSVonau3dgh6vQOp7Ts5eIL6OWE
 a7iLWofbE5jOQjNSTQS0tYuvD6LDKF1G5I1KbJI9ll/ONNpITzCJ0AG5STOpsM1i4ap2Ll4Mj5i
 ZRIFJ1qDqX5qXBXWRFRsoNAzEjP4Pr+wjVs2zzJgd0uW6S8AtrTyLseYcp5ZQgJQwJ13yglIiLj
 ZlMohAQFwUhlU6V/uooEz6fUTm7bOyhYCb6qUKfbF1IbZQbdGQCMll006gw2YWdufwDlBt1Hzrp
 E9OtpEFvmZ2a4SzlprA==
X-Proofpoint-GUID: s_PCmxxntD7VraOkFQ-taoAz7V9I4NfZ
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb7ed9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=6Pv1HT1Rq6VQGdSdbEQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

ecryptfs_write() unlocks the folio before writing it to the lower file.
If that write fails, the folio stays uptodate with data that never made
it to disk, and reads return it until the folio is evicted. Keep the
folio locked until it has been written out, as ecryptfs_writepages()
and ecryptfs_write_end() do, and clear uptodate if the write fails.

Fixes: 16a72c455a67 ("ecryptfs: clean up page flag handling")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/read_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index e7319216a2f1..0881945da99d 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -166,7 +166,6 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 		kunmap_local(ecryptfs_page_virt);
 		flush_dcache_folio(ecryptfs_folio);
 		folio_mark_uptodate(ecryptfs_folio);
-		folio_unlock(ecryptfs_folio);
 		if (crypt_stat->flags & ECRYPTFS_ENCRYPTED)
 			rc = ecryptfs_encrypt_page(ecryptfs_folio);
 		else
@@ -174,6 +173,9 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 						ecryptfs_folio,
 						start_offset_in_page,
 						data_offset);
+		if (rc)
+			folio_clear_uptodate(ecryptfs_folio);
+		folio_unlock(ecryptfs_folio);
 		folio_put(ecryptfs_folio);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting "

-- 
2.39.5

