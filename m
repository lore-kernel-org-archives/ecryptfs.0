From: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: [PATCH 7/17] tipc: Add scaffolding to change completion
 function signature
Date: Mon, 06 Feb 2023 18:22:25 +0800
Message-ID: <E1pOydl-007zhn-Io@formenos.hmeau.com>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dm-devel-bounces@redhat.com>
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
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org

This patch adds temporary scaffolding so that the Crypto API
completion function can take a void * instead of crypto_async_request.
Once affected users have been converted this can be removed.
    
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 net/tipc/crypto.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index d67440de011e..ab356e7a3870 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -267,10 +267,10 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 			     struct tipc_bearer *b,
 			     struct tipc_media_addr *dst,
 			     struct tipc_node *__dnode);
-static void tipc_aead_encrypt_done(struct crypto_async_request *base, int err);
+static void tipc_aead_encrypt_done(crypto_completion_data_t *data, int err);
 static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
 			     struct sk_buff *skb, struct tipc_bearer *b);
-static void tipc_aead_decrypt_done(struct crypto_async_request *base, int err);
+static void tipc_aead_decrypt_done(crypto_completion_data_t *data, int err);
 static inline int tipc_ehdr_size(struct tipc_ehdr *ehdr);
 static int tipc_ehdr_build(struct net *net, struct tipc_aead *aead,
 			   u8 tx_key, struct sk_buff *skb,
@@ -830,9 +830,9 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 	return rc;
 }
 
-static void tipc_aead_encrypt_done(struct crypto_async_request *base, int err)
+static void tipc_aead_encrypt_done(crypto_completion_data_t *data, int err)
 {
-	struct sk_buff *skb = base->data;
+	struct sk_buff *skb = crypto_get_completion_data(data);
 	struct tipc_crypto_tx_ctx *tx_ctx = TIPC_SKB_CB(skb)->crypto_ctx;
 	struct tipc_bearer *b = tx_ctx->bearer;
 	struct tipc_aead *aead = tx_ctx->aead;
@@ -954,9 +954,9 @@ static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
 	return rc;
 }
 
-static void tipc_aead_decrypt_done(struct crypto_async_request *base, int err)
+static void tipc_aead_decrypt_done(crypto_completion_data_t *data, int err)
 {
-	struct sk_buff *skb = base->data;
+	struct sk_buff *skb = crypto_get_completion_data(data);
 	struct tipc_crypto_rx_ctx *rx_ctx = TIPC_SKB_CB(skb)->crypto_ctx;
 	struct tipc_bearer *b = rx_ctx->bearer;
 	struct tipc_aead *aead = rx_ctx->aead;
