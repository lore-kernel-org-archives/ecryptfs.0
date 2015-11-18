From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: An new, fast and "unbreakable" encryption algorithm
Date: Wed, 18 Nov 2015 12:27:00 -0600
Message-ID: <20151118182700.GA8640@boyd>
References: <CAFJyfaP4eOvMTMR0C5y5xj4qJG2gbcYo6_iZZCmxHvSZuY+cCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43467 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbKRS1F (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 18 Nov 2015 13:27:05 -0500
Content-Disposition: inline
In-Reply-To: <CAFJyfaP4eOvMTMR0C5y5xj4qJG2gbcYo6_iZZCmxHvSZuY+cCQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Ismail Kizir <ikizir@gmail.com>
Cc: ecryptfs@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-11-18 07:20:54, Ismail Kizir wrote:
> Hello,
>=20
> I've developed a new encryption algorithm, which dynamically changes
> the key according to plaintext and practically impossible to break. I
> also opened to public with MIT&GPL dual License.
> It is also quite fast; ~80% faster than the fastest mode of AES
> without cpu instruction set support.
> I will present a paper on a Turkish National Inet-tr 2015 Symposium on
> 3 December:
> It is a very simple and yet efficient logic. Anyone who looks at the
> self documented(in English) C code at
> http://ismail-kizir.blogspot.com/2015/11/hohha-dynamic-xor-algorithm-sour=
ce-code.html
>  may understand why and how it is unbreakable.
>=20
> I simply use the key as a jump table and, with every encrypted byte, I
> change the jump table(the key) as a result of 3-4 parameters including
> the last plaintext byte itself. Briefly, I encypt the plaintext with
> the key and also dynamically encrypt the key with the plaintext.
> The code is self documented in English.
> On Linux simply
> gcc HohhaDynamicXOR.c -O2 -Wall
> ./a.out
> will make integrity checks and print benchmarks. It is production ready.
> Other algorithm results are the output of the "openssl speed" command.
> If I am right; you will not be disappointed to include "Hohha Dynamic
> XOR Encryption Algorithm" on Linux Kernel.
>=20
> I will be glad to see my algorithm included in Linux distributions.

Hi Ismail - This is the development list for eCryptfs, which is an
encrypted filesystem in the Linux kernel. eCryptfs doesn't implement
crypto algorithms and simply reuses the Linux kernel's crypto API.

If you want your algorithm to be included in the kernel, you'll need to
discuss it on the linux-crypto list:

  http://vger.kernel.org/vger-lists.html#linux-crypto

Judging from the description above, I expect that it is premature to
include this algorithm in the kernel at this time. However, that
decision is not mine to be made. Good luck!

Tyler

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWTML0AAoJENaSAD2qAscKnNgQAI/4zMD3PTJwMSW1z1VSX6Qm
mJd75d/rcBfhjNmjxe3y6nHBxMRSq7BwltmZCOOUTh4n/xJ1sGqdbyZIdkHiofoW
wwbEq5k2uBgR+eexNV3uJOttONgwjqO70TJxc1z5lOMFyQvhQCwlrkoP16JGnzKl
8Ea8xuSchXN1nvmgMox1ZnQMCSCjPyslV4fJy8eq7pjcy+RbfnJTg6MQ6hqo7uA+
qgV4dUpJsXs5EW6wnBAyDvAcg6GSY6bMnx4xUcZd6rqxrmrIvSpTDr70e4zRMK0P
nSALQoUCg2uQ2LBQEuKoya9Nr5btFKhbpyhhPWlYs4U10yy0h5bFDrgWbTRYTUMN
/fwWz2ovhvrY/gJ/s9o4M0mWVLHuj7UVV5Ua+tHlQsPjtDisHrQP5elhd2xNuLKJ
NLKUQpZRJOlW/5jL8QPyiaG8P/oCX6eqzrypnHpMj+FurjVNfnDpOtJHZc1B9hHT
IkdoAhysD8tndms5Hlqc5Y/OruFO/yL84OUOXu2/GliEThGt9Y+/tr0Ps0RUdbSg
0tXDxyrF2RaEFmFtf6DGXhQMx4QTdOv2U1nt2zDYAGkFkUVALFaXozp95z3trjRi
mvdVymItVvOsDmWeyQFGiPF4TSVtKk9wSoRdwNjshRB/WZNmKnrhQj0bjDhZs78P
tBKZEljtv1A8esXBs04q
=FRzR
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
