From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 2/2] eCryptfs: Initialize empty lower files when opening
 them
Date: Thu, 21 Jun 2012 00:08:22 -0700
Message-ID: <20120621070821.GA14522@boyd>
References: <1339554647-17445-1-git-send-email-tyhicks@canonical.com>
 <1339554647-17445-2-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60660 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab2FUHI2 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 21 Jun 2012 03:08:28 -0400
Content-Disposition: inline
In-Reply-To: <1339554647-17445-2-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: ecryptfs@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Colin Ian King <colin.king@canonical.com>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-12 19:30:47, Tyler Hicks wrote:
> Historically, eCryptfs has only initialized lower files in the
> ecryptfs_create() path. Lower file initialization is the act of writing
> the cryptographic metadata from the inode's crypt_stat to the header of
> the file. The ecryptfs_open() path already expects that metadata to be
> in the header of the file.
>=20
> A number of users have reported empty lower files in beneath their
> eCryptfs mounts. Most of the causes for those empty files being left
> around have been addressed, but the presence of empty files causes
> problems due to the lack of proper cryptographic metadata.
>=20
> To transparently solve this problem, this patch initializes empty lower
> files in the ecryptfs_open() error path. If the metadata is unreadable
> due to the lower inode size being 0, plaintext passthrough support is
> not in use, and the metadata is stored in the header of the file (as
> opposed to the user.ecryptfs extended attribute), the lower file will be
> initialized.
>=20
> The number of nested conditionals in ecryptfs_open() was getting out of
> hand, so a helper function was created. To avoid the same nested
> conditional problem, the conditional logic was reversed inside of the
> helper function.
>=20
> https://launchpad.net/bugs/911507
>=20
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ecryptfs/ecryptfs_kernel.h |    2 ++
>  fs/ecryptfs/file.c            |   69 +++++++++++++++++++++++++----------=
------
>  fs/ecryptfs/inode.c           |    4 +--
>  3 files changed, 47 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 867b64c..56e3aa5 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -568,6 +568,8 @@ struct ecryptfs_open_req {
>  struct inode *ecryptfs_get_inode(struct inode *lower_inode,
>  				 struct super_block *sb);
>  void ecryptfs_i_size_init(const char *page_virt, struct inode *inode);
> +int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
> +			     struct inode *ecryptfs_inode);
>  int ecryptfs_decode_and_decrypt_filename(char **decrypted_name,
>  					 size_t *decrypted_name_size,
>  					 struct dentry *ecryptfs_dentry,
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index 2b17f2f..cb8dd72 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -161,6 +161,48 @@ static int ecryptfs_file_mmap(struct file *file, str=
uct vm_area_struct *vma)
> =20
>  struct kmem_cache *ecryptfs_file_info_cache;
> =20
> +static int read_or_initialize_metadata(struct dentry *dentry)
> +{
> +	struct inode *inode =3D dentry->d_inode;
> +	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
> +	struct ecryptfs_crypt_stat *crypt_stat;
> +	int rc;
> +
> +	crypt_stat =3D &ecryptfs_inode_to_private(inode)->crypt_stat;
> +	mount_crypt_stat =3D &ecryptfs_superblock_to_private(
> +						inode->i_sb)->mount_crypt_stat;
> +	mutex_lock(&crypt_stat->cs_mutex);
> +
> +	if (crypt_stat->flags & ECRYPTFS_POLICY_APPLIED &&
> +	    crypt_stat->flags & ECRYPTFS_KEY_VALID) {
> +		rc =3D 0;
> +		goto out;
> +	}
> +
> +	rc =3D ecryptfs_read_metadata(dentry);
> +	if (!rc)
> +		goto out;
> +
> +	if (mount_crypt_stat->flags & ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED) {
> +		crypt_stat->flags &=3D ~(ECRYPTFS_I_SIZE_INITIALIZED
> +				       | ECRYPTFS_ENCRYPTED);
> +		rc =3D 0;
> +		goto out;
> +	}
> +
> +	if (!(mount_crypt_stat->flags & ECRYPTFS_XATTR_METADATA_ENABLED) &&
> +	    !i_size_read(ecryptfs_inode_to_lower(inode))) {
> +		rc =3D ecryptfs_initialize_file(dentry, inode);
> +		if (!rc)
> +			goto out;
> +	}
> +
> +	rc =3D -EIO;
> +out:
> +	mutex_unlock(&crypt_stat->cs_mutex);
> +	return rc;
> +}
> +
>  /**
>   * ecryptfs_open
>   * @inode: inode speciying file to open
> @@ -236,32 +278,7 @@ static int ecryptfs_open(struct inode *inode, struct=
 file *file)
>  		rc =3D 0;
>  		goto out;
>  	}
> -	mutex_lock(&crypt_stat->cs_mutex);
> -	if (!(crypt_stat->flags & ECRYPTFS_POLICY_APPLIED)
> -	    || !(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
> -		rc =3D ecryptfs_read_metadata(ecryptfs_dentry);
> -		if (rc) {
> -			ecryptfs_printk(KERN_DEBUG,
> -					"Valid headers not found\n");
> -			if (!(mount_crypt_stat->flags
> -			      & ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED)) {
> -				rc =3D -EIO;
> -				printk(KERN_WARNING "Either the lower file "
> -				       "is not in a valid eCryptfs format, "
> -				       "or the key could not be retrieved. "
> -				       "Plaintext passthrough mode is not "
> -				       "enabled; returning -EIO\n");
> -				mutex_unlock(&crypt_stat->cs_mutex);
> -				goto out_put;
> -			}
> -			rc =3D 0;
> -			crypt_stat->flags &=3D ~(ECRYPTFS_I_SIZE_INITIALIZED
> -					       | ECRYPTFS_ENCRYPTED);
> -			mutex_unlock(&crypt_stat->cs_mutex);
> -			goto out;
> -		}
> -	}
> -	mutex_unlock(&crypt_stat->cs_mutex);
> +	rc =3D read_or_initialize_metadata(ecryptfs_dentry);

I've discovered a problem with this patch. I didn't check the return
value of read_or_initialize_metadata() here. Adding this snippet fixes
the problem:

	if (rc)
		goto out_put;

I'll push the corrected patch to the eCryptfs next branch.

Tyler

>  	ecryptfs_printk(KERN_DEBUG, "inode w/ addr =3D [0x%p], i_ino =3D "
>  			"[0x%.16lx] size: [0x%.16llx]\n", inode, inode->i_ino,
>  			(unsigned long long)i_size_read(inode));
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 65efe5f..2d4143f 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -227,8 +227,8 @@ out:
>   *
>   * Returns zero on success
>   */
> -static int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
> -				    struct inode *ecryptfs_inode)
> +int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
> +			     struct inode *ecryptfs_inode)
>  {
>  	struct ecryptfs_crypt_stat *crypt_stat =3D
>  		&ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP4shlAAoJENaSAD2qAscK1DUP/jsH997ysZ9zjmNCkQemGDUY
N0PDA6FjRsBzaL6hEZAkk4I4PxTx7qCG+GzZkvWnjTejtoWkUMzarJz/gDSDjlj4
OHJp05H6ifG5AaVz95RiO3615hZZQ3aREgiAWZPDWeBbnuoswWx7jTMQKydlBvYk
v7MmDSIuTKv/YaKXRbQKkMeAwUiv6OPUdyMfOUPUwrKOXmph72s2jEE3LiLaFW9P
ozTOSu1ZbWPy5THOBrVpuGIEy+KFdMh5hforb38XL41tmVCueO2CYPgBEZRbx4dk
aMO7+vEcD52b+qxQDFSAJc8Urj+gS2bseU5NwmwfLfjgMp5xWW2JRifiq/0VxivP
tMiQ91YXQGUaUT6ufwWPniEuArbJAnHSU9SFDHOVAyFKaBfnVPrRpJzD4uGZ/t45
QFcapwU65pVFLI63LyfKAPWQBl0+GwWNfKLpxJR5mj9vSPuFdOBNgMgOuSZgVRNf
+LaFyUCQJf76B2ZHou/XpkF85680BhBl+Z/g9km6dVi4hBmFmhraqBJVjNanMR7y
UR660NkLzKNHwEcR+lGkDT5gJswTvcN0qy8tmQBR5lBwJ5DxthHatq+WiZUMtzwj
Rnt3wqOZv6U6IY+M44mLP7gRJPVD+rMhcQ3g8pcupDSvHWwtMg/tVHF2kxksPvje
FD5HSclpFlwvYScKU82/
=Shq/
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
