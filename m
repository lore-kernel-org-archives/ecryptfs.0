From: James Muir <muir.james.a@gmail.com>
Subject: Re: porting to android
Date: Fri, 20 Sep 2013 13:43:10 -0400
Message-ID: <523C892E.2020601@gmail.com>
References: <52353200.9040101@gmail.com> <CAFftDdq-DQSzGDqKSDGCpvenGp_KtCgR0hzfX1uqSGnfmKAiqg@mail.gmail.com> <52374CEC.6010507@gmail.com> <CAFftDdrmF6gvk_Vh8AReUrXVRLCs25SdFBZyqUhHv-tid5KDSg@mail.gmail.com> <523A1CC3.3090607@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:34426 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab3ITRnM (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 20 Sep 2013 13:43:12 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so548857vbe.13
        for <ecryptfs@vger.kernel.org>; Fri, 20 Sep 2013 10:43:12 -0700 (PDT)
In-Reply-To: <523A1CC3.3090607@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Success!  I've managed to get the user-land tools working (albeit with
limited functionality) and can now mount/umount ecryptfs volumes on
android.

In hindsight, I can see a much shorter path than the one I took (of
course :-) ).  I think you can do without the mount.ecryptfs utility
for basic applications.

- -James
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlI8iScACgkQ4Arkm0Hw/FJC9gCeISH/F1GviL6vBdqL8kn1frS+
nHsAn0SQm2hU2ItN7LcVGmCHt4B4Xf81
=lJqk
-----END PGP SIGNATURE-----
