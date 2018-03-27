From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: Restore support for both encrypted and
 unencrypted file names
Date: Tue, 27 Mar 2018 10:58:39 -0500
Message-ID: <740f5325-331d-d38c-e9d4-5f81b95a6872@canonical.com>
References: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0JegKyQimqVLbKcaquGF74aKtqi3Bug6b"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0JegKyQimqVLbKcaquGF74aKtqi3Bug6b
Content-Type: multipart/mixed; boundary="J4TwfQrY3h5PXBnaksoblkFkkskmDQ4UC";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <740f5325-331d-d38c-e9d4-5f81b95a6872@canonical.com>
Subject: Re: [PATCH] ecryptfs: Restore support for both encrypted and
 unencrypted file names
References: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1518561368-8324-1-git-send-email-linux@roeck-us.net>

--J4TwfQrY3h5PXBnaksoblkFkkskmDQ4UC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Guenter

On 02/13/2018 04:36 PM, Guenter Roeck wrote:
> Commit 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or
> plaintext name") was supposed to fix a situation where two files with
> the same name and same inode could be created in ecryptfs. One of those=

> files had an encrypted file name, the other file name was unencrypted.

That's correct. Al was concerned about possible deadlocks with aliased
dentries and I thought it would be best to only support encrypted and
unencrypted but not both.

>=20
> After commit 88ae4ab9802e, having a mix of encrypted and unencrypted fi=
le
> names is no longer supposed to be possible. However, that is not the ca=
se.
> The only difference is that it is now even easier to create a situation=

> where two files with the same name coexist (one encrypted and the other=

> not encrypted). In practice, this looks like the following (files
> created with v4.14.12).
>=20
> ecryptfs mounted with file name encryption enabled:
>=20
> $ ls -li
> total 48
> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
> $ grep . *
> myfile:encrypted
> myfile:encrypted
> myfile2:encrypted
> myfile2:encrypted
>=20
> $ ls -li
> total 48
> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36
> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njb=
cIPoApxk7-E--
> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02
> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCt=
J70cm911yZ---
> 5252817 -rw-rw-r-- 1 groeck groeck 12 Jan 20 12:52 myfile
> 5252827 -rw-rw-r-- 1 groeck groeck 12 Jan 20 15:37 myfile2
>=20
> $ grep . *
> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-njb=
cIPoApxk7-E--:encrypted
> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9YCt=
J70cm911yZ---:encrypted
> myfile:unencrypted
> myfile2:unencrypted
>=20
> Creating a file with file name encryption disabled and remounting with
> file name encryption enabled results in the following.
>=20
> $ ls -li
> ls: cannot access 'myfile3': No such file or directory
> total 48
> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>       ? -????????? ? ?      ?       ?            ? myfile3
>=20
> Prior to commit 88ae4ab9802e, the file system had to be mounted with
> encrypted file names first to create a file, then the same had to be
> repeated after mounting with unencrypted file names. Now the duplicate
> files can be created both ways (unencrypted _or_ encrypted first).
>=20
> The only real difference is that it is no longer possible to have a
> _working_ combination of encrypted and unencrypted file names. In other=

> words, commit 88ae4ab9802e results in reduced functionality with no
> benefit whatsoever.
>=20
> Restore ability to have a mix of unencrypted and encrypted files.
> This effectively reverts commit 88ae4ab9802e, but the code is now
> better readable since it avoids a number of goto statements.

I'd like for us to correctly fix 88ae4ab9802e rather than try to support
both filename types under a single mount since that's complex and there
are unknown corner cases to consider. I think this can be done by not
copying up the lower filename when an error is encountered in
ecryptfs_decode_and_decrypt_filename(). If filename encryption is
enabled, it should only return decrypted filenames or an error if it
isn't possible to decrypt the lower filename.

Tyler

>=20
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  fs/ecryptfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 847904aa63a9..14a5c096ead6 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -392,11 +392,11 @@ static struct dentry *ecryptfs_lookup(struct inod=
e *ecryptfs_dir_inode,
>  	int rc =3D 0;
> =20
>  	lower_dir_dentry =3D ecryptfs_dentry_to_lower(ecryptfs_dentry->d_pare=
nt);
> -
> +	lower_dentry =3D lookup_one_len_unlocked(name, lower_dir_dentry, len)=
;
>  	mount_crypt_stat =3D &ecryptfs_superblock_to_private(
>  				ecryptfs_dentry->d_sb)->mount_crypt_stat;
> -	if (mount_crypt_stat
> -	    && (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES))=
 {
> +	if (IS_ERR(lower_dentry) &&
> +	    (mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
>  		rc =3D ecryptfs_encrypt_and_encode_filename(
>  			&encrypted_and_encoded_name, &len,
>  			mount_crypt_stat, name, len);
> @@ -405,10 +405,10 @@ static struct dentry *ecryptfs_lookup(struct inod=
e *ecryptfs_dir_inode,
>  			       "filename; rc =3D [%d]\n", __func__, rc);
>  			return ERR_PTR(rc);
>  		}
> -		name =3D encrypted_and_encoded_name;
> +		lower_dentry =3D lookup_one_len_unlocked(
> +			encrypted_and_encoded_name, lower_dir_dentry, len);
>  	}
> =20
> -	lower_dentry =3D lookup_one_len_unlocked(name, lower_dir_dentry, len)=
;
>  	if (IS_ERR(lower_dentry)) {
>  		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
>  				"[%ld] on lower_dentry =3D [%s]\n", __func__,
>=20



--J4TwfQrY3h5PXBnaksoblkFkkskmDQ4UC--

--0JegKyQimqVLbKcaquGF74aKtqi3Bug6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlq6ai8ACgkQ1pIAPaoC
xwpGmg//b/W9IPF2C8LlpiWM6iNmjyyTzWIHtcBxwOkEXgYd+PAAlSgbHvwDoWQt
4/OqLPcdg2UME/m+qDzhguv3GNjD2VjXgMIV+TCk6qm5m98kWqBlEymOGd2nDBxQ
efOu1NUGDkJg8h4fheSLs49raShoqmAp9y4gyfslDIhWeiqxz1Ux5USUmXvJ5mrz
hyZMM3vQvlldhSuYi4C9JAmobnsKGzmq3JT8SlbnFevzQSnEF1MjvFpTZ51d69mx
GJLrALQSIRiK6CbQqonae9zSPne2gw2K2vNyn5+dHisGLX9jgbcQdzw0hEq+Jv8C
5DdnONXaVdpbUHHlfur6oH1nVqim1eNMvJBKo4F0t7ULYpc7CDljN1Xsc/x3O+bs
B2glnW8iyvMdGTlFUETxI6n2Y1wvb7FLmrnmANOEEEgDfno4o2fdex7vqRz52I00
CeH/E/DtGCwL+OY4RSlm2joLqiFa48KBFya0Z35Zl/niX2AOEaK6Rf2YIOyBl/hq
GHqhrkT0My0r/oyQwuvjXeXz7V4hn+qylOmD/RGaflG9EKIHkZihUqi9aU4O6tY4
wdPy+iXc2o4GZR4NuwZbdXElSk22VkIFiMzj3DqFCbsHSiWim726EIjmA4skAcdv
WX2+RRP/dF/cFjsc6MzSFJJrD3ZJlMUtnRuE1Kt+8hug6YvqiY8=
=8T34
-----END PGP SIGNATURE-----

--0JegKyQimqVLbKcaquGF74aKtqi3Bug6b--
