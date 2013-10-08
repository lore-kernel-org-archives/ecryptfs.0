From: James Muir <muir.james.a@gmail.com>
Subject: Re: porting to android
Date: Tue, 08 Oct 2013 11:12:39 -0400
Message-ID: <525420E7.5060001@gmail.com>
References: <52353200.9040101@gmail.com>	<CAFftDdq-DQSzGDqKSDGCpvenGp_KtCgR0hzfX1uqSGnfmKAiqg@mail.gmail.com>	<52374CEC.6010507@gmail.com>	<CAFftDdrmF6gvk_Vh8AReUrXVRLCs25SdFBZyqUhHv-tid5KDSg@mail.gmail.com>	<523A1CC3.3090607@gmail.com>	<523C892E.2020601@gmail.com> <CANT6BaOV27qqy_aqnLq+aktfr77WyxDo7YrvDwYD0ehm1j40uA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60388 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab3JHPMl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 8 Oct 2013 11:12:41 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so19425971iec.2
        for <ecryptfs@vger.kernel.org>; Tue, 08 Oct 2013 08:12:40 -0700 (PDT)
In-Reply-To: <CANT6BaOV27qqy_aqnLq+aktfr77WyxDo7YrvDwYD0ehm1j40uA@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dustin Kirkland <kirkland@ubuntu.com>, Tyler C Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/2013 11:44 AM, Dustin Kirkland wrote:
> On Fri, Sep 20, 2013 at 12:43 PM, James Muir
> <muir.james.a@gmail.com> wrote: Success!  I've managed to get the
> user-land tools working (albeit with limited functionality) and can
> now mount/umount ecryptfs volumes on android.
> 
> In hindsight, I can see a much shorter path than the one I took
> (of course :-) ).  I think you can do without the mount.ecryptfs
> utility for basic applications.
> 
>> Hi James,
> 
>> Sorry for the delayed response.  I'm one of the two maintainers
>> of eCryptfs.  Tyler Hicks tends to the kernel side of eCryptfs,
>> and I maintain the userspace ecryptfs-utils.
> 
>> I'm delighted to hear that you have ecryptfs-utils working on
>> Android! There was some work a little while back, and it seemed
>> to work on Linaro builds, but this is the first work I'm aware
>> of, getting eCryptfs mounting/unmounting on Android.
> 
>> Do you have a comprehensive set of instructions, or perhaps a
>> blog post, on this?  Are there changes required upstream in
>> ecryptfs-utils to accommodate the build or functionality?  I
>> would be quite keen to getting those merged upstream, if we can
>> test and verify the functionality...

Hi Tyler,

thanks for your note.  It is nice to know that user-space devs read
this list, too :-)

I haven't written any instructions on getting ecryptfs-utils working
in Android yet, but this is something I would like to do.  Importing
keyutils into aosp is a snap, but not so much for ecryptfs-utils.

Unfortunately, the changes I made aren't very merge-friendly, but I
can reformat them inside appropriate if-def blocks (i.e. #ifdef
ANDROID... #endif).  I could then send you a patch (or point you to a
git repo) based on the 103 release.

sound ok?

- -James M
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJUINwACgkQ4Arkm0Hw/FJ8QgCfXiWIefB4zHEfM4esS+nwbIUf
/ewAn2NhwEQdhyshdoEyQzbDEWd95nvq
=ZT+y
-----END PGP SIGNATURE-----
