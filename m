From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH v2 -next] ecryptfs: use DEFINE_MUTEX() for mutex lock
Date: Sat, 30 Jan 2021 11:57:51 -0600
Message-ID: <20210130175751.GC58096@elm>
References: <20201224132233.30852-1-zhengyongjun3@huawei.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhA3R6e (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 30 Jan 2021 12:58:34 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2300C061756
        for <ecryptfs@vger.kernel.org>; Sat, 30 Jan 2021 09:57:53 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id j25so13894387oii.0
        for <ecryptfs@vger.kernel.org>; Sat, 30 Jan 2021 09:57:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20201224132233.30852-1-zhengyongjun3@huawei.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zheng Yongjun <zhengyongjun3@huawei.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-12-24 21:22:33, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

This looks good to me. I've pushed the patch to the eCryptfs next
branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git/log/?h=next

Thanks for the cleanup!

Tyler

> ---
>  fs/ecryptfs/crypto.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 0681540c48d9..be906b9bbb11 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1590,11 +1590,10 @@ ecryptfs_process_key_cipher(struct crypto_skcipher **key_tfm,
>  
>  struct kmem_cache *ecryptfs_key_tfm_cache;
>  static struct list_head key_tfm_list;
> -struct mutex key_tfm_list_mutex;
> +DEFINE_MUTEX(key_tfm_list_mutex);
>  
>  int __init ecryptfs_init_crypto(void)
>  {
> -	mutex_init(&key_tfm_list_mutex);
>  	INIT_LIST_HEAD(&key_tfm_list);
>  	return 0;
>  }
> -- 
> 2.22.0
> 
