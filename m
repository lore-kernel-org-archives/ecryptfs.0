From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH v2] ecryptfs: replace BUG_ON with error handling code
Date: Fri, 14 Feb 2020 14:44:41 -0600
Message-ID: <20200214204441.GA254578@elm>
References: <20200214182101.17165-1-pakki001@umn.edu>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgBNUo7 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 14 Feb 2020 15:44:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so5518924pgm.6
        for <ecryptfs@vger.kernel.org>; Fri, 14 Feb 2020 12:44:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200214182101.17165-1-pakki001@umn.edu>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Tyler Hicks <tyhicks@canonical.com>, Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, Randy Dunlap <rdunlap@infradead.org>, Theodore Ts'o <tytso@mit.edu>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-02-14 12:21:01, Aditya Pakki wrote:
> In crypt_scatterlist, if the crypt_stat argument is not set up
> correctly, the kernel crashes. Instead, by returning an error code
> upstream, the error is handled safely.
> 
> The issue is detected via a static analysis tool written by us.
> 
> Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Thanks! This looks good to me and passes the eCryptfs regression tests.
I've queued it up in my tree.

Tyler

> ---
> v1: Add missing fixes tag suggested by Markus and Tyler.
> ---
>  fs/ecryptfs/crypto.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index db1ef144c63a..2c449aed1b92 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  	struct extent_crypt_result ecr;
>  	int rc = 0;
>  
> -	BUG_ON(!crypt_stat || !crypt_stat->tfm
> -	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
> +	if (!crypt_stat || !crypt_stat->tfm
> +	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
> +		return -EINVAL;
> +
>  	if (unlikely(ecryptfs_verbosity > 0)) {
>  		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
>  				crypt_stat->key_size);
> -- 
> 2.20.1
> 
