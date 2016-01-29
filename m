From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: bcrypt or other key derivation algorithm
Date: Fri, 29 Jan 2016 16:34:34 -0600
Message-ID: <20160129223434.GC15683@boyd>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
 <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
 <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com>
 <2036538347.232681.1453192534353.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39937 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbcA2Wej (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 29 Jan 2016 17:34:39 -0500
Content-Disposition: inline
In-Reply-To: <2036538347.232681.1453192534353.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Wiebe Cazemier <wiebe@halfgaar.net>
Cc: Sylvain Pelissier <sylvain.pelissier@gmail.com>, ecryptfs@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-01-19 09:35:34, Wiebe Cazemier wrote:
> ----- Original Message -----
> > From: "Sylvain Pelissier" <sylvain.pelissier@gmail.com>
> > To: "Wiebe Cazemier" <wiebe@halfgaar.net>
> > Cc: ecryptfs@vger.kernel.org
> > Sent: Monday, 18 January, 2016 12:00:36 PM
> > Subject: Re: bcrypt or other key derivation algorithm
> >=20
> > Hi,
> >=20
> > I think it is a good idea to support stronger algorithms. As a new
> > hashing algorithm, you can also consider Argon2 algorithm, the winner
> > of the Password hashing compettion (https://password-hashing.net/).
> > The implementation is already available:
> > https://github.com/p-h-c/phc-winner-argon2.
> > Reagrds
> >=20
> > Sylvain
>=20
> That's interesting. I wonder why nobody is talking about it. Bcrypt and s=
crypt are all the rage, and even those are not fully trusted by all, becaus=
e they haven't withstood the test of time.
>=20
> Question remains though, I can't implement it without knowing what to do =
with the v2 wrapped passphrase file. I can think of something myself, but I=
'd rather do something that I know won't be rejected :)
>=20
> From the source code:
>=20
>  * Reads a version 2 wrapped passphrase file containing the following for=
mat:
>  *
>  *   Octet  0:      A ':' character
>  *   Octet  1:      uint8_t value indicating file version (MUST be 0x02)
>  *   Octets 2-9:    Wrapping salt
>  *   Octets 10-25:  Signature of wrapping key (16 octets)
>  *   Octets 26-N1:  Variable length field containing the encrypted
>  *                  passphrase. (Up to 64 octets. Must be non-empty.)
>=20
> Would a v3 be in order?:
>=20
>  *   Octet  0:      A ':' character
>  *   Octet  1:      uint8_t value indicating file version (MUST be 0x03)
>  *   Octet  2:      uint8_t id of hashing algorithm.

Don't you mean KDF instead of hashing algorithm here? (scrypt, PBKDF2,
etc.)

>  *   Octets 3-10:   Wrapping salt
>  *   Octets 11-26:  Signature of wrapping key (16 octets)
>  *   Octets 27-N1:  Variable length field containing the encrypted
>  *                  passphrase. (Up to 64 octets. Must be non-empty.)

If octet 2 is KDF instead of hashing algorithm, octets 3-N1 are going
to vary based on the KDF used. For instance, scrypt will need to store
the values of N, r, and p while PBKDF2 will need to store the number of
iterations.

Tyler

>=20
>=20
> Regards,
>=20
> Wiebe
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWq+j6AAoJENaSAD2qAscKQ6YP/0fVZgFJ/NVjUSIEyfqjWwmM
R+Q5gUy7vQ5IYBPWLLf9g9aiuheLMTD7FZ6oQyZCSER0kfJWSlaUlm56JtKI5oF+
MM/KwyqvJWNKVLnJ5XJGBpagzH9v4Iwq3zcdLWrPg5cTk6cju/G/woSyjXvPxyho
ZiJbV0FYuLr14diFwKz2x8JaBREFyCxFknhLYrBOLKbyA1Vm99Aswnp4whcyTPlW
EwmP/f7QpZbiiUb98XWPiCDwEhJLUIziIWFyR8g/aR82p7r/9qy1Kq7u3ozYXfUB
E/ErwSDqdhvQ/Jah+99CKWs9TGG0m2csQ5bo+IUDI06i40sJWenxO8Yh5txeu4po
mRKkrSZtzA+9slUdiDmR/rP1H/4vXUu6K8ZdK86Y/ZBcWmyh4XM3akb/Cq5kkwr+
QWDfDzT7HDjfIglCqTyVaXcnvedUTm6xwhHE8jBJJoLOGK2z6J9tUInXd/uqbkdC
Rb4YXQHC5lpC2q/pKWXKm1U98JqTd/zCqaK30ODEh8tL1xyNMKjYue/X8hGr/Rlw
8/ATcN7rZVsRx3vkBMLJAHc7AUBeaTvR/C+8EOH96vX+JkdNin/NLz2ALUMfBGJa
qgunVyzvZFO0vJUvFkVaMrEwb3GC4pcCAvDY+JRn/n2ZNGrPlQ2KTtuR3SPIcTeh
dQe3sdudTgX9tG4uVV6Z
=4WWf
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
