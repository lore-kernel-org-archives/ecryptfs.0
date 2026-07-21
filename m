Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC011CBA;
	Tue, 21 Jul 2026 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618936; cv=none; b=QsY5l0PA1QaRLhZphII6Ee2u1MvSEvv0Tjsy3Bx+ScTkrgmTr6bcthaid/Fe8lmHE1yEx2EiTd0IjOY1Q4I/31okmQvzKNyZHiHaXWZj1kR+vIgf7XR1Ms20MVXUf7XO9yOyehO1WCFumTwVXkGvdNAuKjquh0GuTcbo7sgpLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618936; c=relaxed/simple;
	bh=kJZfKs4gw9+VCz0VWE3wPi7bx8DEF1Tvp7yzWfdQ4ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gafClqPX7C5Gntxx4S4teFSb41SJLgQ7VINbvG7NV9BKC8HS0mjFNhHysQ/4ZFkfk97my6woE2DyB1kb6q60OKmXsjx3WwihmA8OsUfXIxzpiE7GsY2eF8knZUrkMdMF5qwRUjNHMdvvueg7PbRHCgMkoQ+P8sTrMRWADpBcW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=OARgqWnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQQGVkAv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="OARgqWnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQQGVkAv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D8867A0074;
	Tue, 21 Jul 2026 03:28:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 03:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784618933; x=1784705333; bh=czV0Z7+/Lg
	i6q4ZL+Du1qxOSsIXSAGYl8G6qL8S6Sgw=; b=OARgqWnf+iw2aa8EFyExPcICW8
	zMUKgpAlkL251AtYGmTQ/6O+/TpBa25aR5JuOjqibmqv85Ri3HUGaoGfwWFy/9ay
	KFVMwp74jfwhbX8iPlyi/5/q6MarARLOgdegW5g9plCN7YbQutnCsyiDrDilXAys
	KDTlT2kMQ2t9wq7b3/3D8mlq2llqlWfd1LPFDWrL7x3O+l7Fw+Hnke1PKK6KmrMr
	En8NlV1grUj3zbzMIUyr9hx2pX9eMK/iuSvtExr+uKZGWxcykauMcELYtDIlHhTP
	VRmRAHn9XeYkzRPY354OM8hzxLLEN7v7qGcyLwI6t//4UMF8+mLebolgkbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784618933; x=1784705333; bh=czV0Z7+/Lgi6q4ZL+Du1qxOSsIXSAGYl8G6
	qL8S6Sgw=; b=RQQGVkAvO5bsVnvHjemoFwbZBP2aIFYVRx84uwQgwbHn0D18BFB
	/hQBI6LJdTE1luIbsE+myfWtdHPLTD9ZoUxEasV2jFG1FP9f8Q30AAnjOwzYUA+f
	NPQO9/glnGs5py9H4oHs/2EpcssP2dfVEztSYZi7/2dfuy3nsdzwlxZOxcI40G3z
	5esBbOO7oMzGcJGLECfEj/EF3locPLovwUY6rorw5ExteD4KSo7771DFqyA6vk3g
	3nSMGXIFPuLHO3VJ717u6VbB+Sgp7yXHBF66dJMQUEFmLkMIpYeX4kZ44fsr1MMI
	Hjv9L4L4VopvoXCOhAArk5VrqumIALdBv9g==
X-ME-Sender: <xms:tR9fapCCQhtHiMBqa9LT0M2dTRmeZn5TSJpdH8r25drfSraK9-9gEg>
    <xme:tR9faoNlDihHotiES0YW5r1HDwbueYIL4-Hd5VdATVDxjYCVXf-XtF1Q-QUTIr_Qp
    zw2p55jARPdRQjqz-Ry73YT0Z7f4KTeACW071tzJ8Cgg6MjgwSa1lc>
X-ME-Received: <xmr:tR9faiy_zXMOS0UEPgr9hNRvu5escHx3v4cSX8JdZQ83EDeYgVqgzQ>
X-ME-Proxy-Cause: dmFkZTF4LoQZb/f7XxUR+qWHzxVmn+nyt5XHlYoAYYEwe48QJzV1/+Yo/s2QKqJJgTB7iR
    DotN7te2kw3CmNQqXe+3Su6bsIgMy5BPKy9EE1M91wkMsyYLMjmFqntUmafRivrLVrie1v
    iBEOj4oF0MnpJ3MeIJKtNGqCRBOQJF62JaMn9LlSd9j6QUEWpDtpTX5UKZiWWXJm46VVrL
    xMj44Prx+jB/Svsal7sK/TrvwLETh9Naskr+x6iw8oAnc7Ohfqi8qmEepCQnIsSRU0H/RI
    MuWPtrfpObVt9SMmJCpi+NU9VFq04n9zv8oVr08o74OZEmb6Kx5KRkgqPIZUryQRPgEtpD
    TQHnhGHp3v4jcN8CPxQY6DQwWdG2vpkp400Q8kZ4IGVlkKKwlPcS/dSypM5CqlMYMxLv8J
    jfMUdenJPdPw6XRjgqx+UPbov2LzfuyRFTg6dGcVlAsIiKu4TugzYygqrwCAHD02JcIGQW
    qW7kZxCGxxpbtQkfEKzacoH5qVGDQ1mYIS7k+wUqWu5ambXKBqsTXDNm+hPoXVYTZQMHNu
    msd0zlKbvpHcL3ydaFsmcxQIPD5KEeOlG3PhFYpMmcDIgpFuAZ+WzALzOTDGaX0y8X9t2+
    g7gd9oR4ybqhdE2SBxYMRzNY6Dba9EOPYUD6lUL8UcInEhaAM1WStMri2uUw
X-ME-Proxy: <xmx:tR9faoVNOd93pK2i-MbVRLPthHzhNao2_mSRp9nZ3SnT6vHZMaA6uw>
    <xmx:tR9fakPbgcc-ZaWIgTZdm0R3r6KGORztt1drkf3_hVmFOkNe0hcY1w>
    <xmx:tR9faqCIdWej4RSWZaJr0QJC3DPEy-qRdaLV3TTUOLGu4bUDRGs6yg>
    <xmx:tR9faheq1-zg14gFvazodPL5t12j9WxkgAifYse0Ft56x95UbsiCsg>
    <xmx:tR9fauAEB2uofDCteyPGp3CgPGhHeO0p2kZl6Z6pcnllRVuy1jJeIHek>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:28:53 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:28:49 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: show filename encryption options
Message-ID: <178461835003.30963.6380516143059079780.b4-ty@b4>
References: <20260702052958.313951-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702052958.313951-1-chenyichong@uniontech.com>

On Thu, 02 Jul 2026 13:29:58 +0800, Yichong Chen wrote:
> ecryptfs_show_options() prints most user-visible mount options but
> omits the filename encryption cipher and key size.
> 
> Print ecryptfs_fn_cipher and ecryptfs_fn_key_bytes when filename
> encryption is enabled so that the displayed mount options reflect the
> active filename encryption settings.
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: show filename encryption options
      https://git.kernel.org/tyhicks/ecryptfs/c/496ec2d0852a02d2e631771b5c439130b9c7dce7

Tyler
