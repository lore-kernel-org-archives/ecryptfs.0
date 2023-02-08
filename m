From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/17] crypto: api - Change completion callback argument
 to void star
Date: Wed, 8 Feb 2023 12:02:13 +0800
Message-ID: <Y+MexdOj12Y5Ikj1@gondor.apana.org.au>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <20230206231008.64c822c1@kernel.org>
 <Y+IF6L4cb2Ijy0fN@gondor.apana.org.au>
 <20230207105146.267fc5e8@kernel.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBHECv (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 23:02:51 -0500
Content-Disposition: inline
In-Reply-To: <20230207105146.267fc5e8@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Tue, Feb 07, 2023 at 10:51:46AM -0800, Jakub Kicinski wrote:
.
> Any aes-gcm or chacha-poly implementations which would do that come 
> to mind? I'm asking 'cause we probably want to do stable if we know
> of a combination which would be broken, or the chances of one existing
> are high.

Good point.  I had a quick look at tls_sw.c and it *appears* to be
safe with the default software code.  As tls_sw only uses the generic
AEAD algorithms (rather than the IPsec-specific variants which aren't
safe), the software-only paths *should* be OK.

However, drivers that support these algorithms may require fallbacks
for esoteric reasons.  For example, drivers/crypto/amcc appears to
require a fallback for certain input parameters which may or may not
be possible with TLS.

To be on the safe side I would do a backport once this has been
in mainline for a little bit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
