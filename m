From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: open lower files on kthread under SELinux
Date: Fri, 8 Apr 2016 19:15:03 -0500
Message-ID: <20160409001502.GC25631@boyd>
References: <1459478198-37952-1-git-send-email-rickyz@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58655 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbcDIAPJ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 8 Apr 2016 20:15:09 -0400
Content-Disposition: inline
In-Reply-To: <1459478198-37952-1-git-send-email-rickyz@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Ricky Zhou <rickyz@chromium.org>
Cc: ecryptfs@vger.kernel.org, keescook@chromium.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-03-31 19:36:38, Ricky Zhou wrote:
> When SELinux is enabled, files are associated with the current task's
> SID when they are opened. Before this change, the lower file would
> sometimes be associated with the SID of the first process to open the
> corresponding eCryptfs file. If a second process attempts to access this
> file through the same lower file, the access is denied unless the
> SELinux policy allows the second process to use files opened by the
> first process (the FD__USE permission).
>=20
> Since it may not be desirable to allow all processes this permission,
> this change always opens the lower file from a thread with the kernel
> SID. This way, the policy only needs to grant all processes FD__USE on
> the kernel context (which in practice, is exactly the use of eCryptfs
> lower files).

Hi Ricky - Thanks for patch!

This is interesting because it gets close to fixing a long standing bug
with eCryptfs and AppArmor. Access has to be granted to the lower
mountpoint in AppArmor profiles of processes that deal with files in
eCryptfs mounts. It is similar to the eCryptfs and SELinux bug that
you're trying to address.

Because of the AppArmor issue, I initially thought to recommend *always*
delegating lower opens to the kthread. If we're looking at doing it when
AppArmor or SELinux are enabled, I think we're talking about a good
number of Linux systems. We might as well always do it.

However, I don't think that this patch is the final solution that I'd
like to see. There are a couple reasons:

1) The kthread doesn't look like it will perform well enough to handle
   all lower opens. We could probably squeeze some extra performance out
   of it but I think the better solution is to temporarily change creds,
   do the lower open, and change back to the original cred. See callers
   of prepare_creds() for examples of this.

2) I don't think that delegating open() is sufficient. What about inode
   based operations such as chown()? I think that we'll have a very
   similar problem.

I wanted to have a little bit better solution planned out before
responding but I haven't had sufficient time. I'll give it some more
thought. Feel free to make suggestions in the meantime. :)

Tyler

>=20
> Signed-off-by: Ricky Zhou <rickyz@chromium.org>
> ---
>  fs/ecryptfs/kthread.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
> index 866bb18..0ce7828 100644
> --- a/fs/ecryptfs/kthread.c
> +++ b/fs/ecryptfs/kthread.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/mount.h>
> +#include <linux/selinux.h>
>  #include "ecryptfs_kernel.h"
> =20
>  struct ecryptfs_open_req {
> @@ -141,17 +142,30 @@ int ecryptfs_privileged_open(struct file **lower_fi=
le,
>  	req.path.dentry =3D lower_dentry;
>  	req.path.mnt =3D lower_mnt;
> =20
> -	/* Corresponding dput() and mntput() are done when the
> -	 * lower file is fput() when all eCryptfs files for the inode are
> -	 * released. */
> -	flags |=3D IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
> -	(*lower_file) =3D dentry_open(&req.path, flags, cred);
> -	if (!IS_ERR(*lower_file))
> -		goto out;
> -	if ((flags & O_ACCMODE) =3D=3D O_RDONLY) {
> -		rc =3D PTR_ERR((*lower_file));
> -		goto out;
> +	/*
> +	 * When SELinux is enabled, force the lower file to be opened by the
> +	 * kernel thread. Otherwise, the lower file will be associated with the
> +	 * SELinux context of the first process that opens it, which may prevent
> +	 * a different process from using it, unless that process has permission
> +	 * to use fds from the first process.
> +	 *
> +	 * If SELinux is enabled, then any process that needs read access to an
> +	 * ecryptfs filesytem must allow fd:use on the kernel context.
> +	 */
> +	if (!selinux_is_enabled()) {
> +		/* Corresponding dput() and mntput() are done when the lower
> +		 * file is fput() when all eCryptfs files for the inode are
> +		 * released. */
> +		flags |=3D IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
> +		(*lower_file) =3D dentry_open(&req.path, flags, cred);
> +		if (!IS_ERR(*lower_file))
> +			goto out;
> +		if ((flags & O_ACCMODE) =3D=3D O_RDONLY) {
> +			rc =3D PTR_ERR((*lower_file));
> +			goto out;
> +		}
>  	}
> +
>  	mutex_lock(&ecryptfs_kthread_ctl.mux);
>  	if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
>  		rc =3D -EIO;
> --=20
> 2.8.0.rc3.226.g39d4020
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXCEmGAAoJENaSAD2qAscK+D0QAKa23pEOKATj/7q31XqHBdSI
5w8kpA7Kalfp12LYYINO4uAAxBA+ph1tH3DP2UhLT7c690rCAr1HuDdbgxQfGfHo
JgIZSbXjdGBJKW9rseJAp6fxE1Iylo1apkX6xrax3dCErjl5chBlI8o0yWxNE+Q8
gHSaVqaFCq0Lzu3PhznZVfpg2ZSQ9BEP3omGgv5lF1f4K8J1zl6Nlzcvpu8ZCNJJ
p329Kbe8kq+stp//JUAbYdBDSHdoGSx5GIiiBY+Y4JroT4khWQ0UEnKqiO1X0/cH
r55S6NxEPjqbYO2RFI1wnQA48jsKfVsOmQW4/YsUdmHCUe6xLiI03C/aU0oxc+cC
Tl2mSUBGkGSqtgU0wzSKm40TGx9kBmmRspipoGD8lSHU4W8h3b2nVTQcG+TvgdhG
bP3A3o4bypfIl3WpRCV4LZTirA53Dbsqimg98PqCJRxTU4cyj6AOaj7i/PD69Gj2
GsCCRk3i8EwUZ6C/11LghxE86Gt6XfU/m+jsD2Qrn1ew6MuOju207VR2YBFNpavA
fOjakP3NJ0yrufMLKUf4Ktz8a3NQdinMgXTc4IVZWhlDg8IR2EPsOmdvsFrjQZlT
9pPvvNTETkn/r/RxuGcVmAESyCkfzxS5MMe3bH7KGLdTgRWaezQEF44B3bgWOOyD
u1hq1nrHGA1tXY3C+6R8
=jaul
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
