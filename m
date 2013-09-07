From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [patch] ecryptfs: remove check for if an array is NULL
Date: Fri, 6 Sep 2013 17:30:39 -0700
Message-ID: <20130907003039.GO3853@boyd>
References: <20130731091010.GA2131@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZmZU9S7l/XJx5q9b"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41741 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3IGAan (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 6 Sep 2013 20:30:43 -0400
Content-Disposition: inline
In-Reply-To: <20130731091010.GA2131@elgon.mountain>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org


--ZmZU9S7l/XJx5q9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-07-31 12:10:10, Dan Carpenter wrote:
> It doesn't make sense to check if an array is NULL.  The compiler just
> removes the check.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, Dan!

I've pushed this to my next branch and it will be part of a pull request
that should go out early next week.

Tyler

> ---
> Or perhaps "if (!strlen(crypt_stat->cipher))" was intended?  I'm not
> very familiar with this code.
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index d107576..3bd35e2 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -609,10 +609,6 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_st=
at *crypt_stat)
>  	char *full_alg_name;
>  	int rc =3D -EINVAL;
> =20
> -	if (!crypt_stat->cipher) {
> -		ecryptfs_printk(KERN_ERR, "No cipher specified\n");
> -		goto out;
> -	}
>  	ecryptfs_printk(KERN_DEBUG,
>  			"Initializing cipher [%s]; strlen =3D [%d]; "
>  			"key_size_bits =3D [%zd]\n",

--ZmZU9S7l/XJx5q9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSKnOvAAoJENaSAD2qAscKrBwQAKaVVXzpKtzN5hmqbuBRSjxC
FZqlnXS978e4AVTduyeFJ4tpFWCG0h5UPsmy5NiAaxVWBfan/gMUnUwYQB2jtScv
G9sU6JPKiN5hHsUTw5kXM33cif1AVRAog8IKdGrgxHJwgpb1s4Psl8zxZN+0kh8J
nr2+0ssXw/k27ed3vPzu5Pt4tRRsBWYzzzucVAroRbDyjNNOpqJ3lTQsfS6nDjHX
9Td/+02HUwpBsOPCoEhuTVHCEZE59SNas3k5lxL+LjokgOaR/Y7EtDPWRnZZlrXV
l1vahDKRmBb6sWPx4veNfzAESYf1DZ2l8/jsZT5MU8mXe7rwPZlt/N/fpKu6CYsu
mFG3OmhsWO3MBBcDnACTPgu+9+7DdPWjzscjuzLbEWGBFZyKyMCBOqnEImP2ncBo
M4XRCUOQI3mm2LvIGSN5Ix+iouKwb64qoz769ktLA+7i/k4USgEgRs4Ehg2ow75m
47Npgsnj0cAVunCVukz046GgCtlxkEKbnlejsHWzb8r1jdgcOIpfEi+f+RCb/LBk
4x678lvNsc4jkkZMUzZLTXWkk/TkziLKzJ0WX7eb40V2azx2hehNTc5c+QJA7Q8b
EUvp/LlLcROpnOiRzdrvt19IhFiYA64E9fmcDpLt0NtTQWHfR5xOQY86N74pIgyP
+vaL2qjQqrZRaUp6S6Vl
=v48P
-----END PGP SIGNATURE-----

--ZmZU9S7l/XJx5q9b--
