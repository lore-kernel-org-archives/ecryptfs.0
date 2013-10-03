From: Dustin Kirkland <kirkland@ubuntu.com>
Subject: Re: porting to android
Date: Thu, 3 Oct 2013 10:44:59 -0500
Message-ID: <CANT6BaOV27qqy_aqnLq+aktfr77WyxDo7YrvDwYD0ehm1j40uA@mail.gmail.com>
References: <52353200.9040101@gmail.com>
	<CAFftDdq-DQSzGDqKSDGCpvenGp_KtCgR0hzfX1uqSGnfmKAiqg@mail.gmail.com>
	<52374CEC.6010507@gmail.com>
	<CAFftDdrmF6gvk_Vh8AReUrXVRLCs25SdFBZyqUhHv-tid5KDSg@mail.gmail.com>
	<523A1CC3.3090607@gmail.com>
	<523C892E.2020601@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33504 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab3JCPpA (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 3 Oct 2013 11:45:00 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so2171525lab.28
        for <ecryptfs@vger.kernel.org>; Thu, 03 Oct 2013 08:44:59 -0700 (PDT)
In-Reply-To: <523C892E.2020601@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Muir <muir.james.a@gmail.com>, Tyler C Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

On Fri, Sep 20, 2013 at 12:43 PM, James Muir <muir.james.a@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Success!  I've managed to get the user-land tools working (albeit with
> limited functionality) and can now mount/umount ecryptfs volumes on
> android.
>
> In hindsight, I can see a much shorter path than the one I took (of
> course :-) ).  I think you can do without the mount.ecryptfs utility
> for basic applications.

Hi James,

Sorry for the delayed response.  I'm one of the two maintainers of
eCryptfs.  Tyler Hicks tends to the kernel side of eCryptfs, and I
maintain the userspace ecryptfs-utils.

I'm delighted to hear that you have ecryptfs-utils working on Android!
 There was some work a little while back, and it seemed to work on
Linaro builds, but this is the first work I'm aware of, getting
eCryptfs mounting/unmounting on Android.

Do you have a comprehensive set of instructions, or perhaps a blog
post, on this?  Are there changes required upstream in ecryptfs-utils
to accommodate the build or functionality?  I would be quite keen to
getting those merged upstream, if we can test and verify the
functionality...

Cheers,
:-Dustin

Dustin Kirkland
eCryptfs Maintainer

> - -James
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlI8iScACgkQ4Arkm0Hw/FJC9gCeISH/F1GviL6vBdqL8kn1frS+
> nHsAn0SQm2hU2ItN7LcVGmCHt4B4Xf81
> =lJqk
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
