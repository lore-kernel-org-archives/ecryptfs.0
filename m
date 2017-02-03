From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 11/24] ecryptfs: Convert to separately allocated bdi
Date: Fri, 3 Feb 2017 17:54:14 -0600
Message-ID: <d8c88f4c-855f-b348-081e-6254092c235e@canonical.com>
References: <20170202173422.3240-1-jack@suse.cz>
 <20170202173422.3240-12-jack@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oeoHCUv7juUN7Fge42SrJS3BUeN7tHoJd"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45753 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbdBCXyZ (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 3 Feb 2017 18:54:25 -0500
In-Reply-To: <20170202173422.3240-12-jack@suse.cz>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oeoHCUv7juUN7Fge42SrJS3BUeN7tHoJd
Content-Type: multipart/mixed; boundary="4vGQcH84Im0bbLe3IHdQe1lbvFaxAa7iQ";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 ecryptfs@vger.kernel.org
Message-ID: <d8c88f4c-855f-b348-081e-6254092c235e@canonical.com>
Subject: Re: [PATCH 11/24] ecryptfs: Convert to separately allocated bdi
References: <20170202173422.3240-1-jack@suse.cz>
 <20170202173422.3240-12-jack@suse.cz>
In-Reply-To: <20170202173422.3240-12-jack@suse.cz>

--4vGQcH84Im0bbLe3IHdQe1lbvFaxAa7iQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 02/02/2017 11:34 AM, Jan Kara wrote:
> Allocate struct backing_dev_info separately instead of embedding it
> inside the superblock. This unifies handling of bdi among users.
>=20
> CC: Tyler Hicks <tyhicks@canonical.com>

Looks fine to me.

Acked-by: Tyler Hicks <tyhicks@canonical.com>

> CC: ecryptfs@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ecryptfs/ecryptfs_kernel.h | 1 -
>  fs/ecryptfs/main.c            | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kerne=
l.h
> index 599a29237cfe..e93444a4c4b1 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -349,7 +349,6 @@ struct ecryptfs_mount_crypt_stat {
>  struct ecryptfs_sb_info {
>  	struct super_block *wsi_sb;
>  	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
> -	struct backing_dev_info bdi;
>  };
> =20
>  /* file private data. */
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 151872dcc1f4..9014479d0160 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -519,12 +519,11 @@ static struct dentry *ecryptfs_mount(struct file_=
system_type *fs_type, int flags
>  		goto out;
>  	}
> =20
> -	rc =3D bdi_setup_and_register(&sbi->bdi, "ecryptfs");
> +	rc =3D super_setup_bdi(s);
>  	if (rc)
>  		goto out1;
> =20
>  	ecryptfs_set_superblock_private(s, sbi);
> -	s->s_bdi =3D &sbi->bdi;
> =20
>  	/* ->kill_sb() will take care of sbi after that point */
>  	sbi =3D NULL;
> @@ -633,7 +632,6 @@ static void ecryptfs_kill_block_super(struct super_=
block *sb)
>  	if (!sb_info)
>  		return;
>  	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
> -	bdi_destroy(&sb_info->bdi);
>  	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
>  }
> =20
>=20



--4vGQcH84Im0bbLe3IHdQe1lbvFaxAa7iQ--

--oeoHCUv7juUN7Fge42SrJS3BUeN7tHoJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYlRgmAAoJENaSAD2qAscKeNgQALCop0TqbKMV8gmvUtB4Fh6E
rxT/ANfrSchmxo7ZZghbVhaPU3GWZCd0EJCB02AZZC6Z29M7qvbFAvzGlLowTua6
VoyKhoGSvHxfawaDA5mIKThfYUOe5qoWzbAeXJVjImd+W0LdvIwh88uDgjzogq3A
jebKQBao2+r17gqJ+dc5arFjNQWIHobMoZiew9LIthq153gCjhwG8l5MSf05tWFs
jQfrIgnQ9OxVj/znE64FTOq0EyshaYeb+OSzvCS8LaAKOVTif47mkTCaR4BTKWVC
4IYnYYXxLr2pC8RbC/szDhc7CjL057fdHfTuwLcXlF7lenTdH3xpPjp1gUni3vqL
O0Pykr5WyENFKxsgoH3Pywgfq9WXd8faHNI5WrgvxiMdkPlS9R36GqLjfh7vEHI/
BlZi9tbQhGIgmlF1YZj+VezNfWReDgRrdGrLzIgMZvXzPgtZsv3TMBe4Adg5ccYq
6Ef4m34rGudu5UQYVbjKchH4tSJeZJ59Xi+5DY7vIzw0IiXUpXfnU5YgDdS0Y8GT
YbEH51mPhmRzsH76b65Ga+9acaP5Khtn2aEK3h0YWqOUV19Te+/qWJgi78+aJFod
6fRbeIgHp8emBJEU7+P+gXMfSxqsp6L8xAy/0ndjtbpAlB875aNYmJh0wx02IdpL
NDCFvl15q9tLy8PTTWOo
=bqRh
-----END PGP SIGNATURE-----

--oeoHCUv7juUN7Fge42SrJS3BUeN7tHoJd--
