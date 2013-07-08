From: Karl-Philipp Richter <krichter722@aol.de>
Subject: Re: Filesystem boundaries
Date: Mon, 08 Jul 2013 07:26:16 +0200
Message-ID: <51DA4D78.7040200@aol.de>
References: <51D6E23A.7000103@aol.de> <51DA1052.2060606@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FVJSFRWJSABRGNMESITG"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from omr-m04.mx.aol.com ([64.12.143.78]:42619 "EHLO
	omr-m04.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab3GHFd5 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 8 Jul 2013 01:33:57 -0400
In-Reply-To: <51DA1052.2060606@ubuntukylin.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FVJSFRWJSABRGNMESITG
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Li,
thanks for your answer. In this case I obviously have a problem: My /
drive has 30 GB capacity (Ubuntu takes 10 GB (outside the encypted ~)
max. My data is linked to ~ from /mnt/xy and ~ contains effectively less
than 500 MB, but ~/home/.ecryptfs has about 20 GB. Can you point me into
a direction how to debug this (I know that I'm on dev list where this
doesn't belong... I opened
http://askubuntu.com/questions/317391/how-to-prevent-ecryptfs-from-crossi=
ng-filesystem-boundaries)?

Greetings, Kalle

Am 08.07.2013 03:05, schrieb Li Wang:
> Are those subdirs basically symbol links to somewhere else not inside
> the eCryptfs dir? Then those dirs won't be encrypted by eCryptfs.
> For native subdirs, eCryptfs could not exclude them for being encrypted=
=2E
>
> On 07/05/2013 11:11 PM, Karl-Philipp Richter wrote:
>> Hi together,
>> I'm new to mailing list and hope to be at the right address. I tried t=
o
>> figure out how to prevent ecryptfs to cross file system borders or
>> exclude subdirectories of the source directory (the current setup is
>> that I linked a lot of directories from an encrypted disk, which don't=

>> need encryption). I guess it's explained somewhere. So I'd rather
>> suggest to put it on the man page.
>>
>> Greetings, Kalle
>>



------enig2FVJSFRWJSABRGNMESITG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR2k14AAoJEGadKJ8eJ7ZGt0gIALUSDtExtjYJOqpwfv/QHlsn
KiGEyeEOjOqIej7yjk7KFG9yXO+Trk8AZ1h6yus5dpwjCUrog31mxFVsaC8b9yhg
gxeDgDv4v+xuPvITLSe6w4IlUl6fRWHt248ZoKgmMIepvq0N/EsqmsnVuUDRhcCe
kT0fdrQy+AJvxERqvA3xHMlf+ZD0Xnaj2ANz0630w3bZRurPcmfA8NQGdOY/ReBg
xJOld2O9HvTqolAjt7IcB0uMZr4ngeNP0SkucOnKQwUOJB+dnrOM/NKxYwZsO/Sy
sO+G7CZ9kXUtXYxJ10ZntQ3uRGi0V2O4FiriVLVBdD/BJSuZK3CJ10M16leNw1c=
=dy2J
-----END PGP SIGNATURE-----

------enig2FVJSFRWJSABRGNMESITG--
