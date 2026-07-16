Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7742BEB4;
	Thu, 16 Jul 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214746; cv=none; b=OwkVdEtN3+A+ukVrdJ5pNPbLs8NpmXzR0vxFRLs94gzIXLGafsd3rWNyTJEdZnlW9Ab6P/3Mwe1Ur7KeWybOr+Fv++nIhcjch8XJrlKw0vqbU2NQMnH9AHDR8OByUab4XWqEXln9Zjn+8H7N5iOBYWq+v3Guz8aBc35aUuRkUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214746; c=relaxed/simple;
	bh=K7ig1CnX+KPxCPUSX1r6eK3DlU74OboN3WuAplUH7J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUk7ktE8SWZFJJdzW/UW1ymzZXpq9b8kl0IkAoutM0ejhOZHBfIMx4rmI1SfR0UuBcz/Ysa8dEB90QowCdHzgA0USVDo8hgpUPmAVZy9cB4RLgOcVt9HbIuLF+QKD57w9sUyFFPgIv6kGFCTwqQDzOsknYouWz0BE3UThZofuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=H198QKAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4eMfDbe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="H198QKAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4eMfDbe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C57D140005B;
	Thu, 16 Jul 2026 11:12:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 11:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784214743; x=1784301143; bh=TGGUM25fKP
	pdCG7/ipVXsth3zGD79D8ULD5qHxjFj+U=; b=H198QKATluK5v22UsIgSKJ45Of
	u9iTiQVUaK9HXwaWB7sIcuuUPk/S1fHymcAgYAnG4TQAXvMgJdYcAJPp0q+Ka3hH
	G5lJt8/9/FenRmF+5T+xm4H4YNXXyk8qBML0BJmm4JTNm5w+T6/h3ZTrTGuTayr5
	ZyM8yFNbaP7vF8cjJI5t8wcIfg9n7y6JlMVymf9D6UW/imAeLZVud5VN/uWtm71I
	9rdaaGwnopLlpm02fqR+/R51tJUkT5oKm+pHAB4XQIh8h7a/nbHsjvbH6zKKInvz
	s1fzat+nSE2C319nKgbhkmAxVWWwci/FZ6T983or1R5ebrWncV6A8OdclSXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784214743; x=1784301143; bh=TGGUM25fKPpdCG7/ipVXsth3zGD79D8ULD5
	qHxjFj+U=; b=C4eMfDbeHtQGFyQtBxil6mdVCG3rPfPILCqWXD6WLGT0WrqT4j4
	1GCKbzJKXsLmwsNYR08jPbycd6Yh78WT6bs5C+Gwe9sxLZNMWmoi/AYVoLryGLjD
	WTvPwqOVhCt7PeT+w5GzUaokboy4kNT6pDGlgnRlTRXVRN11bDI1fGsnnfi+25th
	cxaIUnLW54a/6tqGfZiWgskvGMgmqu6KuvU/YLcAy40JX7jNEAw2yzQyqYofeK0f
	tI0AlUustlFex5+EPkZZBxGdeCBKgLrKa2VhA6fYfTERuCz8ftEH1jpglEocmgcg
	hvEozfG/tRPQmKzEKhjeuwHX8XVa2z6CTYw==
X-ME-Sender: <xms:1vRYah_d3EOWkNwaqjndr2M5zpfF-LRHr5M1TwLfgF8S2gU0F1RI_A>
    <xme:1vRYasnmdCkhRtOHZefuHRLed1xlPftrCOUBN4h8oXWJr4SFN6HJhsaGeoi2w29dw
    TKCyIWnHwxJRfqUC51UFRgtFuqzaLoEpdTL1iMrLvN_N5qLFkqG>
