From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: dumb question or not?
Date: Tue, 7 Feb 2012 12:56:04 -0600
Message-ID: <CANT6BaOCdYd06GQATGoZ7C5fKwsNnd7uqRcOJrvDDs=fpTz0TQ@mail.gmail.com>
References: <4F2C1AE4.2040104@gmail.com>
	<CANT6BaMt48S5dE0Sm+fK_aJt=qm=bSzWSCTNCcUgmPNPH-ekjQ@mail.gmail.com>
	<4F30E66D.707@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38224 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab2BGS4F convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Feb 2012 13:56:05 -0500
Received: by daed14 with SMTP id d14so635421dae.19
        for <ecryptfs@vger.kernel.org>; Tue, 07 Feb 2012 10:56:04 -0800 (PST)
In-Reply-To: <4F30E66D.707@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Space Cakex <spacecakex@gmail.com>
Cc: ecryptfs@vger.kernel.org

2012/2/7 Space Cakex <spacecakex@gmail.com>:
> It is slightly different
>
> -rws--x--x 1 root root 13740 febr =A0 3 18.36 /sbin/mount.ecryptfs_pr=
ivate*
>
> since my last mail I have re-emerged ecryptfs utils with suid flag, s=
o now I
> can mount my private
>
> is this really absolutely necessary to have suid bit on the executabl=
es?
> This is looks dangerous to me :)

Well, it's required if you want your non-root user to be able to mount
your private directory.

Otherwise, you can mount it manually by hand as root.

--=20
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
