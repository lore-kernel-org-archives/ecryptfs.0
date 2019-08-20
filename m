From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: fix a memory leak bug
Date: Tue, 20 Aug 2019 00:11:32 -0700
Message-ID: <20190820071131.GB22824@elm>
References: <1566279234-9634-1-git-send-email-wenwen@cs.uga.edu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566279234-9634-1-git-send-email-wenwen@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 2019-08-20 00:33:54, Wenwen Wang wrote:
> In ecryptfs_init_messaging(), if the allocation for 'ecryptfs_msg_ctx_arr'
> fails, the previously allocated 'ecryptfs_daemon_hash' is not deallocated,
> leading to a memory leak bug. To fix this issue, free
> 'ecryptfs_daemon_hash' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Thanks for the patch!

I added the following tags to the commit message:

 Cc: stable@vger.kernel.org
 Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism")

I also added the function name to the commit subject so that it was
unique from your other fix.

I've pushed the fix to the eCryptfs next branch and I'll submit a pull
request for inclusion soon.

Tyler

> ---
>  fs/ecryptfs/messaging.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
> index d668e60..c05ca39 100644
> --- a/fs/ecryptfs/messaging.c
> +++ b/fs/ecryptfs/messaging.c
> @@ -379,6 +379,7 @@ int __init ecryptfs_init_messaging(void)
>  					* ecryptfs_message_buf_len),
>  				       GFP_KERNEL);
>  	if (!ecryptfs_msg_ctx_arr) {
> +		kfree(ecryptfs_daemon_hash);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> -- 
> 2.7.4
> 
