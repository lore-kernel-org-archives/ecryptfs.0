From: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
Subject: Re: Practical questions about locking and re-encrypting
Date: Tue, 23 Sep 2014 11:39:55 +0200
Message-ID: <20140923113955.Horde.hGWGHtD6UQ5UIT-rZ-tGBFA@webmail.ugent.be>
References: <20140922173257.Horde.aPhFRVyqiOZUIEEpuKgAfuA@webmail.ugent.be>
 <20140922155824.GA17376@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtp2.ugent.be ([157.193.49.126]:56877 "EHLO smtp2.ugent.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754955AbaIWJkA (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 23 Sep 2014 05:40:00 -0400
In-Reply-To: <20140922155824.GA17376@boyd>
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="Yes"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org


----- Message from Tyler Hicks <tyhicks@canonical.com> ---------
    Date: Mon, 22 Sep 2014 10:58:25 -0500
    From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Practical questions about locking and re-encrypting
      To: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
      Cc: ecryptfs@vger.kernel.org


> On 2014-09-22 17:32:57, Kenneth Waegeman wrote:
>> Hi all,
>
> Hi Kenneth
>
>>
>>
>> We want to use ecryptfs on GPFS. How does ecryptfs handles locking if an
>> encrypted directory is mounted on different boxes ? Is data corruption
>> possible while writing?
>
> eCryptfs is not well suited for being stacked on top of a distributed
> file system such as GPFS.
>
> That would result in each node having its own eCryptfs mount. Each
> eCryptfs mount has its own page cache. eCryptfs doesn't do any sort of
> coordination between remote mounts and there's no way for the lower
> filesystem to make eCryptfs aware that file contents, which may be in
> the eCryptfs page cache, have been modified by a remote node.
>
> That means that if a file is read into the eCryptfs page cache on node A
> and then that file is updated on node B, node A will never know an
> update has been made and will never invalidate the old, cached file
> contents from its page cache.

When is the pagecache flushed? is sync honoured? or does that happen  
only on unmount?
Does this also apply for directories? What happens if 2 hosts  
modifying different files in same directory?

Thank you for the explanation!

Kenneth

>
>>
>> Another question: Is there an easy way to re-encrypt a directory with
>> another key? (when having compromised key or so).
>
> Unfortunately, no. You'd need to set up a new eCryptfs mount, with a new
> key, and copy the files between the two eCryptfs mounts.
>
> Tyler
>
>>
>>
>> Thank you!!
>>
>> Kenneth
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


----- End message from Tyler Hicks <tyhicks@canonical.com> -----

-- 

Met vriendelijke groeten,
Kenneth Waegeman
