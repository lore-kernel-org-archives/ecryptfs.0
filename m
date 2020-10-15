From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Date: Thu, 15 Oct 2020 20:03:12 +0100
Message-ID: <20201015190312.GB20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
 <20201015094203.GA21420@infradead.org>
 <20201015164333.GA20115@casper.infradead.org>
 <20201015175848.GA4145@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20201015175848.GA4145@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

On Thu, Oct 15, 2020 at 06:58:48PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 05:43:33PM +0100, Matthew Wilcox wrote:
> > I prefer assigning ctx conditionally to propagating the knowledge
> > that !rac means synchronous.  I've gone with this:
> 
> And I really hate these kinds of conditional assignments.  If the
> ->rac check is too raw please just add an explicit
> 
> 	bool synchronous : 1;
> 
> flag.

I honestly don't see the problem.  We have to assign the status
conditionally anyway so we don't overwrite an error with a subsequent
success.

> True.  I'd still prefer the AOP_UPDATED_PAGE as the fallthrough case
> and an explicit goto out_unlock, though.

So this?

        if (ctx.bio) {
                submit_bio(ctx.bio);
                wait_for_completion(&ctx.done);
                if (ret < 0)
                        goto err;
                ret = blk_status_to_errno(ctx.status);
        }

        if (ret < 0)
                goto err;
        return AOP_UPDATED_PAGE;
err:
        unlock_page(page);
        return ret;

