From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 5/9] Use %pd in eCryptFS
Date: Tue, 17 Dec 2013 09:45:19 -0800
Message-ID: <20131217174519.GA5177@boyd>
References: <20131210152612.4916.80435.stgit@warthog.procyon.org.uk>
 <20131210152648.4916.63963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131210152648.4916.63963.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-12-10 15:26:48, David Howells wrote:
> Use the new %pd printk() specifier in eCryptFS to replace passing of dent=
ry
> name or dentry name and name length * 2 with just passing the dentry.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Tyler Hicks <tyhicks@canonical.com>

Acked-by: Tyler Hicks <tyhicks@canonical.com>

Thanks for the patch! It looks like you're asking the individual
filesystem maintainers to carry the patch so I'll throw it into my -next
branch.

Tyler

> cc: ecryptfs@vger.kernel.org
> ---
>=20
>  fs/ecryptfs/file.c  |    4 ++--
>  fs/ecryptfs/inode.c |   12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index b1eaa7a1f82c..c705360e2b16 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -230,8 +230,8 @@ static int ecryptfs_open(struct inode *inode, struct =
file *file)
>  	if (rc) {
>  		printk(KERN_ERR "%s: Error attempting to initialize "
>  			"the lower file for the dentry with name "
> -			"[%s]; rc =3D [%d]\n", __func__,
> -			ecryptfs_dentry->d_name.name, rc);
> +			"[%pd]; rc =3D [%d]\n", __func__,
> +			ecryptfs_dentry, rc);
>  		goto out_free;
>  	}
>  	if ((ecryptfs_inode_to_private(inode)->lower_file->f_flags & O_ACCMODE)
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index c36c44824471..87ad33e091e9 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -250,8 +250,8 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_=
dentry,
>  	if (rc) {
>  		printk(KERN_ERR "%s: Error attempting to initialize "
>  			"the lower file for the dentry with name "
> -			"[%s]; rc =3D [%d]\n", __func__,
> -			ecryptfs_dentry->d_name.name, rc);
> +			"[%pd]; rc =3D [%d]\n", __func__,
> +			ecryptfs_dentry, rc);
>  		goto out;
>  	}
>  	rc =3D ecryptfs_write_metadata(ecryptfs_dentry, ecryptfs_inode);
> @@ -313,8 +313,8 @@ static int ecryptfs_i_size_read(struct dentry *dentry=
, struct inode *inode)
>  	if (rc) {
>  		printk(KERN_ERR "%s: Error attempting to initialize "
>  			"the lower file for the dentry with name "
> -			"[%s]; rc =3D [%d]\n", __func__,
> -			dentry->d_name.name, rc);
> +			"[%pd]; rc =3D [%d]\n", __func__,
> +			dentry, rc);
>  		return rc;
>  	}
> =20
> @@ -418,8 +418,8 @@ static struct dentry *ecryptfs_lookup(struct inode *e=
cryptfs_dir_inode,
>  	if (IS_ERR(lower_dentry)) {
>  		rc =3D PTR_ERR(lower_dentry);
>  		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
> -				"[%d] on lower_dentry =3D [%s]\n", __func__, rc,
> -				ecryptfs_dentry->d_name.name);
> +				"[%d] on lower_dentry =3D [%pd]\n", __func__, rc,
> +				ecryptfs_dentry);
>  		goto out;
>  	}
>  	if (lower_dentry->d_inode)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSsI2vAAoJENaSAD2qAscKBP0QALnr62ZgpIdZfr4+YAZmq5uT
I2UFEHdrMlAgNSlKbSk6yLsglWSmoM84J4ixWs60Rn+fqOJLMgmbVCgTGV3gS6/I
NBfQ/9qJCG5uoAnArxnBJOK9OhAxQoaO9M7TpfOk8i11CY6NrAxWr9Hcl5AQbPIw
KcNl3MDE/LRH2qhhBSC7tD1Qh7JluNAbUacI77mvPo3I9vd7tfipEKkWtOi8eM1q
wU+9Ix/QDRpKynUN5szPaH1uHRDKN+lL+tcmLJaYmCwwd5p2+QOFz4pYK+aZfaWP
VrFycPAzKdWCCZ+eWtepZGDbYinGsiTcLe2Q9MXn3kSqb6Hxd17Df09ypFOAWmPb
gVB6pnfAKnbpIjV3D9dHENOB+UYoCr6FmxxZ7qiR6DTKFTesbPBSemUgN8X+sZUm
zLWGzFnho2Ed45kKiTrAJ2skhbPtxge0BdsDC0xJQyt8mPIEgesmTrXBvtHdv0Wz
S6MsNlyVqD2+Ymj/Q6HpFKcxwQIe86qQRrlB4EbQ2XP0U9awFO0H0JPZrTDtQGaR
YcrMm+niJvB3VQ3QVwvgJMrUwM0uMJjc5uCdwHNivtV2Kh3woI3kto4ICwVxki/o
+IFyl9lrS75ueZWLGWmSfo5ihnfXDwegouI8XSiaNFTBSQfpISupYMn5CrLrpWsQ
4pQ3XgRo+dGqrz45S04t
=00SJ
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
