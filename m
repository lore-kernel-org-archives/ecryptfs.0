From: Jann Horn <jann@thejh.net>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
Date: Tue, 5 Jul 2016 23:57:40 +0200
Message-ID: <20160705215740.GA14388@pc.thejh.net>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467754350-8995-2-git-send-email-jeffm@suse.com>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: jeffm@suse.com
Cc: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, stable@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 05:32:30PM -0400, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
>=20
> There are legitimate reasons to disallow mmap on certain files, notably
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
> +static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct dentry *dentry =3D ecryptfs_dentry_to_lower(file_dentry(file));
> +	/*
> +	 * Don't allow mmap on top of file systems that don't support it
> +	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
> +	 * allows recursive mounting, this will need to be extended.

Or if another new stacking filesystem appears whose f_op->mmap just forwards
to lower_f_op->mmap - but thinking about it, in that scenario, my patch
would stop working, too.

At this point, I dislike both this patch and my own one because of their
lack of robustness. Well, at least e54ad7f1ee263ffa5a2de9c609d58dfa27b21cd9
should be solid. :/


> +	 */
> +	if (!d_inode(dentry)->i_fop->mmap)
> +		return -ENODEV;
> +	return generic_file_mmap(file, vma);
> +}
> +
>  /**
>   * ecryptfs_open
>   * @inode: inode speciying file to open
> @@ -403,7 +417,7 @@ const struct file_operations ecryptfs_main_fops =3D {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl =3D ecryptfs_compat_ioctl,
>  #endif
> -	.mmap =3D generic_file_mmap,
> +	.mmap =3D ecryptfs_mmap,
>  	.open =3D ecryptfs_open,
>  	.flush =3D ecryptfs_flush,
>  	.release =3D ecryptfs_release,
> --=20
> 2.7.1
>=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfC1UAAoJED4KNFJOeCOoZEkQAKtQMWVyjdbqyUKzE4zM0p+C
FKEg19f/NM5LEQjwDfec4MSIq77zkRdAgQ1BnCmnELCl2XK70wCZtPnca/VoJAA3
nAOkjQAjE1vx7bFmMhk+ChGKI2/0dJaWL3eL247b2yiQEsLoxkdQmirQbCGv+VMJ
SFgbLybdmXvLIexO4f2mmKeJqD72xMRvJPIWnLBWH5Gc6Gn1bdyF5uYTch3bgBlU
zVTvDF+Hgk9+0BPjrYDc2BxGNtltRJhA9y1Wv3NoefuDut+/hU/QPgcLqlcQsYjI
2XFLsK4zp9v3Z9YF76nV1W28HpPfsmiRNLiAwzAunUAMbUC3fIoGXktYSW/yesgs
LbrWmgxrj8lsQkGgVzrd//rxPzUCUuya0NZpAeqG/YUWQI06SPSD1CmhMxrwhPof
LJRJEAlyNirm5GOzxmSdGkM12Rcuj9ExA2i/Lo7KX+6ZuaeS30gE5SF+QF3qvxbQ
a0P2WvmIq0aHjpyqDYblV4COtUAKv5CGtHvEQa4tmrS/FsN8ei6c4EKk9dineglk
gP2V8LNqQBUJ2yyE2nsWavhwtQoxmtRueQ2K85F+0ua9ilWsV/+y6/gcH1jj+w+x
6wang5CC8uvwgFFCw2fYg5/ZO4shV+0AW9+3qq/OTophVvvTCGlv+5D1Izqx0EtX
CHIUtZCVqAjMJHmbaxpN
=edfn
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
