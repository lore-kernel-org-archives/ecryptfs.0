From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: Fix comment typo
Date: Sun, 25 Sep 2022 12:16:48 -0500
Message-ID: <20220925171648.GB59018@sequoia>
References: <20220725043853.7441-1-wangborong@cdjrlc.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIYRQw (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 25 Sep 2022 13:16:52 -0400
Content-Disposition: inline
In-Reply-To: <20220725043853.7441-1-wangborong@cdjrlc.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Wang <wangborong@cdjrlc.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2022-07-25 12:38:53, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---

Thanks for the patch but I applied this one that was sent a little
earlier:

 https://lore.kernel.org/lkml/20220722100212.79490-1-slark_xiao@163.com/

Tyler

>  fs/ecryptfs/keystore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 3fe41964c0d8..2452d6fd7062 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
>   * @filename: This function kmalloc's the memory for the filename
>   * @filename_size: This function sets this to the amount of memory
>   *                 kmalloc'd for the filename
> - * @packet_size: This function sets this to the the number of octets
> + * @packet_size: This function sets this to the number of octets
>   *               in the packet parsed
>   * @mount_crypt_stat: The mount-wide cryptographic context
>   * @data: The memory location containing the start of the tag 70
> -- 
> 2.35.1
> 
