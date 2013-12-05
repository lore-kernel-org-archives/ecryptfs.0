From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Looking for volunteers to test and review ecryptfs integration
 with Android
Date: Thu, 5 Dec 2013 10:38:07 -0800
Message-ID: <20131205183806.GC16300@boyd>
References: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38803 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082Ab3LESiL (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 5 Dec 2013 13:38:11 -0500
Content-Disposition: inline
In-Reply-To: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Catalin Ionita <io.catalin@gmail.com>
Cc: ecryptfs@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-12-05 19:32:11, Catalin Ionita wrote:
> Hi,

Hello!

>=20
> I've been working for some time on a solution to integrate ecryptfs
> in Android. Due to some Android specifics and license problems I had
> to rewrite the userspace tools.

I really wish these problems would have been brought up on this list.
Fragmentation of the utilities is a bad thing. There's already enough of
it in ecryptfs-utils (mount.ecryptfs vs mount.ecryptfs_private) but now
there's an entirely new package, too.

> Also, for a nice finish touch, I have
> implemented Android user data encryption from top (including a minimal
> GUI) to bottom on a Nexus 4 running latest AOSP kitkat.

Very cool. Looking forward to checking it out.

>=20
> I'm looking for volunteers to test, review or contribute to Android
> userspace tools that I've built. The project is stored at
> https://github.com/catalinionita/Ecryptfs-Tools-for-Android

First, I'd like to explore merging the two code bases. Can you lay out
the reasons for writing from scratch?

As the kernel maintainer, I don't expect to have the bandwidth to update
and test both utils packages when kernel changes occur. It would be
great if ecryptfs-utils and efs-tools lived in the same tree (and shared
the majority of their code).

Tyler

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSoMgOAAoJENaSAD2qAscKkuUP/28IvypAghIZArPHDf6x1LHG
HtOwpBABROV3ogrjCXh22oRkSlwdaZeeLHbBSUTKLxuw7vnP2fz/e7d0HdVs1Ch6
8j2v4uNIVmbgtr/pdBQNx0rovtPfyIspZnHGv++T5zrodHdrHg6T7BTdRqk1aMAj
vtopetJbntp6mBiokyXtJQP8LkBPUrv11EnqMDjq5Q4T9jXUr2f1hDk+Gu/7MvHY
WSOMqU0HTi9ETu22jL0CxT18Vs9k+4IoD6w09MWSPAv5tndFR3v7ISegA2+uvLUF
GP18tAudPgS8dq5LMvp2jDuDu7WRr75Z0h85bamHu1rIQ4J9Fysb/BGAfsCg1KrJ
yhKPZTZHXuE1BjPg1GjFO8QT0X62CwGXrpTazuS1QXuLcuVXt8myLDlTaD7AKYYR
zeESd1QO7ryUR1a1xpPVsaGh/XoNY/7uWtfS0C47Noowr0IU2xv3bwy0tH23DHd4
8A1OmIdq1Mzvvrks17Acaw5ez6Vf7eVwdjh5/yLwQJZDHCcf+3wl1nTQqQy06kcu
sqQXLNP57umKrOMHq9ifo2ZfBlJkGIKHeP2gaskZtuGHqow8WhYefZ8NFWgBtUeo
sNSZLEsijGb9VO96p5u0at6LQbJ8/BxOTuY01V4hE7SC+B0KX+jjP8ah6nBOVumQ
5gpe+Zbk9hHe0P7o5BiC
=dCeb
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
