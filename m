From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] tls: Pass rec instead of aead_req into tls_encrypt_done
Date: Tue, 7 Feb 2023 10:50:36 -0800
Message-ID: <20230207105036.76b30090@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
        <E1pOydn-007zi3-LG@formenos.hmeau.com>
        <20230206231521.712f53e5@kernel.org>
        <Y+IJXEYPuaQWjfR5@gondor.apana.org.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjBGSuk (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 13:50:40 -0500
In-Reply-To: <Y+IJXEYPuaQWjfR5@gondor.apana.org.au>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Tue, 7 Feb 2023 16:18:36 +0800 Herbert Xu wrote:
> > >  	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> > > -				  tls_encrypt_done, sk);
> > > +				  tls_encrypt_done, aead_req);  
> > 
> > ... let's just pass rec instead of aead_req here, then?  
> 
> Good point.  Could we do this as a follow-up patch? Reposting
> the whole series would disturb a lot of people.  Of course if
> other major issues crop up I can fold this into the existing
> patch.

Whatever works best!

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
