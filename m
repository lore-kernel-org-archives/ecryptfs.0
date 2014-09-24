From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Separating different ecryptfs mounts
Date: Wed, 24 Sep 2014 09:06:12 -0500
Message-ID: <20140924140612.GA19163@boyd>
References: <6009718.QGyqnh1K9Q@hp-stueble>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49050 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbaIXOGS (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 24 Sep 2014 10:06:18 -0400
Content-Disposition: inline
In-Reply-To: <6009718.QGyqnh1K9Q@hp-stueble>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Christian =?iso-8859-1?Q?St=FCble?= <stueble@sirrix.com>
Cc: ecryptfs@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-09-24 10:50:57, Christian St=FCble wrote:
> Hi,
>=20
> is it possible with ecryptfs to have two different ecryptfs mounts, e.g.,
>=20
> plain1 -> raw1
> plain2 -> raw2
>=20
> using two different openssl keys, and to ensure that each key is _only_
> used by its own mount? That is, I want to prevent that files copied betwe=
en=20
> raw1 and raw2 are automatically decrypted.=20

Everything above is doable except for the last part. Copying files
between two eCryptfs mount points will result in the file being
decrypted when copied out of the first mount and re-encrypted when copied
into the second mount point.

>=20
> To my understanding of the IBM paper about ecryptfs, it should be possibl=
e to=20
> set a policy defining which mount is allowed to use which key, but I coul=
d not=20
> find any documentation about it.=20

The policy feature described in the IBM paper was future thinking. It
has never been implemented and there are no near term plans to implement
it. I would be willing to accept patches that implement the feature.

Tyler

>=20
> When it is possible, can you explain or point me to some docs describing =
how I=20
> can do this?
>=20
> Thanks,
> Chris
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUIs/UAAoJENaSAD2qAscKE+4P/j7xkzUarars+fJtrAu/8WvZ
xlw4XiQgdG9KlYVLDWiehJpiMrdzioT9V5FIBvxckOESrHk104aOqpjtbad671Qx
TPrX6BeXiHfeLralTlqpkLK7r+vPQewhJZVixcLYiGVIdyXgrPJsVUogAifqyQwG
4j8T9xCXiQnzviVi0251UqD66YbY8H7FuSbXjEXClUgWKf9MzwDjkXjur8uOR3UY
+xcCY0oOa14PT4MkzN13JFU20TPS9QA2iY/XuOA4o2HiRAGyIunlFJpn9mbuuBU7
dV/Mz0jPvad1DZrJD2ix0SRAvP5YYtw6PuwY4PsXdtP8o5AHInWpBNnp0UjZtbtG
7ev0Ba09vrThG+YMTHTgB4+Ygk3oMD5qnSBInszIS7OOuG3svHGTHiLHQNPriznG
OIbwnxKOGaqnwME/CLfjQsm5TFm/43EBUAy2gKKhXIOuq4cOcJbQsd6bvCqH2rwh
CNAevbInC36La5KtUMaRlBfTeSnMtKNmbdNkSfm1JoaUGdPwbSicJZMaO7BATC/F
Zn7o7ARBRvzctcY975ZwRaVQ9CGNx67eKGuiQZBXsq1TCNXuhf8UUwxzOkDrPaOO
JVn/ZTx8UqyIyAmntGhGDxHi3b5888JaxxCN5YLTFnA/sKtW1hu5776rmVQlFN9Z
BYBkjl1RBvSaw20OdqL8
=chkW
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
