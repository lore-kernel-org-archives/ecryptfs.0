From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Adding cipher mode as a mount option
Date: Mon, 20 May 2013 10:41:14 -0700
Message-ID: <20130520174113.GA6237@boyd>
References: <5196E30A.7040503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59164 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab3ETRlT (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 May 2013 13:41:19 -0400
Content-Disposition: inline
In-Reply-To: <5196E30A.7040503@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Will Morrison <camocrazed@gmail.com>
Cc: ecryptfs@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-05-17 22:10:18, Will Morrison wrote:
> As part of implementing GCM integrity checking for eCryptfs, we
> thought that a good first step would be to take the currently
> hardcoded mode (cbc) and turn it into a mount option. Once a
> filesystem can be created and mounted using arbitrary block modes, we
> can work on allowing integrity protection via GCM.
>=20
> This should also provide a solution to
> https://bugs.launchpad.net/ecryptfs/+bug/1176448
>=20
> Does this sound like a reasonable first step? If not, what issues are
> we missing?

Yes, it does sound like a reasonable first step.

However, we don't want users to be able to mount with *any* mode. We
only want them to be able to mount using a mode that eCryptfs supports.

So, the patch should include a whitelist of modes. The list will only
have one mode, CBC. Then when you add all of the backend support for
GCM in a future patch, you would also add GCM to the whitelist.


Note that this isn't something that I'd merge upstream without the
corresponding backend work to support GCM. This would probably be patch
1 of the larger patchset that adds GCM to eCryptfs.

> In addition, does anyone have tips on speeding up the
> develop/compile/test cycle?

Do you have any specific bottlenecks that are slowing you down?
Otherwise, I'll just be guessing at what you may be doing inefficiently.


One thing that I remember greatly speeding up my eCryptfs kernel
development time was to take advantage of eCryptfs being a module and
avoid rebuilding the entire kernel after making a change.

If all of your changes are local to fs/ecryptfs/ (which they should be
for this feature), then just rebuild the module:

$ make M=3Dfs/ecryptfs

Then, load the new module:

$ sudo insmod fs/ecryptfs/ecryptfs.ko

Now test your changes. No kernel rebuilds, no reboots (unless your
change causes a kernel oops ;), etc.

Automated testing should also speed up your development. The
ecryptfs-utils bzr tree has a test suite in tests/ (see tests/README).
Leverage that as much as possible. Adding a way to test multiple ciphers
and modes (AES-128 w/ CBC is currently hardcoded) when you submit your
GCM kernel patches will greatly speed up the time it takes to get your
patches upstream (because it will be taking the work off of me).

>=20
> -Will, on behalf Will, Zameer, Michael, and Alvin

Thanks for working on this feature!

Tyler

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRmmA5AAoJENaSAD2qAscK7RAQAKWmwKm2R5PcWw9mp1ayC8CW
Fny59pnsLqnBzrOhjwKwgErb3k8RKSaUUjnOSn62IcnC4dAOawjgLaBKfxN4SY1R
hH05DFApO8LMWJP5laf+fpMi0VBYx3TWzMIyuPFDBRNQ5g4Tfx8AOY6Gmj/7ZunD
NMaSHPYpCR/yY4CFEfA/ubAJnW2okVa8bzcLX9zfmv43uBwAhnDgiLcdOvH7pmeq
uiCfDrd2/Bv6fUhp8EuK3LrZwEZ0cc8phve86y/AC+iDXpO+nZA7Z3HIPHKR4N6t
yfbbU96ec3TaEq3CARv75u2ztMQIfY1562UVYCNlTfqqlrlSno0u1Lx+6Xgothvx
tg3eFHGTJuVtP7AbC6Un1+BVakI2tXz77CqNXPt+Olo5GNyJ2NbKIrkkJJeKXc5f
eeFZr4u+TbLmzUOw7zci6bI1BGfB0iPE39kp6UII8BfwGDOIb8bgx9YoJIVfNgQ2
I2ABPPmfqCu3In6cdNuQbBgKvpDEpd3OeBMbdPJ4duJVH6YdVxDW1P0mWMnViYqV
xSxztvScg1UQFnoWk3bq1TPq7BZ/bFobeFJkQdQOWyKER0XVAuMEVH1bBRB/GBqf
j5KeShMcBCW8JodiKJI6WwzPpDxnpdyfoxJqPSm8iKCQhSqdsYJmixn7z/4IVQbk
fy/I92zdK3/+GdN69jaG
=Z+Zb
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
