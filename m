From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Date: Fri, 16 Oct 2020 07:35:46 +0100
Message-ID: <20201016063546.GA4808@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
 <20201015175848.GA4145@infradead.org>
 <20201015190312.GB20115@casper.infradead.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394251AbgJPGft (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 16 Oct 2020 02:35:49 -0400
Content-Disposition: inline
In-Reply-To: <20201015190312.GB20115@casper.infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

On Thu, Oct 15, 2020 at 08:03:12PM +0100, Matthew Wilcox wrote:
> I honestly don't see the problem.  We have to assign the status
> conditionally anyway so we don't overwrite an error with a subsequent
> success.

Yes, but having a potential NULL pointer to a common structure is just
waiting for trouble.

> 
> > True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
> > and an explicit goto out_unlock, though.
> 
> So this?
> 
>         if (ctx.bio) {
>                 submit_bio(ctx.bio);
>                 wait_for_completion(&ctx.done);
>                 if (ret < 0)
>                         goto err;
>                 ret = blk_status_to_errno(ctx.status);
>         }
> 
>         if (ret < 0)
>                 goto err;
>         return AOP_UPDATED_PAGE;
> err:
>         unlock_page(page);
>         return ret;
> 

Looks good.
