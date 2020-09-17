From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 04/13] ceph: Tell the VFS that readpage was synchronous
Date: Thu, 17 Sep 2020 12:49:40 -0400
Message-ID: <57d35fdb5ea646f96b70fd8b8a29434761c3f1d3.camel@kernel.org>
References: <20200917151050.5363-1-willy@infradead.org>
         <20200917151050.5363-5-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgIQQtn (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Thu, 17 Sep 2020 12:49:43 -0400
In-Reply-To: <20200917151050.5363-5-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>

On Thu, 2020-09-17 at 16:10 +0100, Matthew Wilcox (Oracle) wrote:
> The ceph readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ceph/addr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6ea761c84494..b2bf8bf7a312 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -291,10 +291,11 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>  static int ceph_readpage(struct file *filp, struct page *page)
>  {
>  	int r = ceph_do_readpage(filp, page);
> -	if (r != -EINPROGRESS)
> -		unlock_page(page);
> -	else
> -		r = 0;
> +	if (r == -EINPROGRESS)
> +		return 0;
> +	if (r == 0)
> +		return AOP_UPDATED_PAGE;
> +	unlock_page(page);
>  	return r;
>  }
>  

Looks good to me. I assume you'll merge all of these as a set since the
early ones are a prerequisite?

Reviewed-by: Jeff Layton <jlayton@kernel.org>

