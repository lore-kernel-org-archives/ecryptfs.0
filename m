From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/7] FS-Cache: fix dereference of NULL user_key_payload
Date: Tue, 3 Oct 2017 21:51:35 +1100 (AEDT)
Message-ID: <alpine.LRH.2.21.1710032151220.25033@namei.org>
References: <20170928212602.41744-1-ebiggers3@gmail.com> <20170928212602.41744-3-ebiggers3@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:51570 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbdJCKvm (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Tue, 3 Oct 2017 06:51:42 -0400
In-Reply-To: <20170928212602.41744-3-ebiggers3@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Biggers <ebiggers3@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Michael Halcrow <mhalcrow@google.com>, linux-cachefs@redhat.com, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

On Thu, 28 Sep 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> When the file /proc/fs/fscache/objects (available with
> CONFIG_FSCACHE_OBJECT_LIST=y) is opened, we request a user key with
> description "fscache:objlist", then access its payload.  However, a
> revoked key has a NULL payload, and we failed to check for this.
> request_key() *does* skip revoked keys, but there is still a window
> where the key can be revoked before we access its payload.
> 
> Fix it by checking for a NULL payload, treating it like a key which was
> already revoked at the time it was requested.
> 
> Fixes: 4fbf4291aa15 ("FS-Cache: Allow the current state of all objects to be dumped")
> Cc: <stable@vger.kernel.org>    [v2.6.32+]
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>
