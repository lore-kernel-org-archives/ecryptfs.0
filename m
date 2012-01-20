From: Tim Gardner <rtg.canonical@gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: Improve metatdata read failure logging
Date: Fri, 20 Jan 2012 13:17:56 -0700
Message-ID: <4F19CBF4.1020303@canonical.com>
References: <1326301242-5817-1-git-send-email-tim.gardner@canonical.com> <1326301242-5817-2-git-send-email-tim.gardner@canonical.com> <20120112120044.GB4717@boyd> <4F0F0E10.1010107@canonical.com> <20120120195041.GC9156@boyd>
Reply-To: tim.gardner@canonical.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120120195041.GC9156@boyd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Tyler Hicks <tyler.hicks@canonical.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, ecryptfs@vger.kernel.org

On 01/20/2012 12:50 PM, Tyler Hicks wrote:
> On 2012-01-12 17:45:04, Tim Gardner wrote:
>> On 01/12/2012 01:00 PM, Tyler Hicks wrote:
>>> On 2012-01-11 18:00:41, Tim Gardner wrote:
>>>> There are 3 read failure cases in ecryptfs_read_metadata(), but only 2
>>>> of them are uniquely noted by kernel log messages. This patch
>>>> identifies and logs each read failure case. It also correctly interprets
>>>> a negative return value from ecryptfs_read_lower().
>>>
>>> I'm not sure that the negative return value was incorrectly interpreted.
>>> See below.
>>>
>>>>
>>>> Removes unnecessary variable initialization.
>>>>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Tyler Hicks<tyler.hicks@canonical.com>
>>>> Signed-off-by: Tim Gardner<tim.gardner@canonical.com>
>>>> ---
>>>>   fs/ecryptfs/crypto.c |   17 +++++++++++------
>>>>   1 files changed, 11 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
>>>> index d3c8776..ac063bd 100644
>>>> --- a/fs/ecryptfs/crypto.c
>>>> +++ b/fs/ecryptfs/crypto.c
>>>> @@ -1590,8 +1590,8 @@ int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
>>>>    */
>>>>   int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
>>>>   {
>>>> -	int rc = 0;
>>>> -	char *page_virt = NULL;
>>>> +	int rc;
>>>> +	char *page_virt;
>>>>   	struct inode *ecryptfs_inode = ecryptfs_dentry->d_inode;
>>>>   	struct ecryptfs_crypt_stat *crypt_stat =
>>>>   	&ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
>>>> @@ -1611,10 +1611,15 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
>>>>   	}
>>>>   	rc = ecryptfs_read_lower(page_virt, 0, crypt_stat->extent_size,
>>>>   				 ecryptfs_inode);
>>>> -	if (rc>= 0)
>>>> -		rc = ecryptfs_read_headers_virt(page_virt, crypt_stat,
>>>> -						ecryptfs_dentry,
>>>> -						ECRYPTFS_VALIDATE_HEADER_SIZE);
>>>> +	if (rc<   0) {
>>>> +		printk(KERN_ERR "%s: Could not read %u bytes\n",
>>>> +			__func__, crypt_stat->extent_size);
>>>> +		goto out;
>>>> +	}
>>>
>>> This may break things a bit for users that use the
>>> ecryptfs_xattr_metadata mount option (which stores the metadata in an
>>> xattr, rather than the header of the file). A failure to read the lower
>>> file here doesn't matter because the metadata is likely stored in an
>>> xattr, which will be found with the ecryptfs_read_xattr_region() call
>>> below.
>>>
>>> I've never liked that ecryptfs potentially looks in both the header and
>>> the xattr for metadata, but that's how it has been since the very early
>>> days of eCryptfs. I've wanted to change this but there is the potential
>>> to break things for users who have a mixture of files with metadata in
>>> the header and in the header.
>>>
>>> Maybe we just go whole hog for 3.3 and only look in either the header or
>>> xattr for metadata, depending on whether or not ecryptfs_xattr_metadata
>>> is used?
>>>
>>> I could live with that, but I would definitely not want something like
>>> that to go to the stable kernel. Any thoughts?
>>>
>>> Tyler
>>>
>>
>> I think you're right. Given the way the metadata checks are coded I
>> think its impossible to disambiguate the 2 failure scenarios.
>> However, its not really relevant that we know which one failed, only
>> the inode of the metadata read that _did_ fail is important.
>>
>> How about this much simpler patch that is also suitable for stable ?
>> Tested on 3.2.
>
> Hey Tim - Sorry for the hiccup in response time. Comments below.
>
>>
>> rtg
>> --
>> Tim Gardner tim.gardner@canonical.com
>
>>  From 48f75c409ddc00caec88162f53c3155196b17854 Mon Sep 17 00:00:00 2001
>> From: Tim Gardner<tim.gardner@canonical.com>
>> Date: Thu, 12 Jan 2012 16:31:55 +0100
>> Subject: [PATCH 1/1 V2] ecryptfs: Improve metadata read failure logging
>>
>> Print inode on metadata read failure. The only real
>> way of dealing with metadata read failures is to delete
>> the underlying file system file. Having the inode
>> allows one to 'find . -inum INODE`.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Tyler Hicks<tyler.hicks@canonical.com>
>> Signed-off-by: Tim Gardner<tim.gardner@canonical.com>
>> ---
>>   fs/ecryptfs/crypto.c |   14 +++++++++-----
>>   1 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
>> index d3c8776..326d6ab 100644
>> --- a/fs/ecryptfs/crypto.c
>> +++ b/fs/ecryptfs/crypto.c
>> @@ -1590,8 +1590,8 @@ int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
>>    */
>>   int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
>>   {
>> -	int rc = 0;
>> -	char *page_virt = NULL;
>> +	int rc;
>> +	char *page_virt;
>
> I doubt there is any issue with not initializing these variables in
> the older, stable kernel releases, but I don't want to take the time to
> verify that.
>
> So, would you mind if I split this variable initialization part into a
> separate patch not for stable? I can handle that on my end, if that's
> alright with you.
>
> The printk's below are safe and stable-worthy, IMO, because end-users
> should really benefit from the changes.
>
> Tyler
>

I'm fine with that.

rtg
-- 
Tim Gardner tim.gardner@canonical.com
