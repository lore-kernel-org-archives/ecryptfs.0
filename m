From: Martin Steigerwald <ms@teamix.de>
Subject: Re: encryption metadata not stored with filesystem
Date: Tue, 20 Dec 2011 10:53:11 +0100
Message-ID: <201112201053.12281.ms@teamix.de>
References: <201112191336.05938.ms@teamix.de> <CANT6BaOtumjj+kJTsDD92YPBKXqnw0Nw8s24B05Wo2agi2oV1A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:34575 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070Ab1LTJxQ convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Dec 2011 04:53:16 -0500
In-Reply-To: <CANT6BaOtumjj+kJTsDD92YPBKXqnw0Nw8s24B05Wo2agi2oV1A@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="windows-1252"
To: Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: ecryptfs@vger.kernel.org

Am Montag, 19. Dezember 2011 schrieb Dustin Kirkland:
> On Mon, Dec 19, 2011 at 6:36 AM, Martin Steigerwald <ms@teamix.de> wr=
ote:
> > On trying to work with ecryptfs I have found that I have to store
> > ecryptfs configuration in an undocumented file ~/.ecryptfsrc like:
> >=20
> > merkaba:~> cat .ecryptfsrc
> > ecryptfs_unlink_sigs
> > ecryptfs_sig=3D[=85]
> > ecryptfs_fnek_sig=3D[=85]
> > ecryptfs_xattr
> > ecryptfs_key_bytes=3D32
> > ecryptfs_cipher=3Daes
> > ecryptfs_passthrough=3Dn
> >=20
> > in order to mount ecryptfs without mount options.
>=20
> Thanks for that suggestion.  I've actually just created a bug to trac=
k
> this.  I'll try to get this working better this week:
>  * https://bugs.launchpad.net/ecryptfs/+bug/906550

Thanks, Dustin.

One part of my suggestion was to store the configuration of an ecryptfs=
=20
filesystem within the encrypted directory.

With encfs I can rsync the crypted directory to somewhere else and then=
 just=20
mount it on the remote machine like I would on my local one. I do not h=
ave to=20
think about copying the ecryptfs configuration as well.

When I manage to dig out my Launchpad account or create a new one for m=
y=20
company's mail address I add that to the bug report.

Ciao,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
