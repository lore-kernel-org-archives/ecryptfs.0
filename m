From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] fs: ecryptfs: initialize payload_len in keystore.c
Date: Thu, 17 Jan 2013 11:08:07 -0800
Message-ID: <20130117190806.GA2394@boyd>
References: <1358388494-31158-1-git-send-email-sque@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43611 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab3AQTIM (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Jan 2013 14:08:12 -0500
Content-Disposition: inline
In-Reply-To: <1358388494-31158-1-git-send-email-sque@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Simon Que <sque@chromium.org>
Cc: ecryptfs@vger.kernel.org, dustin.kirkland@gazzang.com, msb@chromium.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-01-16 18:08:14, Simon Que wrote:
> Signed-off-by: Simon Que <sque@chromium.org>

Hi Simon - Thanks for the patch but please resubmit it with a
description. Even with a one-liner as simple as this, there needs to be
some background information conveyed with the change.

Is this to just quiet a useless compiler warning or is there a place
were we actually use payload_len without initializing it? If we use it
uninitialized, does it cause a crash or do we "handle" it in error
paths? These details are factored in to determine if I need to send this
to the stable team and if distros need to backport it. It also keeps me
=66rom scratching my head a year down the road when someone asks me about
the patch with no commit message. :)

FWIW, I took a quick look and don't see how it can be used uninitialized
but maybe I'm missing something. I also don't get a compiler warning
about it when building with `make W=3D12 M=3Dfs/ecryptfs`.

Tyler

> ---
>  fs/ecryptfs/keystore.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 2333203..6154cde 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1150,7 +1150,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_a=
uth_tok *auth_tok,
>  	struct ecryptfs_message *msg =3D NULL;
>  	char *auth_tok_sig;
>  	char *payload;
> -	size_t payload_len;
> +	size_t payload_len =3D 0;
>  	int rc;
> =20
>  	rc =3D ecryptfs_get_auth_tok_sig(&auth_tok_sig, auth_tok);
> --=20
> 1.7.8.6
>=20

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQ+EwWAAoJENaSAD2qAscKneIP/RSBmMUjOx6+vBby0YxaUAlH
eP7Mezc6su80LwMoYsKVXYIhz6YGLGWqfFyL6W1CZbMAlSTD1A3dWRcUyQD8R6c2
h16nBerYb8xLKHyZ1WdZeM7hUYb1BulWLjynX2cR+6IWkvwQN9P1tVkPCaG8cbz+
9Z5cmgj3ArjGbwSfOmvDFS3pOcIo6gJ3ZOssez5wt+L5EoTsYT5shnpIidYgMGTO
xpu//t8Ba202hPrw9yOc8O+km5SYv0LxLfBcKjwGY9bMxxSkZ4d68sAcfACGGCS2
mnV/BXJQ4qRRyWGAnJaBMGk6J8ZfNHUZ8OacYKDfHux/NCk1sGPa5D8BcCJuXnbG
LnrnvkC7vjJLaSJOzDmkhqRq3Q/OC0LtHzO81do7d2J6ngNhexs62FiWcQCyNwAR
/MRSGA2+ymxtukhpBE4TYuV6PtpP3dBdwgfSHrptCbq3MauV0QhXMdyapqw+0y8U
3+u0Y2+5jwdNA/83DIcan1QBVh+/4YfHrVfuO2JyuNF9lDcg3NI9D2pfbDn+p0ze
ANRpCLJEXgciZ/Y4UO/71YGet+9J+/ZX4NquxEYvzGnHesKG4dzrD1p4dVFoG4r6
I1cpEr1TjgpzorjAS/SQPL8ZP0S/uB9oK7Xg4nk11ZnNyuzDEY5/+y4Jce0DsJFR
gYxPDwjjLtgW2aoM4oSb
=mJUp
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
