From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: ecryptfs =?utf-8?q?doesn=C2=B4t_like_noauto_and?= noatime
Date: Tue, 17 Jan 2012 09:37:10 +0100
Message-ID: <201201170937.10613.Martin@lichtvoll.de>
References: <201201161044.21718.Martin@lichtvoll.de> <4F14C9DE.80101@gmail.com> (sfid-20120117_093128_614446_D328282A)
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:52028 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2AQIhL convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Jan 2012 03:37:11 -0500
In-Reply-To: <4F14C9DE.80101@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: ecryptfs@vger.kernel.org

Am Dienstag, 17. Januar 2012 schrieb Jakob Unterwurzacher:
> On 16.01.2012 10:44, Martin Steigerwald wrote:
> > Hi!
> >=20
> > I have
> >=20
> > merkaba:~> grep ecrypt /etc/fstab
> > /home/.ms               /home/ms                ecryptfs
> > noatime,noauto  0       0
> >=20
> > And get:
> >=20
> > merkaba:~> mount /home/ms
> > Passphrase:
[=E2=80=A6]
> > Error mounting eCryptfs: [-5] Input/output error
[=E2=80=A6]
> > Still it works.
> >=20
> >=20
> > In dmesg I see:
> >=20
> > [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
> > [noauto]
> > [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
> > [noatime]
> > [ 2657.913215] alg: No test for __gcm-aes-aesni
> > (__driver-gcm-aes-aesni)
> >=20
> >=20
> > Thus I removed at least noatime, but then I still see:
> >=20
> > [ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
> > [noauto]
[=E2=80=A6]
> > Without noatime it would ask me the passwort upon boot, but I do no=
t
> > like that since I do not use that user everytime.

noauto that is.

> > I could use mounting via pam, but I like to have a different passwo=
rd
> > for the user stored in /etc/shadow than the password from the
> > filesystem itself.
>=20
> Note that this should work by creating ~/.ecryptfs/wrapping-independe=
nt
> . Pam will ask for the ecryptfs password explicetely then.

Thanks.

Would that also work within a display manager like kdm?

Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
