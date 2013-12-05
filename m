From: William Roberts <bill.c.roberts@gmail.com>
Subject: Re: Looking for volunteers to test and review ecryptfs integration
 with Android
Date: Thu, 5 Dec 2013 10:57:27 -0800
Message-ID: <CAFftDdqtPGrMZOTj6DXi4fS6t8Jmf=B42JGFwtAV7aLvmov9cA@mail.gmail.com>
References: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
	<20131205183806.GC16300@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:46474 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab3LES52 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 5 Dec 2013 13:57:28 -0500
Received: by mail-we0-f176.google.com with SMTP id w62so11397487wes.35
        for <ecryptfs@vger.kernel.org>; Thu, 05 Dec 2013 10:57:27 -0800 (PST)
In-Reply-To: <20131205183806.GC16300@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Catalin Ionita <io.catalin@gmail.com>, ecryptfs@vger.kernel.org

On Thu, Dec 5, 2013 at 10:38 AM, Tyler Hicks <tyhicks@canonical.com> wrote:
> On 2013-12-05 19:32:11, Catalin Ionita wrote:
>> Hi,
>
> Hello!
>
>>
>> I've been working for some time on a solution to integrate ecryptfs
>> in Android. Due to some Android specifics and license problems I had
>> to rewrite the userspace tools.
>
> I really wish these problems would have been brought up on this list.
> Fragmentation of the utilities is a bad thing. There's already enough of
> it in ecryptfs-utils (mount.ecryptfs vs mount.ecryptfs_private) but now
> there's an entirely new package, too.
>
>> Also, for a nice finish touch, I have
>> implemented Android user data encryption from top (including a minimal
>> GUI) to bottom on a Nexus 4 running latest AOSP kitkat.
>
> Very cool. Looking forward to checking it out.
>
>>
>> I'm looking for volunteers to test, review or contribute to Android
>> userspace tools that I've built. The project is stored at
>> https://github.com/catalinionita/Ecryptfs-Tools-for-Android
>
> First, I'd like to explore merging the two code bases. Can you lay out
> the reasons for writing from scratch?

If he is looking to upstream it, Google prefers things under Apache
2.0. However,
this doesn't mean that other licenses are instantly a no either. For
example, checkpolicy.

On the code side, are their dependencies to other libraries that the
userspace tools
require that perhaps Android does not  have or has incompatible versions?

Another reason would perhaps be size, lets see what the author says.
Also, I could swear
I remember reading something about him asking about Android ecryptfs before.

>
> As the kernel maintainer, I don't expect to have the bandwidth to update
> and test both utils packages when kernel changes occur. It would be
> great if ecryptfs-utils and efs-tools lived in the same tree (and shared
> the majority of their code).
>
> Tyler



-- 
Respectfully,

William C Roberts
