Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866916;
	b=J789nRWt9z6mda+F+ohQyKMm7WUbTVM/lnMJDvlGBetuTAgw7NpW/Gh1wD4zpXS+bI9U
	 5QOXyNQTzauUFpFkqTstyYBXdNIrYcQOJgUpSV2rDDssPfaTkQk7OtVgQkJW+guDCWuGX
	 rZ3eLYzPK8ZsyJo7j+sJiuD4wInZubtY8AZX4P/LFBlGZIQ1lBTUygT/u3PZvZHaV1qoD
	 VdhgQIT1kuWoQkOa9Qpsx53VUEWxsX8y9S0tC9FPsMMFK5ARt43bmfIU3yvmt8xs//Ss8
	 8k3/wWGL89y+STEuErbtwqgs15xX3Izr+DzwNJkHgWiwxbK9Y6vGctaHwg06Rtaq3cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sB/Rgxdi0CHGT1x1y6c2xryTvIBoyqac6aBkvdP57ls=;
	b=uTmf7kIoN3bDHcdHaS15Ystq11Gi3xxtLSoIxlAXutF51N5tKVrLKJwuSXl8tYaotszT
	 haCYy7On9meqdhbRe7OwLJseZ5V98R1rX++sdJZmb42PGdUEYc8m2IA0OueNworR41+mG
	 xeRQtILWB3kQ+gRmgJysL5HU/KP8H6O77RjgB213f/fjSkMcwX8b7ak7srBlTa+bSs9YR
	 S11MaYYMdkaaK2jCVwIdjAgU+FGXIfeNn2h2JwzD2PjyiNTutJf5YzBDuBbt0xW2piPSL
	 B9sQYoN5LX6AZEJb8iNZ2IheIkQg07XHCx7iI8Jr36SxWo6lhqVT4Nz7ofG9Wl45g+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=poRr7yTh;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=j0mts46U;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38260A380B
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C38260A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=poRr7yTh;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=j0mts46U
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYiw34118846
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=sB/R
	gxdi0CHGT1x1y6c2xryTvIBoyqac6aBkvdP57ls=; b=poRr7yTh+BiFEHHRGyYg
	5tJ1+B2QSefNvCmmXEuxAIzA8TSBeSqBsjNeCO3YA6rLIfWv5+3GkY60Vuins9+E
	+wxJztMIIU+PDBfBbQmVde6aVGM+YwwF8KgTdPgcH1VGaNXjgsaPPqZSJtzyeWxr
	BI0e5utcdbnY8lI/VwHG6KIky2Lh3mCbFGMuiVh0MHkRM/i+ABNSA224p+QTiWRo
	o93GxroNs10ZokUbW/aC6OBnlBivLxjYVtwTbQQbaKlaqcTfuCaA1Bey2JgMY6ti
	HJDuVYEnLN7nA2WYhvfv3dvhPVGEBuu8DYbF5I+R4VPkxBHljtjOoHdLOcyb81dc
	dQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598uaks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:32 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2373e9b4so440225385a.1
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866912; x=1795471712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sB/Rgxdi0CHGT1x1y6c2xryTvIBoyqac6aBkvdP57ls=;
        b=j0mts46UkE4f+3slnTq2JpBc3b+iPvpjUxKE3ODG4FwoHEpUaPVYg61D9st87iAZ70
         wRijEXiZk1QbMSM2VVPfEvQAWAP8Lk6yh7VIvAjborKdMrMTV+V42K7vJJcSVYnaG5u2
         4V9BPOgbjwBNPoLDolWRSy0SVHn3CUxJNLOuCfVpdiIvEb885h6+YteU0mOgBcUZarYY
         7Z5UZWNlFxNQM6gQVkCAGJBTi80F1whxSM8Mt2xTfYRevZkaBf3pFTFvpHb7Lw13JDKh
         64qVeXw7TERkGlnOlhcclkTQbb/4xCEK5gFJAc9HW+r/SNJii2eUHp89b94xbUCmxk6k
         quCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866912; x=1795471712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sB/Rgxdi0CHGT1x1y6c2xryTvIBoyqac6aBkvdP57ls=;
        b=0YZ2+dI9qqTPvzBmmPIb7zjtg+CVaJTmLOC8b1idb4kGGUzqLbs6t8Mo5HOb1ryODM
         7Fci8WkItlETVs4SZHArYksDECjxuSWUhyZUkjbBGsiz/bvcMYpijh1iJWUlEGPbxe6q
         VilXep4D34yPfcpQuIk5YYJB7k+mi7f3N+JCognHAcD89qtpZKWg3C/M1RKRU0BAlVt0
         zl/Z3dZLiPnleEA+spWs2tcjFylGvaPxyr4r0H9LGPhnk9XzWrlu7PgC02DM7KHpNhNr
         z8qJKH6XYgHjqkYcyixoP3TTBtncN3bXjh1B+LJ4h7i1kjVz3ABZyS2nY5s4OyUAoI1F
         pWtw==
