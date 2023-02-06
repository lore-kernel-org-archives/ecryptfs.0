From: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: [PATCH 4/17] Bluetooth: Use crypto_wait_req
Date: Mon, 06 Feb 2023 18:22:19 +0800
Message-ID: <E1pOydf-007zgz-7o@formenos.hmeau.com>
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

This patch replaces the custom crypto completion function with
crypto_req_done.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 net/bluetooth/ecdh_helper.c |   37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
index 989401f116e9..0efc93fdae8a 100644
--- a/net/bluetooth/ecdh_helper.c
+++ b/net/bluetooth/ecdh_helper.c
@@ -25,22 +25,6 @@
 #include <linux/scatterlist.h>
 #include <crypto/ecdh.h>
 
-struct ecdh_completion {
-	struct completion completion;
-	int err;
-};
-
-static void ecdh_complete(struct crypto_async_request *req, int err)
-{
-	struct ecdh_completion *res = req->data;
-
-	if (err == -EINPROGRESS)
-		return;
-
-	res->err = err;
-	complete(&res->completion);
-}
-
 static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigits)
 {
 	int i;
@@ -60,9 +44,9 @@ static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigits)
 int compute_ecdh_secret(struct crypto_kpp *tfm, const u8 public_key[64],
 			u8 secret[32])
 {
+	DECLARE_CRYPTO_WAIT(result);
 	struct kpp_request *req;
 	u8 *tmp;
-	struct ecdh_completion result;
 	struct scatterlist src, dst;
 	int err;
 
@@ -76,8 +60,6 @@ int compute_ecdh_secret(struct crypto_kpp *tfm, const u8 public_key[64],
 		goto free_tmp;
 	}
 
-	init_completion(&result.completion);
-
 	swap_digits((u64 *)public_key, (u64 *)tmp, 4); /* x */
 	swap_digits((u64 *)&public_key[32], (u64 *)&tmp[32], 4); /* y */
 
@@ -86,12 +68,9 @@ int compute_ecdh_secret(struct crypto_kpp *tfm, const u8 public_key[64],
 	kpp_request_set_input(req, &src, 64);
 	kpp_request_set_output(req, &dst, 32);
 	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				 ecdh_complete, &result);
+				 crypto_req_done, &result);
 	err = crypto_kpp_compute_shared_secret(req);
-	if (err == -EINPROGRESS) {
-		wait_for_completion(&result.completion);
-		err = result.err;
-	}
+	err = crypto_wait_req(err, &result);
 	if (err < 0) {
 		pr_err("alg: ecdh: compute shared secret failed. err %d\n",
 		       err);
@@ -165,9 +144,9 @@ int set_ecdh_privkey(struct crypto_kpp *tfm, const u8 private_key[32])
  */
 int generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64])
 {
+	DECLARE_CRYPTO_WAIT(result);
 	struct kpp_request *req;
 	u8 *tmp;
-	struct ecdh_completion result;
 	struct scatterlist dst;
 	int err;
 
@@ -181,18 +160,14 @@ int generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64])
 		goto free_tmp;
 	}
 
-	init_completion(&result.completion);
 	sg_init_one(&dst, tmp, 64);
 	kpp_request_set_input(req, NULL, 0);
 	kpp_request_set_output(req, &dst, 64);
 	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				 ecdh_complete, &result);
+				 crypto_req_done, &result);
 
 	err = crypto_kpp_generate_public_key(req);
-	if (err == -EINPROGRESS) {
-		wait_for_completion(&result.completion);
-		err = result.err;
-	}
+	err = crypto_wait_req(err, &result);
 	if (err < 0)
 		goto free_all;
 
