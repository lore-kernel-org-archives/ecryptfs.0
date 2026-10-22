Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686629;
	b=nONsjEGbW+FZOswnLxZOFlX2s6kS844Lyyl4zqsSCDeLSr+dkgDD3Hjreeu+2paGTL6F
	 nh1wl//1pouDCInvXpXCsDVC5qjIz+uJaADYny8xv5kzslIZbeO5ahb70q882MbdXio5p
	 BZBUBsQ0UqAalz10Sni6KK4DFNtnhI4IaYPYUd55p4VsmnzkWyGqVdtoKUu7NfegoLMEr
	 S9fgf5YWK1V+ixA5WrXbdj5ioV+yCdn187z5d+11ucggMTk+hvSAMLjG/Eew1uUF5nRfj
	 qQYr15/6oLA0AaBAK/jDnpVETfXNNnsCr77qV6Vv0/ohpP0B/aKExpuSID4M+GIs3qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686629;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lrrjHTsXX+lF0K8S1G4KJ7467S0hYPsoCwX9ER6dD6Q=;
	b=KyIkltubPq4/D1CCTHJdSsHYGXIWH16t0n7Y2J6DptQXEJWpoV36lfayXJ+3Z9KSTFHs
	 6OgWbsLU/GdJKWCEh2yuFhLSz9BcYm3Jsn7c/0zkfRDzb7gf83E8L2WiV6GGeNKc2B3tR
	 7GIDv2JGfQLrfbl6ZYfNX1uf+jkJt8djKeK6IUhMgTqSFmgYvB+60M2QRtPswijsO6JGX
	 qTEetzZKxrU3SZC9Uy4iP71NXlDNzlpY8s08E87OcC1lGkoYuKDxcC+BPy7BpZQbmgoyY
	 9M8OgCNA9QnZBPIL/3ecubR3NaDUyStDWl4S1ro7727JLfvGkniZWCuiGg5EqRrgKpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=fn76BIqq;
	dkim=temperror header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=By5KtG9G;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D9606A320
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 16:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B0D9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=fn76BIqq;
	dkim=temperror header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=By5KtG9G
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEWvW42758635
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lrrj
	HTsXX+lF0K8S1G4KJ7467S0hYPsoCwX9ER6dD6Q=; b=fn76BIqq4yFfeOp3x2E/
	B4Zq8cvnp6BCl73ATfof2p1JtnWqJyCMxxWMssNgd3kjOdhXQM/mulvQdG2RZKHx
	FjdlBOcHSLYNx8DaZJTeHGLj1fZx6p1u71reb54QROoVj1UGh7MSxGJ2Lvx5hG3w
	RHccPNHEuGTgSzfTplrm2yGzfIQp9QavXsECYOK+7lO/Pf19+XdV+vWjFu7dwshP
	lR0cT6IunRxWYcYP+YOXChKHrHi5Q9DeqhU2AK7fzZvz7Y2MTaORjoEpXiBiDBDU
	Z+5xjSbKxF9TXQZTWotEXnyBYaSokHe+W1xUKmaLnQFziFJdcJBtGcMUNZnAgbyC
	EA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hf987pvg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 12:30:27 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b8306ba68so1064426d6.2
        for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792686627; x=1793291427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lrrjHTsXX+lF0K8S1G4KJ7467S0hYPsoCwX9ER6dD6Q=;
        b=By5KtG9GGGVHjzcmCwfWTRdul9yG2TGlKlBIAJ32mi1pzd50OoqfXS0hb3KbTOYQ/S
         cNEgEDO5WOK/J1S29Sp4Hh5PkBd4DsdFsMkdD5K4qlMZk/08dW4Fa/4R5YCACEBPrsvm
         gwOK/O8b71H/ufFYlODBJJOEwBT9axEhf2nuF8ka6h7OhOBAvHwV1/auVG6N6tbF123U
         JFnGSP5LJxk8k8T9y06Vl8TB+9qokStdgm1Bh55bfOUy81jUv4DFKLCmAGtGu5hdAlN/
         Dr31tXvWlm5zaGeFhEW5Rn/zH9DLNslE2zD0+WG/306O57f6DYlOhIWk6SwHpGpp7FGu
         8VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686627; x=1793291427;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrrjHTsXX+lF0K8S1G4KJ7467S0hYPsoCwX9ER6dD6Q=;
        b=DaB62jlS3sq+NO/ZjxiUg68cKDbVlr2+tmXdAtpUlW3VjBZaFTINp7lVZyREc+2oQw
         t4M1YOizNJwhmhUD4pNqtf7DUTERvMzXrwBHhBp/sygQC8ni8ik8TeWM97MRWyo52pxm
         wOEtWRLgKsXbj+VjO+O660UyoQ2l3KSg+LvnECBnZxk8Jo80eDtBxj0sb6k11FsEH97m
         pnj+B/vSZKPz9WH25SC1LwIlhPw8WdyWkUdD5iTT1KUcjsu2/8qoZqyeBH/LwaLXuigo
         O6b6XAiY5Xz+xFXW0tcvsnY86oiQb6klII0GBuGgC8pm+jcB4FifVO2/k7R/dYLS1jvf
         BKjw==
X-Gm-Message-State: AFq9FYKFaYRXKSx0BJJEtLW/5pLuJLDhQAP4YuLBFmtIEB+CM10sQZri
	gvRx57XKoUE9Aiumj44wLyRmQwjESHfYgVIBclmne1lh9TCibsqR2MQevc1K4AvV8BIXojB8fSg
	MCDv1Mbg9Q5K8CBdfARh0eLb/p1+fVM+uZXRkWL9P7fPIo2alj1ReduEKGeFzOxAc
