From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 0/17] crypto: api - Change completion callback argument
 to void star
Date: Mon, 6 Feb 2023 23:16:29 -0800
Message-ID: <20230206231629.03572f5a@kernel.org>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
        <20230206231008.64c822c1@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGHQd (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2023 02:16:33 -0500
In-Reply-To: <20230206231008.64c822c1@kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kerne>

On Mon, 6 Feb 2023 23:10:08 -0800 Jakub Kicinski wrote:
> Buggy means bug could be hit in real light or buggy == did not use 
> the API right?

"in real light"... time to sign off for the night. s/light/life/
