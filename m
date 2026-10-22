Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685091;
	b=ZjATsQSiAw1l1R1gP6Li/obK8TJdi4feOLjQ55lViPzy5Hm0WWzOCep3x7E73SYH7Ou6
	 gUSP7Hpf5VCLYEP/eLzZzjK+6txjRljuS1MwZUo6SziSwXZbcdm3G8azadzwfJBpIfTvT
	 yJfLeOdlYh+atp8VPMGMYNXkvnwTYCdE/k2FMvC5lKM0umo6nvJJjEaV0E1XMiRLVR/Ch
	 nNYy0JcYzO9WVL4NdQqoLeJS0FubmP7PedFwH1deFmCSSiNFKSYalvvZCRencr5dH1wlK
	 oNeBzcxg93PeIUziLz1yW6GIRAedWwaX/db/adXwoSlcqC3RWZ6IpGjPNwu6AkwC+uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685091;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pDXAHPQkxTtF2dSwsTWY/c3EcaAOKqjepqfHcy7hZKQ=;
	b=XJhfbpxA8hIhBRJrnC5/+3sxTG06sM0q0LsSNgBbeLTca2Dt3pRxc5haZZ/O4IoLxlAA
	 yve6BDzwTmJutlTShQu9hqbWBgky7IBplmqhl4iPfhQzVcGPGT5oBBJBkzB47IlUk9Y3f
	 gyqaHT+4Ho2w47bYIEhxKF6Ab0SIu0o91uDvscOqRwUFYraD1/2W79aSxPTZNcfn362Fa
	 Dst/LIwSc0CNIbzItgwsdMAVsDmnb/3VzumL0jvspgFPV5hJ9Ep4KckLARs9c/tPCOZmr
	 H/cgSvpZO2TjlaZt/TuorCaOH3vgX4BB1Enw+5qKPzcEBO5luv0D/2FLgqKDsllYVfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tyhicks.com;
	spf=pass smtp.mailfrom=tyhicks.com;
	dkim=pass header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=KGEjgZIq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ii2cseVb;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76645606A31E
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 16:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76645606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tyhicks.com header.i=@tyhicks.com header.a=rsa-sha256 header.s=fm1 header.b=KGEjgZIq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ii2cseVb
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ED44EC02CC
	for <ecryptfs@vger.kernel.org>; Thu, 22 Oct 2026 12:04:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 22 Oct 2026 12:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792685089; x=1792771489; bh=pDXAHPQkxT
	tF2dSwsTWY/c3EcaAOKqjepqfHcy7hZKQ=; b=KGEjgZIqH7284K5PSHfUkkEgny
	cs5LThFyH+x5VYUNTptgP09o5K2PPMmN/lCmvI1UmepZSE2InktEAgRWdRHvS1tb
	3Dorj+JcYuPJCvrCJIHk55dU6tKE9Bt8NiQNXpbIU+WcQxH9eVJyEz0+yryNaeab
	XFm0JQagJD5RXLEjiTUe8FgkA3ACn6T35ashU0Zxnh7nWptiHIn1s/XpHTHs7EZz
	cz9LO6nPJqQa3/S2BRyAUOZZXhSYOp2TVxvXsJMOWAuqM0xhZwVlg96AvHmMeLzb
	HkqYgVUJhHBnhsroTag28HgXA2DIIMgylmwy5m+i2sk7kEtTZCjZwZgs/P+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792685089; x=1792771489; bh=pDXAHPQkxTtF2dSwsTWY/c3EcaAOKqjepqf
	Hcy7hZKQ=; b=ii2cseVbIXRoefTYpqdDuM8Wc9J++NALyRhyFtb9C1/wM2Ra17A
	rHbLM7kHZnIAv5XTLsrrzT+qNLLVxo134c/Wl0bVJA+FbYD8xCYjDZQTQZZyr3Lb
	8jBoSplDSDhqvDUSXUA9YUwFdH9506DQC9pp7xa7jBoZ3+wJ8EQ9k5oNhG0/dS4X
	GIdE+Yaw85Ykh7d2GtOvyUqnePuB7mhhbKyqYFNQSJoEtYbuMeXD8rsd3vyxLy5M
	c5yHUbvP4RKHkvfG82Er0XCnMNLkBBN89WT6IqtKrXZaZAD8u1BaRHMpOWxw4qbq
	WvC2foTv5HCXq6k+W4X9C2kV6BQxnzLOcYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792685089; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PGVjcnlwdGZzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:FOicaZMBKyRiVFhC8UysAvaeoLYVA21xNVi4IvL7xEblwsB
	L9pCFjOJIvqbBl1FWnTT69Ogtomrn7tJ+CAyq8Gw/2trgQ9Z6LTbsxmKfgIz8/Kd
	C05qFgFBxir0l4y0lJ1uBPjpQfPfTY69KsUmhjmxPFYuNUxunw/XRnBdIR3MOpM7
	yE5D4djTsQcxAVAB6wI7rbSFKPRV3J91vDy6ivqvf7g32xemeK4ytIalwwJhwlhx
	DWQofXLzjjr5DUmJmxtXyKEcsMVCJipCwCwVqzBusYWWfN+n3tKrEEutiDFQdinC
	0uLHQ0wYXrZu4wbuXY/JjeDumvjaW4D+GmV5ZFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eIMjwbjvEkVM0KyB0641woYC+YgvOAMzz3RNnBYpFeA=:R/d9wQiJzANatNCUqyrrm2pLg4J+8//+WSbG0m0prLQ=;
