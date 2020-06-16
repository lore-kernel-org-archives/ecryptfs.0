From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/3] mm/slab: Use memzero_explicit() in kzfree()
Date: Tue, 16 Jun 2020 09:05:00 -0400
Message-ID: <56c2304c-73cc-8f48-d8d0-5dd6c39f33f3@redhat.com>
References: <20200616015718.7812-1-longman@redhat.com>
 <20200616015718.7812-2-longman@redhat.com>
 <20200616033035.GB902@sol.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20200616033035.GB902@sol.localdomain>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Dan Carpenter <dan.carpenter@oracle.com>, David Sterba <dsterba@suse.cz>, "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org

On 6/15/20 11:30 PM, Eric Biggers wrote:
> On Mon, Jun 15, 2020 at 09:57:16PM -0400, Waiman Long wrote:
>> The kzfree() function is normally used to clear some sensitive
>> information, like encryption keys, in the buffer before freeing it back
>> to the pool. Memset() is currently used for the buffer clearing. However,
>> it is entirely possible that the compiler may choose to optimize away the
>> memory clearing especially if LTO is being used. To make sure that this
>> optimization will not happen, memzero_explicit(), which is introduced
>> in v3.18, is now used in kzfree() to do the clearing.
>>
>> Fixes: 3ef0e5ba4673 ("slab: introduce kzfree()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/slab_common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 9e72ba224175..37d48a56431d 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1726,7 +1726,7 @@ void kzfree(const void *p)
>>   	if (unlikely(ZERO_OR_NULL_PTR(mem)))
>>   		return;
>>   	ks = ksize(mem);
>> -	memset(mem, 0, ks);
>> +	memzero_explicit(mem, ks);
>>   	kfree(mem);
>>   }
>>   EXPORT_SYMBOL(kzfree);
> This is a good change, but the commit message isn't really accurate.  AFAIK, no
> one has found any case where this memset() gets optimized out.  And even with
> LTO, it would be virtually impossible due to all the synchronization and global
> data structures that kfree() uses.  (Remember that this isn't the C standard
> function "free()", so the compiler can't assign it any special meaning.)
> Not to mention that LTO support isn't actually upstream yet.
>
> I still agree with the change, but it might be helpful if the commit message
> were honest that this is really a hardening measure and about properly conveying
> the intent.  As-is this sounds like a critical fix, which might confuse people.

Yes, I agree that the commit log may look a bit scary. How about the 
following:

The kzfree() function is normally used to clear some sensitive
information, like encryption keys, in the buffer before freeing it back
to the pool. Memset() is currently used for buffer clearing. However
unlikely, there is still a non-zero probability that the compiler may
choose to optimize away the memory clearing especially if LTO is being
used in the future. To make sure that this optimization will never
happen, memzero_explicit(), which is introduced in v3.18, is now used
in kzfree() to future-proof it.

Cheers,
Longman

