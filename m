From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] tls: Pass rec instead of aead_req into
 tls_encrypt_done
Date: Tue, 7 Feb 2023 16:18:36 +0800
Message-ID: <Y+IJXEYPuaQWjfR5@gondor.apana.org.au>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOydn-007zi3-LG@formenos.hmeau.com>
 <20230206231521.712f53e5@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dm-devel-bounces@redhat.com>
In-Reply-To: <20230206231521.712f53e5@kernel.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://listman.redhat.com/mailman/options/dm-devel>,
 <mailto:dm-devel-request@redhat.com?subject=unsubscribe>
List-Archive: <http://listman.redhat.com/archives/dm-devel/>
List-Post: <mailto:dm-devel@redhat.com>
List-Help: <mailto:dm-devel-request@redhat.com?subject=help>
List-Subscribe: <https://listman.redhat.com/mailman/listinfo/dm-devel>,
 <mailto:dm-devel-request@redhat.com?subject=subscribe>
Errors-To: dm-devel-bounces@redhat.com
Sender: "dm-devel" <dm-devel-bounces@redhat.com>
Content-Disposition: inline
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, dm-devel@redhat.com, keyrings@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Tyler Hicks <code@tyhicks.com>, Paolo Abeni <pabeni@redhat.com>, Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, ecryptfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, linux-bluetooth@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Feb 06, 2023 at 11:15:21PM -0800, Jakub Kicinski wrote:
>
> >  	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> > -				  tls_encrypt_done, sk);
> > +				  tls_encrypt_done, aead_req);
> 
> ... let's just pass rec instead of aead_req here, then?

Good point.  Could we do this as a follow-up patch? Reposting
the whole series would disturb a lot of people.  Of course if
other major issues crop up I can fold this into the existing
patch.

Thanks!

---8<---
The function tls_encrypt_done only uses aead_req to get ahold of
the tls_rec object.  So we could pass that in instead of aead_req
to simplify the code.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 0515cda32fe2..6dfec2e8fdfa 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -430,18 +430,16 @@ int tls_tx_records(struct sock *sk, int flags)
 
 static void tls_encrypt_done(void *data, int err)
 {
-	struct aead_request *aead_req = data;
 	struct tls_sw_context_tx *ctx;
 	struct tls_context *tls_ctx;
 	struct tls_prot_info *prot;
+	struct tls_rec *rec = data;
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
-	struct tls_rec *rec;
 	bool ready = false;
 	struct sock *sk;
 	int pending;
 
-	rec = container_of(aead_req, struct tls_rec, aead_req);
 	msg_en = &rec->msg_encrypted;
 
 	sk = rec->sk;
@@ -536,7 +534,7 @@ static int tls_do_encryption(struct sock *sk,
 			       data_len, rec->iv_data);
 
 	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				  tls_encrypt_done, aead_req);
+				  tls_encrypt_done, rec);
 
 	/* Add the record in tx_list */
 	list_add_tail((struct list_head *)&rec->list, &ctx->tx_list);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
