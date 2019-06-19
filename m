From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH -next] ecryptfs: Make ecryptfs_xattr_handler static
Date: Wed, 19 Jun 2019 01:33:08 -0500
Message-ID: <20190619063307.GA22021@lindsey>
References: <20190614155117.28988-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614155117.28988-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: viro@zeniv.linux.org.uk, agruenba@redhat.com, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

On 2019-06-14 23:51:17, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/ecryptfs/inode.c:1138:28: warning:
>  symbol 'ecryptfs_xattr_handler' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the cleanup! I've pushed this to the eCryptfs next branch.

Tyler

> ---
>  fs/ecryptfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 1e994d7..18426f4 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1121,7 +1121,7 @@ static int ecryptfs_xattr_set(const struct xattr_handler *handler,
>  	}
>  }
>  
> -const struct xattr_handler ecryptfs_xattr_handler = {
> +static const struct xattr_handler ecryptfs_xattr_handler = {
>  	.prefix = "",  /* match anything */
>  	.get = ecryptfs_xattr_get,
>  	.set = ecryptfs_xattr_set,
> -- 
> 2.7.4
> 
> 
