From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: ecryptfs-mount-private fails the first time after boot
Date: Fri, 15 Nov 2013 19:29:01 -0500
Message-ID: <CAAk6P0XLJK_aF-kvrdaBT7P6qoK_2Scu3hyjPJedDyqQUWmvSw@mail.gmail.com>
References: <CAAk6P0VYWJA+pC6CfeLKhZc6kZ5EVASS+8ELoAUEWCOnqVhhuw@mail.gmail.com>
	<20131115233445.GA4911@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:48377 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab3KPA3D (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 15 Nov 2013 19:29:03 -0500
Received: by mail-wg0-f45.google.com with SMTP id a1so4240044wgh.12
        for <ecryptfs@vger.kernel.org>; Fri, 15 Nov 2013 16:29:01 -0800 (PST)
In-Reply-To: <20131115233445.GA4911@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Thanks for your quick reply!

On 11/15/13, Tyler Hicks <tyhicks@canonical.com> wrote:
> On 2013-11-15 17:51:49, Benjamin Moody wrote:
>> I'm using ecryptfs on Scientific Linux 6.4 (kernel
>> 2.6.32-358.23.2.el6.x86_64, ecryptfs-utils 82-6.el6_1.3)
>
> I don't have a system derived from RHEL 6 to test from. But I gave it a
> shot with Ubuntu 10.04 (kernel 2.6.32-52.114-generic, ecryptfs-utils
> 83-0ubuntu3.2.10.04.3).
>
> I wasn't able to reproduce the bug that you're seeing. I thought that
> maybe the RHEL 6 derivatives don't enable the pam_ecryptfs module and
> that it does something that ecryptfs-mount-private needs, so I commented
> it out of my pam configs and tried again but still couldn't reproduce
> it.

I'm pretty sure it isn't using pam_ecryptfs, but that shouldn't make a
difference in this case (since I'm not using the login password),
right?

>> When I run ecryptfs-mount-private for the first time, it shows the
>> following:
>>
>> $ ecryptfs-mount-private
>> Enter your wrapping passphrase:
>> Inserted auth tok with sig [...] into the user session keyring
>> keyctl_search: Required key not available
>> Perhaps try the interactive 'ecryptfs-mount-private'
>>
>> At this point, the following messages appear in dmesg:
>>
>> $ dmesg
>> ...
>> TECH PREVIEW: ecryptfs may not be fully supported.
>> Please review provided documentation for limitations.
>> SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts
>>
>> And at this point, the filesystem is *mounted* but the files are not
>> correctly decrypted (i.e. Private appears to be an exact mirror of
>> .Private):
>>
>> $ ls Private/
>> ECRYPTFS_FNEK_ENCRYPTED.FWaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLCHzv3PNoOtExPXP.Ei0KiAE--
>> ECRYPTFS_FNEK_ENCRYPTED.FXaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLC-NRvX4ESyXeGh90V8z6JRo2qp.xjwPLn8Fz1BXP8u22-
>> ...
>
> It would be nice to see the mount options, from /proc/mounts, at this
> point.

/home/benjamin/.Private /home/benjamin/Private ecryptfs
rw,relatime,ecryptfs_sig=dceda47e1c1e65a1,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_unlink_sigs
0 0

> I'm having to make some assumptions, but it looks like the mount happens
> without the filename encryption key being loaded into the kernel
> keyring.
>
> Also, seeing how many user keys are loaded at this point would be
> helpful:
>
> $ keyctl show | grep user: | wc -l
> 2

Interesting.  It shows 0 when first starting up, and 1 after I run
ecryptfs-mount-private for the first time.  Looks like you're right
and it's loading the *file* decryption key but not the *filename* key.
 (In fact I was partially incorrect before; the file contents are
being decrypted correctly, it's just the filenames that remain
encrypted.)

>> I then unmount and remount it:
>>
>> $ ecryptfs-umount-private
>> keyctl_search: Required key not available
>> Perhaps try the interactive 'ecryptfs-mount-private'
>>
>> $ ecryptfs-mount-private
>> Enter your wrapping passphrase:
>> Inserted auth tok with sig [...] into the user session keyring
>>
>> at which point it works as expected.
>
> At this point, the keyctl show command above should spit out the same
> result as above. But, I think you'll see "1" printed when you run it
> above, and "2" printed now.

Indeed, it now shows 2, and /proc/mounts shows

/home/benjamin/.Private /home/benjamin/Private ecryptfs
rw,relatime,ecryptfs_fnek_sig=9a046cc859c834ba,ecryptfs_sig=dceda47e1c1e65a1,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_unlink_sigs
0 0

>> So, does anyone know why this might be happening?
>
> No. I don't recall a fixed bug similar to this, but you should search
> our bug tracker (https://bugs.launchpad.net/ecryptfs). Also, take a look
> through the RHEL bug tracker.

Thanks.  I'll do so.

Benjamin
