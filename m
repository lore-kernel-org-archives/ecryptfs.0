Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F42C11CA;
	Tue, 21 Jul 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619026; cv=none; b=rC0WOEKHpvgHHAP/Ts51/VYGM+Ct0HHfkr5K8UBmF6jMVwnr+v+764Y/cirxbTlT89R09XPCk3tSMWa1yQr7HaG12HjDV9Nul5Ife/OteHvbQoip3biOug9clfxDo4C354SwIJ0geDwgchJJSgUdJ0sFgO6ljoxXsQlbEDXtoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619026; c=relaxed/simple;
	bh=eqjsugyxsqdEZ5rY3UZb7lSzGgyUvIj2h9mV1bUpUIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG5qc+9ccZBKMGp0zihhh3QUrHTMgaNhYt0wPDyw9ADK1UrXdeGFQhWMb6vg1cMhwolrdrBPnhxTay80VhUlHKWMDV9lu2q2M4JXxovY+3hxgohaWKgRXlT8w0j6cqa0BJtvNvgqsw+gTjag054Io4qWfoF68Dt2rS3JywcfLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=ZrhBoBb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phYhoCSZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="ZrhBoBb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phYhoCSZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FDBF7A0074;
	Tue, 21 Jul 2026 03:30:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jul 2026 03:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784619024; x=1784705424; bh=fOTN5IZDLR
	YryjdwZxBRp5ZMOFvyKaTtee0cnXQuFzU=; b=ZrhBoBb6sq3mAw5jZbcPVTjlcU
	hJ5V9N2SvS2glnjoIj5wEhJA5Xk00ZUd76wrATMTbDmGv/Bx6LUuXQC2CVv9qb6q
	LUIGYRZqVFIpjr1IWqilEHcGx5Vi+0nwCC0fyOL+PLmSxB5pqu6zK2Tl+sYt2Mt+
	tGH6FRZDUJfcZLuf0u86SJBU2QW4O9HgFSEWwvG5VsflIcBo/X2M6YOe3XC2ElM5
	QBS5ecQVhrRYRVFPpNhRjz//8Cr58eNXKiS4mXKDP4e3guHi0Nj+yUkFzygPduz3
	ToNN9NxXwLcpFuJMrwG12Ve2P6NB7KU9w8rpOqpUOHBBrUNGBfP2kWlXJFiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784619024; x=1784705424; bh=fOTN5IZDLRYryjdwZxBRp5ZMOFvyKaTtee0
	cnXQuFzU=; b=phYhoCSZylITDRDrFWSjvSgbzbdvYKSnt5mNSQmCCAjFRp6CzvK
	1pXP6SirH4xDMCIusTtwsB6VIsNLKp3guhbvzvv8cbiNEzxZdbVIvtivFPjNV+L2
	ZHTBDEeNUM33o7Ypepx+Z9RgRtDEz5sqLTJ4Nha4o6vvuOxMc9As+zk2VEILlzdY
	V8Xv8VzME5k5x2gOyEcaSHM1qgnP0KGcXgMnRxMP99s63pu8LjmVmFbVLI+wsdis
	MRh69d4tGa5amsQBEiMjcsyN6mHUkwhstcAisVvdc8X43bI6mAuyJuQVPtdbrjZt
	6OSg5aYJmgo6RvoonBEz5vva9nizqlPqLBA==
X-ME-Sender: <xms:DyBfap9y5TKEnt3_LzDG0NjjZrvzvni3fedMajIpaoiqHNMl02OYzw>
    <xme:DyBfat0o0mcw2aI0KkCO1EuvSuhSHqPmn75nOCXN-CGKYFWLqLFMlJ3ss_ng6w5Ro
    ZKuDef_NH6CWDnlfbwwEIDkqliWdFZiHl3UAN0SBFGSMC9pTih-EGw>
X-ME-Received: <xmr:DyBfau_9wMTzsPmtZNSVCenUOD_txRtg2cwE7OJBiXbAxpeHVgKsbg>
X-ME-Proxy-Cause: dmFkZTEidRHxNBULUoaY8jfmeclLe5V1rxIgIYDxJEUcZf8/JSyTj0LvGKglZRv58g4suq
    8bBxD/QU/Vq1+VsBK8uBwbYuK5kF2U2QFdtv4ecXVIQ8DlgybKr0aD9rFq4fg2Xuc9l2GB
    dUtbKD7c/SZzBgW2eDPoKfaYm/8YN6xvcFOhDEt2RmvO7HTXUPUh6vx63PQ3vTdpQ1n2rY
    ukG1FaKUvKpnhKKmg1Dm0TrZ14cWIGuNJqJlc1E4+KB3XXAPIJlbd/Kuu0sBrOJZmBOaf+
    Abmk0weDrc7Bquqa29SShUfJMZV3CYYweJdkWGGZgwMIsrFR7VQA5/x3lb8J1L88XWbpDr
    FmcRwfPk5LFSuwfmPewrRzNPwDHME5Gaxve/BzuaGMgkgg86hDLOGXmHqSTAVpYP2HTsO3
    PWsJ64RLgduRWVJDfFW+wIJfYjTgqDT+hgaotKm417sNPtO8Km1eoQA7uFX7sl4CIOwbMv
    myO1KgvbgNUXgBQFoK5DbS0r2lNXzTfAHi2RmOE7wFjxUAoBUTv0ruT/Jt5lEc692xnuZi
    h9Cqtv3zbymiUdm/4BiDPTbYp28d0eS3VZG37pfsXoxBZYBR65T9YQTsG5IqRq8WsRgQBM
    GHCjpJaauiJRrdEMaX6QVstcdFIp2LpDbudMpI/LJ1xi3ZQdZ5uq9X1KvFgw
X-ME-Proxy: <xmx:DyBfaluZ0-evrTsNcnoObrz9P79GkSUr_Cc632QNV7y61MM9JSH6Gg>
    <xmx:DyBfapAbroit60V6ZrqhXbbwgcxe8qGc0La9M5yS5BAMsGWODlUNBw>
    <xmx:DyBfalUqxcA344yDgHkSCw8OazQBKjeWlOQRu3hOibPcSgMCcqhuPg>
    <xmx:DyBfavCZmKEYHl9DnrfdtCQn81JHc4Jk7si7DrA98HA6wfUu0Q1-ag>
    <xmx:ECBfaiQ7K9PgsdDcdgPlnwgErGnnuF6mwjzfMCbdyxU4bwPY5-K8z7Us>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:30:23 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:30:19 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] eCryptfs: bound the packet-length peek to the user
 buffer
Message-ID: <178461835002.30963.2712116522812995858.b4-ty@b4>
References: <20260720115624.5426-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720115624.5426-1-pengpeng@iscas.ac.cn>

On Mon, 20 Jul 2026 19:56:24 +0800, Pengpeng Hou wrote:
> ecryptfs_miscdev_write() accepts the minimum one-byte packet-length
> encoding, but always copies the maximum two-byte encoding from userspace
> before parsing it. A six-byte message therefore reads one byte beyond the
> submitted user buffer.
> 
> Zero-initialize the peek buffer and copy only the packet-length bytes
> present. The existing exact packet-size check still rejects truncated
> two-byte encodings after the parser determines their encoded length.
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] eCryptfs: bound the packet-length peek to the user buffer
      https://git.kernel.org/tyhicks/ecryptfs/c/95540462e630edbc8504e9537d16453d6942d143

Tyler
