From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 8/17] tls: Only use data field in crypto completion
 function
Date: Mon, 6 Feb 2023 23:15:21 -0800
Message-ID: <20230206231521.712f53e5@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
        <E1pOydn-007zi3-LG@formenos.hmeau.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBGHPZ (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 02:15:25 -0500
In-Reply-To: <E1pOydn-007zi3-LG@formenos.hmeau.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Mon, 06 Feb 2023 18:22:27 +0800 Herbert Xu wrote:
> -static void tls_encrypt_done(struct crypto_async_request *req, int err)
> +static void tls_encrypt_done(crypto_completion_data_t *data, int err)
>  {
> -	struct aead_request *aead_req = (struct aead_request *)req;
> -	struct sock *sk = req->data;
> -	struct tls_context *tls_ctx = tls_get_ctx(sk);
> -	struct tls_prot_info *prot = &tls_ctx->prot_info;
> -	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
> +	struct aead_request *aead_req = crypto_get_completion_data(data);

All we use aead_req for in this function now is to find rec...

> +	struct tls_sw_context_tx *ctx;
> +	struct tls_context *tls_ctx;
> +	struct tls_prot_info *prot;
>  	struct scatterlist *sge;
>  	struct sk_msg *msg_en;
>  	struct tls_rec *rec;
>  	bool ready = false;
> +	struct sock *sk;
>  	int pending;
>  
>  	rec = container_of(aead_req, struct tls_rec, aead_req);
>  	msg_en = &rec->msg_encrypted;
>  
> +	sk = rec->sk;
> +	tls_ctx = tls_get_ctx(sk);
> +	prot = &tls_ctx->prot_info;
> +	ctx = tls_sw_ctx_tx(tls_ctx);
> +
>  	sge = sk_msg_elem(msg_en, msg_en->sg.curr);
>  	sge->offset -= prot->prepend_size;
>  	sge->length += prot->prepend_size;
> @@ -520,7 +536,7 @@ static int tls_do_encryption(struct sock *sk,
>  			       data_len, rec->iv_data);
>  
>  	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> -				  tls_encrypt_done, sk);
> +				  tls_encrypt_done, aead_req);

... let's just pass rec instead of aead_req here, then?

>  	/* Add the record in tx_list */
>  	list_add_tail((struct list_head *)&rec->list, &ctx->tx_list);
