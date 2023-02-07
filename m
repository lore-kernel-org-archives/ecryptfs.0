From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 0/17] crypto: api - Change completion callback argument
 to void star
Date: Tue, 7 Feb 2023 10:51:46 -0800
Message-ID: <20230207105146.267fc5e8@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
        <20230206231008.64c822c1@kernel.org>
        <Y+IF6L4cb2Ijy0fN@gondor.apana.org.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjBGSvu (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 13:51:50 -0500
In-Reply-To: <Y+IF6L4cb2Ijy0fN@gondor.apana.org.au>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Tue, 7 Feb 2023 16:03:52 +0800 Herbert Xu wrote:
> > Buggy means bug could be hit in real light or buggy == did not use 
> > the API right?  
> 
> Yes this bug is real.  If you hit a driver/algorithm that returns
> a different request object (of which there are many in the API) then
> you will be dereferencing random pointers.

Any aes-gcm or chacha-poly implementations which would do that come 
to mind? I'm asking 'cause we probably want to do stable if we know
of a combination which would be broken, or the chances of one existing
are high.

Otherwise no objections for the patches to go via the crypto tree,
there should be no conflicts AFAIK. Feel free to add my ack on the
networking changes if needed.
