Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8D35F19F
	for <ecryptfs@vger.kernel.org>; Thu, 26 Mar 2026 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501857; cv=none; b=CxwaakLNv0fuWYdPck92bTN/SKJaiVpXWrCCqsZKA6ujcVVNGWJuCdCVRZIGhsY+iDJFMRmydhz7QXB8gaKRJuSjY64wiYw5uI0XZsJoYQ3kWCnYkQy1yV0q+a3eO09lexQusvRrUSvT9EpBsR6k6IZowRne1iMbNsaxp/jTf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501857; c=relaxed/simple;
	bh=NuDHFbhzxR2+hgv1tYoBM/Ut4nzjg2sZcDRrukVfGj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOgiKcB8ofbypPHg1YcOmd5ew9ExUOTkuGciAIvPILBduF/WKzQ6dYGaOLXnyVrBECwJl+DHPCjZz9FYjlmoG/MfoNfLeCM6n0wNAphyOiVd1ZMNaoi2vS6l3ETRWJcnH+mh841atbedIERLa+CjdlTEGwyedPJepF6jeRtpIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=YulCcggx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r099N2HK; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="YulCcggx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r099N2HK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 515971D0020D;
	Thu, 26 Mar 2026 01:10:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 01:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774501855;
	 x=1774588255; bh=a9Me7hDBDffj7QEml1Q6SDJ35lZewss4V+rimWB1qLA=; b=
	YulCcggxLljhVGiwSjvlPU7UVESV5G2xUQmJDqmBks46ahM00bQ5BKNtbEDF1c8n
	z8mub4eiPCCCPNbxeOYJnJfjtpM+uWdTz8dsAN0yR3KIat2jVFNzWimzGlAWHPmB
	HilVQkuFFNa9V6qwil2wr/xEo9sLL2dmYmEQUVnKIKVDabKsFHwprUIq5eEOIpm2
	v1j5vZdhryFz9yw2P/oKPpxkNyUIfUleh6MdM41YEEkLdm0fR2+uDXvj/oC2G7/f
	tmhly0Z/td4kz0vE4ZvLJyZiqJKhWf50VebQSqac/4Ew5YpncZHuopRAFxUxD7U9
	L7mR5RnZx/NfeKIzRcFnyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774501855; x=
	1774588255; bh=a9Me7hDBDffj7QEml1Q6SDJ35lZewss4V+rimWB1qLA=; b=r
	099N2HKX5v75bfal5sj4/6KztGuZOslDOAV664kRSF1/OXSFGKxpomXJpyfguEg8
	KDn2Rxrzhbk1ob4aqg1lJkSHlY1+oPcOnAU+sXUwOG9okIBK3i5BmgOJmiHk+v7H
	TiiayU2Yd3SmP+j++pvPFivWHXja124wzf4PfbrOMkJjtSqoWYBjxkQXff1hActl
	fRw6LJeb8vsITyWOpogrFTX2RGG7yRHeB2LcQA5LvuHZiyncIpXZzUzWlyNvQpzu
	jGQ4vKZDX/D0ZZkH7ErTE9ElLLEb0AgK168KvpDWVW5z4kXHjftjGDgFIdpUfG6Q
	XR+aoyrPMVLbR9bAalYxQ==
X-ME-Sender: <xms:3r_EaUOo8KqM3vB_4dazqqCo3WUla4jbI3wleXO6x5mjGuv7pv0oSA>
    <xme:3r_EaSbOOelwVmbGLo36CiwxKNxH-odqhqsfqYD5BUJq10eB22nboBOpzknm4akdP
    ozvQG-eOjE3sv29O1bb5LTkRXaVJ4Ky0dPZaE33FRhDkcsBQmuV_Lk>
X-ME-Received: <xmr:3r_EaYryWHBUCh4vIiQAGDFTGeWXrEOsEv3xAKCpizXot1JnsGZBO8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvhihlvghr
    ucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpeejieegveejfeegfeehteejueelhffgheeijedtjeekjeeklefggfdugffhheelteen
    ucffohhmrghinheplhgruhhntghhphgrugdrnhgvthdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvseht
    hihhihgtkhhsrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehfrhgrnhhkhhhsihgrohesqhhnrghprdgtohhmpdhrtghpthhtohep
    sggvrhhtrdifvghsrghrghesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtohepvg
    gtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3r_EaWbEyevG3txQB8wZlKKZrj1wBzUNztcczDRkEQSEmT4WuwQ7AA>
    <xmx:3r_EaQS_xZfrZg19HLNc_iC5Kd2JspsXnPMozqVq_AMtNt-WZGpv8w>
    <xmx:3r_Ead5tEePQ8IzGqkQ-8zNUpsODuwASNDKSCsoOvFPVgDQHZZivMw>
    <xmx:3r_EaVxFnJGdqfvFXFXfzIdBnnb3nXwNFvRzXUC3nzDpfbeCp7rGOQ>
    <xmx:37_EacOtZOm9PAoeDbP82j_zRJBYfIqEatSq8KWQx_0HXe4vbC2hcmkL>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 01:10:54 -0400 (EDT)
Date: Thu, 26 Mar 2026 00:10:46 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Frank Hsiao =?utf-8?B?6JWt5rOV5a6j?= <frankhsiao@qnap.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
Cc: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>
Subject: Re: [PATCH] ecryptfs: set s_time_gran to get correct time granularity
Message-ID: <acS_1gS8HmnUFZ4A@yaupon>
References: <SEZPR04MB6972A94B302FC6AC528823FAB7EE2@SEZPR04MB6972.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR04MB6972A94B302FC6AC528823FAB7EE2@SEZPR04MB6972.apcprd04.prod.outlook.com>

On 2024-05-17 10:09:55, Frank Hsiao 蕭法宣 wrote:
> related to: https://bugs.launchpad.net/ecryptfs/+bug/1890486
> 
> This bug happens in the two following situations:
> cp -p: copy a file and preserve its atime and mtime
> touch -r: touch a file and use a ref file's time instead of current time
> 
> In fs/attr.c notify_change(), atime and mtime is truncated by timestamp_truncate(),
> ecryptfs gets wrong s_time_gran (10^9 instead of original fs time granularity) and
> truncates a/mtime to whole second. Setting s_time_gran when mounting ecryptfs
>  solves the issue. 

Thank you! This has been applied to the next branch of the
tyhicks/ecryptfs.git tree.

I apologize that this fix was forgotten for so long. Thanks to Bert for
raising it back up to my attention.

Given the long delay since you've sent this patch, I went ahead and
slightly modified the commit message to make it follow the guidelines
documented in the Documentation/process/submitting-patches.rst file. Let
me know if you have any objections:

===
ecryptfs: Set s_time_gran to get correct time granularity

Set the eCryptfs superblock time granularity, using the lower
filesystem's s_time_gran value, to prevent unnecessary inode timestamp
truncation to the granularity of a full second.

The use of utimensat(2) to set a timestamp with nanosecond precision
would trigger this bug. That occurred when using the following utilities
to update timestamps of a file:
  * cp -p: copy a file and preserve its atime and mtime
  * touch -r: touch a file and use a reference file's timestamps

Closes: https://bugs.launchpad.net/ecryptfs/+bug/1890486
Signed-off-by: Frank Hsiao 蕭法宣 <frankhsiao@qnap.com>
[tyhicks: Partially rewrite the commit message]
Signed-off-by: Tyler Hicks <code@tyhicks.com>
===

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: Set s_time_gran to get correct time granularity
      https://git.kernel.org/tyhicks/ecryptfs/c/7d9ebf33d85317f3f258c627de51701e2bf7642d

Tyler
