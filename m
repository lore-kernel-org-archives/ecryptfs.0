From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: fix kernel panic with null dev_name
Date: Mon, 19 Apr 2021 00:51:48 -0500
Message-ID: <20210419055148.GC405651@elm>
References: <20210226210023.77597-1-jeffrey.mitchell@starlab.io>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDSFwU (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Apr 2021 01:52:20 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126AC061760
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 22:51:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so7502907ook.2
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 22:51:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20210226210023.77597-1-jeffrey.mitchell@starlab.io>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2021-02-26 15:00:23, Jeffrey Mitchell wrote:
> When mounting eCryptfs, a null "dev_name" argument to ecryptfs_mount()
> causes a kernel panic if the parsed options are valid. The easiest way to
> reproduce this is to call mount() from userspace with an existing
> eCryptfs mount's options and a "source" argument of 0.
> 
> Error out if "dev_name" is null in ecryptfs_mount()
> 
> Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>

Thanks for the fix! I reproduced this on a 4.15 and, while I didn't try
anything older than that, I think it affects the first kernel release
with eCryptfs. I've added the following Fixes tag:

 Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")

I've pushed it to the next branch of tyhicks/ecryptfs.git.

Tyler

> ---
>  fs/ecryptfs/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index e63259fdef28..b2f6a1937d23 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -492,6 +492,12 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
>  		goto out;
>  	}
>  
> +	if (!dev_name) {
> +		rc = -EINVAL;
> +		err = "Device name cannot be null";
> +		goto out;
> +	}
> +
>  	rc = ecryptfs_parse_options(sbi, raw_data, &check_ruid);
>  	if (rc) {
>  		err = "Error parsing options";
> -- 
> 2.25.1
> 
