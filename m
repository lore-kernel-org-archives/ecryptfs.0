From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Delete a check before the function call
 "key_put"
Date: Thu, 6 Aug 2015 09:09:28 -0500
Message-ID: <20150806140928.GA5766@boyd>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <558D7CE5.1090205@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558D7CE5.1090205@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: ecryptfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-06-26 18:25:09, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 26 Jun 2015 18:18:54 +0200
>=20
> The key_put() function tests whether its argument is NULL and then
> returns immediately. Thus the test around this call might not be needed.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for the cleanup. I'll include it in an upcoming eCryptfs pull
request.

Tyler

> ---
>  fs/ecryptfs/crypto.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 97315f2..80d6901 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -258,8 +258,7 @@ void ecryptfs_destroy_mount_crypt_stat(
>  				 &mount_crypt_stat->global_auth_tok_list,
>  				 mount_crypt_stat_list) {
>  		list_del(&auth_tok->mount_crypt_stat_list);
> -		if (auth_tok->global_auth_tok_key
> -		    && !(auth_tok->flags & ECRYPTFS_AUTH_TOK_INVALID))
> +		if (!(auth_tok->flags & ECRYPTFS_AUTH_TOK_INVALID))
>  			key_put(auth_tok->global_auth_tok_key);
>  		kmem_cache_free(ecryptfs_global_auth_tok_cache, auth_tok);
>  	}
> --=20
> 2.4.4
>=20

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVw2qYAAoJENaSAD2qAscKLEsP/147/sq5IemHURa44hUWlVTN
iM0yQT64FBOTmiek7AJR9t4cG/9Rs3xNUp/pLxfXSO9rw6IFvwXOE8O016doPuu7
dfk38b8H/QnLXfxCzlAY50h/Nzsg+zEUaRzuATHNaNaFiUvR4qDh0QjLKCr3FXrA
+NMVgHII3csrkVOEk1QJeji+UuXbQYtnTZ4D9UZvCSEJMBG0SKt49f3Islu42kJ+
GbPeN6/W+K7T8hTqM6y8x+9e1KhgOsF/UqwmBnqPO1uqRJzJHAkmvBDZdsEJ0XXs
Fn/AF4Dgi1Lpohv7OZLc/R3ZWnBkrLcZpsG20c8+SjK6saNftK60IHiqjEX1bGhf
VgXxKscZeGkiXuXW5EeYvAqfJm/QEUsI/FOWzbkDsq3tlEGyNuID6wQ5tiFxC8Mi
0fDIW1rAwWGaIP1EKnAEJ5XUBSClY8VmiVjIeSryNIksl5HEgOVVGt9Ld4YqTyLa
mOrj9FGuR899f7szqMCoHAtKc2lbQp5YyhD66pzKnzIjSCJdBWtKZMcBByTO6v+S
xXZVOJ6/ai9yEec+4FW+Te6YKXJKyzr0gXuUJZdJPRH6AV6H71ICwkHXXNO/RAwd
x+Ewqs+45Aayqi6ms5WO0fpN1+9nKld2X6UL5HTdDLxUJSpc0HRoYoAXvo3Y0sKc
EeqGLZQo2O7PS+lVfYdD
=1cXj
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
