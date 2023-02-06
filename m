From: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: [PATCH 16/17] tls: Remove completion function scaffolding
Date: Mon, 06 Feb 2023 18:22:44 +0800
Message-ID: <E1pOye4-007zka-Fr@formenos.hmeau.com>
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

This patch removes the temporary scaffolding now that the comletion
function signature has been converted.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 net/tls/tls_sw.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5b7f67a7d394..0515cda32fe2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -179,9 +179,9 @@ static int tls_padding_length(struct tls_prot_info *prot, struct sk_buff *skb,
 	return sub;
 }
 
-static void tls_decrypt_done(crypto_completion_data_t *data, int err)
+static void tls_decrypt_done(void *data, int err)
 {
-	struct aead_request *aead_req = crypto_get_completion_data(data);
+	struct aead_request *aead_req = data;
 	struct crypto_aead *aead = crypto_aead_reqtfm(aead_req);
 	struct scatterlist *sgout = aead_req->dst;
 	struct scatterlist *sgin = aead_req->src;
@@ -428,9 +428,9 @@ int tls_tx_records(struct sock *sk, int flags)
 	return rc;
 }
 
-static void tls_encrypt_done(crypto_completion_data_t *data, int err)
+static void tls_encrypt_done(void *data, int err)
 {
-	struct aead_request *aead_req = crypto_get_completion_data(data);
+	struct aead_request *aead_req = data;
 	struct tls_sw_context_tx *ctx;
 	struct tls_context *tls_ctx;
 	struct tls_prot_info *prot;
