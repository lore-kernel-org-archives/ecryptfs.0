From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 1/1] fs/ecryptfs/messaging.c: remove null test before
 kfree
Date: Thu, 3 Jul 2014 16:32:57 -0500
Message-ID: <20140703213257.GA5089@boyd>
References: <1402941972-5166-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402941972-5166-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-06-16 20:06:12, Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: kfree(NULL) is safe this check is probably not required
>=20
> Cc: Tyler Hicks <tyhicks@canonical.com>
> Cc: ecryptfs@vger.kernel.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---

Hi Fabian - Sorry for being slow to respond. This patch looks good. I'll
push it to my next branch.

Tyler

>  fs/ecryptfs/messaging.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
> index e57380e..286f10b 100644
> --- a/fs/ecryptfs/messaging.c
> +++ b/fs/ecryptfs/messaging.c
> @@ -434,8 +434,7 @@ void ecryptfs_release_messaging(void)
>  		mutex_lock(&ecryptfs_msg_ctx_lists_mux);
>  		for (i =3D 0; i < ecryptfs_message_buf_len; i++) {
>  			mutex_lock(&ecryptfs_msg_ctx_arr[i].mux);
> -			if (ecryptfs_msg_ctx_arr[i].msg)
> -				kfree(ecryptfs_msg_ctx_arr[i].msg);
> +			kfree(ecryptfs_msg_ctx_arr[i].msg);
>  			mutex_unlock(&ecryptfs_msg_ctx_arr[i].mux);
>  		}
>  		kfree(ecryptfs_msg_ctx_arr);
> --=20
> 1.8.4.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTtcwJAAoJENaSAD2qAscKbbMP/2+a95lqTIpcHKKrBZZvHOVH
DdhVTd/JVTKyps/ljp+7H37Vq5sHrx5UM/FIIo+Meh6+8Pc7DWQuBEjBnO+WVtS3
8lumqaad+Ubz2ANxRHpp/fDTmhW4xkWPaDUg+S62nZwps2tiukrkkZ2TLQyKoIFw
8PW2kTa7fngx06StIDPjxp/iS/vkwTthENJkMRAtQ16NRVE+2cL2rpuQheMS3N1h
MGainwmpL+sSXy3QxUvFWQZrfhSnJBvUqHqDzCStO/SAwOeopXOIrCpzJ54wwz1C
VPrqTkC/FCDa9TYyOjMu8avlYBxubyYGDQcrwckEeEBN1scQrNjX7/azBpDSW7Tz
IlYVIk+QZlkH1HDHRRbXNbBoWKY8NabA7ZLF/VeHgpZus0uSdHn9Vj5Yw3U66VJV
CN+Ob1XRCcbuFB8A3jtz0a1toJ9Y71NLai/i9ljJoImQTVY+sfYQWzGSqCVTveFL
NOqAIt/D/sWi2MJh7QY3bAmuIg30rv0IQyzpB2QcGnMysKmRM2UBXjeG7d6ADF9X
FJBIzvtaXY3Dri8VhFL3JsIfn0mPwKa0xY5LXlbvMyXa9yoJoT88ugQD/bfDkmQg
3nBfbmgWSxcQV/GRAQUEjvocQYFntx7emCMtiaLdYe6/TBAYtI7JyGBNeAwrhsgz
ySZRLIvT6FlGoi9/cg9v
=wSYf
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
