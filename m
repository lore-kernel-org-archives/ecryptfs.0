From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: hardware acceleration
Date: Tue, 23 Sep 2014 10:45:10 -0500
Message-ID: <20140923154509.GA7673@boyd>
References: <20140923161329.Horde.JgatAND6UQ5UIYAJzVa0rtA@webmail.ugent.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42997 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478AbaIWPpO (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 23 Sep 2014 11:45:14 -0400
Content-Disposition: inline
In-Reply-To: <20140923161329.Horde.JgatAND6UQ5UIYAJzVa0rtA@webmail.ugent.be>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
Cc: ecryptfs@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-09-23 16:13:29, Kenneth Waegeman wrote:
> Hi,
>=20
> I've read that ecryptfs supports hardware acceleration, but I don't find =
how
> to enable this or check if it is working.

This is all handled by the kernel crypto API. Users (you) and kernel
crypto API consumers (eCryptfs) are not expected to do anything to
enable hardware acceleration. The crypto API makes the decision of
whether your hardware supports acceleration and if it should be used.

I don't know of an easy way to check if it is enabled. What I would
suggest doing would be:

1) Set up your eCryptfs mount
   - This will result in eCryptfs autoloading the crypto drivers
2) Look at /proc/crypto
   - Look at all entries with the name "cbc(aes)"
   - Now compare the "priority" fields for each of those entries
   - If the highest priority entry's driver field is "cbc-aes-aesni",
     eCryptfs should be using the AES-NI driver

> How can I find out which cyphers are supported, and how can I see if it
> actually uses the hardware acceleration?

Loaded crypto modules are described in /proc/crypto. You'll need to load
any kernel crypto modules that are not loaded before they're described
in /proc/crypto.

Tyler

>=20
> Thanks again!!
>=20
> Kenneth
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUIZWFAAoJENaSAD2qAscKSqQQAK62fhzaBAasbfvGAQn0PDy0
y0dMjOur2noLnYc5qlBsoCJhIzqWS3LzcGw8fSdxX6NbTzYW7SKyE38YQ+mhevin
M3R+6eKuSpxrY+TrQKa/TTz7knW6fDtRm0AVOkKmIjaj9stlFiVBb0On5GE4ZZy8
0iOid+51TJ0oSeqm0s2Iu7Jz/kdOjtMxiNENU/1MEg4400sHWXMqhORNquYnIKtT
tDJaJC4dvBjuYlkFwbhxoR3E3MPQh1NaFJ5p9VcMR2+exRbhZC+aQJUYWY20NZu9
40ZJUtmOuvd4xIZ2YNR8hRYLl0TzP4sqzCIcPME6JhIZlhWhdFFQwuKLRbBWQ0oW
rhCdgPvJAt/AEy2yNUocxyeOVN9OT9H2dpJyBmdYy67PlVcgd26G5m/tBadg4mEn
RzWMs28WX2gq8MVQ0+Xhj/fuFShl6pt+gWjoRHfGGFztfsWSieG+uICxTjvF6/N9
x7y+8ca4HdqX0X8l09iJQTWr7ksGAcQeSmjLe+h0FnAMFEwn8AeIwdacj732QWw6
0O/wqRVWF1mmaLkcqUpiWDYxhQf7XNKV1DliJtoyYmSHql/kJC/ydGNbk5nAcEWJ
nfb4+t4WS97M732I/2fksjgKdxvqMfBKt1pxyJFI8fQDwsPVHpuo5ookEgMAFm88
wAgiSjuIZFnHDKXOwL9q
=CJXp
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
