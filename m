Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D174524F;
	Thu, 23 Jul 2026 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768477; cv=none; b=cIR0hkE2kvc87LdXqCCqVcesRf0Tg/LLHyB1emBSsReMkAG45u9xMRZKwECTpzJqcDJmG4WpVR3BeIcGmlPZpHYSO29bmfM+oJNQ8BovKISSt3oEm4nnMArL0cyqVzhXdedw9SzP2tEm6YhCK0akXiuYQv1WeJvbD9QeCuam8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768477; c=relaxed/simple;
	bh=jTLKoCxU07j3KusO5Qgbw2EAf//sDok96fA3EDVouIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6eTXXisP3ps7qbfVvn0qeB/bDVNtg4dWvQhEHR79QDxhyz5KFimeF1wAvQjL0gXI+S6+Olxk9V4iUdaAQzqEMiQk6mkZUWSJb7L9L0DU8WWF4hfljnqsh4KhAYYznm+YllghX/xBDFnN9wof/EUZz9m0TnaGGks9gVTcrSYoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=8CxD9Qsk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5qlEFaN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="8CxD9Qsk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5qlEFaN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3C6A7A0078;
	Wed, 22 Jul 2026 21:01:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jul 2026 21:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784768474; x=1784854874; bh=LRJYd4w+C4
	14LoA72BTuGLKRiX0tviO4B7m33e35Pes=; b=8CxD9Qskc8VCJbe6XRiChv/CN8
	nUElIB2t/qkpEnVhCMKWJb0E37SvJwqxEdPfCmvIeOPrv9kjmPW1aKCgr+BoWc27
	rWbcWSsCHKTGTL8NhUjcGMsgHA70ix5oXDzcDaWJbiX/UzSfv/zEVjd2K+rBaE8+
	Fw7uaEwGWRVsW8IpcZdL4u51nq4t56X/bk8OL3lBAH1DImZ6fEqycp3AwQXmqTPN
	ntmJB1tPJpfy5Jy4R3Hfr9cD+5r2nuBWpAVsFkoHVIQohBirMKcEPnaYXmUroBe0
	lJQHbSC4pkF4dM13sVjG+sFTIsxm3uQ6GfosjXewRicGBMMhUN801FkwiUWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784768474; x=1784854874; bh=LRJYd4w+C414LoA72BTuGLKRiX0tviO4B7m
	33e35Pes=; b=G5qlEFaN+YqQMciuL5PvB0e3RESRW8Ra1hVfyxHvKXbQp72BmN6
	gWJY8K11Jzf8Pe9cV1Ewrqi7lMNOiBhGfF0RrhW2SEz8p539C52WDMovDZa6Echi
	rwGE6IWY6/F76Aa7hFhTsw+EUP8Zu7KTd13PJM17tZGHlheemZY8kF0+WN48f7+y
	mDMb+nkwjvqgdHWVywvE4Xsj4y3GrKy3+2s2d5lMSXvevXHvuesrNr7YPyC/QI8K
	9mmrq1MqPJ2Iu4RkrvDRfi2ygqpB0gobJb6JzrLUiJZfCSiQkGDNZLnlB8CUTiC/
	srs6w5Sjsc23OVNU7YkXOLRKPQXvtsJF4RA==
X-ME-Sender: <xms:2mdhakmo0-Sc6oQCAMM7gxXBj2Fo2nKp-apjQd10TiCjRg6WFRPpkg>
    <xme:2mdharnAZvEvo3FkEGK2fvuoWjPMSQjfjA5uksnQ9bHA76Iz_7Fvm9vgvAajSO_23
    6xWVXF9qIG713H1lJ182fhj7WFCYUzHZJ0WRtQQr0FnzGe_1l3AiEE>
