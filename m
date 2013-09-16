From: James Muir <muir.james.a@gmail.com>
Subject: Re: porting to android
Date: Mon, 16 Sep 2013 14:24:44 -0400
Message-ID: <52374CEC.6010507@gmail.com>
References: <52353200.9040101@gmail.com> <CAFftDdq-DQSzGDqKSDGCpvenGp_KtCgR0hzfX1uqSGnfmKAiqg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:48258 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3IPS35 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 16 Sep 2013 14:29:57 -0400
Received: by mail-yh0-f54.google.com with SMTP id z20so2217191yhz.41
        for <ecryptfs@vger.kernel.org>; Mon, 16 Sep 2013 11:29:56 -0700 (PDT)
In-Reply-To: <CAFftDdq-DQSzGDqKSDGCpvenGp_KtCgR0hzfX1uqSGnfmKAiqg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: William Roberts <bill.c.roberts@gmail.com>
Cc: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2013 10:27 AM, William Roberts wrote:
> I've used ecryptfs on Android before, but I wrote my own userland
> tools. I found it easier to just strace the program to figure out
> what the kernel was expecting.
> 

Were your tools generic? or did you create them just to access a
particular ecryptfs container?

I've tried using strace when mounting my encrypted folder like so:

  # strace mount -t ecryptfs /home/username/.Private
/home/username/Private

but I didn't get any output after answering the prompts on ecryptfs
mount options :-(

- -James
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI3TOQACgkQ4Arkm0Hw/FILNACfQsv+RYHlKhZp9Wje3JvBOLIF
xVMAoImjw+WmBCuKxqd28TR676aks7Ry
=2J+k
-----END PGP SIGNATURE-----
