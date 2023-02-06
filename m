From: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: [PATCH 17/17] crypto: api - Remove completion function
 scaffolding
Date: Mon, 06 Feb 2023 18:22:46 +0800
Message-ID: <E1pOye6-007zks-J4@formenos.hmeau.com>
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

 include/linux/crypto.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 80f6350fb588..bb1d9b0e1647 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -176,7 +176,6 @@ struct crypto_async_request;
 struct crypto_tfm;
 struct crypto_type;
 
-typedef void crypto_completion_data_t;
 typedef void (*crypto_completion_t)(void *req, int err);
 
 /**
@@ -596,11 +595,6 @@ struct crypto_wait {
 /*
  * Async ops completion helper functioons
  */
-static inline void *crypto_get_completion_data(void *data)
-{
-	return data;
-}
-
 void crypto_req_done(void *req, int err);
 
 static inline int crypto_wait_req(int err, struct crypto_wait *wait)
