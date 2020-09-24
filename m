From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 12/13] udf: Tell the VFS that readpage was synchronous
Date: Thu, 24 Sep 2020 11:00:21 +0200
Message-ID: <20200924090021.GE27019@quack2.suse.cz>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-13-willy@infradead.org>
Mime-Version: 1.0
Return-path: <ceph-devel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200917151050.5363-13-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>

On Thu 17-09-20 16:10:49, Matthew Wilcox (Oracle) wrote:
> The udf inline data readpage implementation was already synchronous,
> so use AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/udf/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 628941a6b79a..52bbe92d7c43 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -61,9 +61,8 @@ static int udf_adinicb_readpage(struct file *file, struct page *page)
>  {
>  	BUG_ON(!PageLocked(page));
>  	__udf_adinicb_readpage(page);
> -	unlock_page(page);
>  
> -	return 0;
> +	return AOP_UPDATED_PAGE;
>  }
>  
>  static int udf_adinicb_writepage(struct page *page,
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
