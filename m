From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Mon, 27 Jun 2016 14:19:08 -0500
Message-ID: <57717C2C.4010708@canonical.com>
References: <20160627182738.08737a6d@subnote.jensen.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BaNNG4S5JNeRuRxXX9pndDiQIcJDREKr9"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56231 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0TTQ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 27 Jun 2016 15:19:16 -0400
In-Reply-To: <20160627182738.08737a6d@subnote.jensen.local>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Henry Jensen <hjensen@gmx.de>, ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BaNNG4S5JNeRuRxXX9pndDiQIcJDREKr9
Content-Type: multipart/mixed; boundary="Vq9DlUAmEh3jmOBk5JcrUVenuFJQuuC3V"
From: Tyler Hicks <tyhicks@canonical.com>
To: Henry Jensen <hjensen@gmx.de>, ecryptfs@vger.kernel.org
Message-ID: <57717C2C.4010708@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
References: <20160627182738.08737a6d@subnote.jensen.local>
In-Reply-To: <20160627182738.08737a6d@subnote.jensen.local>

--Vq9DlUAmEh3jmOBk5JcrUVenuFJQuuC3V
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/27/2016 11:27 AM, Henry Jensen wrote:
> Greetings,
>=20
> I'm using ecryptfs with Slackware current and kernel 4.4.14. In kernel
> 4.4.14 was a patch introduced which make it impossilble to list the
> contents of a directory.[0]
>=20
> The mount itself works, but listing a directory results in an error
> "wrong medium type". Showing the contents and the file itself (presumed=

> the name of the file is known) works.

Hi Henry - sorry for the trouble. What filesystem are you mounting
eCryptfs on top of?

Tyler

>=20
>=20
> Example:
>=20
> henry@subnote:~$ ecryptfs-mount-private=20
> henry@subnote:~$ echo "foo bar" >Private/foobar
> henry@subnote:~$ ls -l Private/foobar
> -rw-r--r-- 1 henry users 8 Jun 27 18:13 Private/foobar
> henry@subnote:~$ cat Private/foobar
> foo bar
> henry@subnote:~$ ls Private/
> ls: cannot open directory 'Private/': Wrong medium type
> henry@subnote:~$ cat Private/foo* =20
> cat: 'Private/foo*': No such file or directory
>=20
> henry@subnote:~$ ls .Private/     =20
> ECRYPTFS_FNEK_ENCRYPTED.FWZL6yY3cgf9JkRRDnGzSkFOIUQir-xo2KY6u52Ft53bpb4=
SnqMhgeIIl---
>=20
> Output of dmesg:
>=20
> [  946.181961] Error opening lower file for lower_dentry [0xffff88008d5=
32180] and lower_mnt [0xffff8800bbf90f20]; rc =3D [-124]
> [  946.181973] ecryptfs_open: Error attempting to initialize the lower =
file for the dentry with name [/]; rc =3D [-124]
>=20
>=20
> See also [1]
> [0] https://www.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.4.14
> [1] http://www.linuxquestions.org/questions/slackware-14/can%27t-access=
-ecryptfs-with-kernel-4-4-14-a-4175583163/
>=20
> Regards,
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--Vq9DlUAmEh3jmOBk5JcrUVenuFJQuuC3V--

--BaNNG4S5JNeRuRxXX9pndDiQIcJDREKr9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXcXwwAAoJENaSAD2qAscKaJIQALEZFq3r9Kca1IIfykJ+9SgO
i9YSjeBvvV40TqTTIDVK24DNaJKj+MhgjaDYE8mqtky3OkfBByDTnSSzeHD3oGfd
uzKnwdWSlJFPu2xIGRiWBRgQXgUbil9kPSMh6Pje0U7WiK8ie4IvUkldqmsb9C1T
U23Oj9e/GNIMgOM8mXqoaNfxPLYVQYkr78mVQ7nNcKxImgi1TORo5wwwJoUjgWbb
J1422YDZ198/LGv8SMsBbNryT85HBko75YNpPdlCe5oqZurYNqUQSoLRXBY3YDN9
lGK/UFTaBgC3Xlm4BZYetx9wTbDORz1bOLZf2uClM0HSzrjkAnlONF3yV04DKhBc
lvaFRx5sDD3DA+j/h/7pxUTHXQ1V2ZoP+8aKbpR2J2IeFxoFEVyzTDhLfr2yd/Sy
XQYoOU/G81YdGxXEClRUj9IUerxyq/wa3ghDPAwAx+x3YN2iHAkMP+7pOjfAm4ba
06nc4+bQiD1Vfy23TYuUU3z7H0T1AKnOJNP9G7UelqE7fdktSSdfiRaaiJ9K8FaZ
4FqnTuYuCVVQVVWr5mbf2fqXH0ACfuiV9Gz0QbpsCqrJLAL9zMg+VuNQRQ/OMrtw
yMkMPlUMofkvUtdtXwXL3VIX1D9TGlbCmX1fD3vwhkOkwei/nYJmh1JkipoTWaa9
eLluainxJPKCRvj/uNmH
=WvfY
-----END PGP SIGNATURE-----

--BaNNG4S5JNeRuRxXX9pndDiQIcJDREKr9--
