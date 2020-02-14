From: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] ecryptfs: replace BUG_ON with error handling code
Date: Fri, 14 Feb 2020 12:01:51 -0600
Message-ID: <710ceeb1-6b88-4361-d199-414e0714c78f@umn.edu>
References: <20191215172404.28204-1-pakki001@umn.edu>
 <20200214173818.GB250165@elm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214173818.GB250165@elm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: kjlu@umn.edu, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/14/20 11:38 AM, Tyler Hicks wrote:
> On 2019-12-15 11:24:04, Aditya Pakki wrote:
>> In crypt_scatterlist, if the crypt_stat argument is not set up
>> correctly, we avoid crashing, by returning the error upstream.
>> This patch performs the fix.
>>
>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> Hi Aditya - I wanted to check in to see if you are able to submit a new
> revision taking into account the feedback from Markus.
> 
> Also, I'm curious if you've been able to hit this BUG_ON() or if you are
> just being proactive in cleaning up this function?
> 
> Let me know if I can help you prepare a v2 of this patch. Thanks!
> 
> Tyler
> 
>> ---
>>  fs/ecryptfs/crypto.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
>> index f91db24bbf3b..a064b408d841 100644
>> --- a/fs/ecryptfs/crypto.c
>> +++ b/fs/ecryptfs/crypto.c
>> @@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
>>  	struct extent_crypt_result ecr;
>>  	int rc = 0;
>>  
>> -	BUG_ON(!crypt_stat || !crypt_stat->tfm
>> -	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
>> +	if (!crypt_stat || !crypt_stat->tfm
>> +	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
>> +		return -EINVAL;
>> +
>>  	if (unlikely(ecryptfs_verbosity > 0)) {
>>  		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
>>  				crypt_stat->key_size);
>> -- 
>> 2.20.1
>>

The bug was detected by a static analysis tool and have not encountered it. I can send a v2 right away.
