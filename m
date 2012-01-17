From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs =?iso-8859-1?Q?doesn=B4?= =?iso-8859-1?Q?t?= like
 noauto and noatime
Date: Tue, 17 Jan 2012 00:55:37 -0600
Message-ID: <20120117065536.GB4262@boyd>
References: <201201161044.21718.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44653 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab2AQGzm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Jan 2012 01:55:42 -0500
Content-Disposition: inline
In-Reply-To: <201201161044.21718.Martin@lichtvoll.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: ecryptfs@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-01-16 10:44:21, Martin Steigerwald wrote:
> Hi!
>=20
> I have
>=20
> merkaba:~> grep ecrypt /etc/fstab
> /home/.ms               /home/ms                ecryptfs       =20
> noatime,noauto  0       0
>=20
> And get:
>=20
> merkaba:~> mount /home/ms

Is this the *exact* mount command that you're running? You're not
invoking /sbin/mount.ecryptfs directly, using mount -t ecryptfs, or
anything else?

> Passphrase:=20
> Attempting to mount with the following options:
>   ecryptfs_unlink_sigs
>   ecryptfs_fnek_sig=3D0408d19ec184c207
>   ecryptfs_key_bytes=3D32
>   ecryptfs_cipher=3Daes
>   ecryptfs_sig=3D0408d19ec184c207
> Error mounting eCryptfs: [-5] Input/output error
> Check your system logs; visit <http://launchpad.net/ecryptfs>
>=20
>=20
> Still it works.
>=20
>=20
> In dmesg I see:
>=20
> [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized option=20
> [noauto]
> [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized option=20
> [noatime]

Neither of these options should be making their way to the kernel in the
string form. noauto is consumed by the mount utility and should be
stripped out entirely before constructing the final mount options string
for the kernel. noatime should be stripped out and converted into a
mountflags bit (see man 2 mount).

It looks like ecryptfs_generate_mount_flags() is incomplete since it
forgets to handle some options (at least noatime and noauto). I created
bug #917509 to track this:

https://launchpad.net/bugs/917509

Tyler

> [ 2657.913215] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
>=20
>=20
> Thus I removed at least noatime, but then I still see:
>=20
> [ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized option=20
> [noauto]
>=20
>=20
> On could argue about noatime when ecryptfs doesn=B4t override the setting=
 of=20
> the underlying filesystem - i.e. doesn=B4t write the atime itself. But I=
=20
> think noauto should be silently ignored.
>=20
> Without noatime it would ask me the passwort upon boot, but I do not like=
=20
> that since I do not use that user everytime.
>=20
> I could use mounting via pam, but I like to have a different password for=
=20
> the user stored in /etc/shadow than the password from the filesystem=20
> itself.
>=20
>=20
> Thanks,
> --=20
> Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
> GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJPFRtoAAoJENaSAD2qAscKCxcP/14+wBUmlwCx2EF2mHy+RMlI
4kmMIrJvoksIK5SZ3J5hy+FTsmPWibvNo4JnnNJQLKtMMvt9uNi1oFZWgsLwZWdr
RkGX27Ww8Gt9jAnRXld4IihxT7ANxOP5vbYImXubmQrEvfPxGBNNorWFaKoo/KV7
AbK17U1BJkrPUfj7YpKydR0cCLgMeYC70CA7VvDWJlPqsrjhP1Z2LJMuBdCiXzE/
vgPpHK1oT//eSbfILA1J5ynYuf2LiAuAHzdmI8fo23gFvfRq40PL0P6bgmqA4Mbc
iPl9z8zQ1w3ZbhIeJEz4sDQqTNVVw40g7UQhJgSmIW9HcpLd5EMm1O4U//gsv3+E
VX7ch1hk+/gnCPwA3jJlyNX7Y4D20KA5ug4bTM0GK+K2S52DLHQBpYeU6dbGHLaK
Wp1W/hLu7PnsCz2MgWDAt3ZVnGnjIB/9ITOYARyMkZlqkzRRXiQ1+Ryd7ImSZI/F
hoTjPAFVyCUSV8/HUeFFI3hUOPqmjdjMI10CuN6zaKXvlnk4ox61+xoIHSULoDz8
Pa/0FWk0iKwxC5rEIZ6qCUAAR3qSQmHFQToo6hDFRuIw475oV/bo4mXiApr4/oDP
EwqgSAlK2Sm5sFMFn5eJIn46xxKUBIFc+bXn+b96GNtOztnD9glcoUt3J+OHsKAQ
fz2Rjtwj8ttFSQgNIqdP
=SmEs
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
