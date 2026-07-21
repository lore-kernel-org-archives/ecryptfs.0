Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F9433043;
	Tue, 21 Jul 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618913; cv=none; b=JpBg8J+rIoPGmGhySMLdk7ff482TMcgnu8jIv501a7aZsTmYT52yVzOOz3agSIbfrlmpl/qOhCxuY9xZT4dY0nTfqc6O1A0oovSRP9mp6/4VI8cm29yXwrr4ePYw6c//Z1gEU7+MSM7AuieIYFDs8Oz6De6OGY2yxp7rcn+qKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618913; c=relaxed/simple;
	bh=uPVTUHPjM22KYRUb5TClQpDMxWCCa1MFz1SRvW7v9o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbhFA7oJiGQRyySY3thsIw7ZkgjYWsD06kCUts5HvkD+kOFMsy5WLcDp/za8SoitffU3jVnE+aceoAWXAAcfqybhoeHpUvQkmKolYiRQq5EDyq3oN2p8KN7hq/TWMO21+RnfvhPmaUl+0s7DbNpJ0sZodJ2znNlDkxYijkKsovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=XJ2vNHPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHwN/yXv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="XJ2vNHPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHwN/yXv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C7801D0008A;
	Tue, 21 Jul 2026 03:28:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 03:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784618911; x=1784705311; bh=te9JZOOZrz
	ZM2rg7/DYIiZfwM+ajKAA5d3IVs91lMfU=; b=XJ2vNHPgrm/CmXWB5YxyVfckzd
	1cp/stk8QxcQrsXJ3q5jXT8/VTuEmp0vSv1Ltvb2E+mMQ0RAf7og9hEk3UJeXN7C
	RNjVymdtJl+SUPeiZae4XMwYuFRP4KAXLYbrTcE6pKUorA3GeeFWkAwOIzg078nE
	TLhT83YZKJHCwuUaEmzxBrUD4qNXJ0zmE490VCcBWb/gJJJDF6ygZRw8aADLmGYV
	ahgsrehA1xndTLMfzLEelv/ViX+C0aWuh0kTg7MVbn3znulxJ/Ep/03t+XwLSbPg
	FTgvU4qbAxR/Eo9n3QhrutENpU7WXHQ4jdW3H7ASgseb1NwgHye5v1B5tqkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784618911; x=1784705311; bh=te9JZOOZrzZM2rg7/DYIiZfwM+ajKAA5d3I
	Vs91lMfU=; b=DHwN/yXvYi2Rmv1W7TSofKtr0aR0JDq5kTxhOKZUTrEuYFfeBio
	UUUiNt547WjsgCsRdlatEyjC7zsU3B6vz9uJOebM/oyDj9xPZqHFPQpRA8mfT+WI
	QFf6z8gWXWAeDw+7NW0EVFXYmEzQXVQgUcYRw8yub42bW4DwNqAIN2O0ImaLNy67
	P5XV2AjciKqs51//mSJI32t8Xd5xE8db8c/MnoIwifOiocmah+HsE3iue/eiOVjR
	gb7exeFeHsvQ5woQ4euJ5ph7sVY+TEg1hxfI4D1db8fyUv+bg0PcZC3+nOL2rqvG
	PhU7BAtbjrpMgNSdpXHnpeQXFTPDuCGQ2mw==
X-ME-Sender: <xms:nh9fanwOykWeNjEAQvnZxQPp9LyZj7VjEfTbqpQaJzg71GvFRJLRKA>
    <xme:nh9faokCSQYF809R8rmeFTo5y_obI_KBW1q3Jaf4vukn2esSwANoG4T7fvERRLbim
    mvTAmrw-m7LcJVnGCXwmh1HBfN_x4oDvFYYM6Ys-6mG5wtkVsQbbKU>
X-ME-Received: <xmr:nh9faon5HtA_kpdB0CTbizhXe9tWM1jeuCyWz5fiZehZ39Qw8Y_mJQ>
X-ME-Proxy-Cause: dmFkZTEidRHxNBULUoaY8jfmeclLe5V1rxIgIYDxJEUcZf8/JSyTj0LvGKglZRv58g4suq
    8bBxD/QU/Vq1+VsBK8uBwbYuK5kF2U2QFdtv4ecXVIQ8DlgybKr0aD9rFq4fg2Xuc9l2GB
    dUtbKD7c/SZzBgW2eDPoKfaYm/8YN6xvcFOhDEt2RmvO7HTXUPUh6vx63PQ3vTdpQ1n2rY
    ukG1FaKUvKpnhKKmg1Dm0TrZ14cWIGuNJqJlc1E4+KB3XXAPIJlbd/Kuu0sBrOJZmBOaf+
    Abmk0weDrc7Bquqa29SShUfJMZV3CYYweJdkWGGZgwMIsrFR7VQA5/x3lb8J1L88XWbps1
    XlnupAj/N+hogufqWRG6mqZ0nGwUy18OeKEoNidY5juV29/qFjggfi2dX9CB/OJOL2yNh6
    e1kKrrzvloboSPS8tPFqQw7xBCl25WRXT0qfbAEhSk1df9zJT1F1ZAQDpOYRyjQthZbmh9
    WaZDckeZICMxf/sHKpPO5YoBqgfqZaver0OxjE4JYIENGoVPiSsTLrFd4CbxlMLvpnEgnn
    2MSLLdxyqusqy5K4Z72ffI6z0TJthFbUifnLjgoo8f2AFxX9YiYW02cTK9qmDEmoXlAA98
    6cldQ8m4OtQMD5kXnj4osyc8fScaJo6HJdvtET7kjqspQ21AztzbGz3c8QfQ
X-ME-Proxy: <xmx:nh9faix03dh68VgKFbOvybPIGXpMjv9euMjlK4OPmuYAWL-LCYNaxQ>
    <xmx:nh9falp1QpshSdebeaTurlgi0wpOD73NpqotfT9_zlQLjT-OMadsxg>
    <xmx:nh9fap7XgApCucb0-59jwN2ePK60VUysxJv4c0DAJb5YtGzCDME_0Q>
    <xmx:nh9fakeef-8zC18Eqff8mas2DbxepAn2mBkE3gavokaGNmSfsCrPMA>
    <xmx:nx9fakDUZTkH-yYZ_sKC1gIuUPFgGixrIhEtaXaaImlbL41sm8CdFiuN>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 03:28:29 -0400 (EDT)
Date: Tue, 21 Jul 2026 02:28:25 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: hold msg ctx list lock when cleaning daemon
 queue
Message-ID: <178461834999.30963.8777218643183392058.b4-ty@b4>
References: <4C38E7F6BF114337+20260628033725.11296-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C38E7F6BF114337+20260628033725.11296-1-chenyichong@uniontech.com>

On Sun, 28 Jun 2026 11:37:25 +0800, Yichong Chen wrote:
> ecryptfs_exorcise_daemon() drops queued messages from a dying daemon
> without holding ecryptfs_msg_ctx_lists_mux, but
> ecryptfs_msg_ctx_alloc_to_free() requires that lock.
> 
> Take the list lock while moving the queued contexts back to the free
> list to avoid racing with other global msg ctx list users.
> 
> [...]

Thank you! This has been applied to the next branch of the tyhicks/ecryptfs.git tree.

You can find a direct link below but please be aware that the commit hash is
unstable and, therefore, the URL may not be valid in the future.

[1/1] ecryptfs: hold msg ctx list lock when cleaning daemon queue
      https://git.kernel.org/tyhicks/ecryptfs/c/779972513c2fa8c7938e54976f686091dafff22f

Tyler
