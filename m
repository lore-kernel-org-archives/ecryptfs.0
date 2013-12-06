From: Catalin Ionita <io.catalin@gmail.com>
Subject: Re: Looking for volunteers to test and review ecryptfs integration
 with Android
Date: Fri, 6 Dec 2013 10:20:01 +0200
Message-ID: <CAGE04zTK6=cQ4scTOtLr4-9hEmHKR=ZaJ94nHjuj5D2U42zGNw@mail.gmail.com>
References: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
	<20131205183806.GC16300@boyd>
	<CAFftDdqtPGrMZOTj6DXi4fS6t8Jmf=B42JGFwtAV7aLvmov9cA@mail.gmail.com>
	<20131205191108.GD16300@boyd>
	<CAGE04zR1r=9a4mG+OzwjnC_vV3Bix977r55A797ZQ-Ye54UdKw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:45128 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab3LFIUC (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 6 Dec 2013 03:20:02 -0500
Received: by mail-qa0-f51.google.com with SMTP id o15so345476qap.10
        for <ecryptfs@vger.kernel.org>; Fri, 06 Dec 2013 00:20:01 -0800 (PST)
In-Reply-To: <CAGE04zR1r=9a4mG+OzwjnC_vV3Bix977r55A797ZQ-Ye54UdKw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, ecryptfs@vger.kernel.org

Hi William,

> I think I can make some time in the upcoming weeks, worst case right
> after new years?

That will be perfect. If you encounter any kind of problems please
send me an email. Until new year, I'll try to port it to other devices
as well (curenttly lacking the hardware but I'll manage somehow).


--Catalin

On Fri, Dec 6, 2013 at 10:02 AM, Catalin Ionita <io.catalin@gmail.com> wrote:
> Hi Tyler,
>
>> efs-tools, like ecryptfs-utils, is building against the LGPL-ed
>> ibkeyutils.
>
> I'm using a minimal API from libkeyutils to add, search and remove a
> key from kernel keyring. If the LGPL of keyutils will become a problem
> I can switch to calling the syscalls directly inside efs-tools.
>
>> It would obviously take some more thought, but it is possible for
>> ecryptfs-utils to provide an LGPL'ed library that all eCryptfs user
>> space utilities could use.
>> libecryptfs was supposed to be exactly that, but it was unfortunately
>> licensed as GPL long ago...
>
> As far as I know, you have to rewrite the GPL branded components from
> scratch. If there is a way to provide an LGPL ecryptfs-utils I will be
> more than happy to integrate it with Android. I don't like
> fragmentation, and, at this point, ecryptfs-utils is a mature product.
>
>>>
>>> On the code side, are their dependencies to other libraries that the
>>> userspace tools
>>> require that perhaps Android does not  have or has incompatible versions?
>>
>> Possibly, but that could be worked around at build time.
>
> Google striped all GPL components from Android. You can't find easily
> code that you can reuse, so I had to rewrite some features from
> scratch:
>    - Android keystore implementation is different from any Linux
> distro. libnss is not present on Android distributions. I've made a
> minimal software keystore integration in efs-tools. The ultimate goal
> is to have ecryptfs keys backed with hardware (on my todo list for
> Intel mobile platforms).
>    - File utils like cp, mv, rm are scarce (only some BSD code) and I
> had to rewrite those as well
>    - Android does things differently at boot than other Linux distros.
> I had to write a small library that I can statically link with
> initramfs components.
>
> Overall, the only thing that Android has in common with other Linux
> distros is the Linux kernel. We can store efs-tools and ecryptfs-utils
> in the same package and compile according to the OS, but other than
> that, the two libraries can't share code or functionality.
>
>
> --Catalin
>
> On Thu, Dec 5, 2013 at 9:11 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
>> On 2013-12-05 10:57:27, William Roberts wrote:
>>> On Thu, Dec 5, 2013 at 10:38 AM, Tyler Hicks <tyhicks@canonical.com> wrote:
>>> > On 2013-12-05 19:32:11, Catalin Ionita wrote:
>>> >> Hi,
>>> >
>>> > Hello!
>>> >
>>> >>
>>> >> I've been working for some time on a solution to integrate ecryptfs
>>> >> in Android. Due to some Android specifics and license problems I had
>>> >> to rewrite the userspace tools.
>>> >
>>> > I really wish these problems would have been brought up on this list.
>>> > Fragmentation of the utilities is a bad thing. There's already enough of
>>> > it in ecryptfs-utils (mount.ecryptfs vs mount.ecryptfs_private) but now
>>> > there's an entirely new package, too.
>>> >
>>> >> Also, for a nice finish touch, I have
>>> >> implemented Android user data encryption from top (including a minimal
>>> >> GUI) to bottom on a Nexus 4 running latest AOSP kitkat.
>>> >
>>> > Very cool. Looking forward to checking it out.
>>> >
>>> >>
>>> >> I'm looking for volunteers to test, review or contribute to Android
>>> >> userspace tools that I've built. The project is stored at
>>> >> https://github.com/catalinionita/Ecryptfs-Tools-for-Android
>>> >
>>> > First, I'd like to explore merging the two code bases. Can you lay out
>>> > the reasons for writing from scratch?
>>>
>>> If he is looking to upstream it, Google prefers things under Apache
>>> 2.0. However,
>>> this doesn't mean that other licenses are instantly a no either. For
>>> example, checkpolicy.
>>
>> efs-tools, like ecryptfs-utils, is building against the LGPL-ed
>> libkeyutils.
>>
>> It would obviously take some more thought, but it is possible for
>> ecryptfs-utils to provide an LGPL'ed library that all eCryptfs user
>> space utilities could use.
>>
>> libecryptfs was supposed to be exactly that, but it was unfortunately
>> licensed as GPL long ago...
>>
>>>
>>> On the code side, are their dependencies to other libraries that the
>>> userspace tools
>>> require that perhaps Android does not  have or has incompatible versions?
>>
>> Possibly, but that could be worked around at build time.
>>
>>>
>>> Another reason would perhaps be size, lets see what the author says.
>>> Also, I could swear
>>> I remember reading something about him asking about Android ecryptfs before.
>>
>> There have been a couple people ask about building ecryptfs-utils on
>> Android. I think the libnss dependency is the problem. We've discussed
>> how to solve that problem with at least one of those people, but I'm
>> pretty sure that it wasn't Catalin.
>>
>> Tyler
