From: Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH 2/17] net: macsec: Add scaffolding to change completion
 function signature
Date: Fri, 10 Feb 2023 02:43:55 +0200
Message-ID: <Y+WTS5w9nbsoyZyr@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOydb-007zgc-0p@formenos.hmeau.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBJAoB (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 9 Feb 2023 19:44:01 -0500
Content-Disposition: inline
In-Reply-To: <E1pOydb-007zgc-0p@formenos.hmeau.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.c>

On Mon, Feb 06, 2023 at 06:22:15PM +0800, Herbert Xu wrote:
> This patch adds temporary scaffolding so that the Crypto API

nit: "Add ..."

> completion function can take a void * instead of crypto_async_request.
> Once affected users have been converted this can be removed.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
> 
>  drivers/net/macsec.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index bf8ac7a3ded7..b7d9d487ccd2 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -528,9 +528,9 @@ static void count_tx(struct net_device *dev, int ret, int len)
>  	}
>  }
>  
> -static void macsec_encrypt_done(struct crypto_async_request *base, int err)
> +static void macsec_encrypt_done(crypto_completion_data_t *data, int err)
>  {
> -	struct sk_buff *skb = base->data;
> +	struct sk_buff *skb = crypto_get_completion_data(data);
>  	struct net_device *dev = skb->dev;
>  	struct macsec_dev *macsec = macsec_priv(dev);
>  	struct macsec_tx_sa *sa = macsec_skb_cb(skb)->tx_sa;
> @@ -835,9 +835,9 @@ static void count_rx(struct net_device *dev, int len)
>  	u64_stats_update_end(&stats->syncp);
>  }
>  
> -static void macsec_decrypt_done(struct crypto_async_request *base, int err)
> +static void macsec_decrypt_done(crypto_completion_data_t *data, int err)
>  {
> -	struct sk_buff *skb = base->data;
> +	struct sk_buff *skb = crypto_get_completion_data(data);
>  	struct net_device *dev = skb->dev;
>  	struct macsec_dev *macsec = macsec_priv(dev);
>  	struct macsec_rx_sa *rx_sa = macsec_skb_cb(skb)->rx_sa;

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