X-ME-Sender: <xms:ITTaamSFAOFhHTPfwO2QqAHsKZp8c7qi_4EbVf0PzbF5ewNcAjQ7TQ>
    <xme:ITTaakv9PPkyuNOdAMf4pebPQKNYYN_hOdRE5K9FVfjxKWOY42WZeN0Gnbe0JWIi8
    knIMPv5TlDAMYsUyRvjEJVU5eQX8FsMwFuB80UWInpbIw3rtOWxbaI3>
X-ME-Received: <xmr:ITTaavaC5svGbjo9rLZLJuw-OzqfTbg9E4QlFDME5ukh0OLL8ONKkw>
X-ME-Proxy-Cause: dmFkZTFLCAHjFQO2QIsgkjKn7X68PZwkorxm4dIFqzI2GdM9HP9XRb57VrPON0WYWLb7dF
    RiPOvVi5nFg/+AmE2cP2zLCM2/hPq07i5mM5IhH4LJYoeYh135q/YzBPq/Axgw7gE0QJis
    gEjFd/3LZ/OUuj9FmsrOhgyUy6KRrYpOdtOs2DBO+MMuKHs/EPHVmmEGTOQc7s53/lYobw
    /kMvH2hEZoG30C9rH57dofsGH+OE3PfbBzv9IMcAO/dJDJjvPryOZqx6bI8Yzs9N7s9N68
    CpomlH5tkDeR0pnCW7Sr4LdfN/NP3nnll3qq7pVUCdahWhIAaqxHjnwQ9psVklFUUIqwde
    ISYRNOzV2rNgtw6aBpuPcOSRKxQn9QcD0xn+XtQXsaOrxglV1cnSK680tjsH9Rr+32WYFz
    jCwIAKqbnDVQJKcrXt0kaO0/cqtMqIP2y5zL1dK7zqf5jlbgNM9QTJTJ1ESHxu+QsN1MOC
    i71R/5QI9Y5JBnlp3J9H8NZoyMvmh4rE3IugJ+i/rPQTSIPvJpi0U3fksxl1P9g3j5Os1J
    J6DUI+JHLOq22Bg7uuURSvkC+xCPLVCveCkPxMclxMP/bODf8z2WnNbXMbKd7tM44px7TL
    GI+/4x1k6e6GcHinQcB8ltnMNaKpckYILo2eMKV8MEuwCFuVhWTtB1HBt2kg
X-ME-Proxy: <xmx:ITTaaiEICPG9ItgyAzA7bQXrvA_uvleLKitiiqKAhxlZJkZLjZ7FDQ>
    <xmx:ITTaarx26Dz-KZ_YH8O_73TxVS_7E8JaTMUogNj8MReimAy-g975Ww>
    <xmx:ITTaasnl5Cqz9S_m3_5VEMQAOVz1H5YBpXH5_6EVtDNtJftkseSYkA>
    <xmx:ITTaask7qnO7jDN_RJJcaXjRuLkqmPTjvBLoxDD21UH2jYEXAuppkA>
    <xmx:ITTaanM-E2nj4tOJqToeHVXfRA-Ni2jrvboeJpTxIg-gwfLDPI1G8mEr>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:04:48 -0400 (EDT)
Date: Thu, 22 Oct 2026 11:04:29 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Nguyen Duy Nhat Anh <neganhat@gmail.com>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ecryptfs: reject short encrypted key payloads
Message-ID: <179268488671.837681.74144863274950534.b4-ty@b4>
References: <20261016170633.1415240-1-adrianox@gmail.com>
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Post: <mailto:ecryptfs@vger.kernel.org>
List-Help: <mailto:ecryptfs+help@vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ecryptfs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016170633.1415240-1-adrianox@gmail.com>

On Fri, 16 Oct 2026 14:06:32 -0300, Adriano Cordova wrote:
> Reject payloads too short to hold a struct ecryptfs_auth_tok,
> as a key created with a non-ecryptfs format is shorter than
> the struct, so the payload gets dereferenced past its end.

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

I made one small change to the first patch's commit message. Instead of
"as a key created with a non-ecryptfs format is shorter than the
struct", I changed it to "as a key created with a non-ecryptfs format
can be shorter than the struct".

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/2] ecryptfs: reject short encrypted key payloads
      https://git.kernel.org/tyhicks/ecryptfs/c/00cc31a869e2f635e6455685c91c4c9045c96ebd
[2/2] ecryptfs: bound session_key_encryption_key_bytes in auth tok
      https://git.kernel.org/tyhicks/ecryptfs/c/8f6626bd6594a78f454d02b27b74a580c890cab9

Tyler
