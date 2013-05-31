From: Tyler C Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] Update eCryptFS maintainers
Date: Fri, 31 May 2013 09:36:50 -0700
Message-ID: <20130531163649.GA9273@boyd>
References: <CANT6BaPY6Ax+agTQs0eTKMY2tcKad31=jpLVhZJfaL=s9J2o=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50980 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab3EaQg7 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 31 May 2013 12:36:59 -0400
Content-Disposition: inline
In-Reply-To: <CANT6BaPY6Ax+agTQs0eTKMY2tcKad31=jpLVhZJfaL=s9J2o=Q@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: Dustin Kirkland <dustin.kirkland@gmail.com>, ecryptfs@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-05-31 10:41:43, Dustin Kirkland wrote:
> Remove myself from the eCryptFS kernel maintainers.
>=20
> Add the ecryptfs.org website.
>=20
> I will continue to actively maintain and monitor the ecryptfs-utils
> user space project and packages.
>=20
> Signed-off-by: Dustin Kirkland <dustin.kirkland@gazzang.com>
> ---

Thanks Dustin - I'll include this in my next pull request.


For anyone else following along, nothing is changing. Dustin has always
been primarily focused on ecryptfs-utils.

If anyone else is interested in helping me out with the kernel module
maintainership, let me know. The best way to start getting involved is
through patch review (the two sets of patches that I sent out on May 25
would be a great start) and sifting through the bug tracker.

Tyler

>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7714c3c..19ddd7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2890,8 +2890,8 @@ F:	drivers/media/dvb-frontends/ec100*
>=20
>  ECRYPT FILE SYSTEM
>  M:	Tyler Hicks <tyhicks@canonical.com>
> -M:	Dustin Kirkland <dustin.kirkland@gazzang.com>
>  L:	ecryptfs@vger.kernel.org
> +W:	http://ecryptfs.org
>  W:	https://launchpad.net/ecryptfs
>  S:	Supported
>  F:	Documentation/filesystems/ecryptfs.txt
> --=20
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRqNGhAAoJENaSAD2qAscKR0wQAKF5t0pQg7lGtdliXKTVrFd8
QjD/FAQSO5AU2c/sCBUYcZkdaYrH2YhDPehF+kWhsqbSHAyKszkCsjFcqPmjbtJx
yr4HA4sMS+Cm5OdyobK6A3gWZBxnDXf3EvkDGp8Iu2Gwf25Awz+d182g/qENgofe
lj0yxtZ2VxuWpcOD5XIoaQB+naY6rCdG02SAVytQ5hBuRr7uXD3HCUxoJdRO/syr
SPYEri346d2R9IlnamsuIYhHX5T6Vx/01OquvrbFuP241V3541JlRzzluUVA7+gB
uKGRdkTxQVj0RSuzjgXepzqVzi0WhmVYPbT9Xfo57rH/+z1A4oYxr/o5640MVnpQ
pCFvF8oxeKD1y3JYcvOVHh4/Ky6zOLO6JrM/8Fp2AIfF+rkVq8QAppyYxg4dWKg5
6r+8RGiieB1vG/+HbqBkByIto9UA/Ttee1MeA3T6/nUVKWl/JTG0fRvOMJj5aTkC
MYNoS8CTd3vedEINJuBRgtvud6yUzubWLTGcwIWfsvYKncVZVQNkOwg7Y+NFsCbp
03O1JsOvTKR4BHS9KxUliKkTQmOh4QB1qU8X64BGt4Ye0ygTRAKscROncsJss0gy
k9Sav7KR8z5MhXo3p2MeD3WXynQrkuK+OsKbrR3HOJBoU5FZcJ5eQptvJT18HLPi
q7oJOdUdlQXMBcGEmZq7
=pWid
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
