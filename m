From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 2/2] mm, treewide: Rename kzfree() to kfree_sensitive()
Date: Tue, 16 Jun 2020 14:36:15 -0400
Message-ID: <65002c1e-5e31-1f4e-283c-186e06e55ef0@redhat.com>
References: <20200616154311.12314-1-longman@redhat.com>
 <20200616154311.12314-3-longman@redhat.com>
 <20200616110944.c13f221e5c3f54e775190afe@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-ppp-owner@vger.kernel.org>
In-Reply-To: <20200616110944.c13f221e5c3f54e775190afe@linux-foundation.org>
Content-Language: en-US
Sender: linux-ppp-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Dan Carpenter <dan.carpenter@oracle.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@l

On 6/16/20 2:09 PM, Andrew Morton wrote:
> On Tue, 16 Jun 2020 11:43:11 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> As said by Linus:
>>
>>    A symmetric naming is only helpful if it implies symmetries in use.
>>    Otherwise it's actively misleading.
>>
>>    In "kzalloc()", the z is meaningful and an important part of what the
>>    caller wants.
>>
>>    In "kzfree()", the z is actively detrimental, because maybe in the
>>    future we really _might_ want to use that "memfill(0xdeadbeef)" or
>>    something. The "zero" part of the interface isn't even _relevant_.
>>
>> The main reason that kzfree() exists is to clear sensitive information
>> that should not be leaked to other future users of the same memory
>> objects.
>>
>> Rename kzfree() to kfree_sensitive() to follow the example of the
>> recently added kvfree_sensitive() and make the intention of the API
>> more explicit. In addition, memzero_explicit() is used to clear the
>> memory to make sure that it won't get optimized away by the compiler.
>>
>> The renaming is done by using the command sequence:
>>
>>    git grep -w --name-only kzfree |\
>>    xargs sed -i 's/\bkzfree\b/kfree_sensitive/'
>>
>> followed by some editing of the kfree_sensitive() kerneldoc and adding
>> a kzfree backward compatibility macro in slab.h.
>>
>> ...
>>
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -186,10 +186,12 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup *);
>>    */
>>   void * __must_check krealloc(const void *, size_t, gfp_t);
>>   void kfree(const void *);
>> -void kzfree(const void *);
>> +void kfree_sensitive(const void *);
>>   size_t __ksize(const void *);
>>   size_t ksize(const void *);
>>   
>> +#define kzfree(x)	kfree_sensitive(x)	/* For backward compatibility */
>> +
> What was the thinking here?  Is this really necessary?
>
> I suppose we could keep this around for a while to ease migration.  But
> not for too long, please.
>
It should be there just for 1 release cycle. I have broken out the btrfs 
patch to the btrfs list and I didn't make the kzfree to kfree_sensitive 
conversion there as that patch was in front in my patch list. So 
depending on which one lands first, there can be a window where the 
compilation may fail without this workaround. I am going to send out 
another patch in the next release cycle to remove it.

Cheers,
Longman

