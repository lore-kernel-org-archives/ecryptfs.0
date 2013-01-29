From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [patch] eCryptfs: remove unneeded checks in virt_to_scatterlist()
Date: Mon, 28 Jan 2013 17:23:28 -0800
Message-ID: <20130129012328.GA2111@boyd>
References: <20130126074842.GA14365@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37803 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab3A2BXf (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 28 Jan 2013 20:23:35 -0500
Content-Disposition: inline
In-Reply-To: <20130126074842.GA14365@elgon.mountain>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-01-26 10:48:42, Dan Carpenter wrote:
> This is always called with a valid "sg" pointer.  My static checker
> complains because the call to sg_init_table() dereferences "sg" before
> we reach the checks.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, Dan! I've tested and pushed this patch to the eCryptfs next
branch.

Tyler

>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index a7b0c2d..d5c25db 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -301,17 +301,14 @@ int virt_to_scatterlist(const void *addr, int size,=
 struct scatterlist *sg,
>  	while (size > 0 && i < sg_size) {
>  		pg =3D virt_to_page(addr);
>  		offset =3D offset_in_page(addr);
> -		if (sg)
> -			sg_set_page(&sg[i], pg, 0, offset);
> +		sg_set_page(&sg[i], pg, 0, offset);
>  		remainder_of_page =3D PAGE_CACHE_SIZE - offset;
>  		if (size >=3D remainder_of_page) {
> -			if (sg)
> -				sg[i].length =3D remainder_of_page;
> +			sg[i].length =3D remainder_of_page;
>  			addr +=3D remainder_of_page;
>  			size -=3D remainder_of_page;
>  		} else {
> -			if (sg)
> -				sg[i].length =3D size;
> +			sg[i].length =3D size;
>  			addr +=3D size;
>  			size =3D 0;
>  		}

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJRBySPAAoJENaSAD2qAscK9IYP/Av0XGpj8HHJkhDlf3bbidmS
Tbag1cnnlvUKcPneDvk3iam454O3Pu/3HPBZeib07W5SOmCjiN3k3wF1FrXAFx+b
Y9xcLrI6XSntlt7pqjijZMRLQDVA9g3QIYykhs8BOgoNnlm14jeXOySmlk3EkwGD
ipquoHFG/gsPtoeC6csGeSOC7RtVpKO9hzLjN6arJHnB7qL08Y+DYszugEKC7vVv
dwODo63gfNucyWI554FfX54qVBquREkTiR/ORWpQ6UZPtBFjcOrjs4m2+3CNI7dr
EnlUExH1hgdavvyjRUe5pn40SAcuXWqiGxGFs/o9+RU3abqQbrioHlSq9mJpES9A
jGQUXd+633as4AEsmrs7pLE/g4u6jokVEi1Z1IzK6B5jZUvgEOdsDXx4e87S11IB
PfNvo3YfznYJ+W1LVkSIMfrKd273vm6Fx+wXVk4tBSN/1QVIfsU95U0Mzm5Gfnk7
Q+6f4WUcRbicTFErzzPkTA61eA0qCJniEtTvwhPbJy+XBmI9ACogQh+iArehV1P0
tBjxP592YxVMjtrdcsMGxaKIQO3nDKLb0Oz6HEUj4rCv8Xi+xOwwKDWTB9IU3/ol
1CwshUNQsgaPcBIc7mINAhzflMqYaGOwPra+Yc0+0rgtzFsQUtMAQeiI+ZaN5Qg1
lMjKKKl5Kqg8uiWPnCOc
=4pZ9
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
