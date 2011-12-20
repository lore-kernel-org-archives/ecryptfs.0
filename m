From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs_write_metadata: Error writing metadata out to lower
 file; rc = [-13]
Date: Mon, 19 Dec 2011 19:06:17 -0600
Message-ID: <20111220010617.GF14413@boyd>
References: <201112191326.20172.ms@teamix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45236 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab1LTBGW (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 20:06:22 -0500
Content-Disposition: inline
In-Reply-To: <201112191326.20172.ms@teamix.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Martin Steigerwald <ms@teamix.de>
Cc: ecryptfs@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2011-12-19 13:26:19, Martin Steigerwald wrote:
> Hi!
>=20
> Today I tested again whether ecryptfs would be suitable to replace encfs =
on my=20
> laptop. But I found several problems. The blocking one is:

Sorry, hopefully we can get them straightened out.

>=20
> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning#2> LANG=3DC make
> [=E2=80=A6]
> sed: couldn't open temporary file ./sedhqlAcd: Permission denied
> [=E2=80=A6]
>=20
> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> LANG=3DC ls -l=
 | tail=20
> -6
> ls: cannot access sedhqlAcd: No such file or directory
> ls: cannot access sedChky0a: No such file or directory
> ls: cannot access sed1eW8Ek: No such file or directory
> ls: cannot access sedEjR2oA: No such file or directory
> ls: cannot access sedb4JEiI: No such file or directory
> ls: cannot access sedy0KQnt: No such file or directory
> -?????????  ? ?  ?            ?            ? sedChky0a
> -?????????  ? ?  ?            ?            ? sedEjR2oA
> ----------  1 ms teamix 1143445 Dec  5 10:01 sedNL1bTk
> -?????????  ? ?  ?            ?            ? sedb4JEiI
> -?????????  ? ?  ?            ?            ? sedhqlAcd
> -?????????  ? ?  ?            ?            ? sedy0KQnt
>=20
>=20
> Output in dmesg is:
>=20
> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> sudo tail -2=
=20
> /var/log/syslog
> Dec 19 13:23:30 merkaba kernel: [50999.570071] ecryptfs_write_metadata: E=
rror=20
> writing metadata out to lower file; rc =3D [-13]
> Dec 19 13:23:30 merkaba kernel: [50999.570083] Error writing headers; rc =
=3D=20
> [-13]
>=20
>=20
> Ecryptfs is configured as follows:
>=20
> merkaba:~> cat .ecryptfsrc
> ecryptfs_unlink_sigs
> ecryptfs_sig=3D[=E2=80=A6]
> ecryptfs_fnek_sig=3D[=E2=80=A6]
> ecryptfs_xattr
> ecryptfs_key_bytes=3D32
> ecryptfs_cipher=3Daes
> ecryptfs_passthrough=3Dn
>=20
> I am using extended attributes to avoid the space waste of 8 KiB per file.

I must warn you that the ecryptfs_xattr_metadata option is rarely used
by anyone and gets little testing from me upstream. I understand the
desire to save some space, but you should also consider stability here.
I'm working to automate some of that testing soon, so there is hope that
things could get better in this area.

>=20
> The underlying filesystem is:
>=20
> merkaba:~> grep /home /proc/mounts
> /dev/mapper/merkaba-home /home ext4=20
> rw,noatime,user_xattr,acl,barrier=3D1,stripe=3D128,data=3Dordered 0 0
> /home/.ms /home/ms ecryptfs=20
> rw,relatime,ecryptfs_fnek_sig=3D[=E2=80=A6],ecryptfs_sig=3D[=E2=80=A6],ec=
ryptfs_cipher=3Daes,ecryptfs_key_bytes=3D32,ecryptfs_xattr_metadata,ecryptf=
s_unlink_sigs=20
> 0 0
>=20
> Kernel is:
>=20
> ms@merkaba:~> cat /proc/version
> Linux version 3.2.0-rc4-amd64 (Debian 3.2~rc4-1~experimental.1)=20

Ok, I was able to reproduce this on roughly the same kernel version by
untar'ing the kernel source.

I'll have to do some more investigation into how we can handle this
error better. ext4 is returning an error when we're trying to create the
xattr upon file creation, so how we convey that to userspace through the
creat() return value and how we clean up after ourselves is probably the
issue here.

Tyler

> (ben@decadent.org.uk) (gcc version 4.6.2 (Debian 4.6.2-5) ) #1 SMP Sun De=
c 4=20
> 18:38:24 UTC 2011
>=20
>=20
> With encfs or from my local workstation via NFS there is no such issue.
>=20
> Ciao,
> --=20
> Martin Steigerwald - teamix GmbH - http://www.teamix.de
> gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJO79+JAAoJENaSAD2qAscKj0YP/RvWcl70rlmQWgR4dvlzYZRh
ftMhbrrDGRkViT1dU4V+vcIghAuRmLAUD7csKJVfnx7tGM0HeeMBIZdRGkS1vTVo
OhIeVkudFq5UOBu5k0kuBxnB6NUoLT+zAALwuIXlBb3iohdSOhfGXGFDlqR5HZ7K
7vBLgTdWRHCrIZJc6O16JDLb8DzV22udiTS5Z28mYAoq86vgXIi0jTPE6gRIJaJh
UTUCeCtFmxQeS0JbBF9aQ5fU+6qYIsc6r7RrJyW7u1VpkOvWfB8msuJqBhvLnzx5
VK8j2UMRpwbGC2da05Q0wYLr8ooqXkUh/EGpCGzC94h2kxJuTrYYwB8GpWBaf7RA
Gfa6bLRRNoDdxIiMbSWkHYM8adsc2Q/ON7nKijif8XUXRtdq7rta7vK/LZEgFIBp
fpz0ywWVjsfngdVoFnXI8RfEn303Ig5h8nATawWg926QubXvHr+97l5Ww+T8RgUi
DGezeP6/gq2CkRsm1bz+fYqEg/VegxtKcARwfjiuNPIOqkejtQyuDo4nkuKQXAlW
zJhojRbCZyyZdDPoQ/96dsW/wBCEJSc9UXe8OB7zGjcQtvU+2+ZjJwX3xn2kO634
sck5G1QWxUC2dNlxxFUMQQfc4ORhNvtV9suGFYP0X2xJfgyUkcMwalEXWQREDxJW
0FTiUhqfgCo1zwHd+2/2
=BsFU
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
