From: Zeev Zilberman <zeev@annapurnaLabs.com>
Subject: Re: eCryptfs ablkcipher patch
Date: Sun, 20 Jan 2013 12:00:31 +0000
Message-ID: <068EA2D22589DD4FBD9A55E6FF1EA0B50F1E3BCC@SIXPRD0211MB419.apcprd02.prod.outlook.com>
References: <20130110183649.GA30916@boyd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from [216.32.180.188] ([216.32.180.188]:16691 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751867Ab3ATMBU convert rfc822-to-8bit
	(ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 20 Jan 2013 07:01:20 -0500
In-Reply-To: <20130110183649.GA30916@boyd>
Content-Language: en-US
Content-ID: <7A1978F7FB6EB740AB11739F6AF94686@apcprd02.prod.outlook.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

Hi Tyler,

>Its status is somewhere between those two extremes. Not applied, but
>also not dropped. It is useful, but I'm not sure that its benefits
>outweigh the risks of merging it.
>
>The problem with the patch is that it didn't provide a clear performance
>increase across the board. I don't have the performance testing results
>handy, but it gave a nice increase on some systems and hurt performance
>on others. That, coupled with how risky the patch is, makes me hesitant
>to merge it.
>
>I don't currently have the bandwidth to provide the amount of testing
>that would be needed (nor the time to spend on fixing regressions) and
>the patch author has not been active in eCryptfs development for quite
>some time. In other words, no one has stepped up to usher the patch
>through.
>
>Very few eCryptfs users test the mainline -rc kernels and I don't want
>the users of whatever distro first ships this patch to find all of the
>regressions caused by it.

Maybe the async mode can be added as an experimental config option at the
first stage?
The async mode can be really useful for systems that have HW crypto
accelerators.

Regarding the testing, I still don't have the HW available, I'd be glad to
assist with testing once I do.
Which systems were tested till now?


>Please send me patches, and cc this list, for these fixes. I will push
>everything to a branch in the eCryptfs git tree on kernel.org so that we
>don't lose any useful code.

Sending in a separate mail.


>
>>2. I saw that ecryptfs was reverted from writeback to writethrough cache
>>mode.
>
>That's correct
>
>>This seems to be problematic in regard to performance while using async
>>interfaces.
>>The original change to writepage (that uses ecryptfs_encrypt_page_async)
>>allowed
>>submitting async crypto operations and continuing without waiting for
>>the
>>result.
>
>Nice catch, that would have to be changed.

The problem is that in writethrough mode async operation doesn't seem to
be possible (otherwise the same problems that were encountered in
writeback mode will be encountered, as the io itself will be handled later
by the crypto callback).
It seems that the proper solution is switch to writeback and solve the
issues there.
Is there another solution you think can work?


>
>>write_end uses ecryptfs_encrypt_page (and needs its return value), so
>>we'll have to wait
>>for encryption (and write) to complete before continuing to the next
>>operation.
>>Are you planning to return ecryptfs cache to writeback mode?
>
>No, it caused quite a few bugs. I suspect that eCryptfs will stay with
>the writethrough cache.
>

Could you please elaborate on the bugs that were encountered with
writeback cache?
I saw 2 issues mentioned - the issue of return codes from lower fs and the
issue of quota.
I saw that Thieu Le proposed to use fallocate() in write_end, which seems
to address both of the problems.
Are there more issues that are not covered by this solution?


>
>Have you done any performance testing yourself? I'm curious if you're
>interested in this patch because it made a significant difference in
>your use case.

I will test performance as soon as I'll have the HW available (in a few
months).


Thank you,
Zeev

