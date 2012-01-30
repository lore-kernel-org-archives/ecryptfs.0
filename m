From: Martin Steigerwald <ms@teamix.de>
Subject: Re: ecryptfs =?utf-8?q?doesn=C2=B4t_like_noauto_and?= noatime
Date: Mon, 30 Jan 2012 11:58:35 +0100
Message-ID: <201201301158.36957.ms@teamix.de>
References: <201201161044.21718.Martin@lichtvoll.de> <201201170937.10613.Martin@lichtvoll.de> <4F154383.6040201@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:54292 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752292Ab2A3LIu convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 30 Jan 2012 06:08:50 -0500
In-Reply-To: <4F154383.6040201@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Martin Steigerwald <Martin@lichtvoll.de>, ecryptfs@vger.kernel.org

Hi Jakob,

Am Dienstag, 17. Januar 2012 schrieb Jakob Unterwurzacher:
> On 17.01.2012 09:37, Martin Steigerwald wrote:
> > Am Dienstag, 17. Januar 2012 schrieb Jakob Unterwurzacher:
> >> On 16.01.2012 10:44, Martin Steigerwald wrote:
> >>> Hi!
> >>>=20
> >>> I have
> >>>=20
> >>> merkaba:~> grep ecrypt /etc/fstab
> >>> /home/.ms               /home/ms                ecryptfs
> >>> noatime,noauto  0       0
> >>>=20
> >>> And get:
> >>>=20
> >>> merkaba:~> mount /home/ms
> >=20
> >>> Passphrase:
> > [=E2=80=A6]
> >=20
> >>> Error mounting eCryptfs: [-5] Input/output error
> >=20
> > [=E2=80=A6]
> >=20
> >>> Still it works.
> >>>=20
> >>>=20
> >>> In dmesg I see:
> >>>=20
> >>> [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized opt=
ion
> >>> [noauto]
> >>> [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized opt=
ion
> >>> [noatime]
> >>> [ 2657.913215] alg: No test for __gcm-aes-aesni
> >>> (__driver-gcm-aes-aesni)
> >>>=20
> >>>=20
> >>> Thus I removed at least noatime, but then I still see:
> >>>=20
> >>> [ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized opt=
ion
> >>> [noauto]
> >=20
> > [=E2=80=A6]
> >=20
> >>> Without noatime it would ask me the passwort upon boot, but I do =
not
> >>> like that since I do not use that user everytime.
> >=20
> > noauto that is.
> >=20
> >>> I could use mounting via pam, but I like to have a different pass=
word
> >>> for the user stored in /etc/shadow than the password from the
> >>> filesystem itself.
> >>=20
> >> Note that this should work by creating ~/.ecryptfs/wrapping-indepe=
ndent
> >> . Pam will ask for the ecryptfs password explicitely then.
> >=20
> > Thanks.
> >=20
> > Would that also work within a display manager like kdm?
> >=20
> > Ciao,
>=20
> Yes! It will ask for two passwords on login.

Hmmm, I think this won't work for me.

This is used by ecryptfs-mount-private it seems, but I am not only encr=
ypting=20
/home/$USER/Private, but /home/$USER itself. Thus I'd like to mount ~ a=
s is=20
with a different passphrase than my PAM login password.

I tried putting an empty ~/.ecryptfs/wrapping-independent, which has th=
e sig-
cache.txt for the /home/ms mount but this doesn't do the trick, I am no=
t asked=20
for a password and home directory remains empty. I could put=20

Is it true that PAM ecryptfs stuff is only for a ~/Private directory?

Then that would be a reason for me to make a feature request ;).

Thanks,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
