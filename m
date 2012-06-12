From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [patch] eCryptfs: fix ecryptfs_privileged_open() for read only
 files
Date: Tue, 12 Jun 2012 12:02:47 -0700
Message-ID: <20120612190243.GA32418@boyd>
References: <20120609091129.GD877@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53173 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2FLTCy (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 12 Jun 2012 15:02:54 -0400
Content-Disposition: inline
In-Reply-To: <20120609091129.GD877@elgon.mountain>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-09 12:11:29, Dan Carpenter wrote:
> The intent here is to handle read only opens differently.  For example,
> if we don't want to create the file if it doesn't exist.  The problem
> here is that O_RDONLY is 0 and if (x & 0) {... is always false.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, Dan! I committed a slightly different fix with more context in
the commit message (because I had to remind myself what was going on
with that conditional in the first place).

http://git.kernel.org/?p=3Dlinux/kernel/git/tyhicks/ecryptfs.git;a=3Dcommit=
diff;h=3D91425d9b57c024bf8b28055b6a480809fe0941ee

Tyler

> ---
> This is a static checker bug, and I am not very familiar with eCryptfs.
> Please review carefully.
>=20
> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
> index 69f994a..d01b364 100644
> --- a/fs/ecryptfs/kthread.c
> +++ b/fs/ecryptfs/kthread.c
> @@ -149,7 +149,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
>  	(*lower_file) =3D dentry_open(lower_dentry, lower_mnt, flags, cred);
>  	if (!IS_ERR(*lower_file))
>  		goto out;
> -	if (flags & O_RDONLY) {
> +	if (!(flags & O_RDWR)) {
>  		rc =3D PTR_ERR((*lower_file));
>  		goto out;
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP15JTAAoJENaSAD2qAscKmOsQAInR1s62O0jX4xhwhnvUukTO
PX3OlHmMF0v+quJboM07v6N7MvEINJ6bvkrkzjVUfVG2SZtChPMUev2Obn3chPgh
ezy8r1ArI8KhhSmuZsWZKJ3ycCWtACKR4bG9yxvExLtA2NCfHGb4PF7e0B7koxgI
q/7qoPM1Bcq0Yv04n76egZgQZcWafhnI7xyqqxpRRzRBjD35k6ypyPoU+qUgl+gH
tBritsnbAvpvmWYQNMMYJv1mafQeZ6nOyfk8TzV5FM1BDp9SSyUBSBJQ5H1hKYpm
oMKLpliBPsQCDfTYfw+xLQ3GBzhm8v4we8WwtuBqWsMXzkxc3Yl0Ybhf9AoHDPvA
iknigqP1Yr+VhvT4oau3VnRY7HgEImLmcQrWGa7ib5AEMY9ztXW4dd1JkKYD4TYp
MRHoOPyoDnQoNc3yKXZN9GpYjxNMnLvcHKro8et0zczjw9v6TvvrmyFcuAqvhO+b
48sLjArtIuvmnT99UtZI3CL65QLLLxWF1TlHVpF7c5TGrWUmLeBDRxEjOKlme1Pb
0oRZER4i2jUQujPj+KRLiJqlaxZUB2yVOcK9SZDB5+cHgwSytdra4bHKLdR3Sw5E
kV8pUrPZmpywt8pSEpa6xaVon8mCdhp+VWOpD+R8ePhkv4cKwk/G/at/lOF9Re31
JmwRd+jRtKKjjNlrffiV
=TVEY
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
