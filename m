From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 0/17] crypto: api - Change completion callback argument
 to void star
Date: Mon, 6 Feb 2023 23:10:08 -0800
Message-ID: <20230206231008.64c822c1@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjBGHKO (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 02:10:14 -0500
In-Reply-To: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Mon, 6 Feb 2023 18:21:06 +0800 Herbert Xu wrote:
> The crypto completion function currently takes a pointer to a
> struct crypto_async_request object.  However, in reality the API
> does not allow the use of any part of the object apart from the
> data field.  For example, ahash/shash will create a fake object
> on the stack to pass along a different data field.

"different data field" == copy the value to a different structure?
A bit hard to parse TBH.

> This leads to potential bugs where the user may try to dereference
> or otherwise use the crypto_async_request object.
> 
> This series changes the completion function to take a void *
> argument instead of crypto_async_request.
> 
> This series touches code in a number of different subsystems.
> Most of them are trivial except for tls which was actually buggy
> as it did exactly what was described above.

Buggy means bug could be hit in real light or buggy == did not use 
the API right?

> I'd like to pull all the changes through the crypto tree.  But
> feel free to object if you'd like the relevant patches to go
> through your trees instead and I'll split this up.
