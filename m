From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] ecryptfs: remove unnecessary i_version bump
Date: Mon, 30 Oct 2017 11:03:30 -0400
Message-ID: <1509375810.5412.22.camel@poochiereds.net>
References: <20171030150131.2587-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171030150131.2587-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-10-30 at 11:01 -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> There is no need to bump the i_version counter here, as ecryptfs does
> not set the MS_I_VERSION flag, and doesn't use it internally. It also

My apologies, I've been sitting on this patch for a while now. That
should be changed to the SB_I_VERSION flag. Tyler, do you mind fixing
that up before merge, or would you like me to resend?

> only bumps it when the inode is instantiated, which doesn't make much
> sense.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ecryptfs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index efc2db42d175..b59b083379ea 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -64,7 +64,6 @@ static int ecryptfs_inode_set(struct inode *inode, void *opaque)
>  	/* i_size will be overwritten for encrypted regular files */
>  	fsstack_copy_inode_size(inode, lower_inode);
>  	inode->i_ino = lower_inode->i_ino;
> -	inode->i_version++;
>  	inode->i_mapping->a_ops = &ecryptfs_aops;
>  
>  	if (S_ISLNK(inode->i_mode))

-- 
Jeff Layton <jlayton@poochiereds.net>
