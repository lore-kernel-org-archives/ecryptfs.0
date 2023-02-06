From: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: [PATCH 11/17] dm: Remove completion function scaffolding
Date: Mon, 06 Feb 2023 18:22:34 +0800
Message-ID: <E1pOydu-007zio-0W@formenos.hmeau.com>
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

 drivers/md/dm-crypt.c     |    6 +++---
 drivers/md/dm-integrity.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 7609fe39ab8c..3aeeb8f2802f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1458,7 +1458,7 @@ static int crypt_convert_block_skcipher(struct crypt_config *cc,
 	return r;
 }
 
-static void kcryptd_async_done(crypto_completion_data_t *async_req, int error);
+static void kcryptd_async_done(void *async_req, int error);
 
 static int crypt_alloc_req_skcipher(struct crypt_config *cc,
 				     struct convert_context *ctx)
@@ -2146,9 +2146,9 @@ static void kcryptd_crypt_read_convert(struct dm_crypt_io *io)
 	crypt_dec_pending(io);
 }
 
-static void kcryptd_async_done(crypto_completion_data_t *data, int error)
+static void kcryptd_async_done(void *data, int error)
 {
-	struct dm_crypt_request *dmreq = crypto_get_completion_data(data);
+	struct dm_crypt_request *dmreq = data;
 	struct convert_context *ctx = dmreq->ctx;
 	struct dm_crypt_io *io = container_of(ctx, struct dm_crypt_io, ctx);
 	struct crypt_config *cc = io->cc;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index eefe25ed841e..c58156deb2b1 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -955,9 +955,9 @@ static void xor_journal(struct dm_integrity_c *ic, bool encrypt, unsigned sectio
 	async_tx_issue_pending_all();
 }
 
-static void complete_journal_encrypt(crypto_completion_data_t *data, int err)
+static void complete_journal_encrypt(void *data, int err)
 {
-	struct journal_completion *comp = crypto_get_completion_data(data);
+	struct journal_completion *comp = data;
 	if (unlikely(err)) {
 		if (likely(err == -EINPROGRESS)) {
 			complete(&comp->ic->crypto_backoff);
