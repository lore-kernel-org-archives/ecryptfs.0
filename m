From: Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 11/17] dm: Remove completion function
 scaffolding
Date: Mon, 6 Feb 2023 12:29:38 -0500
Message-ID: <Y+E5AkiVTbjgXWjs@redhat.com>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOydu-007zio-0W@formenos.hmeau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dm-devel-bounces@redhat.com>
In-Reply-To: <E1pOydu-007zio-0W@formenos.hmeau.com>
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
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, dm-devel@redhat.com, keyrings@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Tyler Hicks <code@tyhicks.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, ecryptfs@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, linux-bluetooth@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Feb 06 2023 at  5:22P -0500,
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This patch removes the temporary scaffolding now that the comletion
> function signature has been converted.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Mike Snitzer <snitzer@kernel.org>