X-ME-Received: <xmr:2mdhalvA05zJw4-46wU2mDEAPiaXpwb2eBjGOSu0nIPi4Cffz7CtIQ>
X-ME-Proxy-Cause: dmFkZTEe7TzWU83bsNr5M6gVe4GaY59xpr7uynvBaxPgFBKEXq1+oSRaiZdmMxioiv9k0x
    0kxifFRSkqlnWweqsK7awKtXUHX+7y3Jgot9AGj1kc2rWXtti9/qwBF4/9RRuajSDAkxwe
    5POJTsClKZ1Eh5kLdhbk3opo1aU1BoJC2kdG/RVQVuuHFk5UlTRbH8jNQB63Vbp/efQTUb
    A57sMuaO7TqDuXsFbGDTTCVnQ+89dAWeWsyl1FGFuF9cYoekYk4Csznd2rA9gfjfwAVSJP
    o+/2PmBK9xPtYPJPaAgytDrzydBPPC/RgCYw9qp0waIut8iat9bIOwVptLt9897guPG8nB
    3Wvv+fVK3DsRSpjvg98lQUnX2pWYTP/LSDQb6WJULz3xSbZd0fQB/Z6OUteTag31pf2EGe
    dduumIlTrvU1X5l85DtPH9R7ErPNnKiEyN5lbO5nE91kEmNbOZAsRX3elTg2xj4Ik0wh9H
    fXKKYdz/xzNIRoPZSKtxf4zzCmNPydRMz2wPiLk/Z5WOXXLUIFMyYVF5qaEBNBvJL1uEj9
    Av6gPkkIQ8znGSS3eCf17BjGqdFJikPPW3q3DTrr55JIanwYGhJZrgAwSQuNJAeYU+C94t
    mXKXdHNElyjiHf3Jq+znYPaEiEsRfKwkaAwd82hAqt4YfNWiazNX3wAc6P8g
X-ME-Proxy: <xmx:2mdhaukpcE2ZRDjXl9sKWVxlhfM8AZQLvUhegp82nOKDbf9mZf-Ymw>
    <xmx:2mdhags4CN32oHxNpcGBfWfA5KeUFvglNkrkYJEm4ze9gLBOhm3BtA>
    <xmx:2mdhakd_LBZDSWiHoizoeSsrZn1aYO2ebr_l5SfAf58oR31BXxgaAA>
    <xmx:2mdhagwJqsDwVD9VIjRxBKhfXMSdaeloPwYFl7ioiKOtRyZoNm47Ig>
    <xmx:2mdham1jucSeOZ_MeruHYgjL6xU5X9VQaEy8sXcSyqmx85xnGNnNpDaU>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 21:01:13 -0400 (EDT)
Date: Wed, 22 Jul 2026 20:01:02 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: ecryptfs_kernel.h: clean up kernel-doc comments
Message-ID: <178476842590.100088.4245942333108072614.b4-ty@b4>
References: <20260722000812.3823299-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722000812.3823299-1-rdunlap@infradead.org>

On Tue, 21 Jul 2026 17:08:12 -0700, Randy Dunlap wrote:
> - don't use "/**" for non-kernel-doc comments
> - use the struct keyword when describing structs
> - delete one Excess struct member
> 
> to prevent the following warnings:
> 
> Warning: ./fs/ecryptfs/ecryptfs_kernel.h:14 cannot understand function
>  prototype: 'ECRYPTFS_KERNEL_H'
> Warning: ./fs/ecryptfs/ecryptfs_kernel.h:207 This comment starts with
>  '/**', but isn't a kernel-doc comment.
>  * This is the primary struct associated with each encrypted file.
> Warning: ./fs/ecryptfs/ecryptfs_kernel.h:275 cannot understand function
>  prototype: 'struct ecryptfs_global_auth_tok'
> Warning: fs/ecryptfs/ecryptfs_kernel.h:283 Excess struct member
>  'global_auth_tok' description in 'ecryptfs_global_auth_tok'
> Warning: ./fs/ecryptfs/ecryptfs_kernel.h:298 cannot understand function
>  prototype: 'struct ecryptfs_key_tfm'
> Warning: ./fs/ecryptfs/ecryptfs_kernel.h:309 This comment starts with
>  '/**', but isn't a kernel-doc comment.
>  * This struct is to enable a mount-wide passphrase/salt combo. This
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: ecryptfs_kernel.h: clean up kernel-doc comments
      https://git.kernel.org/tyhicks/ecryptfs/c/f81cb44f9a4b88d73ee5dec4a1ccdb0232fd2e3f

Tyler
