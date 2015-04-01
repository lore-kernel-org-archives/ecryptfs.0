From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Way to decrypt an encrypted /home
Date: Wed, 1 Apr 2015 09:42:12 -0500
Message-ID: <20150401144211.GA11872@boyd>
References: <CAHTahaZZetDg8=X=G4rTRJJWJBRXrN4N1dK86kUqwOXXKhh7bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44765 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbbDAOmQ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 1 Apr 2015 10:42:16 -0400
Content-Disposition: inline
In-Reply-To: <CAHTahaZZetDg8=X=G4rTRJJWJBRXrN4N1dK86kUqwOXXKhh7bQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Marc de Verdelhan <mdeverdelhan@gmail.com>
Cc: ecryptfs@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-04-01 09:52:49, Marc de Verdelhan wrote:
> Hi there,

Hello! Sorry to hear about the trouble you're having.

>=20
> I made a huge mistake and I need some help.
>=20
> I was running Linux Mint 17 (based on Ubuntu 14.04) with an encrypted
> home directory (using eCryptfs). /home and / were on separated
> partitions.
> Last week I replaced Mint by Debian. I formatted the / partition and
> kept the /home one. Now I can't decrypt my data. :/

Did you record the randomly generated mount passphrase? After you set up
an encrypted home directory in Ubuntu, you receive a pop up dialogue box
informing you to record the mount passphrase and keep it somewhere safe.
If you followed that advice, we can save a lot of time debugging the
issue below.

Tyler

>=20
> So I installed the ecryptfs-utils package.
>=20
> "ecryptfs-mount-private" returns:
> Error: Unwrapping passphrase and inserting into the user session
> keyring failed [-5]
> Info: Check the system log for more information from libecryptfs
> ERROR: Your passphrase is incorrect
>=20
> "/var/log/syslog" contains:
> ecryptfs-insert-wrapped-passphrase-into-keyring: Incorrect wrapping
> key for file [/home/login/.ecryptfs/wrapped-passphrase]
> ecryptfs-insert-wrapped-passphrase-into-keyring: Error attempting to
> unwrap passphrase from file
> [/home/login/.ecryptfs/wrapped-passphrase]; rc =3D [-5]
>=20
> "ecryptfs-unwrap-passphrase
> /home/.ecryptfs/login/.ecryptfs/wrapped-passphrase" returns:
> Error: Unwrapping passphrase and inserting into the user session
> keyring failed [-5]
> Info: Check the system log for more information from libecryptfs
>=20
> To be sure I reinstalled the original Linux Mint on the / partition,
> using the same login:password as before my misfortune. Same results.
> I'm ABSOLUTELY sure that I'm using the same login and password than
> last week. I installed Linux Mint 17 on June 2014; the ecryptfs-utils
> version should have been "104-0ubuntu1".
>=20
> So questions are:
> 1) What happened? Did I erase a configuration file I shouldn't? I
> would like to understand what operation occurred to be in that
> unpleasant situation?
>=20
> 2) What are my options? It may involve some C development if needed.
> According to you, is there a way to brute force something? Or a more
> intelligent solution, starting with sit down, have a tea and think.
>=20
> Any help will be greatly appreciated. Thank you for reading.
>=20
> Marc
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVHAPDAAoJENaSAD2qAscKhywP/2rT9Fv8EHrEhttReQpovfzi
qtKE3UwyTPJv1DIFvE/tpedqhtsH1Au4+cqQ7ixIwmGso9ErZixhM60rWLRebJ9d
42JyDg14gv77uBi3vv8WKBS+OorgF/PWHuoORc2dqW9MDcSOMjSzbtw7gvIxp758
MgupSD0Zt7uYhEm0dKS4NMeKyTosBgfRJ5+BcOiTz9UqPFzleZQklcCAYmQFsc0G
RqFg+x0H1F61Iuq/FBEHweJzDbYlwEqkCyQV/swSaPu7ph0dbf1xXXCaO2RX/8KU
fo3iIOL0FekTeDsM4OlUkjTDGb0DEfWlEkgjkCCJYeNTx+B4QFMow/FCE0DKo8Er
iiGMDAb4tt84WaRw+IPerNVT3qU4AqVONFwMBb0HxK/sW0PFsjAoS7cFrpwMJphb
99zSvdUbyzk7oCmakh+2jBWM1QoerqxFUo08mSIzVsz7EAHFkAsiE/xA3YRcTiuJ
rHwbdHkSN3TUwojbwym5sCjtXRZqCNjC588BmDtRy2GRmwmq8HVucY2tvpOLsyrR
TUzkcatPsmm38ltjdDZB3XQ8mpIs1SiTtK6owQ3OcdDTwjRfN1D9fuVamcRk1oS/
CY08ihdzXa2wXs9zP+QzUno2RlKCutIslyou4xKVgsyfUMScGpyd5rJGmo91GjEP
IGAEceP9vq7ydUs/PKkE
=Aw7d
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
