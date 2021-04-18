From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH -next] eCryptfs: Use DEFINE_MUTEX() for mutex lock
Date: Sun, 18 Apr 2021 12:34:33 -0500
Message-ID: <20210418173433.GD398325@elm>
References: <20210409095142.2294032-1-yebin10@huawei.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhDRRfE (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 18 Apr 2021 13:35:04 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47105C061760
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 10:34:36 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id c6-20020a4aacc60000b02901e6260b12e2so4760541oon.3
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 10:34:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20210409095142.2294032-1-yebin10@huawei.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ye Bin <yebin10@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>

On 2021-04-09 17:51:42, Ye Bin wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>

This looks good to me. Thanks for the fix.

Tyler

> ---
>  fs/ecryptfs/messaging.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
> index c0dfd9647627..25ed9baf524e 100644
> --- a/fs/ecryptfs/messaging.c
> +++ b/fs/ecryptfs/messaging.c
> @@ -14,10 +14,10 @@
>  
>  static LIST_HEAD(ecryptfs_msg_ctx_free_list);
>  static LIST_HEAD(ecryptfs_msg_ctx_alloc_list);
> -static struct mutex ecryptfs_msg_ctx_lists_mux;
> +static DEFINE_MUTEX(ecryptfs_msg_ctx_lists_mux);
>  
>  static struct hlist_head *ecryptfs_daemon_hash;
> -struct mutex ecryptfs_daemon_hash_mux;
> +DEFINE_MUTEX(ecryptfs_daemon_hash_mux);
>  static int ecryptfs_hash_bits;
>  #define ecryptfs_current_euid_hash(uid) \
>  	hash_long((unsigned long)from_kuid(&init_user_ns, current_euid()), ecryptfs_hash_bits)
> @@ -359,7 +359,6 @@ int __init ecryptfs_init_messaging(void)
>  		       "too large, defaulting to [%d] users\n", __func__,
>  		       ecryptfs_number_of_users);
>  	}
> -	mutex_init(&ecryptfs_daemon_hash_mux);
>  	mutex_lock(&ecryptfs_daemon_hash_mux);
>  	ecryptfs_hash_bits = 1;
>  	while (ecryptfs_number_of_users >> ecryptfs_hash_bits)
> @@ -383,7 +382,6 @@ int __init ecryptfs_init_messaging(void)
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> -	mutex_init(&ecryptfs_msg_ctx_lists_mux);
>  	mutex_lock(&ecryptfs_msg_ctx_lists_mux);
>  	ecryptfs_msg_counter = 0;
>  	for (i = 0; i < ecryptfs_message_buf_len; i++) {
> 
