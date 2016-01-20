From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Key derivation and passprhase wrapping
Date: Tue, 19 Jan 2016 21:05:57 -0600
Message-ID: <20160120030556.GC5623@boyd>
References: <794484591.224591.1452104561446.JavaMail.zimbra@halfgaar.net>
 <676716416.231851.1453112857325.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57265 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933613AbcATDGB (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 19 Jan 2016 22:06:01 -0500
Content-Disposition: inline
In-Reply-To: <676716416.231851.1453112857325.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Wiebe Cazemier <wiebe@halfgaar.net>
Cc: ecryptfs@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-01-18 11:27:37, Wiebe Cazemier wrote:
> Hi,=20
>=20
> I was looking at the ecryptfs source code, and saw that the actual
> encryption key inserted into the kernel keyring is the *original*
> wrapped passphrase, SHA512'ed 65536 times. Why is a user-given
> passphrase encrypted as key, and not data from /dev/random?

This assumes that the mount.ecryptfs helper is used and not the
mount.ecryptfs_private helper.

mount.ecryptfs does key stretching (SHA512 * 65536) on a user-provided
passphrase and uses that as the file encryption key encryption key
(FEKEK). This keeps things simple so that the only thing a user needs to
access their encrypted files is the passphrase. There's no chance of
losing track of a file containing a wrapped FEKEK that is randomly
generated. However, mount.ecryptfs could be extended to make use of
wrapped, randomly generated FEKEK which would provide a more secure
option.

> I unwrapped the passphrase on my Linux Mint system and saw it is
> actually a random string, so the Ubuntu/Mint installer took care of it
> for me. But why is that responsibility given to the user / outside
> world?

All of the logic that set up that random FEKEK is in upstream
ecryptfs-utils. The confusion is probably caused by the unfortunate
split between the mount.ecryptfs and mount.ecryptfs_private helpers.

> One of the problems is that I can't change it. Had I made a
> ecryptfs archive myself and wrapped 'hello' as passphrase, that weak
> key will be used and cannot be changed by rewrapping.
>=20
> Would it be possible/feasible to do something like:
>=20
> * generate random encryption key A for insertion into kernel keyring.
> * derive encryption key B from password with 'generate_passphrase_sig(...=
)' to encrypt key A.
> * In v2 wrapped passphrase file, Octets 26-N1, store encrypted A, instead=
 of encrypted passphrase.

I'm not following the intent here. You're wanting to change the FEKEK
that the Ubuntu/Mint installer generated?

Tyler

>=20
> Depending on how it's implemented, it could even be done completely backw=
ards compatible (by ignoring the to-wrap passphrase).
>=20
> Regards,
>=20
> Wiebe
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWnvmUAAoJENaSAD2qAscK4H4P+gJw/+dwA6JEPPVYQVtnP0GD
Nk0K/MIxHGNFM7fUkl1StQkWM1NIDI76aOxD24A3vMHZnGcjDGbt/8NWSgTPNuDq
gwZQf6kzvKFHpfAl+Qq9EZO5aM6dNwLMepSFdmfRiQxJ3rOQhu9KX75COUVIhro4
Sfzf+nTGoYxUPtuYMzAFz4Q2RfK4TUJ8kr+j6IuFdpNkGkHff4Ymw3QAFD3No/zg
gIJvON5DXbvWwtkB9Ifmk7nQVFOOAG/FtRUAF5cf9UX8lqw5Ea0LpvzclTpCnOt7
g9FSOX5hqqAYmLOfYlZsui++5+dLZF+fmt5mfvFh+X/N81S2smr+koKIhd5gaoJX
cL6yidcKwGfpTldmIpaA1QJpTeZ2J89Rk2kPNrFYuDc0GAsqQXqXt5pd3FRHRSf3
QTrLhCYhy6sS1gJGbM6IsqDY+FDwP0bG6VstaaaQyOdkl4BYzyncuos3gcDoykef
yPhK8wsnUfzdUYArI6bCoVFZRgcGJqPXRFuJzNOVBKlmSc6uDLTGKbeO+jZb2R9Z
C93Bom6EWyl7uKMGG2UvgzbK1T6RZAE6CK31giRRAmdyG8BndjZuIWXdBYW9aND8
FZbzPoHekjyK9jHYm++2moxpAFkCZrNXM3BWKtoKZdA2jgzt/VjA9FjfWqD3Flb7
+c10dqZ93hQ2XpQkNGcp
=KXv4
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
