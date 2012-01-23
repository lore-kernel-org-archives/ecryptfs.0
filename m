From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: eCryptfs: Truncate path improvements
Date: Mon, 23 Jan 2012 10:57:15 -0600
Message-ID: <20120123165714.GA20665@boyd>
References: <1327098907-28963-1-git-send-email-tyhicks@canonical.com>
 <CA+55aFzpM-c9FWdC8+7sV0GOXqvFNvxPsrV42rvXJHXnKsDoZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzpM-c9FWdC8+7sV0GOXqvFNvxPsrV42rvXJHXnKsDoZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, john.johansen@canonical.com, dustin.kirkland@gazzang.com, Cong Wang <xiyou.wangcong@gmail.com>, Li Wang <liwang@nudt.edu.cn>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-01-23 08:49:40, Linus Torvalds wrote:
> On Fri, Jan 20, 2012 at 2:35 PM, Tyler Hicks <tyhicks@canonical.com> wrot=
e:
> > As Linus pointed out[1], eCryptfs needs more checks around its truncate=
 path.
> > The first patch in this series makes it possible for an eCryptfs trunca=
te
> > operation to be gracefully interrupted by a fatal signal. The second ad=
ds
> > checks for eCryptfs inode changes in setattr. The third is simply remov=
al of
> > an old, unused function.
>=20
> Tyler, should I take these patches directly? Or are these just for
> review and I should wait for a pull request?

Just for review, as I'll send a pull request.

I'll try to be more clear about that in the future.

Tyler

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJPHZFqAAoJENaSAD2qAscKU7oP/iAxoxIUAb7NbmrxwRv0Ma01
C9I/I0u6reXXtv1APTshUmbwjCqXKBmHOolR3gkXud8i4EvTbL7RHn5mF0/IGnNg
m+FCi++kVd9IIu2KkfqC2pvmrFlKrXs/PXe2DL1cbrqLmF/6Pn8s/phuNASo4UIK
nqNBwz67b+MNfuZIdQ1of0WEtCxg4EnF0gjHTDDdeAbV0sBZMLbyD1V0Vq5nsO+V
DngVKOxDzM4N4Mh97e1PSzwjVmSedSsVmVXd0GYkEsXDkaLI084NTvn16WClFW6G
7q4XWjxqnsmkI5aL4uz381B8NX2hWy6llim01p5LzYl0I9EMY4y9F9g4ZMqBAF8F
tBNCNoJBvq9C0THPIUY+3820icJggrsdMq4AuU8BEn/P6mSChsIdC7s5AKo4Uk5M
PPGopgtNPp/NkJz/CTDBJTBlyKHpTjw5s/QMgcv1/zevR0LnqdTIOoB4BOgZ7+2g
Sm/4ViCG3EwARjfgQz3ZiiAA87AHrW/EncBq3LTqyDv1MfgOq57G1GhEX5+dmHT2
AcYQr4wiqEqcHaW9+959zMWHNUNv/SGKgObh5ogoagUiWU2xiZLcL/KRru9HqER0
dDIJqAjSh8uGT1F03xIWNYk18dXjwGNffEUBnI+bHI79uEmMPWg/GSxkhDa4Uz4m
4Giq1Mnmpij9m1xeEuHb
=TWEd
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
