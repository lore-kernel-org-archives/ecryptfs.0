Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4F3AE19C;
	Tue, 21 Jul 2026 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619004; cv=none; b=HFmhRnf0y5jKQAuiFZUt2xzs9k23ZazoYJeUq/v5wSBdWzXsCCCfdIgAVbJgXK8LMSWo+ZGUADXZHayUgOiN1gNm5eazE3euklGZl2W7N5MylMTtywPph9fLwHkmZxuzYgaMuxOH/uxr2mGCSCpm19bvP1k8uvbULlYvUHnsiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619004; c=relaxed/simple;
	bh=gO54gaLGMY1ciVWK1G7c0Gs+BLB8519C4cFqlE+8zqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7ablywTcnMDob0esrqnKXY17eOq8Q4ZQZ2uDJIJc2/itgeZjBTECZFtAIIxZkM7TwOaWaq4+Krpu8gUK3Wrdp50xAhx+eXPGAFSQA1ANGLdjnCBKEfLrKbYP0St0lIU8YJjPoCzTMpISgIQkKuWVCmVuBWLcogxExTCt+TXH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=8zEnlfm4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k14Ak8LP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="8zEnlfm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k14Ak8LP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 195F37A0074;
	Tue, 21 Jul 2026 03:30:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 03:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784619001; x=1784705401; bh=JkfmDu5rf3
	jnNl1dw02bkI5vDdf9f5ZMbQrLt0LTcGE=; b=8zEnlfm4mH5dXsvsYJW3KhvJPc
	8yai7NI1TF+5v2SGUGZWEpwdfFko1dw1vtc1KaS5+P1ZLoymXVfm900g3bOCaimC
	6bWs0NMiRK0IWRd1Z6n/xwxoN9qdYyw+iV8BsRR4ZpNvAHeM7UTbMLRdDUuTxtuT
	TEohzVdGSg+0IoaSzVGEaAtuPPJtf5Bq5ySm4aXK4cyTTnFIDCvUAhi1QSBF/+Mf
	19wt5braGE3lzqcUjcESyjO1CzSm8XVdwz9d19usJ3vJYHS5BFJx1MMjiiBVTH7H
	AkYt63bC/KMFSJmx/0ydqJEICarw4kU/O1N2eLnLy9A8gngyEHdcfGcdBy9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784619001; x=1784705401; bh=JkfmDu5rf3jnNl1dw02bkI5vDdf9f5ZMbQr
	Lt0LTcGE=; b=k14Ak8LP1WfBRdKa8OIEncEK4xIp8H79fqGJkmGW9OHk5Wyn8xh
	X58v/wNJjvE6/Qq/ePd/SOE75dAdw5pxMeng6gs06X1e5uK3kF+D4SlTtIzvwOxh
	+MpnxgfGQdSE8OskKhgTgsgY86Vd/3rX9lmIp+XPgR7AviwiLpKKSiN1Jzq2C/Gb
	oMm8HG7J/30WHe5c4r6RvH8UYq+WX1RkV7whlf3e+EIxB+2gfted+Vq54BC/d/LK
	I9i8EI47LlkqHsU8SywRf2+9X+ll3Kg14M9qmyMIrwq+SbiML9lQea+pPAl3tPfj
	Qj3Zw8QKVmYahtPKeW5mXdDrE5eDWDc0DVg==
X-ME-Sender: <xms:-R9faoHfEUudDeQXCWuiJ6rML7qGcKgdzLtWWzre9WLORh9PuwXk4g>
    <xme:-R9fai0693MasJQOhHBis30RLN1xg0ocvomo-iGP4h4LfmiQWAZuPDQHjiiPFt2NS
    VValTkjMWY6xK7Ezwv1qoRtHu2yQy-L1WPhYi6GFvT_bfoLy0mu7Ms>
X-ME-Received: <xmr:-R9faiPwGVukwbjh-aLDJQxmVhG8LiVLthmC8yDvL-acXQgEuc2KMA>
X-ME-Proxy-Cause: dmFkZTGqHE7cTw57xOxUP4PVEx2HC1w3ZAOc5NM8QNlBEzip7kqpgiUa0sSJWsZwfE0F6f
    T5bFQfDLlj2MvaWjcvCRCPAH9VDCzlG5K4PBt7tasGlH8f+A/bCPtO+ZYnQAbdV1+4CnPn
    R4r4KDnBxks9YV1/VLGTyGaeAm8Cf/GzfgTZshFHN3A/TQ+lJ6KJOuvLAE0TsIKoVRJ7+e
    t0VFCI9ZCC7ZnYa9IdoqPR7OqryMKObhNc5whdbW2NhOyzJok1K6vz/shv22XLO/NkvVhN
    vh7xgtIS6S4lPGKZhIhCdnSC7hCE9TA/6bDXdcEee/4f65qpKJype6hIhUSLwkbizdxvq5
    RsDHxdNJ0Lw9xGyzIzEhM+k9k8lEghAk04U+135I7J1UYZCkPv1XN9NEXp4XsAH2h+R4L/
    /Zlc6MCnBVhGnxgloiI/EhrcQxOTlSkdTo0fw76w0Px343DJHor5M9XKyPPoP2Zpy2G8pb
    Cj/eui8wPEUQmPyMzt9ajmkdgtA8gXK96LlsOobNVG37f9FARlHGRefcg4EJ5Gps54Ruw2
    7QVTDsDJHKtosY6Ag9XdlZBp5BoAiuWfXHjlE+g+776yxYHpsK90m2FOpqTwxg5F9tGCNH
    QgczKQvyHy0kCmScvLp/nKlnMvaYPQELzDWNd/F9XdbT4PnF2udyNBXNzODQ
X-ME-Proxy: <xmx:-R9fap4KC9Z-6fzK14T8UVWLM4eVG5Ij-mVieUClOvAfQVYXg__pVg>
    <xmx:-R9fak3BHjJLETTPxGBjAC8qK0Z4MRBeM1DK2nrpzeoRJdnN-GqW6w>
    <xmx:-R9faiy9MOmZ1g_4RuRIh-ro7uz2E6kOmuEa6xtfRTjk6wToAAHY6A>
    <xmx:-R9famtuCemu6K3fTGdXVGwIowRMBSKSBKgjPF7y6eSUMzK3gI5sKw>
    <xmx:-R9faiw_Xz3ejAVnIkWf4Uzlz58mSPb95b1Z5k-uoEQf0tWXIbt2TY40>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:30:00 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:29:56 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>,
	ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ecryptfs: release message context on send failure
Message-ID: <178461834997.30963.3121844491716187512.b4-ty@b4>
References: <20260701053406.256772-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701053406.256772-1-chenyichong@uniontech.com>

On Wed, 01 Jul 2026 13:34:06 +0800, Yichong Chen wrote:
> ecryptfs_send_message_locked() moves a message context from the free
> list to the allocated list before sending the request to the userspace
> daemon.
> 
> If ecryptfs_send_miscdev() fails, the context is left on the
> allocated list and cannot be reused. Move it back to the free list on
> failure and clear the caller's pointer.
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: release message context on send failure
      https://git.kernel.org/tyhicks/ecryptfs/c/219644a3ad5518217b2d62cad6d2c36a2308c949

Tyler
