From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: Fix inodes not being evicted until unmount
Date: Sat, 30 Jan 2021 11:06:40 -0600
Message-ID: <20210130170640.GA58096@elm>
References: <20201218190730.141761-1-jeffrey.mitchell@starlab.io>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhA3RHe (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 30 Jan 2021 12:07:34 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93791C061574
        for <ecryptfs@vger.kernel.org>; Sat, 30 Jan 2021 09:06:54 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id j25so13774639oii.0
        for <ecryptfs@vger.kernel.org>; Sat, 30 Jan 2021 09:06:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20201218190730.141761-1-jeffrey.mitchell@starlab.io>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Robertson <daniel.robertson@starlab.io>

On 2020-12-18 13:07:30, Jeffrey Mitchell wrote:
> On asynchronous base filesystems like NFS, eCryptFS leaves inodes for
> deleted files in the cache until unmounting. Change call in
> ecryptfs_do_unlink() from set_nlink() to drop_nlink() in order to reliably
> evict inodes from the cache even on top of NFS.
> 
> Signed-off-by: Dan Robertson <daniel.robertson@starlab.io>
> Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>

Hey Jeffrey and Dan - thanks for the patch! Unfortunately, I think this
would allow the eCryptfs inode's nlink count to get out of sync with the
lower inode's nlink count in the case of direct manipulation to the
lower filesystem.

Is the condition that you're trying to fix a result of going through the
this code path?

 ecryptfs_unlink() -> ecryptfs_do_unlink() -> vfs_unlink() -> nfs_unlink() -> nfs_sillyrename() -> nfs_async_unlink()

Tyler

> ---
>  fs/ecryptfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d..f7594b6 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -147,7 +147,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
>  		goto out_unlock;
>  	}
>  	fsstack_copy_attr_times(dir, lower_dir_inode);
> -	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
> +	drop_nlink(inode);
>  	inode->i_ctime = dir->i_ctime;
>  out_unlock:
>  	dput(lower_dentry);
> -- 
> 2.7.4
> 
