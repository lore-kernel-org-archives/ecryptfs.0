From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: Fix typo in message
Date: Sun, 18 Apr 2021 12:38:19 -0500
Message-ID: <20210418173819.GE398325@elm>
References: <20210224113059.28445-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhDRRix (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 18 Apr 2021 13:38:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD547C061760
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 10:38:21 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso16382772otm.4
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 10:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20210224113059.28445-1-s.hauer@pengutronix.de>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2021-02-24 12:30:59, Sascha Hauer wrote:
> ecryptfs_decrypt_page() issues a warning "Error encrypting extent". This
> should be "Error decrypting extent" instead.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks! This looks good. I'll add the following fixes line while
applying:

Fixes: 0216f7f79217 ("eCryptfs: replace encrypt, decrypt, and inode size write")

Tyler

> ---
>  fs/ecryptfs/crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index a48116aae02c..0fed4ff02f69 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -535,7 +535,7 @@ int ecryptfs_decrypt_page(struct page *page)
>  		rc = crypt_extent(crypt_stat, page, page,
>  				  extent_offset, DECRYPT);
>  		if (rc) {
> -			printk(KERN_ERR "%s: Error encrypting extent; "
> +			printk(KERN_ERR "%s: Error decrypting extent; "
>  			       "rc = [%d]\n", __func__, rc);
>  			goto out;
>  		}
> -- 
> 2.29.2
> 
