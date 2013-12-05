From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Looking for volunteers to test and review ecryptfs integration
 with Android
Date: Thu, 5 Dec 2013 11:11:08 -0800
Message-ID: <20131205191108.GD16300@boyd>
References: <CAGE04zTe4VP_hDju9E9m8ONbTPZyv_pZ=9CPkd5Ke8aOK9Ddyg@mail.gmail.com>
 <20131205183806.GC16300@boyd>
 <CAFftDdqtPGrMZOTj6DXi4fS6t8Jmf=B42JGFwtAV7aLvmov9cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38971 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab3LETLN (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 5 Dec 2013 14:11:13 -0500
Content-Disposition: inline
In-Reply-To: <CAFftDdqtPGrMZOTj6DXi4fS6t8Jmf=B42JGFwtAV7aLvmov9cA@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Catalin Ionita <io.catalin@gmail.com>, ecryptfs@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-12-05 10:57:27, William Roberts wrote:
> On Thu, Dec 5, 2013 at 10:38 AM, Tyler Hicks <tyhicks@canonical.com> wrot=
e:
> > On 2013-12-05 19:32:11, Catalin Ionita wrote:
> >> Hi,
> >
> > Hello!
> >
> >>
> >> I've been working for some time on a solution to integrate ecryptfs
> >> in Android. Due to some Android specifics and license problems I had
> >> to rewrite the userspace tools.
> >
> > I really wish these problems would have been brought up on this list.
> > Fragmentation of the utilities is a bad thing. There's already enough of
> > it in ecryptfs-utils (mount.ecryptfs vs mount.ecryptfs_private) but now
> > there's an entirely new package, too.
> >
> >> Also, for a nice finish touch, I have
> >> implemented Android user data encryption from top (including a minimal
> >> GUI) to bottom on a Nexus 4 running latest AOSP kitkat.
> >
> > Very cool. Looking forward to checking it out.
> >
> >>
> >> I'm looking for volunteers to test, review or contribute to Android
> >> userspace tools that I've built. The project is stored at
> >> https://github.com/catalinionita/Ecryptfs-Tools-for-Android
> >
> > First, I'd like to explore merging the two code bases. Can you lay out
> > the reasons for writing from scratch?
>=20
> If he is looking to upstream it, Google prefers things under Apache
> 2.0. However,
> this doesn't mean that other licenses are instantly a no either. For
> example, checkpolicy.

efs-tools, like ecryptfs-utils, is building against the LGPL-ed
libkeyutils.

It would obviously take some more thought, but it is possible for
ecryptfs-utils to provide an LGPL'ed library that all eCryptfs user
space utilities could use.

libecryptfs was supposed to be exactly that, but it was unfortunately
licensed as GPL long ago...

>=20
> On the code side, are their dependencies to other libraries that the
> userspace tools
> require that perhaps Android does not  have or has incompatible versions?

Possibly, but that could be worked around at build time.

>=20
> Another reason would perhaps be size, lets see what the author says.
> Also, I could swear
> I remember reading something about him asking about Android ecryptfs befo=
re.

There have been a couple people ask about building ecryptfs-utils on
Android. I think the libnss dependency is the problem. We've discussed
how to solve that problem with at least one of those people, but I'm
pretty sure that it wasn't Catalin.

Tyler

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSoM/MAAoJENaSAD2qAscKfikP/i8+9WvXmUQ+j3KFFKvVxKUy
6fmO2OWoFDlyh1pMiturEW/FRq2valLCsxqyKIPiS9o6XfBgkMSKirZaTd6w0KO7
f3nxsokGVBOh18kPuGyV8A7FOXyxYvpg5mcwpqBa7kygNFEXGKlqkGMaBrCpSIog
AMzbx+eOUnoSyn+XKeWoba68r6btgX8KKJPUbiQ0d87I5RBRoYrKCle8br48yRW0
BTvuyKon5bpbvHSiCpglrW4MTGAy6Z2qYe5xCebBTMB6CTVNXGVhKKnFDuGIGeXJ
5qWUNnsGE+/fbiUfVMi9Fy0QfRbjNdSm7YjGhXB5s8Ak4AV5agUGcUa2V17uZITM
eST4lKsBhH7YJk1GDGU8cMrSGXiKiALAKAHFZ1ErYzCU+rs/w6Ru6maIDb/h09g0
l0QweIstFK9daywlGtqxR8XYP6RQKtOaKJhfY6VAC9jwh0kMR5CbC/NvGFK6ac3k
NwJFrgIvomWxynzHsyDVQdCSSfSe1vODKbtoOo5GBszQQh21dJHj/BUhMcOItJP8
2P87w3mEZGV679tYvrXeEVc5hyoLc3xz8ickS8CRsJuzzVyS2N+VwTTvTam9Otxs
ZgfnVaXeYVXzsm5T8D47RSESmOy/27A0AIgilCIemGuvW8hUcPNmX/o1taSxFtkd
2XONAGOajs11zN8Y16gs
=j2y5
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
