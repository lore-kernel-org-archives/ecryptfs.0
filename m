From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: bcrypt or other key derivation algorithm
Date: Tue, 19 Jan 2016 20:48:44 -0600
Message-ID: <20160120024844.GA5623@boyd>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
 <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57196 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbcATCst (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 19 Jan 2016 21:48:49 -0500
Content-Disposition: inline
In-Reply-To: <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Wiebe Cazemier <wiebe@halfgaar.net>
Cc: ecryptfs@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-01-18 11:51:36, Wiebe Cazemier wrote:
> Hi,=20
>=20
> What are the thoughts on implementing bcrypt as key derivation
> algorithm? I already found a TODO in the code that ecryptfs should
> support more algorithms than just SHA512 * 65536. I tried brute
> forcing this, and got no further than about 20/s, but on FPGAs/GPUs
> this would be a lot faster.

bcrypt would be a fine kdf.

> It should be easy enough to borrow code from OpenSSH, which uses
> bcrypt in their secure new private key file format (ssh-keygen -o;
> their old format is pretty weak (MD5 once, encrypt with AES 128)).
>=20
> Questions:
>=20
> 1) The v2 wrapped does not have a field to indicate which algorithm is
>    used (like /etc/shadow (crypt API) has). Does this necessitate a
>    v3, which does have said field?

Yes. The v2 wrapped passphrase format was intended to be the most simple
fix possible for CVE-2014-9687 in order to make backporting to stable
releases and transparent upgrades easy.

The thought was always that a v3 would be needed to support greater
algorithm agility.

> 2) Are there objections to including BSD licensed code from OpenSSH?

That bit of code looks like it is under the 4-clause BSD license. I
think that'll be a problem since the ecryptfs-utils project is GPLv2.

Can you reuse the crypt(3) interface, passing the "2a" ID for bcrypt?

Tyler

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWnvWMAAoJENaSAD2qAscKgOIP/jTCbqrkvPTm4NYqHqBPYPZH
C3OrNkGxYu1SG5HYqTl0rzdqBkvWGxckEGAMmuZrVnsl3njXnx5tqYvDdqYeIBEb
hQ+Jo5rdZxMOXmgawlD2m1gWBRHzpfeNSPdfmmBbBJplpjW9+yca54TrYQRgQf+F
3WL9wPW0wYDmD1J19CxYKnUchw1/77pgVmWF9hIJoLcmjuIjtVbtWBir9lWrSnBy
mctCvm7gEA+znaZMwT8YqmchWND1U7RjtWu+VS+RJhUeSDdHWKHCZvrBvYS7EtQp
haZ9Y0V4wIbibiUS8vPqZeRy+/5cKfIe/4jx+lxhInnkroC/KSHku713oXDD21j2
YoUKIXEqI6nvCFrhSPU5yOlf29f8+jXZUhFjWvcWblLSzdjDkxEAEhF1L7eIzYG+
4J41Q+bvYRXUlKOeUYHHyHZnB+SPWETMmrofS1Mp4JQZb7uzWv7aWZULla2RsWgR
QxJfNVHIgbCTO22kK1rHJ4tnolD0eMvNZ+yJF+gOhlEPCGj6kaUWfNSVakVGV2cg
Uwffifzea2c01tdM7p/Dfi9GfOwnu6GOaAVcs4St+jej5TMsrgTdNv9RHe8+gHWy
8ReZv47pnJ+m4PYuQeC0sFgzBGkEDes/HxyMWgqd5ow/wdiNF+h21m47lrELjpBQ
iPMqxxk5M1KL6tK+U8Ln
=ES01
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
