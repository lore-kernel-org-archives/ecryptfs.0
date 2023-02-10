From: Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH 17/17] crypto: api - Remove completion function
 scaffolding
Date: Fri, 10 Feb 2023 02:56:34 +0200
Message-ID: <Y+WWQgP/qTmLN42m@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOye6-007zks-J4@formenos.hmeau.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBJA6a (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 9 Feb 2023 19:58:30 -0500
Content-Disposition: inline
In-Reply-To: <E1pOye6-007zks-J4@formenos.hmeau.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.c>

On Mon, Feb 06, 2023 at 06:22:46PM +0800, Herbert Xu wrote:
> This patch removes the temporary scaffolding now that the comletion
> function signature has been converted.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

For the 1-17:

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

(nit applies tho to all of them but use your own judgement i guess)

> ---
> 
>  include/linux/crypto.h |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 80f6350fb588..bb1d9b0e1647 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -176,7 +176,6 @@ struct crypto_async_request;
>  struct crypto_tfm;
>  struct crypto_type;
>  
> -typedef void crypto_completion_data_t;
>  typedef void (*crypto_completion_t)(void *req, int err);
>  
>  /**
> @@ -596,11 +595,6 @@ struct crypto_wait {
>  /*
>   * Async ops completion helper functioons
>   */
> -static inline void *crypto_get_completion_data(void *data)
> -{
> -	return data;
> -}
> -
>  void crypto_req_done(void *req, int err);
>  
>  static inline int crypto_wait_req(int err, struct crypto_wait *wait)

BR, Jarkko
