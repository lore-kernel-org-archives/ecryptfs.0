From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/ecryptfs: Replace kmap_atomic() with kmap_local_page()
Date: Tue, 14 Feb 2023 20:42:33 -0800
Message-ID: <63ec62b9a1285_18bf5929449@iweiny-mobl.notmuch>
References: <20230103190259.30944-1-fmdefrancesco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOEmx (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 14 Feb 2023 23:42:53 -0500
Content-Disposition: inline
In-Reply-To: <20230103190259.30944-1-fmdefrancesco@gmail.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, Tyler Hicks <code@tyhicks.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Al Viro <viro@zeniv.linux.org.uk>, Muchun Song <muchun.song@linux.dev>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>

Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page() in ecryptfs_write().
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> 
> The code within the mapping/un-mapping in ecryptfs_write() does not
> depend on the above-mentioned side effects.
> 
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ecryptfs/read_write.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 5edf027c8359..3458f153a588 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -140,7 +140,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  			       ecryptfs_page_idx, rc);
>  			goto out;
>  		}
> -		ecryptfs_page_virt = kmap_atomic(ecryptfs_page);
> +		ecryptfs_page_virt = kmap_local_page(ecryptfs_page);
>  
>  		/*
>  		 * pos: where we're now writing, offset: where the request was
> @@ -163,7 +163,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  			       (data + data_offset), num_bytes);
>  			data_offset += num_bytes;
>  		}
> -		kunmap_atomic(ecryptfs_page_virt);
> +		kunmap_local(ecryptfs_page_virt);
>  		flush_dcache_page(ecryptfs_page);
>  		SetPageUptodate(ecryptfs_page);
>  		unlock_page(ecryptfs_page);
> -- 
> 2.39.0
> 


