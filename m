From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2] ecryptfs: open lower files using kernel creds
Date: Fri, 29 Apr 2016 19:23:02 -0500
Message-ID: <20160430002302.GB3296@boyd>
References: <1460456144-27669-1-git-send-email-rickyz@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42752 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcD3AXH (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 29 Apr 2016 20:23:07 -0400
Content-Disposition: inline
In-Reply-To: <1460456144-27669-1-git-send-email-rickyz@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Ricky Zhou <rickyz@chromium.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, keescook@chromium.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-04-12 03:15:44, Ricky Zhou wrote:
> In LSMs such as SELinux, files can be associated with state from the
> credentials of the task that opens it. Since ecryptfs shares a single
> handle to lower files across tasks that access it, others tasks can
> later be denied access to the lower file as a result.
>=20
> This change removes the kthread and unconditionally opens lower files
> with kernel service credentials. Under SELinux, users will need to allow
> the FD__USE permissions on the kernel context to process that need to
> access files on an ecryptfs filesystem.
>=20
> Signed-off-by: Ricky Zhou <rickyz@chromium.org>
> ---
>  fs/ecryptfs/Makefile          |   2 +-
>  fs/ecryptfs/ecryptfs_kernel.h |   4 -
>  fs/ecryptfs/kthread.c         | 172 ------------------------------------=
------
>  fs/ecryptfs/main.c            |  78 +++++++++++++++----
>  4 files changed, 65 insertions(+), 191 deletions(-)
>  delete mode 100644 fs/ecryptfs/kthread.c
>=20
> diff --git a/fs/ecryptfs/Makefile b/fs/ecryptfs/Makefile
> index 49678a6..f0bcf51 100644
> --- a/fs/ecryptfs/Makefile
> +++ b/fs/ecryptfs/Makefile
> @@ -5,6 +5,6 @@
>  obj-$(CONFIG_ECRYPT_FS) +=3D ecryptfs.o
> =20
>  ecryptfs-y :=3D dentry.o file.o inode.o main.o super.o mmap.o read_write=
=2Eo \
> -	      crypto.o keystore.o kthread.o debug.o
> +	      crypto.o keystore.o debug.o
> =20
>  ecryptfs-$(CONFIG_ECRYPT_FS_MESSAGING) +=3D messaging.o miscdev.o
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index d123fba..6434736 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -695,10 +695,6 @@ int ecryptfs_find_daemon_by_euid(struct ecryptfs_dae=
mon **daemon);
>  #endif
>  int ecryptfs_init_kthread(void);
>  void ecryptfs_destroy_kthread(void);

The ecryptfs_{init,destroy}_kthread() declarations also need to be
removed.

> -int ecryptfs_privileged_open(struct file **lower_file,
> -			     struct dentry *lower_dentry,
> -			     struct vfsmount *lower_mnt,
> -			     const struct cred *cred);
>  int ecryptfs_get_lower_file(struct dentry *dentry, struct inode *inode);
>  void ecryptfs_put_lower_file(struct inode *inode);
>  int
> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
> deleted file mode 100644
> index 866bb18..0000000
> --- a/fs/ecryptfs/kthread.c
> +++ /dev/null
> @@ -1,172 +0,0 @@
> -/**
> - * eCryptfs: Linux filesystem encryption layer
> - *
> - * Copyright (C) 2008 International Business Machines Corp.
> - *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
> - * 02111-1307, USA.
> - */
> -
> -#include <linux/kthread.h>
> -#include <linux/freezer.h>
> -#include <linux/slab.h>
> -#include <linux/wait.h>
> -#include <linux/mount.h>
> -#include "ecryptfs_kernel.h"
> -
> -struct ecryptfs_open_req {
> -	struct file **lower_file;
> -	struct path path;
> -	struct completion done;
> -	struct list_head kthread_ctl_list;
> -};
> -
> -static struct ecryptfs_kthread_ctl {
> -#define ECRYPTFS_KTHREAD_ZOMBIE 0x00000001
> -	u32 flags;
> -	struct mutex mux;
> -	struct list_head req_list;
> -	wait_queue_head_t wait;
> -} ecryptfs_kthread_ctl;
> -
> -static struct task_struct *ecryptfs_kthread;
> -
> -/**
> - * ecryptfs_threadfn
> - * @ignored: ignored
> - *
> - * The eCryptfs kernel thread that has the responsibility of getting
> - * the lower file with RW permissions.
> - *
> - * Returns zero on success; non-zero otherwise
> - */
> -static int ecryptfs_threadfn(void *ignored)
> -{
> -	set_freezable();
> -	while (1)  {
> -		struct ecryptfs_open_req *req;
> -
> -		wait_event_freezable(
> -			ecryptfs_kthread_ctl.wait,
> -			(!list_empty(&ecryptfs_kthread_ctl.req_list)
> -			 || kthread_should_stop()));
> -		mutex_lock(&ecryptfs_kthread_ctl.mux);
> -		if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
> -			mutex_unlock(&ecryptfs_kthread_ctl.mux);
> -			goto out;
> -		}
> -		while (!list_empty(&ecryptfs_kthread_ctl.req_list)) {
> -			req =3D list_first_entry(&ecryptfs_kthread_ctl.req_list,
> -					       struct ecryptfs_open_req,
> -					       kthread_ctl_list);
> -			list_del(&req->kthread_ctl_list);
> -			*req->lower_file =3D dentry_open(&req->path,
> -				(O_RDWR | O_LARGEFILE), current_cred());
> -			complete(&req->done);
> -		}
> -		mutex_unlock(&ecryptfs_kthread_ctl.mux);
> -	}
> -out:
> -	return 0;
> -}
> -
> -int __init ecryptfs_init_kthread(void)
> -{
> -	int rc =3D 0;
> -
> -	mutex_init(&ecryptfs_kthread_ctl.mux);
> -	init_waitqueue_head(&ecryptfs_kthread_ctl.wait);
> -	INIT_LIST_HEAD(&ecryptfs_kthread_ctl.req_list);
> -	ecryptfs_kthread =3D kthread_run(&ecryptfs_threadfn, NULL,
> -				       "ecryptfs-kthread");
> -	if (IS_ERR(ecryptfs_kthread)) {
> -		rc =3D PTR_ERR(ecryptfs_kthread);
> -		printk(KERN_ERR "%s: Failed to create kernel thread; rc =3D [%d]"
> -		       "\n", __func__, rc);
> -	}
> -	return rc;
> -}
> -
> -void ecryptfs_destroy_kthread(void)
> -{
> -	struct ecryptfs_open_req *req, *tmp;
> -
> -	mutex_lock(&ecryptfs_kthread_ctl.mux);
> -	ecryptfs_kthread_ctl.flags |=3D ECRYPTFS_KTHREAD_ZOMBIE;
> -	list_for_each_entry_safe(req, tmp, &ecryptfs_kthread_ctl.req_list,
> -				 kthread_ctl_list) {
> -		list_del(&req->kthread_ctl_list);
> -		*req->lower_file =3D ERR_PTR(-EIO);
> -		complete(&req->done);
> -	}
> -	mutex_unlock(&ecryptfs_kthread_ctl.mux);
> -	kthread_stop(ecryptfs_kthread);
> -	wake_up(&ecryptfs_kthread_ctl.wait);
> -}
> -
> -/**
> - * ecryptfs_privileged_open
> - * @lower_file: Result of dentry_open by root on lower dentry
> - * @lower_dentry: Lower dentry for file to open
> - * @lower_mnt: Lower vfsmount for file to open
> - *
> - * This function gets a r/w file opened againt the lower dentry.
> - *
> - * Returns zero on success; non-zero otherwise
> - */
> -int ecryptfs_privileged_open(struct file **lower_file,
> -			     struct dentry *lower_dentry,
> -			     struct vfsmount *lower_mnt,
> -			     const struct cred *cred)
> -{
> -	struct ecryptfs_open_req req;
> -	int flags =3D O_LARGEFILE;
> -	int rc =3D 0;
> -
> -	init_completion(&req.done);
> -	req.lower_file =3D lower_file;
> -	req.path.dentry =3D lower_dentry;
> -	req.path.mnt =3D lower_mnt;
> -
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
> -	}
> -	mutex_lock(&ecryptfs_kthread_ctl.mux);
> -	if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
> -		rc =3D -EIO;
> -		mutex_unlock(&ecryptfs_kthread_ctl.mux);
> -		printk(KERN_ERR "%s: We are in the middle of shutting down; "
> -		       "aborting privileged request to open lower file\n",
> -			__func__);
> -		goto out;
> -	}
> -	list_add_tail(&req.kthread_ctl_list, &ecryptfs_kthread_ctl.req_list);
> -	mutex_unlock(&ecryptfs_kthread_ctl.mux);
> -	wake_up(&ecryptfs_kthread_ctl.wait);
> -	wait_for_completion(&req.done);
> -	if (IS_ERR(*lower_file))
> -		rc =3D PTR_ERR(*lower_file);
> -out:
> -	return rc;
> -}
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 1698132..9459fbb 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -24,6 +24,7 @@
>   * 02111-1307, USA.
>   */
> =20
> +#include <linux/cred.h>
>  #include <linux/dcache.h>
>  #include <linux/file.h>
>  #include <linux/module.h>
> @@ -95,6 +96,56 @@ void __ecryptfs_printk(const char *fmt, ...)
>  }
> =20
>  /**
> + * Credentials for opening lower files.
> + */
> +static const struct cred *kernel_cred;
> +
> +/**
> + * ecryptfs_privileged_open
> + * @lower_file: Result of dentry_open by root on lower dentry
> + * @lower_dentry: Lower dentry for file to open
> + * @lower_mnt: Lower vfsmount for file to open
> + *
> + * This function gets a r/w file opened againt the lower dentry.

s/againt/against/

> + *
> + * Returns zero on success; non-zero otherwise
> + */
> +static int ecryptfs_privileged_open(struct file **lower_file,
> +				    struct dentry *lower_dentry,
> +				    struct vfsmount *lower_mnt)
> +{
> +	struct path path;
> +	int flags =3D O_LARGEFILE;
> +	int rc =3D 0;
> +	const struct cred *old_cred;
> +
> +	path.dentry =3D lower_dentry;
> +	path.mnt =3D lower_mnt;
> +	flags |=3D IS_RDONLY(d_inode(lower_dentry)) ? O_RDONLY : O_RDWR;
> +
> +	/*
> +	 * Use kernel service credentials to open the lower file, as the current
> +	 * task may not have write privileges.  Uses kernel creds instead of
> +	 * normal creds with CAP_DAC_OVERRIDE because because some LSMs like
> +	 * SELinux associate the file with extra state from the current
> +	 * credentials. When this happens, access to the lower file can
> +	 * be affected by which task was the first to open it.
> +	 */
> +	old_cred =3D override_creds(kernel_cred);

Do you know if we have to call override_creds() here or can we simply
pass kernel_cred to dentry_open()?

The LSMs would get kernel_cred passed to their file_open hook but I'm
wondering if we could potentially hit an issue where we don't have
enough privs when calling into a filesystem's d_op->d_select_inode() or
f_op->open().

> +
> +	/* Corresponding dput() and mntput() are done when the
> +	 * lower file is fput() when all eCryptfs files for the inode are
> +	 * released. */
> +	(*lower_file) =3D dentry_open(&path, flags, kernel_cred);
> +
> +	revert_creds(old_cred);
> +
> +	if (IS_ERR(*lower_file))
> +		rc =3D PTR_ERR(*lower_file);
> +	return rc;
> +}
> +
> +/**
>   * ecryptfs_init_lower_file
>   * @ecryptfs_dentry: Fully initialized eCryptfs dentry object, with
>   *                   the lower dentry and the lower mount set
> @@ -118,12 +169,10 @@ void __ecryptfs_printk(const char *fmt, ...)
>  static int ecryptfs_init_lower_file(struct dentry *dentry,
>  				    struct file **lower_file)
>  {
> -	const struct cred *cred =3D current_cred();
>  	struct path *path =3D ecryptfs_dentry_to_lower_path(dentry);
>  	int rc;
> =20
> -	rc =3D ecryptfs_privileged_open(lower_file, path->dentry, path->mnt,
> -				      cred);
> +	rc =3D ecryptfs_privileged_open(lower_file, path->dentry, path->mnt);
>  	if (rc) {
>  		printk(KERN_ERR "Error opening lower file "
>  		       "for lower_dentry [0x%p] and lower_mnt [0x%p]; "
> @@ -829,29 +878,30 @@ static int __init ecryptfs_init(void)
>  				(unsigned long)PAGE_SIZE);
>  		goto out;
>  	}
> +	kernel_cred =3D prepare_kernel_cred(NULL);

I see the prepare_kernel_cred(NULL) results in the capabilities being
set to CAP_FULL_SET. I don't love the thought of that because I don't
think it is necessary. To reduce the potential for mistakes/abuse, I'd
like to see us use a kernel cred that has the bare minimum set of caps
that is needed to perform this dentry_open().


I think we're getting close to landing on a final patch. Thanks for
being patient with my slow review turnarounds. Things have been busy
with the Ubuntu 16.04 release.

Tyler

> +	if (kernel_cred =3D=3D NULL) {
> +		rc =3D -ENOMEM;
> +		ecryptfs_printk(KERN_ERR,
> +				"Failed to prepare kernel credentials\n");
> +		goto out;
> +	}
>  	rc =3D ecryptfs_init_kmem_caches();
>  	if (rc) {
>  		printk(KERN_ERR
>  		       "Failed to allocate one or more kmem_cache objects\n");
> -		goto out;
> +		goto out_put_cred;
>  	}
>  	rc =3D do_sysfs_registration();
>  	if (rc) {
>  		printk(KERN_ERR "sysfs registration failed\n");
>  		goto out_free_kmem_caches;
>  	}
> -	rc =3D ecryptfs_init_kthread();
> -	if (rc) {
> -		printk(KERN_ERR "%s: kthread initialization failed; "
> -		       "rc =3D [%d]\n", __func__, rc);
> -		goto out_do_sysfs_unregistration;
> -	}
>  	rc =3D ecryptfs_init_messaging();
>  	if (rc) {
>  		printk(KERN_ERR "Failure occurred while attempting to "
>  				"initialize the communications channel to "
>  				"ecryptfsd\n");
> -		goto out_destroy_kthread;
> +		goto out_do_sysfs_unregistration;
>  	}
>  	rc =3D ecryptfs_init_crypto();
>  	if (rc) {
> @@ -873,12 +923,12 @@ out_destroy_crypto:
>  	ecryptfs_destroy_crypto();
>  out_release_messaging:
>  	ecryptfs_release_messaging();
> -out_destroy_kthread:
> -	ecryptfs_destroy_kthread();
>  out_do_sysfs_unregistration:
>  	do_sysfs_unregistration();
>  out_free_kmem_caches:
>  	ecryptfs_free_kmem_caches();
> +out_put_cred:
> +	put_cred(kernel_cred);
>  out:
>  	return rc;
>  }
> @@ -892,10 +942,10 @@ static void __exit ecryptfs_exit(void)
>  		printk(KERN_ERR "Failure whilst attempting to destroy crypto; "
>  		       "rc =3D [%d]\n", rc);
>  	ecryptfs_release_messaging();
> -	ecryptfs_destroy_kthread();
>  	do_sysfs_unregistration();
>  	unregister_filesystem(&ecryptfs_fs_type);
>  	ecryptfs_free_kmem_caches();
> +	put_cred(kernel_cred);
>  }
> =20
>  MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
> --=20
> 2.8.0.rc3.226.g39d4020
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXI/rmAAoJENaSAD2qAscKF1gQALD271HuUvPwtNrXLbKcK3vX
ZCx12YXu/QL4A/olRNTZmusjCUQrTKBNv4/zm0eLYQ2fza6Jbmo9Lz9We+EFtcVT
LoPoTXr4y78oiEYjX2/+Z0b2B04r6eFw6ZJ6cGqeexzXKIDCnP5Gu2+eaix5I6gB
RfYZbtIjfsXmuH9Pa/q099hd+QbwNGHzjbOywkZDzuga4NITODIwX+mmqSvsNQOd
ObJ8JIwTZx3cdkFhUdUbebhfUfVhh8JRdvDClAmYPtcLAbt1S72C6PYsWnKLxNC2
dwsuAuUXB8SbOXnR92rIHXGVzSdR0lM2LNJvXJcB4UBsZSzOVXH+nc3MLMFFQOrQ
/fZ0vM2BGBN6HnGA+VjkcZgGMkBA+shIq7UTd6B2oXoKpvceSa0IW826zprEUBfU
E0xYo+j5B3grn1UxCDCVUKDpmXidnDYLyclRKE3CO5eTmiKE2Gq7+4blSYYpN5A+
KzvcDa+34dDaT3qND/7iU3lu9AJoh22LPZ7494DcKWSJLzBFuO4oS6N6Nrtsm5Ot
T43Wg271RUHemcXGHHBRCFlr5pR0DJ1Ts76+su+Cgnt44r7VqlTbcc7ERhnSyYfA
hb0tMRlEFgHi66ChgDZyWfwtI7+qr2vbEmy1B2J5QtMjPvhHzUMkmOw6BkZ6Izov
S+1uP5KQ17mupvIBFaZX
=9hYE
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
