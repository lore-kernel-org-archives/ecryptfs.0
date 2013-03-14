From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Will there be a multi CPU core version of eCryptfs?
Date: Thu, 14 Mar 2013 09:26:53 -0700
Message-ID: <20130314162652.GA24036@boyd>
References: <loom.20130314T111312-931@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54082 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab3CNQ07 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 14 Mar 2013 12:26:59 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130314T111312-931@post.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Michael Schneider <michael8schneider@gmail.com>
Cc: ecryptfs@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-03-14 10:53:54, Michael Schneider wrote:
> Hello,

Hi Michael

>=20
> When using eCryptfs on a low end devices like NASs,=20
> the CPU is often limiting the performance of reading/writing dramatically
> because of the intense cryptographic workload.
>=20
> I know that using cryptography on such systems is always a trade off,
>  but I ask myself about a possible optimization which would help very muc=
h:
>=20
> On my NAS the throughput with eCryptfs drops by about 70%=20

Drops ~70% in comparison to what?

> (Synology DS412+, Atom D2700 - 2 Cores, Hyperthreading).
>=20
> For non-encrypted operation the CPU nearly idles, when using eCryptfs
> its at about 25% load. I assume that only one of the possible
> four parallel CPU threads are used.=20
>=20
> My question is "Will there be a multi CPU core version?" which would impr=
ove
> performance on low powered CPUs.

Possibly. Myself and others are currently looking into ways to increase
eCryptfs performance. There's an opportunity to spread out the work
across multiple cores while doing that and it is something that is being
taken into consideration.

>=20
> I don't know, if this is the right place to ask, but it would be great
> if any of the developers could give me feedback if this will be possible
> in the future - crossing fingers :)

You found the right place. Sit tight for a bit and maybe kernel 3.10
will have what you're wanting. Thanks for the question.

Tyler

>=20
> Thanks.
>=20
> Best regards,
> Michael
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRQfpMAAoJENaSAD2qAscKARwP/2/ZrALTqkRFrHdztN/2Sj50
c1Iqa9qNJ3RuufBSQQsoQJ7RhnfP3ngAx+ivrYVB4ZCPIN/eaS6x4CuMcrxXIr/S
mBHwYX+gXhKbHWgZ6mD1SM7MNjInlnbyVf3o3UKLe47HXOR0UqoqeU0Ypr2OAeWz
AEof6GhFJMiLVFPZqsYtZg8RVtE2zDksK5gbgtehB0audDZuRc4gu1kX4HyVDvBP
huw1qafLsI5eRqZc4R09xEj1xml+WWQN1Dv3hj7gVB8UlkdzAXR2/8LstfGVeuMD
SUJEMxgRqfCPkUnNXB5Zz4/2d+hpzOD6zyXMzU6a0C4cZ7e9K+1O6z2NXH977nOm
waKT3EYhpFGCZue1qKSh3rCw3GueNW/2R5nPNLqA4R+OlbJ3utxPsu+RJ0tPnNuM
BHL/6DqLVNhz6t954GxlUs/jkFHcpEQnlpl30GpOBSzVheyBwldJ/gClpt1d/Bg9
5JgKpI9h3xTbutb2K5XgfDcLho9vMPe7YSrlfoN45SUvPtKq3rwEcKhEG8nJ/N+A
/ANJRBVXk9pKXGkZNCqk8LEkWQcPwa5/BHWdoZNZ757kXBizgHcNKIQgpFqYJupO
IDx8fDmDPrSgCzYbVIOt5f/nr13IIhI1UK2vUwjjnVYjfyGqfWeJF8t+4vvNpUw/
o1cbmqsX+s7Xj/TuFr5q
=4mwf
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
