From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 28/39] ecryptfs: drop null test before destroy functions
Date: Mon, 14 Sep 2015 21:08:31 -0500
Message-ID: <20150915020830.GC32505@boyd>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
 <1442146532-9100-29-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36206 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbbIOCIg (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 14 Sep 2015 22:08:36 -0400
Content-Disposition: inline
In-Reply-To: <1442146532-9100-29-git-send-email-Julia.Lawall@lip6.fr>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-09-13 14:15:21, Julia Lawall wrote:
> Remove unneeded NULL test.
>=20
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@ expression x; @@
> -if (x !=3D NULL)
>   \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Tyler Hicks <tyhicks@canonical.com>

I assume that you'll be landing this patch set into Linus' tree all
together. Let me know if that's incorrect and I should take this single
patch into the eCryptfs dev tree.

Thanks!

Tyler

>=20
> ---
>  fs/ecryptfs/main.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 4f4d047..e83f31c 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -737,8 +737,7 @@ static void ecryptfs_free_kmem_caches(void)
>  		struct ecryptfs_cache_info *info;
> =20
>  		info =3D &ecryptfs_cache_infos[i];
> -		if (*(info->cache))
> -			kmem_cache_destroy(*(info->cache));
> +		kmem_cache_destroy(*(info->cache));
>  	}
>  }
> =20
>=20

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV932eAAoJENaSAD2qAscK3nsP/iqZKRiGLzVB/O6RJBSEApA3
Ifgs6SblEs1On28OyGeYX+AHWWsx117o6MDqinJWJOfrSohSoBIE4BeDQshr2rE1
UpTQ8uxh3SLw1coHnBXzTx0j2CeADrNtT4VWmv+6fyKfiv4JTYnZ0he1gfQMZ319
R2l+s45BWW+XDnyFqGFHYTlrnpCGQyO0KVachSjMPxQffUZmdspfCoJBh8IyD6/p
H6MBpwKUyAihdBG7PKABMBlqr1x1SCZEO3kqKxvmGg6uUP9DYNN5hnSBtixR29EV
C3Ar98FvEITvNDIjlg5jbsB6yQi+1Zo7bY7qFv79T8aTy+0kmsOM03fBq7AVY2W7
q4ecRj0LbPX/vFoXKgu3PWeUus2UNYRsvGqyemelDYWxsg3s+Zo+dE43/0yPSGTv
XkRX+QJzkbpIKuh/NqoZKGsxeTZ6k+tDK4p75cjwqZ1SxSojqTJhs7dydCtPzLuV
lLydleLb1VeyakyIDKZGBkgjgZgHH9M9NoYV0fdyXdEntl3RUEw2f3m53Trhqp+g
QsD3AziQwOLR6jwtdc7bnV2iZhyRUy+qWQL1ElPaw0tgGKbrPVfIbiFJwfnKaMcT
/qpwapO8ywxYNA57FVaRYZ3bxmtN0XZz9KYgcyFUGAkMXKiOcSKmdmJRS9ORC8Rr
mPh5dzmyMOYWxN4N8TnC
=0aPU
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
