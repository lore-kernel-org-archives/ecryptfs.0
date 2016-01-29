From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: bcrypt or other key derivation algorithm
Date: Fri, 29 Jan 2016 16:19:11 -0600
Message-ID: <20160129221911.GA15683@boyd>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
 <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
 <20160120024844.GA5623@boyd>
 <1009266489.234663.1453318409855.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39860 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbcA2WTP (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 29 Jan 2016 17:19:15 -0500
Content-Disposition: inline
In-Reply-To: <1009266489.234663.1453318409855.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Wiebe Cazemier <wiebe@halfgaar.net>
Cc: ecryptfs@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-01-20 20:33:29, Wiebe Cazemier wrote:
> ----- Original Message -----
> > From: "Tyler Hicks" <tyhicks@canonical.com>
> > To: "Wiebe Cazemier" <wiebe@halfgaar.net>
> > Cc: ecryptfs@vger.kernel.org
> > Sent: Wednesday, 20 January, 2016 3:48:44 AM
> > Subject: Re: bcrypt or other key derivation algorithm
> >=20
> > > It should be easy enough to borrow code from OpenSSH, which uses
> > > bcrypt in their secure new private key file format (ssh-keygen -o;
> > > their old format is pretty weak (MD5 once, encrypt with AES 128)).
> > >=20
> > > Questions:
> > >=20
> > > 1) The v2 wrapped does not have a field to indicate which algorithm is
> > >    used (like /etc/shadow (crypt API) has). Does this necessitate a
> > >    v3, which does have said field?
> >=20
> > Yes. The v2 wrapped passphrase format was intended to be the most simple
> > fix possible for CVE-2014-9687 in order to make backporting to stable
> > releases and transparent upgrades easy.
> >=20
> > The thought was always that a v3 would be needed to support greater
> > algorithm agility.
>=20
> Has there already been plans for the layout of v3? Is it as simple as my =
suggestion?
>=20
> The read_v2_wrapped_passphrase_file method could be renamed to read_v2plu=
s_wrapped_passphrase_file and use different offsets for v3.=20
>=20
> >=20
> > > 2) Are there objections to including BSD licensed code from OpenSSH?
> >=20
> > That bit of code looks like it is under the 4-clause BSD license. I
> > think that'll be a problem since the ecryptfs-utils project is GPLv2.
> >=20
> > Can you reuse the crypt(3) interface, passing the "2a" ID for bcrypt?
>=20
> The man page for crypt says:=20
>=20
>   2a | Blowfish (not in mainline glibc; added in some Linux distributions=
)".=20
>=20
> A Debian 5 system I still have says:
>=20
>   2a | Blowfish (on some Linux distributions)
>=20
> It's not as portable, apparently.
>=20
> Also, it's a little inconvenient that it returns an encoded string, not b=
ytes. But I guess that's convertable.

That is a bit unfortunate and could cause issues down the line if there
were any changes in encoding.

>=20
> I'll look a bit more for bcrypt code/libs.
>=20
> Is ecryptfs Linux only, BTW?

Yes, eCryptfs is Linux only.

Tyler

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWq+VfAAoJENaSAD2qAscKS+4P/R+lTBuE2nxbbmn7A4Y13dvw
CGYo1kH8YFXvtCAy0bhocascZsPR1Dqb4tI5/HWjjL+tpYL2ZkJZMolmewb1FcyS
qE/jTxTm49peAMmF47czZrztEe0vas8nhf0XaAIpv4ao4vViasSxZ8kY4F5q3WlW
T9p6wlJi7T2wcYXHHhO7v8nfFL9JRagm8I5XRIN57KEEzlx+3XbY7yZHLyUIabux
YKy6tCGeKM76dDC4GCA+XHII2oDV1mDhLddtNtMZSS0PTnlbInadMpeKXvkKVVd4
G9I8xc8Eh8WY43D0SUNIthYFlktUKWGeV7YwMx7e+5h5IdDIQp7+MUWcMZLl4FEU
xzafxRkMK6y4pt78N6sDb/3IDeR3m7GKTM+P7OLhwyo/bS8W0b5XUhQsi1137Xf/
bySWXVpDjEZz5ng6slvnm/7r5ILNf2NY8psLMsIwgAHEw52Dg9gNchrnCLDbk556
pAcG1mL7hraDUvo+qCIjEVtSywpyz+hmS8zQ2ixAmRQzvhYOD81xBs3jWeAuzaeY
hOlLQJGjQCGiBTkcnT46Pfo9dwqsJXGVL4mbCLwQdGkYBKt90/9jtvyJWG/PM78z
mvBjV4xamDALdH0XdtOhOJrwpZRtNVtnOlNu5onkkHyPNS/ERe8x4NEy2LDnK2Jp
1f5Jlsd4f3+QNumi/vZk
=zMF8
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
