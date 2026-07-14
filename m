Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB33128AB;
	Tue, 14 Jul 2026 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006323; cv=none; b=QOfIy2nVDyzDTgaqxuy53hY5PNmi9NUgf4MFd8C4w/uVap5hIOaRbfuSrWxnlJnTMmYSqvEYNWNUVoj0VYQh9KXdjDdi6j1YD/qexJB9en3VWPhA5pady7c2+QrwVZLObpvZJ1byKX6TYgw22Hdp2CAYIk/985rAC2p4aCJ047g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006323; c=relaxed/simple;
	bh=703JAzi6fC7A2UkmCVKXXpBIcqV6RmtZDpsQOvQSDC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+8SLyRtxF113IUNpP2aIDsN62+B2ipkOOhondPTvxhtMf4mic2Au7fzSp02nqhv1pQFeAgQNtXYX1WZ6ftrdYSBMbnvOZTV4cUOHuXKFAx7qLwWeYWrG1A2hhxXWLCoybwv1e789Z9zHsG6N2LgjPkDoD05EPpCC+OKepAjZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE59568BFE; Tue, 14 Jul 2026 07:18:37 +0200 (CEST)
Date: Tue, 14 Jul 2026 07:18:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: use filemap_dirty_folio for address space
 operations
Message-ID: <20260714051837.GA31751@lst.de>
References: <20260703090044.1649-1-aditya.ansh182@gmail.com> <alXCix5IKavpp2Pr@elm>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alXCix5IKavpp2Pr@elm>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 14, 2026 at 12:00:59AM -0500, Tyler Hicks wrote:
> This looks correct to me and I've successfully ran the kernel tests in
> the ecryptfs-utils test suite with the patch applied.
> 
> Adding Christoph for comment since this addresses the concern he
> documented in the code comment below.

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
