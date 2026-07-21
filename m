Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D611CBA;
	Tue, 21 Jul 2026 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618885; cv=none; b=YkbcES+AoX7Ze4DBqNZbTrxd5F+XOTGUBNfyILuofv+/bmQ6J9QXY1WlWSmud+l+JAM8kcMhRoFlmi641rHWV9RX8mBdOh6hWlLOXo9FYR+rhEVacDyZWpRlFQNDoyHQzeNi+AGw4JsoU/Fym9f3B17HFcldTTkWmGKDX2BAPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618885; c=relaxed/simple;
	bh=mngdcxHQrhJ5Dd/GRib2RioN2cwEwbsXQvKqFbNFtMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC68ZHJDJvVNbEhTITFgdhNTU/qLWFQIIs/LsWMrd1qFxKlnozCDonjWZVp7ucLMgjscTG0yvbBfXbut0yNRFJbqah11gKaHyOjSd0wvp787CJ7a5/GfSo/wH2/nRIL57V2F3a4uvUQwrdejF9MWkwW1ezsXs272jag4QGcsZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=9U4snqxK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvYuFXxO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="9U4snqxK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvYuFXxO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 597177A00F9;
	Tue, 21 Jul 2026 03:28:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 21 Jul 2026 03:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784618883; x=1784705283; bh=Fy4Vlcl7r0
	ISg4JhmRyigBlsXNv7Hw3fqnTK3JGgELs=; b=9U4snqxKMzdfXpGE+auGg3pT1y
	PfowX/+e//HW9i4Jk+o+Sg6ljohiSYYfLx/t2QO0xWGtCUrw4GnXXTiCx5NAc1Ow
	l85xoj4rQdbIQ+qNzgM/LnwGY0iDxhMtIiF/5NoA3J2Rlp1bo1PzU7pFZGhXig/3
	vEsTzB6fKOvGRrdQLHlfoorqZLPayfk3QUCz4m5A7cxQs/Y3w21rdBvVfvHjgMie
	CofNTistfss2kA36tKnnraBGXJwkd8XGb6DCTH1afmBNJ78WDU8gLTecOe+QuSTQ
	Fw/1HI9wl/cJ8i2XPg3dYVsBY/OGuRrwpepm6N+HcvgP6BDAehRo0Dq7/Xsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784618883; x=1784705283; bh=Fy4Vlcl7r0ISg4JhmRyigBlsXNv7Hw3fqnT
	K3JGgELs=; b=bvYuFXxOfXWER4/NwksDBF3fGM3lvzD1fg3dHHE5/AIKlSC9GIs
	YZadsupOwRi8ht1fZfiQMyK5rkFOSIeqAPh0BdyzUo6JyKjGuPRsgs6aUWKMmZjj
	ehW6Z+k4laTpI/2Cd8S4FR6+FtVO9HcSOfLXqsvY47SPhei3/tVVfMrDC8CmzBrn
	sR6zBr3sTLhx8/BkU+C4IRaR/H/Po4bF4iaym8XqhRHGcoDUPJv1VTL0vSqpiOe/
	bnde3qcH1SBFxrJ45ROueWthD/vpHQuqL47OeJjIIh0WqU2uHt0WnVJHY2/Dt94e
	N3l5J+AZkAbkOsKGdyZOD8epKKGfxPYh0aQ==
X-ME-Sender: <xms:gh9farT7B65xLs28EnqmW61mCqAw5uw5vKfp4LeHiui-I6DbGV7fbw>
    <xme:gh9fauQNG-3FIqLLZMShYclK27y0ZDaoDDbBJm3LmMPNYJLeIT63aF9iRO6I068mB
    lCBTzfOf1CcIKnEVIOZSg19gpX53-W5KVk5Etj42mbUchJ43IUy>
X-ME-Received: <xmr:gh9fag5_Rf7eUeQLXNF8d_HENxcDBoRtYtO7wLlLV6ADIya2v9C51Q>
X-ME-Proxy-Cause: dmFkZTEidRHxNBULUoaY8jfmeclLe5V1rxIgIYDxJEUcZf8/JSyTj0LvGKglZRv58g4suq
    8bBxD/QU/Vq1+VsBK8uBwbYuK5kF2U2QFdtv4ecXVIQ8DlgybKr0aD9rFq4fg2Xuc9l2GB
    dUtbKD7c/SZzBgW2eDPoKfaYm/8YN6xvcFOhDEt2RmvO7HTXUPUh6vx63PQ3vTdpQ1n2rY
    ukG1FaKUvKpnhKKmg1Dm0TrZ14cWIGuNJqJlc1E4+KB3XXAPIJlbd/Kuu0sBrOJZmBOaf+
    Abmk0weDrc7Bquqa29SShUfJMZV3CYYweJdkWGGZgwMIsrFR7VQA5/x3lb8J1L88XWbpU4
    5vks+7YzLeHjl16kvWQwrAbquqCwNyUsu7LJuUPBt7Kj69P+E3775LJU5AA6hGxEqkhd0C
    bh6XoYy/cQKiguWyk2ivVNojomQuzKPBWS8H5DkB+DSAKBJylTivHq0zNnsKwofN+szhgl
    W2ibfMvZ9kW/feD9iXPfpKCcfV3uTba381jIIasRSgulOK0IOLz5/QayZHlLEJ9sWyUnxk
    LIjiLKCvEH3ZoJ//IMaX/h/lR8HD4gR4iht08sLVMKshnDlWJbLil9gjwTv96688h+P/EJ
    QSPyO0Nl8XOmzMc0JYTKXlT7BB/j6lErzUY6jLGDUmXfrCV7ibgInt+0z9PA
X-ME-Proxy: <xmx:gh9faq0GovwnU9pi2kxPc-f-a2BlMKjnzCaWbNaD8dBzpG9Zmvx5mA>
    <xmx:gh9farCNsaZxF-EJN5QhpiOtkMePVRQNaJuSEoA-aJ6k2bzO9TvcoQ>
    <xmx:gh9falO1lrSIlKs35AsbZZWgkEny44eSZ__gFYmfvXJ5zeZmhdmjBw>
    <xmx:gh9fagYhW7avAwIkZvAMGB9tIbwqJAB2soSI6PgMrn9uCT92wMt0QQ>
    <xmx:gx9faj59GvVCLlH5XaCl4aDbhtsKqE-96AF2nN9MGSyS34ZRTTCnh0ev>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:28:01 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:27:58 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Taotao Chen <chentaotao@didiglobal.com>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: avoid heap allocation for inode size write
Message-ID: <178461835004.30963.18044962628432270880.b4-ty@b4>
References: <20260630030800.191457-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630030800.191457-1-chenyichong@uniontech.com>

On Tue, 30 Jun 2026 11:08:00 +0800, Yichong Chen wrote:
> ecryptfs_write_inode_size_to_header() allocates an 8-byte buffer only
> to write the encoded inode size to the lower file header.
> 
> Use a stack __be64 value instead. This avoids an unnecessary allocation
> and removes a failure path without changing the data written to disk.
> 
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: avoid heap allocation for inode size write
      https://git.kernel.org/tyhicks/ecryptfs/c/8fafd7c86fc35bd11eb34d4ab2d6282b3354f30f

Tyler
