From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs / aladdin token
Date: Tue, 17 Jan 2012 12:53:16 -0600
Message-ID: <20120117185315.GB8155@boyd>
References: <4F15A514.8050106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47281 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716Ab2AQSxW (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Jan 2012 13:53:22 -0500
Content-Disposition: inline
In-Reply-To: <4F15A514.8050106@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Space Cake <spacecakex@gmail.com>
Cc: ecryptfs@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-01-17 17:43:00, Space Cake wrote:
> Hi,
>=20
> I'm trying to use an aladdin token to access some sensitive information.
> Unfortunately I'm getting the following error message
>=20
> vlad@brutal ~ $ ecryptfs-manager
>=20
> eCryptfs key management menu
> -------------------------------
>     1. Add passphrase key to keyring
>     2. Add public key to keyring
>     3. Generate new public/private keypair
>     4. Exit
>=20
> Make selection: 2
> [opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
> failed: 0x8010002e
> [opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
> No readers found
> Select key type to use for newly created files:
>  1) tspi
>  2) passphrase
>  3) openssl
>  4) pkcs11-helper
> Selection: 4
> [opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
> failed: 0x8010002e
> [opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
> No readers found
> [opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
> failed: 0x8010002e
> [opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
> No readers found
> PKCS#11 Serialized ID:
> Passphrase (empty for interactive):
> Optional X.509 Certificate PEM file:
> Error processing key generation decision graph; rc =3D [-5]
>=20
> I can see the card from pkcs11-tool
>=20
> vlad@brutal ~ $ pkcs11-tool -L
> [opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
> failed: 0x8010002e
> [opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
> No readers found
> [opensc-pkcs11] reader-pcsc.c:896:pcsc_detect_readers: SCardListReaders
> failed: 0x8010002e
> [opensc-pkcs11] reader-pcsc.c:1015:pcsc_detect_readers: returning with:
> No readers found
> Available slots:
> Slot 0           Aladdin eToken PRO
>   token label:   OpenSC Card (vlad)
>   token manuf:   OpenSC Project
>   token model:   PKCS#15
>   token flags:   login required, PIN initialized, token initialized
>   serial num  :  262119072909
>=20
> any idea? same token is working for ssh login

It is likely a bug with the eCryptfs pkcs11-helper key module. It
doesn't get much use and neither of us eCryptfs maintainers have the
appropriate hardware to test it (it was contributed by the pkcs11-helper
maintainer, IIRC).

Feel free to file a bug in launchpad:

https://bugs.launchpad.net/ecryptfs/+filebug

But do keep in mind that we don't have the needed hardware to fix it.
I've looked into buying an eToken PRO for personal use, but sourcing
just one in the US didn't seem to be very easy at the time.

Tyler

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJPFcObAAoJENaSAD2qAscKofsQAI1Qqw5JSYdyE1/Gn+etGHzj
y5r0SgmCFj1GdcVrhfXc4RaOPbr2tIv9YuhZo9AwZRn9qS5ycqga37BKgnCQVqnw
J/1tkLktO+F2mCndXBEjr2pGY0fbPvnF23MXH87dIro2AthRVyRFDNBm4KOTC9oV
L4GDxNtZv2lHt2OHuG7Cf29LDqIQgmFxkOiHVswsN9yFC+hgOQ/VN/UjLQmigbmW
w4e/bgsECKWTR+l7XO0QKDFBKQa6NOXIngcNm7FpC7pZMiXQSjkUkiOuLcTtbZ8z
a9Bh2Q5EWQsE4Rr8PeGFcuHHNYzMkXwb+WMyK+ABBx/70MbQKO4wqFCzZx6Ec69T
r8Hxz3xLgYH+fpSftb63Nrtulm6+XD6amgR0FBGJ7Ap0j2S9VMotiPhFR3fNOHXk
akkoic8z1PeJVfqlUdPLTo97uTSflT1cFs5rl3ArsdMPYMjFKpC8gre09oHG2S93
QiCUOklrdVFOOlzJhnoHduLHLaT+3+fUxFm960bWij3kmy8Y26U5PjDsc0fxj79i
NLQTehli4vH+/gzfrEiBY8ZTgZMjuDulyVeBU3Gu5k6xluIoevl5Asm/UmHXPiu1
qkzeOQtUCfwc83oRDuwd0akeyneJXLWAogVYbM9XuupAsPiJ7ByuI4z7liHt3rVC
B+NVGJTvuDGIY2xiWPYY
=vf1D
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