X-Gm-Message-State: APuU4Z/12R33FCkvrJ2+G8Gjxbsp2856ceuciOaK4uOkK3dacTh4pPgO
	gzW6mKuiCzxrfLQtCfmnJvyCWZpfV+f0sqb6+oIFGhWBdzYcKQKXWGDY0F4MhlgPUl228Rmaqr1
	egkIIdmXEwwBmdCQHG8iepjOB7Cca3TlGbZxynk/s/osEEy921T9UYNeg
X-Gm-Gg: AYBFou2QVT+QJksWFN89bUGCUKKaoTS0mHgaZtq44wQ6oNf4ibXPBLwL1Af0Mhh1nGf
	xwW0dPo3gZ9z9w3UvCRuH+4lMo64LuEZh3++n1VWJn9qkjDzMcycAIlsQ/OA+lEfHCIuiLBZelS
	fFCbe9i1h4mlLCHO2PoxDpUqIspzN6PmWDm3ASQ+bd50kVJ/kB08DbDS4qZHLmU1nTnuATxnGNY
	TCkCyn6b309lqIISOV34Vn6ACLQS6qX7CHbkz40cxSUh6aujWuujPdud+vYriB2BmG9gITcFt1c
	fz5GklUqP2KpfOGswM5KjlX9jMVufW0bYvUJHJDDWyXp0iOQ/cNdfal9ssWa1k+a2v1B26ZYtIN
	DLNRaJSohhaMxDS/nhgHZUIPXorsMmGJ1T4GyWaET6iZPnyOxMMjIoEL/7hBS8yHt77frHRICsJ
	/S8IOL2mINaAjal57x4146
X-Received: by 2002:a05:620a:1b90:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-9494bbbdeadmr1706750485a.31.1794866911558;
        Mon, 16 Nov 2026 14:08:31 -0800 (PST)
X-Received: by 2002:a05:620a:1b90:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-9494bbbdeadmr1706747685a.31.1794866911022;
        Mon, 16 Nov 2026 14:08:31 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:30 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:16 -0500
Subject: [PATCH v3 10/10] ecryptfs: refer to folios in comments and printk
 strings
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
Message-Id: <20261116-ecryptfs-folio-v3-10-1aba8e620eda@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=11260;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7gCESTaoOYsjHTjQj/jUXAbyJ5KiZRBf1dqz1igpy/M=;
 b=JavZLytCbMmF5wa0/+NnJA9AGO4WIXvjhOrKvh/HYWA7laVRAd5mFK/a2utXcG3Ayci4P2I/Q
 6KFALPp5yMGDQ3MmFW+N9VAYGKWrF3pJQcSr6YNnrfFfwU8myziC/ly
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfXyBwo57Mp5sHT
 t52bVL0k7eLveCJBlgcg5yElO8XjWLVtDXNiesc60fBFNpYQRjE1Z6fQcP2sJ0iqDx7+zM8Gq6e
 4YJl35EC6eJxUnyeVro5KROGFysBSRuwzG+OWW0mAKXzZY1hi4BZ
X-Proofpoint-ORIG-GUID: rO6MEKdhoX8Wwq-tU3E1B73dJbkLdr6T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfXwU8dSciFOlr/
 HQr1O7sFvXtmyhW+NVSyGi6fgAKUGUooePJviTETvPILZz6sgc72ihCVLbdLp2loVBGmPN1TETh
 0LjJ6UveVyNFyUtU4VcGJ9wYyuHmjW9GIEHraTb8jxItRsU3j4q0I2+19XauweD0oheoZcJUgAO
 GMML0oOxKTAyE9MqIBuOdXpRm8uO4evNMlc1882wqi5BA9dO12bVf9Z2duOyN074L6UIzT6LUwh
 tXMZCfmbh3XO7q/GbIwzjZkLgUXYDzU5hZsjyNzyyUfg2PnhVV8znhznL8l4fYCN6m+pBjbze1n
 iNJNIipmIdRnWIAiiTIYPYcT5rOzZ2npEhk6rZDvbyphBJYC8LaOJ3S8Dr9qUT4aE18jOORuhO/
 Y0ft0/x1Q0f1kWTfh8WxsWVauKp0ygDA0uPf8qbrtQidKSwl7tJ3Xg0otr74lSYLgBrHsqglLHa
 v1Lc5+e2XoWuINjIxkw==
X-Proofpoint-GUID: rO6MEKdhoX8Wwq-tU3E1B73dJbkLdr6T
X-Authority-Analysis: v=2.4 cv=R/aWitRX c=1 sm=1 tr=0 ts=6afb7ee0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=UaDNW_uvnF1uU8MiXK0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=10 malwarescore=0 spamscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

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
index fa876eef85ad..8c2527eb828e 100644
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
@@ -178,8 +178,8 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 		folio_unlock(ecryptfs_folio);
 		folio_put(ecryptfs_folio);
 		if (rc) {
-			printk(KERN_ERR "%s: Error encrypting "
-			       "page; rc = [%d]\n", __func__, rc);
+			pr_err("%s: Error encrypting folio; rc = [%d]\n",
+			       __func__, rc);
 			goto out;
 		}
 		pos += num_bytes;
@@ -232,16 +232,16 @@ int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
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

