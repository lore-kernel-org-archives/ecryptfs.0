From: Tyler Hicks <tyhicks@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ecryptfs: Preallocate space in lower file in write
 path
Date: Thu, 18 Aug 2011 09:34:25 -0500
Message-ID: <20110818143425.GA8589@boyd.l.tihix.com>
References: <1311901067-1130-1-git-send-email-thieule@chromium.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:44483 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab1HROex (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 18 Aug 2011 10:34:53 -0400
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7IEVhZ4031065
	for <ecryptfs@vger.kernel.org>; Thu, 18 Aug 2011 08:31:43 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p7IEYWvv152014
	for <ecryptfs@vger.kernel.org>; Thu, 18 Aug 2011 08:34:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7I8YQUX007523
	for <ecryptfs@vger.kernel.org>; Thu, 18 Aug 2011 02:34:26 -0600
Content-Disposition: inline
In-Reply-To: <1311901067-1130-1-git-send-email-thieule@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thieu Le <thieule@chromium.org>
Cc: ecryptfs@vger.kernel.org

I apologize for the slow review, Thieu. When I originally reviewed this
patch, our email infrastructure was down for maintenance, so I saved it
off in a local drafts folder. I forgot about it until you pinged me. :/

Original review below...

On Thu Jul 28, 2011 at 05:57:47PM -0700, Thieu Le <thieule@chromium.org> wrote:
> eCryptfs does not allocate space in the lower file until writepage.  In
> low free space situation, this leads to the application thinking the
> write succeeds but it actually fails later when the page is written out.
> This patch preallocates the space in the write path using fallocate()
> first.  For lower file systems that do not support fallocate(), it falls back
> to writing the encrypted page directly to the lower file.  The
> preallocation is only done for writes that extend the file.
> 
> Signed-off-by: Thieu Le <thieule@chromium.org>
> ---
>  fs/ecryptfs/mmap.c |   26 ++++++++++++++++++++++++--
>  1 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> index 6a44148..ed0eace 100644
> --- a/fs/ecryptfs/mmap.c
> +++ b/fs/ecryptfs/mmap.c
> @@ -520,9 +520,29 @@ static int ecryptfs_write_end(struct file *file,
>  		goto out;
>  	}
>  	set_page_dirty(page);
> -	unlock_page(page);
> -	need_unlock_page = 0;
>  	if (pos + copied > i_size_read(ecryptfs_inode)) {
> +		struct ecryptfs_inode_info *inode_info =
> +			ecryptfs_inode_to_private(ecryptfs_inode);
> +		loff_t offset = ecryptfs_lower_header_size(crypt_stat) + pos;
> +		BUG_ON(!inode_info->lower_file);
> +		rc = do_fallocate(inode_info->lower_file, 0, offset,
> +				  PAGE_CACHE_SIZE);

do_fallocate() isn't exported to modules:

WARNING: "do_fallocate" [fs/ecryptfs/ecryptfs.ko] undefined!

> +		if (rc == -EOPNOTSUPP)
> +			rc = ecryptfs_encrypt_page(page);
> +		if (rc) {
> +			if (rc != -ENOSPC) {
> +				ecryptfs_printk(KERN_ERR,
> +						"Error preallocating page "
> +						"(upper index "
> +						"[0x%.16lx], rc = [%d])\n",
> +						index, rc);
> +			}
> +			goto out;
> +		}
> +
> +		unlock_page(page);
> +		need_unlock_page = 0;
> +
>  		i_size_write(ecryptfs_inode, pos + copied);
>  		ecryptfs_printk(KERN_DEBUG, "Expanded file size to "
>  			"[0x%.16llx]\n",
> @@ -540,6 +560,8 @@ out:
>  	if (need_unlock_page)
>  		unlock_page(page);
>  	page_cache_release(page);
> +	if (rc)
> +		truncate_inode_pages(mapping, i_size_read(ecryptfs_inode));

This change seems to be silently fixing a separate issue (truncating
after a failed write).

I wonder if we should be using ecryptfs_truncate() here, instead? It
truncates the lower file, as well.

Tyler

>  	return rc;
>  }
> 
> -- 
> 1.7.3.1
> 
