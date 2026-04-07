Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EE481B1;
	Tue,  7 Apr 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573430; cv=none; b=MsVuHGraq9mVKY08Tj4hiYyimZhckc5IibH4EgjQugssGdcpeaPbDmeUK5jS7VTqAbYASYtDi7wQQv/RagxzwssqBgo1N4vEe0ii/YVFh5xVk4eaJt8d1OAiVV07fsz8eT6Bi0jhSjdLt7B0Qv3oGHR+MHK4dxVCd9p2r9rsL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573430; c=relaxed/simple;
	bh=A43lvWXmlXMWwApJYQuqVaytgCVACY0fWYvys4mnAA0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDzh1+YpTdmsm9Si0HDDQLwtRlrg9V2yakyRl/Baagw8W2kwJgPAXW8ySMSy68OmzjfJHMSfcpkw+yrWS1mitcjy4UQl/li3UX1Ad2mQhw2vS3TND378pjZmEjLdbpR3lMmVTlzYn+NxjMFhWh4QtlzIn3CXiWlpy3LcLV0PJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rsi5Rh1/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rsi5Rh1/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tv1CjszI0+RbxNAqIfOQH37mmDbsaX4SbJ+Z4c8Li7g=; b=Rsi5Rh1/PwEOR4Z1gnfuYj3vln
	a+ZyLLc5TE1bWm6sRbDkdDj1P7FleomU/L6hBLptY6Irbzj8pvrKYFJi2vjAthzEuyE3Ta1mFa0Z4
	gsP2p38kRmWv67TDvPcXlkh+E7QXBv03zX5zeHgBrbMPVgWOSlh/i0q39hlEqD9TLJqhSaMdKL1tB
	dfU6z7u27tnVcDzfsFkTpRRpV1IOpIEseGmhYhzIoSPUkVHSLhvNMgXeCOWcetiCKtNdiOM6iEfJb
	wN18dND4kEUMr/Ufu6iA76/Z8GGG2n+jp1DO7hFfB8ERFI5JUprWwc7gyu5NXd1jw5YsDIIO9aMyN
	AU9Qsy6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA7l5-00000006eRF-25pU;
	Tue, 07 Apr 2026 14:50:27 +0000
Date: Tue, 7 Apr 2026 07:50:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: cleanup truncate handling in ecryptfs v2
Message-ID: <adUZs-oTFj5t1Lnh@infradead.org>
References: <20260407140329.633186-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407140329.633186-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 07, 2026 at 04:02:36PM +0200, Christoph Hellwig wrote:
> Hi Tyler,
> 
> this series cleans up the truncate handling in ecryptfs.  I did
> it as preparation for some changes into size changing truncate
> VFS interfaces I'm looking into in the moment.  The changes have
> passed the regression test suite in the userspace ecryptfs
> repository and against the ecryptfs next branch.

So right after I posted this I came up with an idea how to better
pass arguments to the low-level truncate helper as the size + lower_ia
kept irking me.  The branch here:

https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/ecryptfs-truncate

simply only passed the upper ia, which feels a lot cleaner.  It passes
the ecryptfs test suite, but otherwise is hot off the press.  If you
like the new version I'll send it out tomorrow.