X-ME-Received: <xmr:1vRYanVsfWAZo9q4DiL8ioS4qVFR5-C26VkvK_HOy-C0mkU-hd0tCQ>
X-ME-Proxy-Cause: dmFkZTFO2sNdk0SPsBelkas9EmB/g3XkIqzpIRprhlkzdgX5q74qqfvF+pYnSW71g29Hpk
    z6Z4PB4NNHgkmego29Xs0usM19BGwcb62fcMiwkeWDHlTRUPGKrQkUwa7cpBypkYLo+bJ5
    5ICPFjhVctZlLPz497pKm0DvaFEQYycZA9+uUX6RqFG6eas9gyVnD8wiUoOWvihG61VCCs
    yRWbMPwQvJQj6BjWdMpEoglG6DdEloerMgDO9WG+FaRq90eg44goerIiJotsKU44gvJBHn
    t85K2AicAK25/LNYeCzvrvC7ez1je3rdUn1AkpSmOtaZsQ1UeuVdxGAz+E4VMboQ7QIfQS
    mJu2A5GvFlbthEb+svxQpFz1K/4nClSILFqTFlJ1fH0gEcd1gf3XeP2NCug9QgVV4bxFaq
    qfJM8lzm2fFxBiyjhsRucHOE4MmJOzKnyXrkgeO/OkP+BvV6Jin2PNNvhU+JnpRAwPLB5J
    5/CyU33ZL45pl3daK87j5jsGCgzgxJZ0Ai+5k6eBgEyOevN8GU6ak1GsUQx0Ulb1hYOIWy
    EPyFMLrP/PnlfSxy0aUEFD9/PzQAVnCOaWQlV/JXBDZEbooGTZyUQuZC4vvD0tl3mrfGDV
    f97/XxCV0NYcV0BcveePakcfzpt3uKZcJl1qUSudbrebpG+h71J2hI778WJg
X-ME-Proxy: <xmx:1vRYahF2VbymxFNpsvCpnUQ1duFKezdA1rbup7CuKkP6EPKuIGGzbw>
    <xmx:1vRYajdIOMN0_LgHDUxXf3BzbUKXiXl0-d0KTrp5FAXsKRRobcTUpQ>
    <xmx:1vRYaiKDiPiWI6vLa4-KlXq0-dEXoeoMKUsCATfDvSNl8OyoP5uH-w>
    <xmx:1vRYaoGpgS1sG2popkmqr7EvbX2kky-Y69ZGfiQbkNW1wLfsJzlY9A>
    <xmx:1_RYat2djn5T_UA6sC6zo-e-8dAUb5_gZKKHeZJyt37QXqDuXktgEC6m>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 11:12:21 -0400 (EDT)
Date: Thu, 16 Jul 2026 10:12:20 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [PATCH] ecryptfs: validate encoded packet length extent
Message-ID: <alj01DBcUTGaE5DO@elm>
References: <20260715083702.29471-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715083702.29471-1-pengpeng@iscas.ac.cn>

On 2026-07-15 16:37:02, Pengpeng Hou wrote:
> ecryptfs_miscdev_write() accepts a six-byte write as a minimally sized
> message.  It then copies two bytes from the packet-length field at byte
> offset five, although such an input supplies only the first byte.
> 
> Copy only the bytes covered by the current write.  When the first byte
> selects the two-byte encoding, reject the message unless it also supplies
> the second byte before calling ecryptfs_parse_packet_length().
> 
> Fixes: 8bf2debd5f7b ("eCryptfs: introduce device handle for userspace daemon communications")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Hello and thank you for the fix! Some comments below...

> ---
>  fs/ecryptfs/miscdev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
> index 5a7d08149922..a99e16db8243 100644
> --- a/fs/ecryptfs/miscdev.c
> +++ b/fs/ecryptfs/miscdev.c
> @@ -360,7 +360,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
>  	u32 seq;
>  	size_t packet_size, packet_size_length;
>  	char *data;
> -	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE];
> +	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE] = { 0 };
>  	ssize_t rc;
>  
>  	if (count == 0) {
> @@ -376,11 +376,17 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
>  	}
>  
>  	if (copy_from_user(packet_size_peek, &buf[PKT_LEN_OFFSET],
> -			   sizeof(packet_size_peek))) {
> +			   min_t(size_t, count - PKT_LEN_OFFSET,
> +				 sizeof(packet_size_peek)))) {

This is a good change and fixes a potential one-byte over read.

>  		printk(KERN_WARNING "%s: Error while inspecting packet size\n",
>  		       __func__);
>  		return -EFAULT;
>  	}
> +	if (packet_size_peek[0] >= 192 && packet_size_peek[0] < 224 &&
> +	    count - PKT_LEN_OFFSET < ECRYPTFS_MAX_PKT_LEN_SIZE) {
> +		ecryptfs_printk(KERN_WARNING, "Truncated packet length\n");
> +		return -EINVAL;
> +	}

I don't think that this new check is necessary. The call to
ecryptfs_parse_packet_length(), below, will already return a
packet_size_length of 2 if packet_size_peek[0] is >= 192.

The existing check, right after the call to
ecryptfs_parse_packet_length() is error checked, ensures that the value
of count is equal to 1 + 4 + 2 + packet_size. This already protects
against the truncated packet length issue that the new conditional is
checking. Do you agree?

Tyler

>  
>  	rc = ecryptfs_parse_packet_length(packet_size_peek, &packet_size,
>  					  &packet_size_length);
> -- 
> 2.43.0
> 
