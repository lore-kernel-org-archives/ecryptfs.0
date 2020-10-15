From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Date: Thu, 15 Oct 2020 18:58:48 +0100
Message-ID: <20201015175848.GA4145@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbgJOR6u (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 15 Oct 2020 13:58:50 -0400
Content-Disposition: inline
In-Reply-To: <20201015164333.GA20115@casper.infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

On Thu, Oct 15, 2020 at 05:43:33PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 15, 2020 at 10:42:03AM +0100, Christoph Hellwig wrote:
> > > +static void iomap_read_page_end_io(struct bio_vec *bvec,
> > > +		struct completion *done, bool error)
> > 
> > I really don't like the parameters here.  Part of the problem is
> > that ctx is only assigned to bi_private conditionally, which can
> > easily be fixed.  The other part is the strange bool error when
> > we can just pass on bi_stats.  See the patch at the end of what
> > I'd do intead.
> 
> I prefer assigning ctx conditionally to propagating the knowledge
> that !rac means synchronous.  I've gone with this:

And I really hate these kinds of conditional assignments.  If the
->rac check is too raw please just add an explicit

	bool synchronous : 1;

flag.

> @@ -340,16 +335,12 @@ iomap_readpage(struct page *page, const struct iomap_ops *
> ops)
>  
>         if (ctx.bio) {
>                 submit_bio(ctx.bio);
> +               if (ret > 0)
> +                       ret = blk_status_to_errno(ctx.status);
>         }
>  
> -       wait_for_completion(&ctx.done);
>         if (ret >= 0)
> -               ret = blk_status_to_errno(ctx.status);
> -       if (ret == 0)
>                 return AOP_UPDATED_PAGE;
>         unlock_page(page);
>         return ret;
> 
> 
> ... there's no need to call blk_status_to_errno if we never submitted a bio.

True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
and an explicit goto out_unlock, though.
