From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Fri, 1 Jul 2016 16:06:56 -0500
Message-ID: <5776DB70.5060006@canonical.com>
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
 <5771AD13.2010408@canonical.com> <57735047.1050706@canonical.com>
 <20160701221519.229e9e43@subnote.jensen.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9KIFVEuiPkaMsjfeScDP3HjmI2woblh3x"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53332 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbcGAVIV (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 1 Jul 2016 17:08:21 -0400
In-Reply-To: <20160701221519.229e9e43@subnote.jensen.local>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Henry Jensen <hjensen@gmx.de>
Cc: Kenneth Tan <gmane@way-of-the-blade.com>, ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9KIFVEuiPkaMsjfeScDP3HjmI2woblh3x
Content-Type: multipart/mixed; boundary="lXQRWuunDOaa4we6E9bhqbGkPq5TiIQns"
From: Tyler Hicks <tyhicks@canonical.com>
To: Henry Jensen <hjensen@gmx.de>
Cc: Kenneth Tan <gmane@way-of-the-blade.com>, ecryptfs@vger.kernel.org
Message-ID: <5776DB70.5060006@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
 <5771AD13.2010408@canonical.com> <57735047.1050706@canonical.com>
 <20160701221519.229e9e43@subnote.jensen.local>
In-Reply-To: <20160701221519.229e9e43@subnote.jensen.local>

--lXQRWuunDOaa4we6E9bhqbGkPq5TiIQns
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/01/2016 03:15 PM, Henry Jensen wrote:
> Hello Tyler
>=20
> On Tue, 28 Jun 2016 23:36:23 -0500
> Tyler Hicks <tyhicks@canonical.com> wrote:
>=20
>>> Thanks. The backported version of the patch needs to be adjusted. I'l=
l
>>> try to get a patch out the stable list tomorrow. =20
>>
>> I've sent a fix to the stable list (and cc'ed the ecryptfs list). I
>> tested on 4.4.y and 3.18.y on ext{2,3,4}, btrfs, and xfs. It should fi=
x
>> the regression that you hit.
>=20
>=20
> Sorry, the patch did not work for me. I am still getting error "Wrong
> medium type" wwhen accessing directories.
>=20

Hi Henry - Can you please double check that you're running the patched
kernel? I only ask that because I have a pretty high degree of
confidence that the patch fixes the issue due to the amount of testing
that I performed. I'm in the middle of rebuilding the linux-stable 4.4.y
kernel with that patch applied on top to retest. If you could double
check your environment in the meantime, I'd appreciate it.

If it turns out that you're still hitting the bug, I'll need reproducer
instructions as my tests don't seem to be sufficient. Thank you!

Tyler

>=20
> Regards,
>=20
> Henry
>=20



--lXQRWuunDOaa4we6E9bhqbGkPq5TiIQns--

--9KIFVEuiPkaMsjfeScDP3HjmI2woblh3x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXdttwAAoJENaSAD2qAscK3awQAL+WXqlSMx15fXEuQifKshvQ
v9W7gYhFXSL+9u0DnFrx4S0Ij8QD7UwIIRnON1csa4fA6jdxKDMD+tPSDGiVNYjZ
DrY4mgw7GxM0DQl3cuLyg8xbABv0GUyTgeBQTZapdpyEgZUzYr/EbfysdIpI9ZC2
qqH6uNEzTzL94EvpOtWLUYO0fvAxOpC9ylMaocZMQPWjRWh8NjLs2q/YY7YSgKAX
6NJuEe97wVagz46BMPWGMJ/4KcX0mNIbLiPThXdFRkirmmjtgKvTd7rtTKry4jGL
m9blAEf8e4BFEDytrbmlpndQ//pWvUroZfsxx6P0rN+SZR3uh41fo9W5arVXQrgC
RWOLPQ30H+Zi2HVmarRZgSlOeM1BOjwfVhzO5z/I5eEh8OZ3GOJFLudaHMXt9sxR
0LJ9gd84qSTr2bgm1StHt7RXZl5DbWWiddGAdqcq1r0+ylE37cP2ca0HKhZMYrXq
II8X9of+92HbqeBhglcF1B7kR5KsGNmkIwxiTdNfciEGzLM4M4I3HymGRq6P9YF1
zu6hgEZ/kI6vCOVZ/bRQ/yw7P77oR7V1/JUBAC5X4kUzMxkJM2ZuR6ql5ELibMN4
5E0QeIlAX7296vQqK91gy7WeyJwtAV7RH9dfoZC0e+wIDB1sRA3uDpkSPykUUxP5
4AIX/PCpG8QGZEph96Ze
=FvLh
-----END PGP SIGNATURE-----

--9KIFVEuiPkaMsjfeScDP3HjmI2woblh3x--
