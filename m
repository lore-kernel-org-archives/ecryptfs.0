From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 1/4] ecryptfs: remove unnessesary null check in
 ecryptfs_keyring_auth_tok_for_sig
Date: Mon, 27 May 2019 21:22:53 +0800
Message-ID: <193c19d5-94df-de12-49a0-878c434a9069@huawei.com>
References: <20190527131559.16088-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527131559.16088-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: tyhicks@canonical.com, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

Pls ignore this, will fix patch title

On 2019/5/27 21:15, YueHaibing wrote:
> request_key and ecryptfs_get_encrypted_key never
> return a NULL pointer, so no need do a null check.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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
> 

