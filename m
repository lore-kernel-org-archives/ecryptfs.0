From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 7/7] ecryptfs: move key payload accessor functions into
 keystore.c
Date: Tue, 3 Oct 2017 22:05:05 +1100 (AEDT)
Message-ID: <alpine.LRH.2.21.1710032204010.25033@namei.org>
References: <20170928212602.41744-1-ebiggers3@gmail.com> <20170928212602.41744-8-ebiggers3@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:51602 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbdJCLFR (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Tue, 3 Oct 2017 07:05:17 -0400
In-Reply-To: <20170928212602.41744-8-ebiggers3@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Biggers <ebiggers3@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Michael Halcrow <mhalcrow@google.com>, linux-cachefs@redhat.com, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Biggers <ebiggers@google.com>

On Thu, 28 Sep 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> As experience has shown, accessing the 'struct key' payload is very
> error-prone, since we need to hold the key semaphore and properly
> validate everything.  Fortunately eCryptfs only does it from one place,
> in ecryptfs_verify_auth_tok_from_key() in keystore.c.  Therefore, move
> the payload accessor functions like ecryptfs_get_key_payload_data() out
> of ecryptfs_kernel.h and into keystore.c so that people might be less
> tempted to use them directly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ecryptfs/ecryptfs_kernel.h | 60 -------------------------------------------
>  fs/ecryptfs/keystore.c        | 60 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 60 deletions(-)

Ok, I should have started at this patch :)

Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>
