From: William Roberts <bill.c.roberts@gmail.com>
Subject: Re: Looking for volunteers to test and review ecryptfs integration
 with Android
Date: Fri, 6 Dec 2013 14:38:00 -0800
Message-ID: <CAFftDdqw84jQfdu3RQqpveZJjaAAnt0Wt8p1QZ4FYz3tFaRVRw@mail.gmail.com>
References: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
	<20131205183806.GC16300@boyd>
	<CAFftDdqtPGrMZOTj6DXi4fS6t8Jmf=B42JGFwtAV7aLvmov9cA@mail.gmail.com>
	<20131205191108.GD16300@boyd>
	<CAGE04zR1r=9a4mG+OzwjnC_vV3Bix977r55A797ZQ-Ye54UdKw@mail.gmail.com>
	<CAFftDdraQs9AUVfOVjGLNx2V4X4P+w3upDNPSm_p=T5Jjhd2jA@mail.gmail.com>
	<CAGE04zQ93AEHMFxaLs_BdHtPB4843aVd6OwCwQWTZtdmVvosQA@mail.gmail.com>
	<CAGE04zSvwi=i=6rNBSroibHdQ+vmzWr8Tttta+DRYGO-qoNeTw@mail.gmail.com>
	<CAFftDdrFi4B43oE+bkHxBY8YaeCntr-z_W5i7SK-Zf4QOx2TMQ@mail.gmail.com>
	<CAGE04zTk81-_v=j8L236yJYO9qib=QnE931_7sQ0tF+ThcNrSg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:51601 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759024Ab3LFWiC (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 6 Dec 2013 17:38:02 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so1260711wgh.26
        for <ecryptfs@vger.kernel.org>; Fri, 06 Dec 2013 14:38:00 -0800 (PST)
In-Reply-To: <CAGE04zTk81-_v=j8L236yJYO9qib=QnE931_7sQ0tF+ThcNrSg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Ionita <io.catalin@gmail.com>
Cc: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>

On Fri, Dec 6, 2013 at 2:26 PM, Catalin Ionita <io.catalin@gmail.com> wrote:
> Point taken William. The e2fsprogs is used for file system creation
> when flashing the device. For this operation the device boots into a
> minimal OS which resembles more to a small embedded Linux distro than
> Android OS and performs maintenance operations.  Still, the recovery
> image is flashed into the production image so some GPL code is still
> available inside the production image. Ecryptfs-utils can be
> integrated into the recovery OS without problems, as you can install
> libc and other GPL libraries. Unfortunately, is hardly of use for me
> there.
>
> To have the ecryptfs-utilities functionality available in Android I
> have to dynamically link  one of Android core services with
> ecryptfs-utils. For example, efs-tools is linked with vold (volume
> daemon). These services have root capabilities (since SELinux is on
> enforcing the root capabilities are shared between different core
> services)

SELinux is not quite in enforcing on Android. Its globally turned on,
but depending on your version, most of the domains are in permissive.
4.4 turns on a lot of them, I think vold was one of them. Ie getenforce
will return EPERM or enforcing, but the policy has permissive
type attributes.

and are Apache 2.0. If you are building Android applications
> using SDK or NDK you have to rely on these core services to provide
> functionality as your application doesn't have any root capabilities.
> This is were ecryptfs-utils has integration problems. It will be nice
> to have a libecryptfs Apache 2.0 (this is what I have done) or at
> least LGPL.
>
> --Catalin

I faced the same dilemma with libaudit for Android. Ultimatley, its easier if
license doesn't get in the way of the merge. One less thing for Android to
complain about. I wrote a tiny libaudit for AOSP for this reason. Also so
OEMS had a version they could hack on without sharing. Eventually my
tinyport and auditd was not accepted by them but it was based on concer
of adding another running process. Were discussing alternatives now.

>
>
>
> On Fri, Dec 6, 2013 at 6:22 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> On Fri, Dec 6, 2013 at 7:17 AM, Catalin Ionita <io.catalin@gmail.com> wrote:
>>> The only exception, that I know of, to the "no GPL code is available
>>> on production image" is the kernel.
>>>
>>
>> external/e2fsprogs is tagged with MODULE_LICENSE_GPL and the Android.mk's
>> are building some target libs. I do know Android doesn't like GPL...
>> but its not a show
>> stopper.
>>
>>> On Fri, Dec 6, 2013 at 5:15 PM, Catalin Ionita <io.catalin@gmail.com> wrote:
>>>>> No they didn't... External/check policy is GPL...the kernel..etc
>>>>
>>>> external/checkpolicy is getting build only for host system and is used
>>>> with the Android build system. No GPL code is available on a
>>>> production image. Busybox and other GPL tools available in the Androd
>>>> tree are built only for debugging images, not production ones. This is
>>>> one of the main reason why Google has reimplemented GPL projects like
>>>> libc (bionic).
>>>>
>>>> --Catalin
>>>>
>>>> On Fri, Dec 6, 2013 at 4:28 PM, William Roberts
>>>> <bill.c.roberts@gmail.com> wrote:
>>>>>
>>>>> On Dec 6, 2013 12:02 AM, "Catalin Ionita" <io.catalin@gmail.com> wrote:
>>>>>>
>>>>>> Hi Tyler,
>>>>>>
>>>>>> > efs-tools, like ecryptfs-utils, is building against the LGPL-ed
>>>>>> > ibkeyutils.
>>>>>>
>>>>>> I'm using a minimal API from libkeyutils to add, search and remove a
>>>>>> key from kernel keyring. If the LGPL of keyutils will become a problem
>>>>>> I can switch to calling the syscalls directly inside efs-tools.
>>>>>>
>>>>>> > It would obviously take some more thought, but it is possible for
>>>>>> > ecryptfs-utils to provide an LGPL'ed library that all eCryptfs user
>>>>>> > space utilities could use.
>>>>>> > libecryptfs was supposed to be exactly that, but it was unfortunately
>>>>>> > licensed as GPL long ago...
>>>>>>
>>>>>> As far as I know, you have to rewrite the GPL branded components from
>>>>>> scratch. If there is a way to provide an LGPL ecryptfs-utils I will be
>>>>>> more than happy to integrate it with Android. I don't like
>>>>>> fragmentation, and, at this point, ecryptfs-utils is a mature product.
>>>>>
>>>>> No they didn't... External/check policy is GPL...the kernel..etc.
>>>>>
>>>>>>
>>>>>> >>
>>>>>> >> On the code side, are their dependencies to other libraries that the
>>>>>> >> userspace tools
>>>>>> >> require that perhaps Android does not  have or has incompatible
>>>>>> >> versions?
>>>>>> >
>>>>>> > Possibly, but that could be worked around at build time.
>>>>>>
>>>>>> Google striped all GPL components from Android. You can't find easily
>>>>>> code that you can reuse, so I had to rewrite some features from
>>>>>> scratch:
>>>>>>    - Android keystore implementation is different from any Linux
>>>>>> distro. libnss is not present on Android distributions. I've made a
>>>>>> minimal software keystore integration in efs-tools. The ultimate goal
>>>>>> is to have ecryptfs keys backed with hardware (on my todo list for
>>>>>> Intel mobile platforms).
>>>>>>    - File utils like cp, mv, rm are scarce (only some BSD code) and I
>>>>>> had to rewrite those as well
>>>>>>    - Android does things differently at boot than other Linux distros.
>>>>>> I had to write a small library that I can statically link with
>>>>>> initramfs components.
>>>>>>
>>>>>> Overall, the only thing that Android has in common with other Linux
>>>>>> distros is the Linux kernel. We can store efs-tools and ecryptfs-utils
>>>>>> in the same package and compile according to the OS, but other than
>>>>>> that, the two libraries can't share code or functionality.
>>>>>>
>>>>>>
>>>>>> --Catalin
>>>>>>
>>>>>> On Thu, Dec 5, 2013 at 9:11 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
>>>>>> > On 2013-12-05 10:57:27, William Roberts wrote:
>>>>>> >> On Thu, Dec 5, 2013 at 10:38 AM, Tyler Hicks <tyhicks@canonical.com>
>>>>>> >> wrote:
>>>>>> >> > On 2013-12-05 19:32:11, Catalin Ionita wrote:
>>>>>> >> >> Hi,
>>>>>> >> >
>>>>>> >> > Hello!
>>>>>> >> >
>>>>>> >> >>
>>>>>> >> >> I've been working for some time on a solution to integrate ecryptfs
>>>>>> >> >> in Android. Due to some Android specifics and license problems I had
>>>>>> >> >> to rewrite the userspace tools.
>>>>>> >> >
>>>>>> >> > I really wish these problems would have been brought up on this list.
>>>>>> >> > Fragmentation of the utilities is a bad thing. There's already enough
>>>>>> >> > of
>>>>>> >> > it in ecryptfs-utils (mount.ecryptfs vs mount.ecryptfs_private) but
>>>>>> >> > now
>>>>>> >> > there's an entirely new package, too.
>>>>>> >> >
>>>>>> >> >> Also, for a nice finish touch, I have
>>>>>> >> >> implemented Android user data encryption from top (including a
>>>>>> >> >> minimal
>>>>>> >> >> GUI) to bottom on a Nexus 4 running latest AOSP kitkat.
>>>>>> >> >
>>>>>> >> > Very cool. Looking forward to checking it out.
>>>>>> >> >
>>>>>> >> >>
>>>>>> >> >> I'm looking for volunteers to test, review or contribute to Android
>>>>>> >> >> userspace tools that I've built. The project is stored at
>>>>>> >> >> https://github.com/catalinionita/Ecryptfs-Tools-for-Android
>>>>>> >> >
>>>>>> >> > First, I'd like to explore merging the two code bases. Can you lay
>>>>>> >> > out
>>>>>> >> > the reasons for writing from scratch?
>>>>>> >>
>>>>>> >> If he is looking to upstream it, Google prefers things under Apache
>>>>>> >> 2.0. However,
>>>>>> >> this doesn't mean that other licenses are instantly a no either. For
>>>>>> >> example, checkpolicy.
>>>>>> >
>>>>>> > efs-tools, like ecryptfs-utils, is building against the LGPL-ed
>>>>>> > libkeyutils.
>>>>>> >
>>>>>> > It would obviously take some more thought, but it is possible for
>>>>>> > ecryptfs-utils to provide an LGPL'ed library that all eCryptfs user
>>>>>> > space utilities could use.
>>>>>> >
>>>>>> > libecryptfs was supposed to be exactly that, but it was unfortunately
>>>>>> > licensed as GPL long ago...
>>>>>> >
>>>>>> >>
>>>>>> >> On the code side, are their dependencies to other libraries that the
>>>>>> >> userspace tools
>>>>>> >> require that perhaps Android does not  have or has incompatible
>>>>>> >> versions?
>>>>>> >
>>>>>> > Possibly, but that could be worked around at build time.
>>>>>> >
>>>>>> >>
>>>>>> >> Another reason would perhaps be size, lets see what the author says.
>>>>>> >> Also, I could swear
>>>>>> >> I remember reading something about him asking about Android ecryptfs
>>>>>> >> before.
>>>>>> >
>>>>>> > There have been a couple people ask about building ecryptfs-utils on
>>>>>> > Android. I think the libnss dependency is the problem. We've discussed
>>>>>> > how to solve that problem with at least one of those people, but I'm
>>>>>> > pretty sure that it wasn't Catalin.
>>>>>> >
>>>>>> > Tyler
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts



-- 
Respectfully,

William C Roberts
