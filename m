From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/17] crypto: api - Change completion callback argument
 to void star
Date: Tue, 7 Feb 2023 16:03:52 +0800
Message-ID: <Y+IF6L4cb2Ijy0fN@gondor.apana.org.au>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <20230206231008.64c822c1@kernel.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBGIEd (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 03:04:33 -0500
Content-Disposition: inline
In-Reply-To: <20230206231008.64c822c1@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Mon, Feb 06, 2023 at 11:10:08PM -0800, Jakub Kicinski wrote:
> On Mon, 6 Feb 2023 18:21:06 +0800 Herbert Xu wrote:
> > The crypto completion function currently takes a pointer to a
> > struct crypto_async_request object.  However, in reality the API
> > does not allow the use of any part of the object apart from the
> > data field.  For example, ahash/shash will create a fake object
> > on the stack to pass along a different data field.
> 
> "different data field" == copy the value to a different structure?
> A bit hard to parse TBH.

The word data here refers to the data field in struct crypto_async_request.
 
> Buggy means bug could be hit in real light or buggy == did not use 
> the API right?

Yes this bug is real.  If you hit a driver/algorithm that returns
a different request object (of which there are many in the API) then
you will be dereferencing random pointers.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
