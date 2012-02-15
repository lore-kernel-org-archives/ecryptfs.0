From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs with aes-ni slower bug
Date: Wed, 15 Feb 2012 04:48:16 -0600
Message-ID: <20120215104815.GB1991@boyd>
References: <CAB89gJErehp2bw6XuWghBXT9D4632rgtowUVqSsna2ng8XQ5Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46832 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab2BOKsU (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 15 Feb 2012 05:48:20 -0500
Content-Disposition: inline
In-Reply-To: <CAB89gJErehp2bw6XuWghBXT9D4632rgtowUVqSsna2ng8XQ5Sw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Stefan =?iso-8859-1?Q?Dr=F6ge?= <stefan@sdroege.de>
Cc: ecryptfs@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-02-15 11:43:21, Stefan Dr=F6ge wrote:
> Hi all,
> A while ago I read at phoronix, that ecryptfs is actually slower when
> having loaded the aesni-intel kernel module.
> Out of curiosiy I checked whether this problem still exists in the
> Ubuntu 12.04 alpha2, and it does.
> I tried to find infos to this in the mailing list archive, but I found no=
thing.
>=20
> So my question: Is somebody working on this?

No, not currently. I've been focusing on stability rather than
performance.

I'd love for someone else to become interested in the problem and dig
in. Otherwise, it will have to wait a while longer until I get some free
cycles to look into it.

Tyler

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJPO41vAAoJENaSAD2qAscKlvoQAM3pbwacDrKbUMItmYck9TBZ
ZJnpwYsMBV/PQP2Vgo9lbaUVSYxZXuYdicTb0lyQ9Uu7jfUd7tbWESQDSrgh8o2P
p7qJcLT/WJIfIiOgpexYkeM6/S8c/zdKgNuYPxfd2Ixei2JrLlTMREbjHUtm2Lzj
405ENWYjPxI/sfJlKmt/3v6OKhAP8tcS90KzBwyBBevIdO/osJDAKZ/s9bur5dVW
5/zbAVq1cDIifp6MI21fi9VzxJaGzUS641Ivc4W3E11HcK+5/ku37j9sD3tzRaAp
k6OlcFepRG0BKy012FNWASuvhlWiOtax1B9obrGMnk4Bg57YQPUgq6vvl48TII+H
F7gxcikfEPBjm84TC9g24snHZR/gBcjH2EpHnmnfYux+uRLGJkXhgrQpVmHV6Du3
Qetb8KzLzuO6taKF9jsNOsTzRTqQ90qn5XeSNLVPaE4ByRNgWM8k3nQ+/Bh2tpSi
VuZe6L9F5tI1r6ptIAFh+xI+GYvd4IbTSGAeV/HIgaHrx/1bjDkxfKD5OJ96B1NJ
309JJLVzpPsjURCKZUtuQawAGXMwBUXAfpPGovBRqFQHk3sIvWsIxKjHi8J5qfQR
I8s9e83da0pa4o2mJspoCDkAY5/6nwbM/hzmalcY/ePIpK78BONq7s39aKAXlLrq
mm/D+6jHveupowFYRxcK
=6Eku
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
