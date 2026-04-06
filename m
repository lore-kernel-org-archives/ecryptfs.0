Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302229B78F;
	Mon,  6 Apr 2026 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775456903; cv=none; b=Gbjpa7DGLGN917OoHDeCzZ/9sxNOvmSGRSuLo0+3RS7aMsTiU0BDXWcyKIde8zDW588ZTeUIt/lKooFVMzwArqxxeR3OjHG2Ohh5MJUfRh98o/ugZ9h26vBAeeXtRDxewzTXQJf/X27dvmOd+YZetDjEQORDOiAxLU33K48bRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775456903; c=relaxed/simple;
	bh=2mtu1trazRMAN8J57/v0tOgq32IG6gJRpkhpNujQDRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6JCV939d/FoQibccveRunRhEbMGFasuOXO1/k9B8VzjVVjkJH8jiyGgW96CRr5OKY5Ffl6H/mr8OYYRN0uLY8REvijzJ2YFruiXZKrPn/IOj2ms+rxmP4PwIJp7LSbnBow8EZZoKKm2g7NG9jw349OceabVgIJrFrYhpSxZC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 351D368BFE; Mon,  6 Apr 2026 08:28:20 +0200 (CEST)
Date: Mon, 6 Apr 2026 08:28:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: Christoph Hellwig <hch@lst.de>, ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] ecryptfs: streamline truncate_upper
Message-ID: <20260406062820.GB17642@lst.de>
References: <20260331153752.4049454-1-hch@lst.de> <20260331153752.4049454-2-hch@lst.de> <adNKBUZrbBzZGCpf@yaupon>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adNKBUZrbBzZGCpf@yaupon>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 06, 2026 at 12:52:05AM -0500, Tyler Hicks wrote:
> On 2026-03-31 17:37:22, Christoph Hellwig wrote:
> > Use a few strategic gotos to keep reduce indentation and keep the
> > main reduce size flow outside of branches.  Switch all touched comments
> 
> I think that first sentence was supposed to say, "Use a few strategic
> gotos to reduce indentation and keep the main flow outside of branches."
> Could you confirm?

Yes.

> > +		/*
> > +		 * Write a single 0 at the last position of the file; this
> > +		 * triggers code that will fill in 0's throughout the
> > +		 * intermediate portion of the previous end of the file and the
> > +		 * new and of the file.
> 
> Since we're touching this comment, we might as well fix the typo:
> 
>  s/new and of the file/new end of the file/
> 
> I can do both of these small changes when merging, if we don't have a
> better reason to respin this series.

I'll fix it up when I resend, and it looks like we're need another version
anyway.

