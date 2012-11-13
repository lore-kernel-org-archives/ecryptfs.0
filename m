From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [3.0.y, 3.2.y, 3.4.y] Re: ecryptfs: corrupted files on a disk
 full event
Date: Tue, 13 Nov 2012 20:15:22 +0000
Message-ID: <1352837722.16264.105.camel@deadeye.wl.decadent.org.uk>
References: <20121009173522.5563.81022.reportbug@klapprechner>
	 <20121009193342.GA3993@elie.Belkin> <1349874250.6874.6.camel@klapprechner>
	 <20121010213203.GC4517@elie.Belkin>
	 <20121112195606.GF3342@herton-Z68MA-D2H-B3>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-eVkDfCqmu0fY+8lyQwTK"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51091 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755512Ab2KMUPc (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 13 Nov 2012 15:15:32 -0500
In-Reply-To: <20121112195606.GF3342@herton-Z68MA-D2H-B3>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, stable@vger.kernel.org, Sebastian Heinlein <devel@glatzor.de>, Tyler Hicks <tyhicks@canonical.com>, Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org


--=-eVkDfCqmu0fY+8lyQwTK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-11-12 at 17:56 -0200, Herton Ronaldo Krzesinski wrote:
> On Wed, Oct 10, 2012 at 02:32:03PM -0700, Jonathan Nieder wrote:
> > Hi Ben and Greg,
> >=20
> > Please consider
> >=20
> >   8bc2d3cf6129 eCryptfs: Unlink lower inode when ecryptfs_create() fail=
s
> >   e3ccaa976120 eCryptfs: Initialize empty lower files when opening them
> >   821f7494a776 eCryptfs: Revert to a writethrough cache model
> >   7149f2558d5b eCryptfs: Write out all dirty pages just before releasin=
g the
> >                lower file
> >   64e6651dcc10 eCryptfs: Call lower ->flush() from ecryptfs_flush()
>=20
> What about also picking the following two for stables?
>=20
> 069ddcda37b2cf5bb4b6031a944c0e9359213262
> eCryptfs: Copy up POSIX ACL and read-only flags from lower mount
>=20
> 5f5b331d5c21228a6519dcb793fc1629646c51a6
> eCryptfs: check for eCryptfs cipher support at mount
[...]

Added to the queue for 3.2, thanks.

Ben.

--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.

--=-eVkDfCqmu0fY+8lyQwTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUKKqWue/yOyVhhEJAQp8KhAAgZN0N2rosaizwF/IUmkr4cZr0nLHYjnx
/EGcMB68QUO6SW8iRjKbUUSYsBBHkytjkQfufWkeqwPa/Qs4mjZXwc6bPYpWlTfk
HOjQExKPnMEkY/196+5dEpOgvB2Vvd5P0QEIUCIzOgZ2r6L1BV6XgH/cbpCNbF5/
YIhLUKwN5c+IMLJwaze5HjQHYNCwh1oLm6jEQMeVAgOADrKXUDHpS2/5hHq5Aw+2
25R+zpVR0IJTOhA87sjnRQetgZY1kI2nDLMR9ynKzIRFD5sqhcIIqH/pGfQusDWe
8cH1z0o49HIoa/9Q6Ot9lM1BcXD9SlyJzYA4842NCilCL1z9oES2QMerk1np6hDj
Ty2/4sm5Q5pbdaQMLWc3YiZiLAaHlaFLdSuZEtDoJqa5LBNSQ123vqotiRV7iyH/
7HAV6Kgd7AAGvOw5kCJt5DolupJToNmPcIatRUKX9h3f5fLHHdWB9hFaFOd6291G
yg1kE19ADZtSjBB3Zq0pGrY6cLZMrPJkXePM21MA1OwWE18Bh23/8SBNlEuLQMu9
pzqP0r8BKoRG6liXxLXTrCuXXiC1Io8eYdbe6vU3Cfd/LbwpPtbGm4i9vNb0sh5Q
FqaHJXEKLdM2ND1N4S073HFNvf6pemDcd99xt7WXCtWfLKAeKeJ+3b2ZA9I2cVCQ
M9ach8ax1Js=
=jVo4
-----END PGP SIGNATURE-----

--=-eVkDfCqmu0fY+8lyQwTK--
