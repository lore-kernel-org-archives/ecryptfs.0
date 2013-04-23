From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Tue, 23 Apr 2013 12:30:16 -0700
Message-ID: <20130423193016.GB7389@boyd>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
 <alpine.DEB.2.10.1304211324450.13746@trent.utfs.org>
 <CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
 <alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
 <CAHHtCV8Efp+OJ3Rx54_d_dMcSvZnNxdodBK96hSj9=1iLUSB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52864 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3DWTaY (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 23 Apr 2013 15:30:24 -0400
Content-Disposition: inline
In-Reply-To: <CAHHtCV8Efp+OJ3Rx54_d_dMcSvZnNxdodBK96hSj9=1iLUSB7g@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Ivan Yosifov <iyosifov@gmail.com>
Cc: Christian Kujau <lists@nerdbynature.de>, Mike Reinstein <reinstein.mike@gmail.com>, ecryptfs@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-04-23 22:11:40, Ivan Yosifov wrote:
> On Mon, Apr 22, 2013 at 2:29 AM, Christian Kujau <lists@nerdbynature.de> =
wrote:
> > On Sun, 21 Apr 2013 at 13:54, Mike Reinstein wrote:
> >> Maybe I'm just misunderstanding the problem. Is it being suggested tha=
t the
> >> unencrypted copy of the data should be backed up over sshfs to an untr=
usted
> >> machine?
> >
> > No, I think the untrusted machine would hold the encrypted data, which =
is
> > mounted to a trusted machine, where it's then decrypted via ecryptfs.
>=20
> You're right, that's the idea. I want to run the crypto on the trusted
> machine and only use the untrusted one as dumb storage.
>=20
> I'm running arch, ecryptfs-utils 103, sshfs 2.4, kernel 3.8.8, so very
> similar to yours. Running strace was a good idea, the relevant bit is:
>=20
> utimensat(4, NULL, {{1366539595, 699650012}, {1366539595, 699650012}},
> 0) =3D -1 EPERM (Operation not permitted)

Does this happen when only using sshfs (without eCryptfs mounted on
top)?

Does this happen when only using eCryptfs (mounted locally on top of
something like ext4)?

>=20
> The setup that fails is thus: The sshfs is mounted by my regular user
> with -o allow_root and the ecryptfs is mounted from a root console.
>=20
> I tried doing both the sshfs and ecryptfs mounts by root and that
> worked. I'm assuming it's a problem if the sshfs and ecryptfs are
> "running as different users". Frankly, I'm not at all sure what
> "running as a user" means in the context of kernel code like fuse and
> ecryptfs, does this ring any bells?

Nothing like that should be a problem from eCryptfs' standpoint. I have
no idea about sshfs.

>=20
> Are both mounts in your setup done by a non-root user? If yes, what's
> the correct way to mount an ecryptfs as a user? I tried adding a line
> to /etc/fstab with <all the options>,user,noauto and it didn't work.
> The arch wiki (
> https://wiki.archlinux.org/index.php/ECryptfs#Mounting_.28the_hard_way.29
> ) suggests /sbin/mount.ecryptf should be suid root, but that doesn't
> make it work either.

Don't set mount.ecryptfs as setuid root. That's very bad advice.

Why didn't adding user,noauto to the fstab entry work for you? What
error message did you see? Anything relevant in the system log?

Tyler

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRduFHAAoJENaSAD2qAscKM9YP/R1nwjJQaT4v5Cx1W4QarmAF
QjEmRmW2WRMsfxDeMDZ9xI9Pns7P0MdGMlvUOKq7lzV34qJ+5ymclt9yGmZFcFtO
iNsFsJbvj8K4d88ACY6bmOwsZrXsOyEoCRpBTfiBeXLN+I/2nCO0S1UzsE80YtMW
I9m+9D4RqNBftHhMyHkD0zjIHmj1n2NTxfr0RFq9BGec9Lmfnwaaph7maeRTvaKt
dNF/cgUG5VD6WAnXIAQlDpCwwuTzzcakql0qtsI7mSkrPMbe4fX8PiR8YZ77FFOH
Qw+cBJZT2madb3PlaapjRyAyXIhkmTuiyLr5+E40kcrQ4Vvbf9NwOFNxG9Tlh/B1
2OEwbPGyO7GxHmYnbNGfPdPeuh7KPITRZfXYdrwXRnqXNhEFElgBo7nlXWABabKt
FG5rchBZhbNBgbRn+WGhzb8AjNk2P1qHfxfoeCOrlgpu7G+guLsjzBn9sTRrmbFf
dnZ1NV8bXU42org7cpyNHH2xzzyYJhkO4Oq4XYsVk+mdLzaYzhIocGys9xVxf1Ad
y13kGEAmg7rLztv4thHy/rSwDpaFj5sZChayAjR2j5scoOsdq4R6pxiYNVHsDgqU
3NQMMrN3xSaMKuzVVceDl2z1kZ5muVV37uXFG3/rSidwKPN5mkkr/WJdH4dM2pj8
lDaqPX/Kg0Y8liNGIJPC
=nlPe
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
