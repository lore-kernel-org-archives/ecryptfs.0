Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F837A825;
	Tue, 21 Jul 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618855; cv=none; b=sa+4ay4ADcPKA2raY+oErS5o5djq674wgJDtSlyW7WF5qq/l6pRC0PZkUX/PD590FMMe3A8y60SZoS/Hl0RkPrkQ/jJDOvsoUCj5XzmlG4eBoNA/PEDCO8eUypXY3W/OlVgrASvhC1r0FetrnZ41atLXAsWNsCeELEDmLP3P1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618855; c=relaxed/simple;
	bh=bYKfEmMc8KWZ3TT28DhG/SsSdCpqxPWvbBs0XG9JeCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiRDI1yL/5807E0Hl8kvPAOKi/h7yRk0wskJw3dtWdDwcFnGkh3a0UOyh0Ha+lcDzVFebd6dkZR2e6HV653JFoGmonkniAI8YT5DFE0F6XsJzKFGkK0WIl9l7oVLPY9sWy+UckXrOQDaHfCPKip29GElC0i5y/5R1CqcYeKwPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=2rI6RrP1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6tLMpQJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="2rI6RrP1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6tLMpQJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E0C87A006C;
	Tue, 21 Jul 2026 03:27:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Jul 2026 03:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784618853; x=1784705253; bh=MFgsI3ve0Z
	+z+T5iASaYFGBRnj0aHQSoW8Phf0jGw7Y=; b=2rI6RrP137r92gJl5L0golIVk+
	235GQyPpIMWWh0uQVK6XISw7P0AryK6ZkG1H9fy3o5V94F0GHX5/CfAsXgyu50KH
	xzbdVkjLoReSEFabWJVFfDxo8e2ghZw5iJsw9/O3xgKFctEKB+kpA+8hejJfp/NZ
	jjW0pYXTYwVcKU4NgDWPzHUb/rNzZPSOosEjuuW4Z/FHiRlBe0yUUxQXTJSVFK9U
	VLCocjrAAHrMTLwYobrIMD0teJD1ISETn5W80aH4c602AnbvcfSgBBGql37CwXXH
	iP00j4flPR7Yr0r97x6NO7zH579WmEtSshVr0MWLCtrh3pgNJL5WVK1V5b2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784618853; x=1784705253; bh=MFgsI3ve0Z+z+T5iASaYFGBRnj0aHQSoW8P
	hf0jGw7Y=; b=W6tLMpQJv/wzit1t82MyKyZXDghuQrkrkzNwHZoCHUUnA3NWFJV
	eovRXoneXw76P+htW3Ak5cF6kimIy3RWCDN0hYxawkrK6HOh35+jIOXa/NXB86py
	HIVfPxAHia8WrNGLPPCz3wHdgx4KYK5j0BHoHka0dTIUal0/oH/wujfD3q8j43RL
	vrNBPnCUDazkHrVmm3Y3lTNct00QnPUpjfGop2M8cqmcOoln5DWqPiCxRhJdzyqe
	ZdUewmUJH8ImfiHzh7zz1zsMCNsgflRgHjVJfWnnWzd++imGgUVc36u3T2PUO0FQ
	w7o1PtDgyHIkisfaLdYwJ6D0QBlkgiyS+mw==
X-ME-Sender: <xms:ZB9fapj_o3vhX6itJcFCwup0eUBAFBFOD2L_UUbA31pDEYjG7nP8-Q>
    <xme:ZB9far1xtkXP4HePkT3iUunon1Vm0anheuLSuHJrh8_vBrNqN0oLYC4AbVb_rIVsk
    So9WVbyTmpzlM0bbKeZKYlpoumAObCMkqGhmBrvbeteFiFSk-b4qtk>
X-ME-Received: <xmr:ZB9fajhxWwZimmIr1UZ9KuGjyjKx5tFpWYQziptu-PSTS1REOxy5HA>
X-ME-Proxy-Cause: dmFkZTEidRHxNBULUoaY8jfmeclLe5V1rxIgIYDxJEUcZf8/JSyTj0LvGKglZRv58g4suq
    8bBxD/QU/Vq1+VsBK8uBwbYuK5kF2U2QFdtv4ecXVIQ8DlgybKr0aD9rFq4fg2Xuc9l2GB
    dUtbKD7c/SZzBgW2eDPoKfaYm/8YN6xvcFOhDEt2RmvO7HTXUPUh6vx63PQ3vTdpQ1n2rY
    ukG1FaKUvKpnhKKmg1Dm0TrZ14cWIGuNJqJlc1E4+KB3XXAPIJlbd/Kuu0sBrOJZmBOaf+
    Abmk0weDrc7Bquqa29SShUfJMZV3CYYweJdkWGGZgwMIsrFR7VQA5/x3lb8J1L88XWbpnz
    vLhXTSuo2ZrhqKwoHiwJ56yho0vtbgBEYmyg5EHbYAF/hmoPcl91rzllgpHFHNMZjqnkMH
    y6XAanMH/vHIMOx9vE1yKXgYF7Sf3VGvgr8ZZgn9rVFS1ngvVc+2IjUl/nY4D/MKKZjQPT
    GiqGl3PjgpV8eskGEPvjlYoCplOR4zxkEI5qmrN2re39CvcA6//r7/FIDIwbdNOCuQDMLE
    mJRRFQUXtiPpcr2ep9bUmJLwczelkUNSf2MtwOWje+FIssV8eX3Ps5gpEAHZ2GkDwa3cZG
    HCgmPLolVn53iS840qvpCtGW8FyKKJfgoJKPD/UrcjblNx2TlDctkp3EHu+w
X-ME-Proxy: <xmx:ZR9farfS3RpCqROuHm8hMycIW_3sQ776rc7Qf29pmODAQnk5xCS_1A>
    <xmx:ZR9famk1YjbyWJEcrRbWW-dPHt6qtnxx1j9cJZVqaGfxp7ww8N_aQg>
    <xmx:ZR9fakv6xckqdDbozUEkmuCOQvTdBqVOvyANqX0uG_9otrrWgk8ahw>
    <xmx:ZR9fas-GYTJyO0_AbACepSULecbTRErMVtNRUJvsY5FjRPqe1lH9Zg>
    <xmx:ZR9fatevQHT1sJtV2vU-xx-3isbHTtxQE2Rh8y5VyDmRHAitmq5M6lT->
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:27:32 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:27:14 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: use filemap_dirty_folio for address space
 operations
Message-ID: <178461835005.30963.1054967726586017542.b4-ty@b4>
References: <20260703090044.1649-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703090044.1649-1-aditya.ansh182@gmail.com>

On Fri, 03 Jul 2026 09:00:44 +0000, Aditya Prakash Srivastava wrote:
> ecryptfs does not use buffer_heads. The legacy block_dirty_folio and
> block_invalidate_folio mapping operations were only added as a
> temporary compatibility fallback under CONFIG_BLOCK.
> 
> Since ecryptfs does not attach private metadata (such as buffer_heads)
> to its folios, block_dirty_folio is unnecessary.
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: use filemap_dirty_folio for address space operations
      https://git.kernel.org/tyhicks/ecryptfs/c/21a6287ae2489426d23979e2213033dd204aa9fa

Tyler
