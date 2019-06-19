From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH -next] ecryptfs: remove unnessesary null check in
 ecryptfs_keyring_auth_tok_for_sig
Date: Wed, 19 Jun 2019 01:34:06 -0500
Message-ID: <20190619063405.GB22021@lindsey>
References: <20190527132814.19600-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190527132814.19600-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

On 2019-05-27 21:28:14, YueHaibing wrote:
> request_key and ecryptfs_get_encrypted_key never
> return a NULL pointer, so no need do a null check.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This change looks good to me. I've pushed it to the eCryptfs next
branch.

Tyler

> ---
>  fs/ecryptfs/keystore.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 95662fd46b1d..a1afb162b9d2 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1626,9 +1626,9 @@ int ecryptfs_keyring_auth_tok_for_sig(struct key **auth_tok_key,
>  	int rc = 0;
>  
>  	(*auth_tok_key) = request_key(&key_type_user, sig, NULL);
> -	if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
> +	if (IS_ERR(*auth_tok_key)) {
>  		(*auth_tok_key) = ecryptfs_get_encrypted_key(sig);
> -		if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
> +		if (IS_ERR(*auth_tok_key)) {
>  			printk(KERN_ERR "Could not find key with description: [%s]\n",
>  			      sig);
>  			rc = process_request_key_err(PTR_ERR(*auth_tok_key));
> -- 
> 2.17.1
> 
> 
