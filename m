Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF697368276;
	Fri, 28 Aug 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936254; cv=none; b=OXgi/EU8xCcXV5KrpV0M2JagePxx3nipLYvuSr1PJGMPo4fHutSp2S5enQRPAQYb08c8zFtGZNximdYWOOFOtv9xcdCHZFWhSuzRiz6YSbkoz+1gLLsKlgxWreS6kd1F/noEKvcnKXUOAj2uQWLhfwuFkkXO2Gz2wohLgyjixvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936254; c=relaxed/simple;
	bh=z9HmObvO8ekArk21oDr1C+BIxTXvF9QTNN2HmKxWUKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7YVmLAnj0jRqS4EoHhz1BEZo+HUUH2HV/sF11Y94jZN/0unebF3bOT61ojuCZtPQ84i6VCabhne+3hy8cblSY6HppWz2dUQ9VBPWE8k7WSzYyxeQbr5LdhWNiEMqv0lgQKBaGkL+ejEUd8i59cH9ZYTjnFxtdWOJbWtKNedxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=ReIOwFBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LddJ/2+0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="ReIOwFBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LddJ/2+0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D34C0140013F;
	Fri, 28 Aug 2026 12:57:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Aug 2026 12:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787936251; x=1788022651; bh=IbFvfOBdh+
	EKNkREXJ5YazpgqM6aNMD/NTaeMUI9mCE=; b=ReIOwFBrmg7QXEEDeUTsDI/7EL
	Kf0VmFeFLDP9CD6XCjRrgarDNtrGA8YG4Ha9r0i9KiQaE8EsSQjv3/vNEixjqyPq
	Vq75Orx65CLcWi/iM3rXaOAUMm8AP2PuG6M2Y/jtKo/3fQxiemvLF53HRyw3DInA
	TOzTALmrfEVaFWUFCO2JEFyVdUW+yzC2HquJ0V3p2wYUchOrVeh1k3oxoNb9AfE3
	SaMDLznq2lz3Vjw/maTnT68GT7t64W/ol4S8vwKoqgXkLl5hf+wWe2Us7jb8T3Oj
	lrpQ7MzhqPg9sZVkf0KAQ5OVAiyRQPvzZRRgSIiOxxs8HonBA+SMhKTD+TPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787936251; x=1788022651; bh=IbFvfOBdh+EKNkREXJ5YazpgqM6aNMD/NTa
	eMUI9mCE=; b=LddJ/2+08Il/3n+scBtWQcTS997kAl0Z5FpHE8w84LNjUPXDCmf
	OcRa7ZvNjO/mVkr1JZZnZEtWmP7VTWKVM7mSNx1g54DJcUd8mx/XU4ZT3Px0Jkvh
	4E3TGFt/q5xc7rVy7vvTeDjQjSi3SpU8mLyyAwmBtzsasz1CjJbMiN2YjahaGTzv
	xUJPz5uatqhN+/9jJTDfgGp+evpCYRQpSyp1EhlrD7w8JHIW86+L5zFsE7GyZIdk
	2ReIi78s+/CwB+YvVspaCXZAvYwCxItM/poQkZQ4noMXHUJ7tTnrZd9+5+BYIeoF
	fvdS5oPnNuwzOdrEiehFKNnV0vnb+vrFUDQ==
X-ME-Sender: <xms:-72Raogjm01ubLBJg8dUOuoB_1Azub6AeaieSbMQpaesbxo5uwq15g>
    <xme:-72RarBuQ5OgoCIiLPrdaghRb-cKOPKcZOh0zkTC1QBEOnNnuujwsQ7tfInERITS2
    DN0jjACZg2tX43hVORGiCw8ugAIV3HK9hkbTUIo4Lw0D3AHsKybtxc>
