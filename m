From: Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH 3/17] fs: ecryptfs: Use crypto_wait_req
Date: Fri, 10 Feb 2023 02:42:55 +0200
Message-ID: <Y+WTD3TrxaJOPdRg@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOydd-007zgo-4c@formenos.hmeau.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBJAm7 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 9 Feb 2023 19:42:59 -0500
Content-Disposition: inline
In-Reply-To: <E1pOydd-007zgo-4c@formenos.hmeau.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.c>

On Mon, Feb 06, 2023 at 06:22:17PM +0800, Herbert Xu wrote:
> This patch replaces the custom crypto completion function with
> crypto_req_done.

nit: "Replace the custom crypto ..."

> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
> 
>  fs/ecryptfs/crypto.c |   30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e3f5d7f3c8a0..c3057539f088 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -260,22 +260,6 @@ int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
>  	return i;
>  }
>  
> -struct extent_crypt_result {
> -	struct completion completion;
> -	int rc;
> -};
> -
> -static void extent_crypt_complete(struct crypto_async_request *req, int rc)
> -{
> -	struct extent_crypt_result *ecr = req->data;
> -
> -	if (rc == -EINPROGRESS)
> -		return;
> -
> -	ecr->rc = rc;
> -	complete(&ecr->completion);
> -}
> -
>  /**
>   * crypt_scatterlist
>   * @crypt_stat: Pointer to the crypt_stat struct to initialize.
> @@ -293,7 +277,7 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  			     unsigned char *iv, int op)
>  {
>  	struct skcipher_request *req = NULL;
> -	struct extent_crypt_result ecr;
> +	DECLARE_CRYPTO_WAIT(ecr);
>  	int rc = 0;
>  
>  	if (unlikely(ecryptfs_verbosity > 0)) {
> @@ -303,8 +287,6 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  				  crypt_stat->key_size);
>  	}
>  
> -	init_completion(&ecr.completion);
> -
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
>  	req = skcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
>  	if (!req) {
> @@ -315,7 +297,7 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  
>  	skcipher_request_set_callback(req,
>  			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
> -			extent_crypt_complete, &ecr);
> +			crypto_req_done, &ecr);
>  	/* Consider doing this once, when the file is opened */
>  	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
>  		rc = crypto_skcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> @@ -334,13 +316,7 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>  	skcipher_request_set_crypt(req, src_sg, dst_sg, size, iv);
>  	rc = op == ENCRYPT ? crypto_skcipher_encrypt(req) :
>  			     crypto_skcipher_decrypt(req);
> -	if (rc == -EINPROGRESS || rc == -EBUSY) {
> -		struct extent_crypt_result *ecr = req->base.data;
> -
> -		wait_for_completion(&ecr->completion);
> -		rc = ecr->rc;
> -		reinit_completion(&ecr->completion);
> -	}
> +	rc = crypto_wait_req(rc, &ecr);
>  out:
>  	skcipher_request_free(req);
>  	return rc;


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
