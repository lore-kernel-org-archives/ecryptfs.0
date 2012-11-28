From: Rahul Agrawal <mailrhl@gmail.com>
Subject: Re: Regd: Prefetching and Buffering in eCryptfs
Date: Tue, 27 Nov 2012 22:33:25 -0500
Message-ID: <CAAQA4tXq4orSSk+tBEuCpLFYm002xPUzmSnFmN=cdybidw2YMg@mail.gmail.com>
References: <CAAQA4tWoyrM09FQkTRBBh8tQMiRng+Dp=2Q2TXTZn7z99vMARA@mail.gmail.com>
 <20121128024424.GA17780@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56893 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab2K1Ddm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 27 Nov 2012 22:33:42 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so9366171qcr.19
        for <ecryptfs@vger.kernel.org>; Tue, 27 Nov 2012 19:33:41 -0800 (PST)
In-Reply-To: <20121128024424.GA17780@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs <ecryptfs@vger.kernel.org>

Hi Tyler,

Thanks for taking time out to reply to the thread.

The table that I used for querying is 7.5 GBs in size, my system
memory is 8 GBs. In a full read scan query, I'd expect the underlying
filesystem's caching to not affect the final results that much, since
the table is pretty big. When querying on just ext4, I do get the same
results with a very little deviation. The ext4 cache remains uncleared
between different runs.

Even with the 3 scenarios of eCryptfs usage, I got the same results
with little deviation.

I had run some other standard benchmarks like sysbench and percona's
OLTP. In those runs too, I found eCryptfs to return better numbers.
Hence I fell back upon a really a simple query to reason out the
numbers.

My MySQL vars remains unaltered in both the cases. Thanks for the
pointer on innodb_flush_method, it was set to O_DIRECT, but would this
come into play for READ queries (Only error logs are on)? I changed
this, retried the numbers, it's still the same.

Since eCryptfs is stacked on top of an existing file system, my guess
was I'd see some overhead due to decryption when reading data. Have
ran several tests but unable to figure it out. I am pretty sure, my
eCryptfs mount is correct. I have created simple text files and they
are showing as encrypted when read in the actual directory.
Additionally, something is certainly happening, else I would have seen
the exact number in the runs.

Anything else that I can try?

Rahul


Rahul

On Tue, Nov 27, 2012 at 9:44 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> On 2012-11-27 21:03:28, Rahul Agrawal wrote:
>> Hello all,
>>
>> I have been running some tests for using eCryptfs with MySQL and have
>> posted a query on Stackexchange regarding the results that I got.
>>
>> http://superuser.com/questions/511275/does-ecryptfs-prefetch-and-or-buffer-data
>>
>> If someone knows about this and could answer the question, I'd really
>> appreciate it.
>
> Your test results don't make sense to me at first glance.
>
> In the majority of kernel versions, eCryptfs uses write-through caching.
> There were a few kernel releases where a write-back cache was
> implemented, but it caused some problems and that patch was reverted.
>
> For the SUM query that you're doing, I'd expect it to be all reads, so
> write-back or write-through shouldn't matter much. There would be a
> layer of caching of the encrypted pages in the lower filesystem and then
> another cached layer of the decrypted pages at the eCryptfs level, so it
> is certainly different than when you are just using plain ext4.
>
> You talked about clearing the MySQL buffers and the eCryptfs page cache
> (by unmounting and remounting eCryptfs) between tests. There is still
> the lower filesystem page cache which isn't being cleared. Maybe that
> has something to do with it, but I doubt that is the full story here.
>
> Are you using innodb_flush_method=O_DIRECT? eCryptfs doesn't implement
> direct I/O, so I'm not sure how MySQL would handle that on top of
> eCryptfs vs. ext4, which does do direct I/O.
>
> This is something that I'd have to dig into more to make any sense of
> it. What you're seeing is definitely odd.
>
> Tyler
