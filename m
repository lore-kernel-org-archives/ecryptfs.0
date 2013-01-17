From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2] fs: ecryptfs: initialize payload_len in keystore.c
Date: Thu, 17 Jan 2013 13:39:58 -0800
Message-ID: <20130117213957.GA13176@boyd>
References: <1358450300-23826-1-git-send-email-sque@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44186 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3AQVkD (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Jan 2013 16:40:03 -0500
Content-Disposition: inline
In-Reply-To: <1358450300-23826-1-git-send-email-sque@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Simon Que <sque@chromium.org>
Cc: ecryptfs@vger.kernel.org, dustin.kirkland@gazzang.com, msb@chromium.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-01-17 11:18:20, Simon Que wrote:
> This is meant to remove a compiler warning.  It should not make any
> functional change.
>=20
> payload_len should be initialized when it is passed to
> write_tag_64_packet() as a pointer.  If that call fails, this function
> should return early, and payload_len won't be used.
>=20
> Signed-off-by: Simon Que <sque@chromium.org>

Thanks for resubmitting. I've pushed it to the next branch at:

http://git.kernel.org/?p=3Dlinux/kernel/git/tyhicks/ecryptfs.git;a=3Dsummary

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
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQ+G+tAAoJENaSAD2qAscK8/YP/3nD3TeIqikvL2mtCTsZDYPH
ZrCrsve7TNvWKll8EN7AKO5iy/0dsuOTUSgFqSE9OtrgQcF8B77dNveQ76uwaqIA
qLkBjKWKN8mQh2Z9ZICs3OZIJF61Y40ZJAcTFIqih6N1WEhPtX1/aCA3GGbzv3Rq
FyH/Iu135DdyD64F39XbMi7loPBsUJXMfwmLCFCNYyW+UMTsWFd6OvY6J8IINECI
fzA0b6ClOL3J0Ek4sPUsn7iXWl1LZ60+NPRp2UnpWTXAkb/1pxCOVIMAgyma4hmn
nYzBc5HzgOtBaxkUjtw0mqz+VZWN8IEEwxWCXbkZ+rNcimbUoujWX2q5/6HeuhYS
+EiAa0RZ7TR9JoyD7NDGP7vtKmKPjRu8MDz2YclEwHQGhjwk+2tKbNYcLn4jefI3
OYcxDL31gJZT09j00jjrLO9x34qQVZaZ+KVq23tl/vd3iBocUEcI/Lw343mAeHe6
BlsKNuXj+9XCq+aTKP36pBE3ZHokR4jxQvbcf7DkD5MNSd3WkFzF3KZv7ytScBzo
IzkwedbX570CjWvcTREOFfmqYGRjxj3O12bPNAWX9ATsqluXte/1CblgdrzgJFa/
mzAHXQ3mR8/OCifK4IyOkYCntQh5lI5/zd4tCyfRvOonM7rEpdoZfB3UqaD/owHC
elvePokq+19u7Lbty5J9
=R9Uw
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
