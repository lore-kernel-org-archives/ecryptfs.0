From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm: Don't warn if memdup_user fails
Date: Thu, 12 Jan 2012 09:12:12 +0200 (EET)
Message-ID: <alpine.LFD.2.02.1201120909510.2652@tux.localdomain>
References: <1326300636-29233-1-git-send-email-levinsasha928@gmail.com> <20120111141219.271d3a97.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64963 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533Ab2ALHMZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 12 Jan 2012 02:12:25 -0500
In-Reply-To: <20120111141219.271d3a97.akpm@linux-foundation.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <levinsasha928@gmail.com>, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <kirkland@canonical.com>, ecryptfs@vger.kernel.org

On Wed, 11 Jan 2012, Andrew Morton wrote:
>> diff --git a/mm/util.c b/mm/util.c
>> index 136ac4f..88bb4d4 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -91,7 +91,7 @@ void *memdup_user(const void __user *src, size_t len)
>>  	 * cause pagefault, which makes it pointless to use GFP_NOFS
>>  	 * or GFP_ATOMIC.
>>  	 */
>> -	p = kmalloc_track_caller(len, GFP_KERNEL);
>> +	p = kmalloc_track_caller(len, GFP_KERNEL | __GFP_NOWARN);
>>  	if (!p)
>>  		return ERR_PTR(-ENOMEM);
>
> There's nothing particularly special about memdup_user(): there are
> many ways in which userspace can trigger GFP_KERNEL allocations.
>
> The problem here (one which your patch carefully covers up) is that
> ecryptfs_miscdev_write() is passing an unchecked userspace-provided
> `count' direct into kmalloc().  This is a bit problematic for other
> reasons: it gives userspace a way to trigger heavy reclaim activity and
> perhaps even to trigger the oom-killer.
>
> A better fix here would be to validate the incoming arg before using
> it.  Preferably by running ecryptfs_parse_packet_length() before taking
> a copy of the data.  That would require adding a small copy_from_user()
> to peek at the message header.

Yup, right you are. I didn't think about the reclaim and oom issue. We 
should add a big fat warning on top of memdup_user() to tell users to 
check 'len' for sanity themselves. I think they're now fooled into 
thinking memdup_user() automagically does the right thing.

 			Pekka
