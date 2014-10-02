From: Michael Chang <thenewme91@gmail.com>
Subject: Re: Mount parameters
Date: Thu, 2 Oct 2014 16:25:54 -0700
Message-ID: <CAHcyQ+5msQHBLDwVwbW45fEK66EMiOHA1HJc0sijqdw-3k45kw@mail.gmail.com>
References: <CAPJTpio229msbOvRTrE_6GCVLaLeU=O4aUsfEShoOpVypMC-GQ@mail.gmail.com>
 <CAHcyQ+5yiEb9Vcs9WeEMMORLHu6B5qOTz2vp_GKJ9VVx60hWjg@mail.gmail.com>
 <CAHcyQ+7796ySS8sFHiRwaYUXO3unpJ2VUTyBOHpUTp4+-+amjw@mail.gmail.com> <CAPJTpipJ-JJn3no6OWfxBcc-gYrXKvQjTdSgq8xvmoGPsfy4Tg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:61605 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbaJBX0e (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 2 Oct 2014 19:26:34 -0400
Received: by mail-oi0-f44.google.com with SMTP id x69so120778oia.3
        for <ecryptfs@vger.kernel.org>; Thu, 02 Oct 2014 16:26:34 -0700 (PDT)
In-Reply-To: <CAPJTpipJ-JJn3no6OWfxBcc-gYrXKvQjTdSgq8xvmoGPsfy4Tg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wilson <wilson.ubuntu@gmail.com>
Cc: ecryptfs <ecryptfs@vger.kernel.org>

Hmm... that doesn't prevent executing commands of the form "wget
'$URL' | /bin/bash" which are increasingly common.

You could also set umask to prevent new files from having the execute
bit set, but with shell and script interpreters (bash, python, etc.)
I'm not sure how fruitful that will be.

On Thu, Oct 2, 2014 at 4:21 PM, Wilson <wilson.ubuntu@gmail.com> wrote:
> Thanks for the immediate answer.
>
> My present goal is just to prevent automated or accidental execution
> of treacherous downloads while letting users to execute their own code
> if they really want (next step will be to give permission to mount FS
> to some users and not others), so the noexec parameter seemed the
> obvious way to do it (and for users with a not encrypted home it works
> fine).
>
>
> I'm using the standard "use a crypted home" by Ubuntu, so as far as I
> know I'm using the PAM module, I'm just unable to find out where to
> look to configure it (either globally or for a single user).
>
> I've the feeling that I'm missing something obvious, but I can't find it.
>
> Wilson
>
> 2014-10-03 0:56 GMT+02:00 Michael Chang <thenewme91@gmail.com>:
>> My gut feeling is you really want Apparmor or SELinux to restrict
>> execution, since users can just mount new filesystems wherever with
>> exec set (especially on a Desktop configuration with e.g. GNOME
>> installed).
>>
>> However, ecryptfs takes the "noexec" parameter at mount time, just
>> like most FUSE filesystems. You can test this by mounting it from the
>> command line and passing it as an option. Where you would set that so
>> that it always takes effect depends on how you're mounting the
>> directories...
>>
>> Michael Chang
>>
>> On Thu, Oct 2, 2014 at 3:55 PM, Michael Chang <thenewme91@gmail.com> wrote:
>>> My gut feeling is you really want Apparmor or SELinux to restrict execution,
>>> since users can just mount new filesystems wherever with exec set
>>> (especially on a Desktop configuration with e.g. GNOME installed).
>>>
>>> However, ecryptfs takes the "noexec" parameter at mount time, just like most
>>> FUSE filesystems. You can test this by mounting it from the command line and
>>> passing it as an option. Where you would set that so that it always takes
>>> effect depends on how you're mounting the directories...
>>>
>>> Michael Chang
>>>
>>> On Thu, Oct 2, 2014 at 3:41 PM, Wilson <wilson.ubuntu@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> is it possible to mount a ecryptfs home directory with mount
>>>> parameters such as noexec?
>>>>
>>>> I'm trying to build an hardened Ubuntu install (it's just an hobby for
>>>> learning something, noting professional) and I'm stuck trying to
>>>> prevent execution from home even for users with cyphered home.
>>>>
>>>> I'm mounting the whole /home with noexec in fstab, but cyphered home
>>>> are obviously unaffected and I'm unable to find a way to say to
>>>> ecryptfs to do so, can it be done?
>>>>
>>>> Thanks,
>>>>
>>>> Wilson
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>>> --
>>> Michael Chang
>>
>>
>>
>> --
>> Michael Chang
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Michael Chang
