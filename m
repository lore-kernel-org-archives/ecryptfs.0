From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: fix a memory leak bug
Date: Tue, 20 Aug 2019 00:10:09 -0700
Message-ID: <20190820071008.GA22824@elm>
References: <1566278200-9368-1-git-send-email-wenwen@cs.uga.edu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566278200-9368-1-git-send-email-wenwen@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 2019-08-20 00:16:40, Wenwen Wang wrote:
> In parse_tag_1_packet(), if tag 1 packet contains a key larger than
> ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES, no cleanup is executed, leading to a
> memory leak on the allocated 'auth_tok_list_item'. To fix this issue, go to
> the label 'out_free' to perform the cleanup work.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Thanks for the patch!

I added the following tags to the commit message:

 Cc: stable@vger.kernel.org
 Fixes: dddfa461fc89 ("[PATCH] eCryptfs: Public key; packet management")

I also added the function name to the commit subject so that it was
unique from your other fix.

I've pushed the fix to the eCryptfs next branch and I'll submit a pull
request for inclusion soon.

Tyler

> ---
>  fs/ecryptfs/keystore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 216fbe6..4dc0963 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1304,7 +1304,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
>  		printk(KERN_WARNING "Tag 1 packet contains key larger "
>  		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES\n");
>  		rc = -EINVAL;
> -		goto out;
> +		goto out_free;
>  	}
>  	memcpy((*new_auth_tok)->session_key.encrypted_key,
>  	       &data[(*packet_size)], (body_size - (ECRYPTFS_SIG_SIZE + 2)));
> -- 
> 2.7.4
> 