X-Gm-Gg: AYBFou3e46uO2yMIFpgh9JPF+T05de7ONKWqxFXZhJ0RlpOLVD5OogaGphv0ucszikx
	6G6rGepYh0YAKTJ95ycF1rIRpqZ793L72nWS6H2+F4kbK9TXxknXt1N5TjQko8DoL3A9t8dRs1w
	OlL/lNTBA+/44XKEL+0554rGCRpwCezk55D/U9yeo0hUM4SKA7fRX1Q6cJ3JM6FRWc7oTux34Xf
	seouoPs/cV37cd9bd/5ZXFHQlRbCwG7iC/H0xqrfS75yraaKQ5DFlQlEvBOBrtpW1eVsX9RgipM
	7ho27ZodQJ5TDfQHumaSMnJV41j426irkgvFi4XVd/Z6oyhn/rpthjDnVudRE9KYLIKO0ojxLuv
	UkgzKfnTas6lupQjW72PbGfLNl8ZUMgT3suqpxAegreMuE2kULzc=
X-Received: by 2002:a05:6214:5283:b0:91c:305:a955 with SMTP id 6a1803df08f44-91c12ee13femr95696816d6.31.1792686627070;
        Thu, 22 Oct 2026 09:30:27 -0700 (PDT)
X-Received: by 2002:a05:6214:5283:b0:91c:305:a955 with SMTP id 6a1803df08f44-91c12ee13femr95696026d6.31.1792686626376;
        Thu, 22 Oct 2026 09:30:26 -0700 (PDT)
Received: from [10.207.2.202] (nat-128-59-178-167.net.columbia.edu. [128.59.178.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c370ed672sm1061766d6.42.2026.10.22.09.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 09:30:25 -0700 (PDT)
Message-ID: <816dcdc4-7b4f-4d8a-982d-5fe45c3c3e99@columbia.edu>
Date: Thu, 22 Oct 2026 12:30:24 -0400
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ecryptfs: remove the remaining struct page usage
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2NSBTYWx0ZWRfX5ANtVMY4TIjh
 aIjGRi3bjz9QawpZeDaoyMPVqhxoxeoGc693pbG9x9LdvQgnSB3znNpT40RcnAM4PrHdnd14UcS
 PV3FTvPaMxBaIUIGIqMSRjGBQNfZsy9QJ2vZ2z0lUTRCEr2F3svW
X-Authority-Analysis: v=2.4 cv=QrHLTlyd c=1 sm=1 tr=0 ts=6ada3a24 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=2Da5xiS/qB/F0tTsr62afA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=gF-yDPsWzASaGOsw9AEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: MdhySAA7UhibCQfCemjX7nhtGLF5P7t2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2NSBTYWx0ZWRfX6D66bk5sTtrK
 nQ2CA/AQszZFe22qKv7b1wvyec4o7BRhBE2+cG9tTRBz3zQO/C7Mhmh2/mQrflOp3nDufJvryn0
 gvhP7LdPUdUIeq2m8zLYE8I7v/ieDEw+qwopYSuwufnTyYLG2mDfJQBkttAbMA+p5xVGQlI68M6
 u24WdPaVPKFoCnbkzSYW1UgX+fb2/kgLpKR5aJYmCOn+plWfK4ubiZ24zRljXqo1k1RVhjVuCMA
 xCVZnjDp+/wNIPeQmrKOXW80tbCi+SHJI3Om4qFA19ckMIIqzZLbs097337qFSvn9uCV8emL2s8
 BHonOgUX5hrRDoOkkdNBOuU17UBoR5GyQ0KsJQiQeoJIIafcrPkhYuQdHUltY8VT4s5UBU7Kln1
 GKfQk9WPo2KgdR9Uj9klrNwJW+MYmfVq2f2ybXnU26x7HOheu1bS7ToWZm5Kpr7koUNrn8YAqha
 YP4vJDaXf2OiE5KjZBw==
X-Proofpoint-GUID: MdhySAA7UhibCQfCemjX7nhtGLF5P7t2
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11942
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=10 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=10 suspectscore=0 impostorscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220065

On 10/14/26 9:35 PM, Tal Zussman wrote:
> Convert the page cache side of the encryption path to folios, and use
> plain kernel memory for the buffers that were only pages because of the
> old interfaces: the ciphertext block, the header buffer from
> ecryptfs_get_zeroed_pages(), and the scatterlists built by
> virt_to_scatterlist(). Also make a shrinking truncate zero the tail of
> the last folio in place, as other filesystems do, instead of copying
> from the zero page through the write path. After this, fs/ecryptfs has
> no struct page usage left.
> 
> Ran cleanly with fsx and fsstress on ecryptfs over ext4 in the default,
> xattr, and passthrough mount options.
> 
> ---
> Tal Zussman (7):
>       ecryptfs: remove struct ecryptfs_page_crypt_context
>       ecryptfs: use a folio and a buffer in crypt_extent()
>       ecryptfs: use kzalloc() for the header buffer
>       ecryptfs: use sg_init_one() instead of virt_to_scatterlist()
>       ecryptfs: zero the tail of the last folio in place on truncate
>       ecryptfs: rename functions to refer to folios
>       ecryptfs: refer to folios in comments and printk strings
> 

Sashiko found some issues with patches 4 and 5. I'll send v2 with fixes
soon.

Thanks,
Tal

