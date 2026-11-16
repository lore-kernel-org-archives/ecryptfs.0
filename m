Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866916;
	b=Z6KjThz0nJpbcIGZfKwk08vwPC5cvmmQI7z9sA1xZYLRLqDCruSHht5WWJU2szL4uMu6
	 +5m2pycLezTTQqwwSEvP9TNB9mCU3cs5+KqmDYEIcBg0IRPSvzofNNKgiPxVSRawsrQgV
	 /4wTV9D8fcg7mFSDWfzcA0f8YKGGLRP54+e8h6BZBkTksP0YSDrm95fJdiBvU/yV+6qye
	 BfrqJvf+V6/p7AX+Iv6X2yv/eQ1m3Kl2wQ7j6UMSUKYEdhstUNvYA6RNZm8nto1nJUZus
	 SFfrRC9YIzPR/hLjhcfvwyMsAr9EabRPQTps1ENgTpVMqRdW4AdBPucVGQjyN8oITKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1HR2RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=;
	b=fw7nnHheHKbeeo9YJoj/G3K4huzsEYpYYXcPXN8QBvOpBzGJCqtGMlerPhN58TJt/QgV
	 YuYhyxEUrYftYuQUtox5Bgin4GC/FDkicyPUczSIL8EqyqtFQkBrQy6Z0E20TVBYntrRc
	 oZzWYHN1/GbzWolowzf2kfgg/msGO1cI8Lsaq+ke0dhmBYV5e1Vy+y/mVH1fzLKLTyd9R
	 uQrRLvd/L8E9sLKz7dKjmTGwk0lcgN6GB3A4p6fMwFvgHL2bmAmqZl366+DdG99aVJ8A6
	 MmMTfUMZDq8uIrQ4popB186315QP/0qhkj3vxCBYNUA8JoMBh/MfYsVmo+eag8HJ5Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Lcn01MkO;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=AxlJQPpg;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71129606A8A2
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 22:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71129606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Lcn01MkO;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=AxlJQPpg
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLZ2iq238962
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1HR2
	RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=; b=Lcn01MkOQnctcq2KDfHD
	2//hXu3P9VxU1MMd/XhRdHcUPTGCoBOQ9SUfERtwU/ZSzi90lJPx/FCADS0GnZte
	JZC2TTJUpeDeahdk70KYtwuQ0i3qEZl8msXqLmtPZ1svLTqbrqvB7mEaSY20PLKl
	V/vwh6oMPrYPJCm19AJ3wBmSPSn4jqPke9Ir/2dNaXLQn42Bb7mfHWGXMoyHPqB7
	UBJHtC+QyKZ8ifTolZ4tV1sSY5wlZZ20yCECvKq4e5C1ue8AbXzbqbbuYg4evJXv
	EWLIOcXoEurHbilveBVO7fpNzXUXVGXMuEQq1jLhjS8zouNxGYwU0SqVvKGHU7ds
	TQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059dkbap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 17:08:26 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so1111680485a.1
        for <ecryptfs@vger.kernel.org>; Mon, 16 Nov 2026 14:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866906; x=1795471706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HR2RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=;
        b=AxlJQPpg9DO35i6r83bS/cAglUj33fYlpt4Rbizr6rruZi6xdYCaLmmXdDUsFEv5AW
         L+uEkRCYxksVzVBGgfyFWtvLAkcseCgAStN41ByOzb/TFP9Zz+I7c0oumlt4UBGZ4ezi
         ObrEHq4tNwTanI9+yn8OG+ippnssIJx3LYELe8IgSgInyMdRHmO7yAybVlu8NRsrsR3J
         J8pZZqeQ4JXHHm625qAu9tOWkxUXVzajOcaJ081TedlGwLkvjJt63WLWjc6sZdd3/B2h
         htXnT0dC07KOEph3WYK0fhcT99NvDJXmpqIP0orEZd5LR7oYThCRC3jJaEusKXHbB73V
         aqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866906; x=1795471706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1HR2RLdcMRaD9EbSYsw/zZt5bThBAeaFepmhayLTiyQ=;
        b=rBVd3WbYCJ+zFaxofQhDAAmNctM1iwobBwZ1rzsTVxg+EuzqKvfU0NiSb5vhU/DJjM
         sYH1I1KdmSu7XIFhOL7L30H0uhptN71foyivbMqvzUxkFDSMm/CPLtqQIPNvBEdQ1Be5
         sMgBzJwZ3rRUfOnWyZt3rR8EhavK9rGok6anMaDrxPZyKSN/NEp2vl/hELKy5/uSMa36
         bYaVw70v7QF6av+jy4Y9VlYSGmeZniAoyLVVt9JG6PXl7WtcL9/DDeNY503MsxDvKZlS
         bubfIZKBbDRJmbeT9qJqVAfwQunIha2mUE4M32m9LT/z65eUwY8YQWcknr81/45bD1W5
         Le6A==
X-Gm-Message-State: APuU4Z92L/o45qOKCRU0JcQcSE0Rs3g7DoGa8bRG95FTZn97wxQqi96J
	ts7pBLbjh/YHFGqcC6ygL81GAQQVdc2djPTtQK3EeHNTS2SH9l7o8kEWAwYRlOOYy89PcXX48LT
	J8va14KyktQ/BB6b6liiFY6Gh0Gvrw76n+xcoJ5+/jNWx/Nif7RWpRPDI
