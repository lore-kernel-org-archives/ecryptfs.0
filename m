Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16623101BC;
	Mon,  6 Apr 2026 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775456837; cv=none; b=e5wH3ScVa1sCm0rZLBtTMw1zox3Dbfl9Y9tD28M1gvKuHgXMb00DTPPnZEEfBrhlVvSCu9zws8fjamVGH0GKadYNpCZYj/mlq6LC0Rx55GsiYJ3Mn+fKe+BWPycTNySWdEesCbmnAwY/rKmgIkZK1ObsOUkdhe7hfXYBOuJg0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775456837; c=relaxed/simple;
	bh=RB3LtdS6Vm4OB3PLYbRRBi9/Yz+ypLogEWlkpyA2h3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkkWGvX+9e/kX9NeZ5W3bITIECabcoW9nDxK0gcEQ7S2ANN2hweGf8kBXuAIjtIQ3W+nFDH/tbo0iwHDylF5MoY717byIanEzOh+7O9G6dC9s5e7Idbs0MAWf3OPR4+Ca6vGNvzXpLzhXOn0YPMn6lvWGtPWAgt4aua4OaGr1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DBF1E68BFE; Mon,  6 Apr 2026 08:27:13 +0200 (CEST)
Date: Mon, 6 Apr 2026 08:27:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: Christoph Hellwig <hch@lst.de>, ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] ecryptfs: sanitize struct iattr handling in
 truncate_upper
Message-ID: <20260406062713.GA17642@lst.de>
References: <20260331153752.4049454-1-hch@lst.de> <20260331153752.4049454-6-hch@lst.de> <adNLfwLA4Iuvvupk@yaupon> <adNRPdonh5rP-nbm@yaupon>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adNRPdonh5rP-nbm@yaupon>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 06, 2026 at 01:22:53AM -0500, Tyler Hicks wrote:
> Err... that was a bad suggestion. upper_size should be a loff_t but, now
> that I'm at the end of the patch series review, I see that's essentially
> the signature of ecryptfs_truncate() but I'm still not understanding why
> we're sticking the upper inode size into the lower_ia.

Because that's what the existing setattr path already does by doing a
memcpy of the upper ia.  We can explicitly pass it as a separate
argument, but I'm not really sure that clarifies things as all other
information gets passed in lower_ia.  I could add a big comment explaining
all this if it helps?  It took me some time to figure out, so I might as
well share that with the world.

