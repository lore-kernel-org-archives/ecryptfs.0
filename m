Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487D3A9D94
	for <ecryptfs@vger.kernel.org>; Mon, 30 Mar 2026 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857397; cv=none; b=kQyD720Pkt7e6+VqClt+M/cdb7ZHKaO01HYn0crEwvkbkqQx3gb+Olj3PRhQtvoYlBA51a8ERRbjo8YUgJmR4XcE1/4RQ86Tej1qgi+ZPc0hfnJ3GvKAjkHBJF/z4jNQjWog0ZwIloLWeU+AyN7SRPKaJU3TiYbG1Ub5+3xEFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857397; c=relaxed/simple;
	bh=Gr6aSxugTR3lddgRXaJ/z/ROWYGJDoeZlg6NTSpFCxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8OTGcJ8kwabjNMNGgvR7GF2YTE8C4viTN6h3HZCg7YXmq4FbySRIi9UTQzypOxh5n/dNHbs6GAaNvum0gu0+/qibyKRWWU4f+5kuxl3J3UXRuFKR2iPVhVtYRmZLXwHuRfCf+W1tbJBljNpMWYQJQ+4JHjy9aVFLymF0T4xE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYb0Pcsz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYb0Pcsz"
Date: Mon, 30 Mar 2026 09:56:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774857384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHHhT2qfpXE70nk4sipcypcMRxnmCnaq9Kmr0k9T/0M=;
	b=sYb0Pcszm9LdFsgRxiKUqYuUwFYqZGG0lc8XQwy1hiz4xmb8VIDLFlvjwH+ayWbnZNcAM1
	TLLS+LtffKeJ9ljHjgFGcIhWe+W/mGNjblKql6mTut1cTAtD+asoCNss8tyLIoRBDQT6Sz
	z0alrwiWTvf0WlPKX6EGHNPgwg/ISs0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Tyler Hicks <code@tyhicks.com>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>,
	Zipeng Zhang <zhangzipeng0@foxmail.com>,
	Chuck Lever <chuck.lever@oracle.com>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: streamline offset formatting in
 ecryptfs_derive_iv
Message-ID: <acoso_G9DyM03xMy@linux.dev>
References: <20260329212325.371720-2-thorsten.blum@linux.dev>
 <20260329220505.GB2106@quark>
 <acnLDxr4UF1dULrm@linux.dev>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acnLDxr4UF1dULrm@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 30, 2026 at 03:00:04AM +0200, Thorsten Blum wrote:
> On Sun, Mar 29, 2026 at 03:05:05PM -0700, Eric Biggers wrote:
> > This isn't exactly "streamlining" the code.  memset(p, 0, 16) tends to
> > get compiled into just two instructions.  In contrast, a variable-length
> > memset tends to be several instructions to set up, plus a call
> > instruction, and the instructions inside memset() itself.  scnprintf()
> > is also a few more instructions than snprintf().
> > 
> > So I'd say the old version is more "streamlined", actually.  Granted,
> > the difference is probably only a few cycles, but it sounds like the
> > motivation for this patch is that you assumed the new version is faster?
> 
> I meant "streamline" as in write bytes once.
> 
> Maybe we should just zero-initialize the 32 bytes in 'src' instead and
> keep snprintf(). That removes the need to keep track of 'len' and also
> gets rid of the explicit memset(0).

Let's drop this patch and I'll send a new one to fix the typo and remove
the TODO. Keeping the explicit memset(0) is probably best here. Thanks!