X-Gm-Gg: AYBFou3ccvaLXfcyF4T7CWqhRduGA1bZ7XNUancCqp0Cltg1K4ZAt9PdGOcGlg/nXVs
	aGO9qC9eJVgij8KxmmzsG+p9sb6wXapJ4/MVjKgao3E409SrSfFGLz0jJymSHALx+7+3EC15QxI
	kblg0GkAogJBwlJhOMWlJ2xK0RrO1CPrFqri3szgl0ude6fMCaicmy+jiDzo/ug80FxIPaf2eDq
	A5aVbF0QOV5viHXtGijxLuJFkVlrwKN9y/S2/D9+L+T23+/QMLPn9n8j3U4oUtcGeJ+NFFOs8Bj
	PbtpjHKORGDuZQQzfBPJBeEZgoMYDAO2OFkR9oMyAuQKt9oEzZe+6si9yCjLqH97bu0RNMW04D1
	jYH8TDzyJquy0zKC4mQVQYfdnA87N7o7knYVy17cdPsfm9k0I1p94s7THrq2JKs2Smacfl4WQ15
	/g7c+4+V8cshlv4r1Dl5ay
X-Received: by 2002:a05:620a:27c5:b0:949:7b2c:671f with SMTP id af79cd13be357-9497b2c6976mr748373285a.82.1794866905687;
        Mon, 16 Nov 2026 14:08:25 -0800 (PST)
X-Received: by 2002:a05:620a:27c5:b0:949:7b2c:671f with SMTP id af79cd13be357-9497b2c6976mr748370285a.82.1794866905252;
        Mon, 16 Nov 2026 14:08:25 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:24 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 17:08:10 -0500
Subject: [PATCH v3 04/10] ecryptfs: remove struct
 ecryptfs_page_crypt_context
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
Message-Id: <20261116-ecryptfs-folio-v3-4-1aba8e620eda@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=1031;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8nNsMMmNdcqVbMlIKq9eZpT/6NpoMNBQA7psRulhB58=;
 b=sdDdsOb04BJGImGvRcaS3h2apUzwX5ol2azcfjms1C33PJmTtMwV5ypen5E+kRDOGFGXDJ1Ds
 lvUrAPyKb/HAK7uqtIR7alJB4aAadSi8hS9BnXRq1u8Axb6u8da3K5l
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: cY_5MXjGPYDk9tL7xVEfZE8vICBx5f8C
X-Authority-Analysis: v=2.4 cv=Utf2pOwB c=1 sm=1 tr=0 ts=6afb7eda cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=4zUkhEILHW4tcmWJkwUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX5BJ2tVAhLYFQ
 2x4mLr5+UJ0ZXCTE5eCbOZKCuw/JX3Uuhpk0RYqWMUmZTzC1NFRW43zXWQrMHcZH/EoG5PQDReC
 c6f+bDRIgxf67p5bqHreojSuYm75qIdAy6UZ5yaWyWlKsW1s2Zz8sMesHzJpGwIdgU7KbfPA2Ug
 xS8n4hwyThqUSpGQOGNaLSMEPJcwQRWb3WKJVyvn1SkB5c74moSIwjiumDGGm/bHOXKICrXUmUC
 2cPXf2IS/AHfeAA76PM7CNL+k1zffb4FlHZRIc5850OooaDKJMRTXcY3zndwsu71v8iHfQeu47H
 sc0X9FhTRC4BrEusy+CXtYsDrWLt72jXHAajpGsoTvsZ0rA+/pyh6qzq+EkDxLcDuV+Yc7/rMsm
 H+CCcZ7+Unphdczitp5qJxVtkOqhvpkvyhKovdZzed8SC6nYK/xcoI9Xcyjn6H9KsrSXT6aEr7Z
 raYLYwadlyaALlqXSyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NyBTYWx0ZWRfX7g4Wip755q7g
 7YrazKhRwWCV7I2B+ZFmuBAC6RSaz34gWAPOAz87K/0XXQGBoNu17Pf+43mXgE6VRdYkm51FiYM
 Y41wCk0rPbpiQqf5ZFUue0aqL/+AxeyVq4sJ0S+Gb85RQHFLVQkp
X-Proofpoint-ORIG-GUID: cY_5MXjGPYDk9tL7xVEfZE8vICBx5f8C
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=10 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=10 suspectscore=0 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160087

This has been unused since commit b6c1d8fcbade ("eCryptfs: remove
unused functions and kmem_cache") in 2007. Remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ecryptfs/ecryptfs_kernel.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4315c18ba1cd..d828040ade89 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -64,17 +64,6 @@ struct ecryptfs_auth_tok_list {
 struct ecryptfs_crypt_stat;
 struct ecryptfs_mount_crypt_stat;
 
-struct ecryptfs_page_crypt_context {
-	struct page *page;
-#define ECRYPTFS_PREPARE_COMMIT_MODE 0
-#define ECRYPTFS_WRITEPAGE_MODE      1
-	unsigned int mode;
-	union {
-		struct file *lower_file;
-		struct writeback_control *wbc;
-	} param;
-};
-
 #if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
 static inline struct ecryptfs_auth_tok *
 ecryptfs_get_encrypted_key_payload_data(struct key *key)

-- 
2.39.5

