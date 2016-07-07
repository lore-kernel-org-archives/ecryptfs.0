From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
Date: Thu, 7 Jul 2016 18:20:08 -0500
Message-ID: <577EE3A8.4030106@canonical.com>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="07932sxcFQ1kC8ItbsuBljniD0trDsJvE"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1467754350-8995-2-git-send-email-jeffm@suse.com>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: jeffm@suse.com, ecryptfs@vger.kernel.org
Cc: Jann Horn <jann@thejh.net>, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--07932sxcFQ1kC8ItbsuBljniD0trDsJvE
Content-Type: multipart/mixed; boundary="uBG2mCNf3sVskV44nfXeCPgjAiJl5wo8q"
From: Tyler Hicks <tyhicks@canonical.com>
To: jeffm@suse.com, ecryptfs@vger.kernel.org
Cc: Jann Horn <jann@thejh.net>, stable@vger.kernel.org
Message-ID: <577EE3A8.4030106@canonical.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
In-Reply-To: <1467754350-8995-2-git-send-email-jeffm@suse.com>

--uBG2mCNf3sVskV44nfXeCPgjAiJl5wo8q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/05/2016 04:32 PM, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
>=20
> There are legitimate reasons to disallow mmap on certain files, notably=

> in sysfs or procfs.  We shouldn't emulate mmap support on file systems
> that don't offer support natively.
>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  fs/ecryptfs/file.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index 7000b96..4aaa656 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -169,6 +169,20 @@ out:
>  	return rc;
>  }
> =20
> +
> +static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma=
)
> +{
> +	struct dentry *dentry =3D ecryptfs_dentry_to_lower(file_dentry(file))=
;

This should be:

	struct file *lower_file =3D ecryptfs_file_to_lower(file);

> +	/*
> +	 * Don't allow mmap on top of file systems that don't support it
> +	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
> +	 * allows recursive mounting, this will need to be extended.
> +	 */
> +	if (!d_inode(dentry)->i_fop->mmap)

and then:

	if (!lower_file->f_op->mmap)


I'll make these simple changes, add stable to cc in the patch tags, and
push to Linus.

Thanks again!

Tyler

> +		return -ENODEV;
> +	return generic_file_mmap(file, vma);
> +}
> +
>  /**
>   * ecryptfs_open
>   * @inode: inode speciying file to open
> @@ -403,7 +417,7 @@ const struct file_operations ecryptfs_main_fops =3D=
 {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl =3D ecryptfs_compat_ioctl,
>  #endif
> -	.mmap =3D generic_file_mmap,
> +	.mmap =3D ecryptfs_mmap,
>  	.open =3D ecryptfs_open,
>  	.flush =3D ecryptfs_flush,
>  	.release =3D ecryptfs_release,
>=20



--uBG2mCNf3sVskV44nfXeCPgjAiJl5wo8q--

--07932sxcFQ1kC8ItbsuBljniD0trDsJvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXfuOoAAoJENaSAD2qAscK47cP/35WUcS32NTKXLRee5bGPMQi
qIis2XSs5Uch3vs0c49lmXN7gufpAvIAvuC7Q1VYTy1gorLQcHrVI08ZcMGsgvBn
m1plK9D5U3t9yUJfXyBjOth/B9u6WKylucMv6aFYeS7lp4OxS3n/yjLICxvO7G6d
MMzs+KuImMThk2RezYgXyOATEq7ahnfm5w91kf0+4GjyCreApWjWogMJThZYuGYL
BqcO+eg07BoIGWNjxgQwbBDK5k7RqhGwVX66XtRswi4tjAVYm+C4xgPCqup9aQ9c
09FB3DsrwXEQtN5EQDIYqUBfH3J6zwefAEuvVEQid/xTBJWndWKBV+74S0r3JkIf
FF7kwLYtZ8YreVY8syyN8kuyGvUnmFWbQ5jgE6Fw3Zt88eSOIUZ9dLlnOWffDFqi
y1Eo2vzzpbqluj9E86yOjHlGEViK5hO7EqOCZHNIU0MPMBQhQzP7ae+RPzYekSuq
aiE8MEnAgUtt9rZJYY9Mip1fB5VKtlU2th8RQSw4rs+oT0q+8k93bqBw6VTPMF1+
OPxjv0/T0hxz76hMfWcLH8ny68Lvi3vnGRtp+QAYkb+tQbp/3fZhNzwCyKV3icMj
doNVct/Veuqe16f0RAVrb5Mp9xTrr1qcNbGikZcXC4CDHod76EyqTZFPO7tONVc2
gBi1EzOQcTgwCFgT4va8
=VxEL
-----END PGP SIGNATURE-----

--07932sxcFQ1kC8ItbsuBljniD0trDsJvE--
