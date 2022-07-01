From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Date: Fri, 1 Jul 2022 12:04:00 -0700
Message-ID: <Yr9FIKyHWi930QBd@iweiny-desk3>
References: <20220628184950.2045-1-fmdefrancesco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGATEL (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 1 Jul 2022 15:04:11 -0400
Content-Disposition: inline
In-Reply-To: <20220628184950.2045-1-fmdefrancesco@gmail.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>, Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@digitalocean.com>, Amir Goldstein <amir73il@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Muchun Song <songmuchun@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, Theodore Ts'o <tytso@mit.edu>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:49:50PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> With kmap_local_page() the mappings are per thread, CPU local and not
> globally visible.
> 
> Use kmap_local_page() on all calling sites where kmap() is currently used.
> 
> The mappings in fs/ecryptfs seem to conform to the prerequisites for
> easy conversions to kmap_local_page(), however I am not familiar with this
> code.
> 
> This is why this is an RFC PATCH. I'd appreciate if people familiar with
> eCryptfs could test and confirm whether these conversions are safe or not.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ecryptfs/crypto.c     | 8 ++++----
>  fs/ecryptfs/read_write.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e3f5d7f3c8a0..03263ebcccc6 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -465,10 +465,10 @@ int ecryptfs_encrypt_page(struct page *page)
>  	}
>  
>  	lower_offset = lower_offset_for_page(crypt_stat, page);
> -	enc_extent_virt = kmap(enc_extent_page);
> +	enc_extent_virt = kmap_local_page(enc_extent_page);
>  	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
>  				  PAGE_SIZE);
> -	kunmap(enc_extent_page);
> +	kunmap_local(enc_extent_virt);
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR,
>  			"Error attempting to write lower page; rc = [%d]\n",
> @@ -514,10 +514,10 @@ int ecryptfs_decrypt_page(struct page *page)
>  	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
>  
>  	lower_offset = lower_offset_for_page(crypt_stat, page);
> -	page_virt = kmap(page);
> +	page_virt = kmap_local_page(page);
>  	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
>  				 ecryptfs_inode);
> -	kunmap(page);
> +	kunmap_local(page_virt);
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR,
>  			"Error attempting to read lower page; rc = [%d]\n",
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 60bdcaddcbe5..5edf027c8359 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -64,11 +64,11 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
>  
>  	offset = ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
>  		  + offset_in_page);
> -	virt = kmap(page_for_lower);
> +	virt = kmap_local_page(page_for_lower);
>  	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
>  	if (rc > 0)
>  		rc = 0;
> -	kunmap(page_for_lower);
> +	kunmap_local(virt);
>  	return rc;
>  }
>  
> @@ -253,11 +253,11 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
>  	int rc;
>  
>  	offset = ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
> -	virt = kmap(page_for_ecryptfs);
> +	virt = kmap_local_page(page_for_ecryptfs);
>  	rc = ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
>  	if (rc > 0)
>  		rc = 0;
> -	kunmap(page_for_ecryptfs);
> +	kunmap_local(virt);
>  	flush_dcache_page(page_for_ecryptfs);
>  	return rc;
>  }
> -- 
> 2.36.1
> 
