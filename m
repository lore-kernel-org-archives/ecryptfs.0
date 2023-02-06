From: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: [PATCH 9/17] KEYS: DH: Use crypto_wait_req
Date: Mon, 06 Feb 2023 18:22:29 +0800
Message-ID: <E1pOydp-007ziH-Oe@formenos.hmeau.com>
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

 security/keys/dh.c |   30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index b339760a31dd..da64c358474b 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -64,22 +64,6 @@ static void dh_free_data(struct dh *dh)
 	kfree_sensitive(dh->g);
 }
 
-struct dh_completion {
-	struct completion completion;
-	int err;
-};
-
-static void dh_crypto_done(struct crypto_async_request *req, int err)
-{
-	struct dh_completion *compl = req->data;
-
-	if (err == -EINPROGRESS)
-		return;
-
-	compl->err = err;
-	complete(&compl->completion);
-}
-
 static int kdf_alloc(struct crypto_shash **hash, char *hashname)
 {
 	struct crypto_shash *tfm;
@@ -146,7 +130,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	struct keyctl_dh_params pcopy;
 	struct dh dh_inputs;
 	struct scatterlist outsg;
-	struct dh_completion compl;
+	DECLARE_CRYPTO_WAIT(compl);
 	struct crypto_kpp *tfm;
 	struct kpp_request *req;
 	uint8_t *secret;
@@ -266,22 +250,18 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 
 	kpp_request_set_input(req, NULL, 0);
 	kpp_request_set_output(req, &outsg, outlen);
-	init_completion(&compl.completion);
 	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
 				 CRYPTO_TFM_REQ_MAY_SLEEP,
-				 dh_crypto_done, &compl);
+				 crypto_req_done, &compl);
 
 	/*
 	 * For DH, generate_public_key and generate_shared_secret are
 	 * the same calculation
 	 */
 	ret = crypto_kpp_generate_public_key(req);
-	if (ret == -EINPROGRESS) {
-		wait_for_completion(&compl.completion);
-		ret = compl.err;
-		if (ret)
-			goto out6;
-	}
+	ret = crypto_wait_req(ret, &compl);
+	if (ret)
+		goto out6;
 
 	if (kdfcopy) {
 		/*
