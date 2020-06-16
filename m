From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/2] mm, treewide: Rename kzfree() to
 kfree_sensitive()
Date: Tue, 16 Jun 2020 11:09:44 -0700
Message-ID: <20200616110944.c13f221e5c3f54e775190afe@linux-foundation.org>
References: <20200616154311.12314-1-longman@redhat.com>
        <20200616154311.12314-3-longman@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPSJq (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Tue, 16 Jun 2020 14:09:46 -0400
In-Reply-To: <20200616154311.12314-3-longman@redhat.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Dan Carpenter <dan.carpenter@oracle.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@l

On Tue, 16 Jun 2020 11:43:11 -0400 Waiman Long <longman@redhat.com> wrote:

> As said by Linus:
> 
>   A symmetric naming is only helpful if it implies symmetries in use.
>   Otherwise it's actively misleading.
> 
>   In "kzalloc()", the z is meaningful and an important part of what the
>   caller wants.
> 
>   In "kzfree()", the z is actively detrimental, because maybe in the
>   future we really _might_ want to use that "memfill(0xdeadbeef)" or
>   something. The "zero" part of the interface isn't even _relevant_.
> 
> The main reason that kzfree() exists is to clear sensitive information
> that should not be leaked to other future users of the same memory
> objects.
> 
> Rename kzfree() to kfree_sensitive() to follow the example of the
> recently added kvfree_sensitive() and make the intention of the API
> more explicit. In addition, memzero_explicit() is used to clear the
> memory to make sure that it won't get optimized away by the compiler.
> 
> The renaming is done by using the command sequence:
> 
>   git grep -w --name-only kzfree |\
>   xargs sed -i 's/\bkzfree\b/kfree_sensitive/'
> 
> followed by some editing of the kfree_sensitive() kerneldoc and adding
> a kzfree backward compatibility macro in slab.h.
> 
> ...
>
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -186,10 +186,12 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup *);
>   */
>  void * __must_check krealloc(const void *, size_t, gfp_t);
>  void kfree(const void *);
> -void kzfree(const void *);
> +void kfree_sensitive(const void *);
>  size_t __ksize(const void *);
>  size_t ksize(const void *);
>  
> +#define kzfree(x)	kfree_sensitive(x)	/* For backward compatibility */
> +

What was the thinking here?  Is this really necessary?

I suppose we could keep this around for a while to ease migration.  But
not for too long, please.
