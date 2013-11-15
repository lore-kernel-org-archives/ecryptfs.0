From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs-mount-private fails the first time after boot
Date: Fri, 15 Nov 2013 15:34:46 -0800
Message-ID: <20131115233445.GA4911@boyd>
References: <CAAk6P0VYWJA+pC6CfeLKhZc6kZ5EVASS+8ELoAUEWCOnqVhhuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55908 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab3KOXev (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 15 Nov 2013 18:34:51 -0500
Content-Disposition: inline
In-Reply-To: <CAAk6P0VYWJA+pC6CfeLKhZc6kZ5EVASS+8ELoAUEWCOnqVhhuw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: ecryptfs@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-11-15 17:51:49, Benjamin Moody wrote:
> I'm using ecryptfs on Scientific Linux 6.4 (kernel
> 2.6.32-358.23.2.el6.x86_64, ecryptfs-utils 82-6.el6_1.3)

I don't have a system derived from RHEL 6 to test from. But I gave it a
shot with Ubuntu 10.04 (kernel 2.6.32-52.114-generic, ecryptfs-utils
83-0ubuntu3.2.10.04.3).

I wasn't able to reproduce the bug that you're seeing. I thought that
maybe the RHEL 6 derivatives don't enable the pam_ecryptfs module and
that it does something that ecryptfs-mount-private needs, so I commented
it out of my pam configs and tried again but still couldn't reproduce
it.

> When I run ecryptfs-mount-private for the first time, it shows the follow=
ing:
>=20
> $ ecryptfs-mount-private
> Enter your wrapping passphrase:
> Inserted auth tok with sig [...] into the user session keyring
> keyctl_search: Required key not available
> Perhaps try the interactive 'ecryptfs-mount-private'
>=20
> At this point, the following messages appear in dmesg:
>=20
> $ dmesg
> ...
> TECH PREVIEW: ecryptfs may not be fully supported.
> Please review provided documentation for limitations.
> SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts
>=20
> And at this point, the filesystem is *mounted* but the files are not
> correctly decrypted (i.e. Private appears to be an exact mirror of
> .Private):
>=20
> $ ls Private/
> ECRYPTFS_FNEK_ENCRYPTED.FWaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLCHzv3PNoOtExPX=
P.Ei0KiAE--
> ECRYPTFS_FNEK_ENCRYPTED.FXaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLC-NRvX4ESyXeGh=
90V8z6JRo2qp.xjwPLn8Fz1BXP8u22-
> ...

It would be nice to see the mount options, from /proc/mounts, at this
point.

I'm having to make some assumptions, but it looks like the mount happens
without the filename encryption key being loaded into the kernel
keyring.

Also, seeing how many user keys are loaded at this point would be
helpful:

$ keyctl show | grep user: | wc -l
2

> I then unmount and remount it:
>=20
> $ ecryptfs-umount-private
> keyctl_search: Required key not available
> Perhaps try the interactive 'ecryptfs-mount-private'
>=20
> $ ecryptfs-mount-private
> Enter your wrapping passphrase:
> Inserted auth tok with sig [...] into the user session keyring
>=20
> at which point it works as expected.

At this point, the keyctl show command above should spit out the same
result as above. But, I think you'll see "1" printed when you run it
above, and "2" printed now.

> So, does anyone know why this might be happening?

No. I don't recall a fixed bug similar to this, but you should search
our bug tracker (https://bugs.launchpad.net/ecryptfs). Also, take a look
through the RHEL bug tracker.

Sorry I'm not more help at this point but I can't reproduce it at the
moment and don't recall us fixing anything like this. Dustin tends to
this portion of ecryptfs-utils, so maybe he'll remember something when
he sees your email.

Tyler

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJShq+VAAoJENaSAD2qAscK+WcQAJ0sN5wPs0030D0FfCVozt6Q
lEcRomYqc7GXguXtzDACA6HRnBKsuqKfX3loiU0kuPZ8Hp2yuBKtHwpMpzaOwiDY
565auJwKxRTtcTIFNKzgUIoycih+Ajtq7fmV0+Pbj8jsBhz/Aqbi5acDmplybYvR
Fp2kE7J504Lbv2pGPDDuH8ASf2DCaxQNh1861cYj89qGLG6ucGJs7oBLo8G46BLg
lz/ImJbG/CeaPXzGT8YmuJFYERA1F7YzOCIqkIa8UtFcZy4E4F/JQo5LSBrNdRGe
PkHVvPQIHLg/RtM7DmwVRVMZchvH0SorxYArYLeltrMgNhpTjk7ERJQ6O+V6aRU8
gjXKCUjPC5ojAGBM79pjEbJaFzyOQRzgenRBiludZj2X5tfT9eXQK+t8tV1Zi029
WccAc58B5T3tlH4CarQO3ERU46IKg8+uaQgN5Wqtq8vzExMH3qPGbAK/G0qc7GHo
GzP7xaTkPBdKupKUQjFfeyhZ8AvqynIoAlinNlIZJgs2i6EyLX5qZ2hFwj/cylkX
Hnd0j+08m9xyZXUSrepr+DlTaBmA6ddMbs8W3XXC+4hzxvB+Tx9Bjqc/Rsp1J/W+
uPtgmnzsvK3NrCUL2Sfp59unGQLMrApQGkl2BDzIJ2ipgyuNJx0xuBLIzxKXN8KQ
orLlae/agoMAwvCsOUih
=Mfw+
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
