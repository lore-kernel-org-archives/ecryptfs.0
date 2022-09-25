From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: keystore: Fix typo 'the the' in comment
Date: Sun, 25 Sep 2022 12:15:11 -0500
Message-ID: <20220925171511.GA59018@sequoia>
References: <20220722100212.79490-1-slark_xiao@163.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiIYRP3 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 25 Sep 2022 13:15:29 -0400
Content-Disposition: inline
In-Reply-To: <20220722100212.79490-1-slark_xiao@163.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Slark Xiao <slark_xiao@163.com>
Cc: linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

On 2022-07-22 18:02:12, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---

Thanks! I've applied the cleanup.

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
> 2.25.1
> 
