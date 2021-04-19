From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 1/3] ecryptfs: remove unused helpers
Date: Sun, 18 Apr 2021 23:48:50 -0500
Message-ID: <20210419044850.GF398325@elm>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-2-brauner@kernel.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhDSEty (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Apr 2021 00:49:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37BC061760
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 21:48:52 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so25536407oti.9
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 21:48:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20210409162422.1326565-2-brauner@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian Brauner <brauner@kernel.org>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>

On 2021-04-09 18:24:20, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Remove two helpers that are unused.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: ecryptfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

I'll pick this patch up now as it looks like it didn't make it into your
v2 of the port to private mounts. I'll review those patches separately.

Thanks!

Tyler

> ---
>  fs/ecryptfs/ecryptfs_kernel.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index e6ac78c62ca4..463b2d99b554 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -496,12 +496,6 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
>  	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
>  }
>  
> -static inline struct ecryptfs_dentry_info *
> -ecryptfs_dentry_to_private(struct dentry *dentry)
> -{
> -	return (struct ecryptfs_dentry_info *)dentry->d_fsdata;
> -}
> -
>  static inline void
>  ecryptfs_set_dentry_private(struct dentry *dentry,
>  			    struct ecryptfs_dentry_info *dentry_info)
> @@ -515,12 +509,6 @@ ecryptfs_dentry_to_lower(struct dentry *dentry)
>  	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
>  }
>  
> -static inline struct vfsmount *
> -ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
> -{
> -	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt;
> -}
> -
>  static inline struct path *
>  ecryptfs_dentry_to_lower_path(struct dentry *dentry)
>  {
> -- 
> 2.27.0
> 
