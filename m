From: Henry Jensen <hjensen@gmx.de>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Fri, 01 Jul 2016 23:16:46 +0200
Message-ID: <78E8F2EB-8C8C-4ECD-83D2-2E7EF9F6526E@gmx.de>
References: <20160627182738.08737a6d@subnote.jensen.local> <57717C2C.4010708@canonical.com> <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de> <5771AD13.2010408@canonical.com> <57735047.1050706@canonical.com> <20160701221519.229e9e43@subnote.jensen.local> <5776DB70.5060006@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:64161 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbcGAVQx convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 1 Jul 2016 17:16:53 -0400
In-Reply-To: <5776DB70.5060006@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Kenneth Tan <gmane@way-of-the-blade.com>, ecryptfs@vger.kernel.org

Hi Tyler,

hold on, I think I ran into the same issue as the guys from Manjaro, see

https://forum.manjaro.org/t/kenel-4-4-14-lts-has-issues-with-ecryptfs-on-testing-29-june-2016/5001/9

and

https://github.com/manjaro/packages-core/commit/ff5431986233877dba816e77debe0bf1eacf6628

tl;dr - the patch was malformed. Will check again with correct formatted patch.

Regards,

Henry

Am 1. Juli 2016 23:06:56 MESZ, schrieb Tyler Hicks <tyhicks@canonical.com>:
>On 07/01/2016 03:15 PM, Henry Jensen wrote:
>> Hello Tyler
>> 
>> On Tue, 28 Jun 2016 23:36:23 -0500
>> Tyler Hicks <tyhicks@canonical.com> wrote:
>> 
>>>> Thanks. The backported version of the patch needs to be adjusted.
>I'll
>>>> try to get a patch out the stable list tomorrow.  
>>>
>>> I've sent a fix to the stable list (and cc'ed the ecryptfs list). I
>>> tested on 4.4.y and 3.18.y on ext{2,3,4}, btrfs, and xfs. It should
>fix
>>> the regression that you hit.
>> 
>> 
>> Sorry, the patch did not work for me. I am still getting error "Wrong
>> medium type" wwhen accessing directories.
>> 
>
>Hi Henry - Can you please double check that you're running the patched
>kernel? I only ask that because I have a pretty high degree of
>confidence that the patch fixes the issue due to the amount of testing
>that I performed. I'm in the middle of rebuilding the linux-stable
>4.4.y
>kernel with that patch applied on top to retest. If you could double
>check your environment in the meantime, I'd appreciate it.
>
>If it turns out that you're still hitting the bug, I'll need reproducer
>instructions as my tests don't seem to be sufficient. Thank you!
>
>Tyler
>
>> 
>> Regards,
>> 
>> Henry
>> 