X-ME-Received: <xmr:-72RamvPphtzYEd34U03QF1hksDG2Mc5QIX1egn74rCTk47HRllViok>
X-ME-Proxy-Cause: dmFkZTE4pOuEdjo6yXSH9/1OiWD+gc4VA7Fat/w18aP3vJU9EsnkbaHKdq5P+DQXG1f0HP
    0GZYge7deP+elbQpeZofh4XFjf00F52ublzs7s6W2eBXZ7ILEjygWXu5VnqU2kt5KKOO+o
    Jwo7+c0R4D5QzUTXzFt+849QHWUdHLcIK9wtrt165rfzELS06d1p6Afit/tdIzhX4aRNlb
    Jpzw6bKRtcbVmw0usRJ8wnZEYAGZXI27ubS2Z0z0uGZvSdTPCTbqpJ7XVUyPeDYUkAVQ1J
    Xo7K6RGfMyQuYu1Ga8d0vWrT/oERLTjXJyyc+wc3tHSdqLtuqXw2F9pJ8cFDc0BVvFV1FK
    rTuGEiAqjGgP8tNlF3sEAVITYhz3eR+xhxC0q0KfKGjdn9zW6Td0XrQYfBZ1MyG/M+NrXH
    gHTZMPPxb7GEHnk/me+JzUUZwHGTikygkXw9opjlnnPEJXIg/LZfDJTmQ75/bJ/FlDeA1j
    uS8PcYRzPi7Pmf0uSSO3W5488s0QpPZX2066y6zmrN6InGgh9qY4LST60otaNGQfsnwm4H
    EVI3v2DLwOyjQpVOapLM8i0TADFxTlrzT6WOcWiZbjVS+yi1+r5dkFpBcppiFybGnnokKA
    4V+rxf4XjU2eehQ5bs/oepjtZbAlujRamgh5y+wDxRjdOsTXTNAdj98KvPtw
X-ME-Proxy: <xmx:-72RandwvIWms7cekSPmpC6TkYvZdHo10h5edninWYr5iISg83A5og>
    <xmx:-72Raj8dvqDFdP8815rgly93uHd2NpnStahtZSKKxnPy31oafAVy1Q>
    <xmx:-72RaiTuAArvrEYLpSMvNj-cHQNB6Gswrxj3a5MgwfrggRq_n8bAzw>
    <xmx:-72RakqSp2AYKB-Jzr7gTGCFCy7FltzoHUm3BejzpqoqCy4oyKEUIw>
    <xmx:-72RatFet4WHZS9KduEWlgcMSNmmdql4YhJqirEYgA7ra5neCzEGZsa3>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 12:57:30 -0400 (EDT)
Date: Fri, 28 Aug 2026 11:57:22 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, falemi@asu.edu,
	ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ecryptfs leaks an inode on lookup failure -> kernel BUG in
 generic_shutdown_super()
Message-ID: <apG98qJyYqvcTXIh@yaupon>
References: <CA+0ovCgYP920GT68hAJK6Trjyv1kGv2dZAuem4LEunycQ=POww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCgYP920GT68hAJK6Trjyv1kGv2dZAuem4LEunycQ=POww@mail.gmail.com>

On 2026-08-27 20:18:11, Farhad Alemi wrote:
> Hello,

Hi - Thank you for the report.

> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/128-ecryptfs-i_new-inode-leak-lookup-failure/
> 
>   ecryptfs_i_size_read: Error attempting to initialize the lower file
> for the dentry with name [victim]; rc = [-26]
>   VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
>   kernel BUG at fs/super.c:779!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Call Trace:
>    kill_anon_super+0x3b/0x70
>    ecryptfs_kill_block_super+0x44/0xa0
>    deactivate_locked_super+0xbc/0x110
>    cleanup_mnt+0x437/0x4d0
>    task_work_run+0x1d9/0x270
>    exit_to_user_mode_loop+0x14e/0x540
>    do_syscall_64+0x317/0x510
>   Kernel panic - not syncing: Fatal exception
> 
> Our reproducer.c is available upon request.

Yes, please provide reproducer.c.

Tyler

> Happy to test a patch if that would help.
> 
> Regards,
