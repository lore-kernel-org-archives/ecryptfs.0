From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: lookup: Don't check if mount_crypt_stat is NULL
Date: Wed, 28 Mar 2018 20:45:22 -0500
Message-ID: <b6ebb694-2b6e-e5bb-ff94-2aea46f7a3f6@canonical.com>
References: <1516329625-19236-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="czLv5ySrUnL7aq6ABcu8UbZQ0lUIoxZ1N"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516329625-19236-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--czLv5ySrUnL7aq6ABcu8UbZQ0lUIoxZ1N
Content-Type: multipart/mixed; boundary="zbiBzif4ah7P8NlxSjzyWq41DFi6rHjTk";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <b6ebb694-2b6e-e5bb-ff94-2aea46f7a3f6@canonical.com>
Subject: Re: [PATCH] ecryptfs: lookup: Don't check if mount_crypt_stat is NULL
References: <1516329625-19236-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1516329625-19236-1-git-send-email-linux@roeck-us.net>

--zbiBzif4ah7P8NlxSjzyWq41DFi6rHjTk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 08:40 PM, Guenter Roeck wrote:
> mount_crypt_stat is assigned to
> &ecryptfs_superblock_to_private(ecryptfs_dentry->d_sb)->mount_crypt_sta=
t,
> and mount_crypt_stat is not the first object in struct ecryptfs_sb_info=
=2E
> mount_crypt_stat is therefore never NULL. At the same time, no crash
> in ecryptfs_lookup() has been reported, and the lookup functions in
> other file systems don't check if d_sb is NULL either.
> Given that, remove the NULL check.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks! I think this change is fine. I'll get it queued up.

Tyler

> ---
>  fs/ecryptfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 847904aa63a9..97d17eaeba07 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -395,8 +395,7 @@ static struct dentry *ecryptfs_lookup(struct inode =
*ecryptfs_dir_inode,
> =20
>  	mount_crypt_stat =3D &ecryptfs_superblock_to_private(
>  				ecryptfs_dentry->d_sb)->mount_crypt_stat;
> -	if (mount_crypt_stat
> -	    && (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES))=
 {
> +	if (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) {
>  		rc =3D ecryptfs_encrypt_and_encode_filename(
>  			&encrypted_and_encoded_name, &len,
>  			mount_crypt_stat, name, len);
>=20



--zbiBzif4ah7P8NlxSjzyWq41DFi6rHjTk--

--czLv5ySrUnL7aq6ABcu8UbZQ0lUIoxZ1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlq8RTIACgkQ1pIAPaoC
xwosfw/+Nmt0pUq1lWRIBwZbg4cEw02u3WNNph78gxJr2PcWREX2F5dW2Ac9sXGN
4ihCwfhSnr9ylalLybAMCcitTmFLE2mwnyVRkKZIg87N45X/1E+t+dt14dUP0XvG
pKGqanXDCVRJZ0CpBs6rFh9V9v3+Nm6EoIVLgXfeIc57ukC00qPV8jns7Wj0SW33
WC3y03mQRyz5due1bLsEgsoWOBSWslXAsY9C15oj1FxamAVxQYGULybX+0j0JwbN
+6SspO8yBKEAWqjUVCNbb5MNbij/UGxALrZtJvy09kfkffXy1byFlnBkt2d7Co8K
H97BTtiAbFRq55yHRiiI0ZI9zjmGl/PQ/vxjStLq3ws+gabX36lhbMdC66e5L135
xsXbkmSxjm0RBuz0Kr7qtJtJhGhyCcdppmQk4/IRtN7wnZ+c9hUxHdCHvzfz5I/M
r8acdvagJBGAB490B05wzgF/LKmS46LgX/C8SUs53rlIBBlI5y1uSCP2WET1dd31
/Unr8lonIZtzYvXKrm6TlvRFRmrjMjKkGyzf0Cy//Nn4PcBYC+UibyD35MuGzBF3
eRq71ftCWuMRmpQnF3lNUH7h8mINR+ik9U7PBe9nCGrPPK9UquAIQs3ndoyYw1NW
8qBd2R7SYFcGVwPdEspRqPQLaR/1ZHVo8LvvFI9P9Pe8V3Oyvqo=
=8pod
-----END PGP SIGNATURE-----

--czLv5ySrUnL7aq6ABcu8UbZQ0lUIoxZ1N--
