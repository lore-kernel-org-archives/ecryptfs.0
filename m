From: Michael Chang <thenewme91@gmail.com>
Subject: Re: Mount parameters
Date: Thu, 2 Oct 2014 15:56:22 -0700
Message-ID: <CAHcyQ+7796ySS8sFHiRwaYUXO3unpJ2VUTyBOHpUTp4+-+amjw@mail.gmail.com>
References: <CAPJTpio229msbOvRTrE_6GCVLaLeU=O4aUsfEShoOpVypMC-GQ@mail.gmail.com>
 <CAHcyQ+5yiEb9Vcs9WeEMMORLHu6B5qOTz2vp_GKJ9VVx60hWjg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:59623 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaJBW5E (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 2 Oct 2014 18:57:04 -0400
Received: by mail-ob0-f169.google.com with SMTP id m8so87445obr.28
        for <ecryptfs@vger.kernel.org>; Thu, 02 Oct 2014 15:57:03 -0700 (PDT)
In-Reply-To: <CAHcyQ+5yiEb9Vcs9WeEMMORLHu6B5qOTz2vp_GKJ9VVx60hWjg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: ecryptfs <ecryptfs@vger.kernel.org>

My gut feeling is you really want Apparmor or SELinux to restrict
execution, since users can just mount new filesystems wherever with
exec set (especially on a Desktop configuration with e.g. GNOME
installed).

However, ecryptfs takes the "noexec" parameter at mount time, just
like most FUSE filesystems. You can test this by mounting it from the
command line and passing it as an option. Where you would set that so
that it always takes effect depends on how you're mounting the
directories...

Michael Chang

On Thu, Oct 2, 2014 at 3:55 PM, Michael Chang <thenewme91@gmail.com> wrote:
> My gut feeling is you really want Apparmor or SELinux to restrict execution,
> since users can just mount new filesystems wherever with exec set
> (especially on a Desktop configuration with e.g. GNOME installed).
>
> However, ecryptfs takes the "noexec" parameter at mount time, just like most
> FUSE filesystems. You can test this by mounting it from the command line and
> passing it as an option. Where you would set that so that it always takes
> effect depends on how you're mounting the directories...
>
> Michael Chang
>
> On Thu, Oct 2, 2014 at 3:41 PM, Wilson <wilson.ubuntu@gmail.com> wrote:
>>
>> Hi,
>>
>> is it possible to mount a ecryptfs home directory with mount
>> parameters such as noexec?
>>
>> I'm trying to build an hardened Ubuntu install (it's just an hobby for
>> learning something, noting professional) and I'm stuck trying to
>> prevent execution from home even for users with cyphered home.
>>
>> I'm mounting the whole /home with noexec in fstab, but cyphered home
>> are obviously unaffected and I'm unable to find a way to say to
>> ecryptfs to do so, can it be done?
>>
>> Thanks,
>>
>> Wilson
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Michael Chang



-- 
Michael Chang
