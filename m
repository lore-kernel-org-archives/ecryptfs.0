From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: bcrypt or other key derivation algorithm
Date: Tue, 19 Jan 2016 20:54:42 -0600
Message-ID: <20160120025442.GB5623@boyd>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
 <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
 <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57221 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbcATCyq (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 19 Jan 2016 21:54:46 -0500
Content-Disposition: inline
In-Reply-To: <CAOkUe-DgVJ6DPaL0UnTM7T1FzDEvWV6_HwsSvVDVTj5F_JW6vg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Sylvain Pelissier <sylvain.pelissier@gmail.com>
Cc: Wiebe Cazemier <wiebe@halfgaar.net>, ecryptfs@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While it would be nice in some ways to be on the cutting edge of things,
I'd prefer to stick with something more widely used today (bcrypt,
scrypt, PBKDF2) while ensuring that the design allows for easily
extending to something like argon2.

Tyler

On 2016-01-18 12:00:36, Sylvain Pelissier wrote:
> Hi,
>=20
> I think it is a good idea to support stronger algorithms. As a new
> hashing algorithm, you can also consider Argon2 algorithm, the winner
> of the Password hashing compettion (https://password-hashing.net/).
> The implementation is already available:
> https://github.com/p-h-c/phc-winner-argon2.
> Reagrds
>=20
> Sylvain
>=20
> On 18 January 2016 at 11:51, Wiebe Cazemier <wiebe@halfgaar.net> wrote:
> > Hi,
> >
> > What are the thoughts on implementing bcrypt as key derivation algorith=
m? I already found a TODO in the code that ecryptfs should support more alg=
orithms than just SHA512 * 65536. I tried brute forcing this, and got no fu=
rther than about 20/s, but on FPGAs/GPUs this would be a lot faster.
> >
> > It should be easy enough to borrow code from OpenSSH, which uses bcrypt=
 in their secure new private key file format (ssh-keygen -o; their old form=
at is pretty weak (MD5 once, encrypt with AES 128)).
> >
> > Questions:
> >
> > 1) The v2 wrapped does not have a field to indicate which algorithm is =
used (like /etc/shadow (crypt API) has). Does this necessitate a v3, which =
does have said field?
> >
> > 2) Are there objections to including BSD licensed code from OpenSSH?
> >
> > Regards,
> >
> > Wiebe
> > --
> > To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWnvbxAAoJENaSAD2qAscK4MsQAMfVJhZ5Ygc/RuZzw/XlmqFE
YoJfig4WFKnOtMS6Aoqn0XR6wrPZQhY9YbFY4kHFPH7ewQtzqkV0ihebe7xUXst9
8WrpbkJ+oRtoqpTtlKGyasA3ZzPjf8+YbTIMI6sYBJgaK+mhrYuDMLWy0l0fSBR9
j6SW0bgAXda7Lu9CtU6U6pesBZ6Ivh6i4yC1m8IHt9ENiy2K+vB7HWZJvy/C/MuO
9OhN/3ZXOKtnHizBQVHVyDLBk0lBMia82pX2MOsaZe5SyS4f9EwPMZCmykGF0+ex
khLrmaQJyfWhOWR82NQ2VYR/wM2tAy4GuenJyBvAE+mRGncRXO+Q6NYyzFR5Kl/a
BfapNa4FcpAr4JD0C0FDXvW+QRF1Nq98j063ZcjLYYu5sikUuLAt0OJQ8cs73vwh
XBW8LZUvhH21LriUuZbF6DMSF3BiFAaAnIrcnqq4t1ObBF3pcLpV299tVecIWV4S
9KH/yNqBImErpS6C6xvTqTx6oLlR69rCUe2YhW+qYjsqSHh9eRcbZH4PffIL3/mS
tG2eOXk1nuMdHxOIA0sxzLgoKh0TsQy1D5zRpvRrYx4dUi1xz+Z02JBjz6kViS77
80baNWIeN9eQN2uyjvAePD6f0WpLH81tnbjxF7jQPYDB+NKvXOV9fuenPqIoaTwV
NoPGbk6xNNGuevzpMKqp
=t19u
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
