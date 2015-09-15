From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 28/39] ecryptfs: drop null test before destroy
 functions
Date: Tue, 15 Sep 2015 06:36:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1509150636260.2048@localhost6.localdomain6>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr> <1442146532-9100-29-git-send-email-Julia.Lawall@lip6.fr> <20150915020830.GC32505@boyd>
Mime-Version: 1.0
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150915020830.GC32505@boyd>
Sender: kernel-janitors-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 14 Sep 2015, Tyler Hicks wrote:

> On 2015-09-13 14:15:21, Julia Lawall wrote:
> > Remove unneeded NULL test.
> > 
> > The semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @@ expression x; @@
> > -if (x != NULL)
> >   \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Acked-by: Tyler Hicks <tyhicks@canonical.com>
> 
> I assume that you'll be landing this patch set into Linus' tree all
> together. Let me know if that's incorrect and I should take this single
> patch into the eCryptfs dev tree.

I'm not doing anythign after this point.  Some others have taken the patch
into their trees.

julia

> 
> Thanks!
> 
> Tyler
> 
> > 
> > ---
> >  fs/ecryptfs/main.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> > index 4f4d047..e83f31c 100644
> > --- a/fs/ecryptfs/main.c
> > +++ b/fs/ecryptfs/main.c
> > @@ -737,8 +737,7 @@ static void ecryptfs_free_kmem_caches(void)
> >  		struct ecryptfs_cache_info *info;
> >  
> >  		info = &ecryptfs_cache_infos[i];
> > -		if (*(info->cache))
> > -			kmem_cache_destroy(*(info->cache));
> > +		kmem_cache_destroy(*(info->cache));
> >  	}
> >  }
> >  
> > 
> 
