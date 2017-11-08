From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: Fix stat command displays wrong file size in
 xattr region
Date: Tue, 7 Nov 2017 18:22:08 -0600
Message-ID: <ef57ab68-f081-e762-7321-4dd7c3b33c33@canonical.com>
References: <1498116075-2195-1-git-send-email-kerneljasonxing@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="C5qdTpGPae3OXCeXGMRDM8sDPR9TXXRwb"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49706 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdKHAWP (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 7 Nov 2017 19:22:15 -0500
In-Reply-To: <1498116075-2195-1-git-send-email-kerneljasonxing@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>, ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C5qdTpGPae3OXCeXGMRDM8sDPR9TXXRwb
Content-Type: multipart/mixed; boundary="JXrDXnke9lqKPKbDC35T8BwQdsiMAi9Nf";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Jason Xing <kerneljasonxing@gmail.com>, ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <ef57ab68-f081-e762-7321-4dd7c3b33c33@canonical.com>
Subject: Re: [PATCH] ecryptfs: Fix stat command displays wrong file size in
 xattr region
References: <1498116075-2195-1-git-send-email-kerneljasonxing@gmail.com>
In-Reply-To: <1498116075-2195-1-git-send-email-kerneljasonxing@gmail.com>

--JXrDXnke9lqKPKbDC35T8BwQdsiMAi9Nf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Jason! My apologies for not getting to this review earlier. I haven't
had much time to spend on eCryptfs lately.

Thanks for this bug fix! This patch looks mostly good but I have a
suggestion and question below.

On 06/22/2017 02:21 AM, Jason Xing wrote:
> When doing ecryptfs_read_and_validate_xattr_region(), eCryptfs
> reads only 16 bytes from xattr region. However, the lower filesystem
> like ext4 always compares 16 with the size of ecryptfs xattr region
> which is 81 bytes, and then it will return ERANGE (-34) and do not
> read that region.
>=20
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  fs/ecryptfs/crypto.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e5e29f8..895140f 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1389,19 +1389,36 @@ int ecryptfs_read_xattr_region(char *page_virt,=
 struct inode *ecryptfs_inode)
>  int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
>  					    struct inode *inode)
>  {
> -	u8 file_size[ECRYPTFS_SIZE_AND_MARKER_BYTES];
> -	u8 *marker =3D file_size + ECRYPTFS_FILE_SIZE_BYTES;
> +	char *page_virt;
>  	int rc;
> =20
> +	page_virt =3D kmem_cache_alloc(ecryptfs_header_cache, GFP_USER);
> +	if (!page_virt) {
> +		rc =3D -ENOMEM;
> +		printk(KERN_ERR "%s: Unable to allocate page_virt\n",
> +		       __func__);
> +		goto out;
> +	}
>  	rc =3D ecryptfs_getxattr_lower(ecryptfs_dentry_to_lower(dentry),
>  				     ecryptfs_inode_to_lower(inode),
> -				     ECRYPTFS_XATTR_NAME, file_size,
> -				     ECRYPTFS_SIZE_AND_MARKER_BYTES);
> -	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
> -		return rc >=3D 0 ? -EINVAL : rc;
> -	rc =3D ecryptfs_validate_marker(marker);
> +				     ECRYPTFS_XATTR_NAME, page_virt,
> +				     ECRYPTFS_DEFAULT_EXTENT_SIZE);

I worry that the ecryptfs_header_cache size and
ECRYPTFS_DEFAULT_EXTENT_SIZE aren't tied together in any way. What do
you think about using ecryptfs_header_cache->size instead of
ECRYPTFS_DEFAULT_EXTENT_SIZE here?

I think you probably copied this call to ecryptfs_getxattr_lower() from
elsewhere in fs/ecryptfs/* so I wouldn't expect you to have use
ecryptfs_header_cache->size but maybe we should correct it before making
the same mistake twice.

> +	if (rc < 0) {
> +		if (unlikely(ecryptfs_verbosity > 0))
> +			printk(KERN_INFO "Error attempting to read the [%s] "
> +			       "xattr from the lower file; return value =3D "
> +			       "[%d]\n", ECRYPTFS_XATTR_NAME, rc);
> +		rc =3D -EINVAL;

Why not pass rc up from ecryptfs_getxattr_lower() instead of masking its
error with -EINVAL?

> +		goto out;
> +	}

Lets make sure that rc is greater than or equal to
ECRYPTFS_FILE_SIZE_AND_MARKER_BYTES before proceeding.

> +	rc =3D ecryptfs_validate_marker(page_virt + ECRYPTFS_FILE_SIZE_BYTES)=
;
>  	if (!rc)
> -		ecryptfs_i_size_init(file_size, inode);
> +		ecryptfs_i_size_init(page_virt, inode);
> +out:
> +	if (page_virt) {
> +		memset(page_virt, 0, PAGE_SIZE);

I don't feel like a memset() is needed here since the header metadata is
not considered to be secret in itself. All secrets are encrypted.

Tyler

> +		kmem_cache_free(ecryptfs_header_cache, page_virt);
> +	}
>  	return rc;
>  }
> =20
>=20



--JXrDXnke9lqKPKbDC35T8BwQdsiMAi9Nf--

--C5qdTpGPae3OXCeXGMRDM8sDPR9TXXRwb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJaAk4wAAoJENaSAD2qAscKphcP/A25kwaxE0mGmNRzyeU+Se6Z
z9EKhzF1Bez6u3yDHIKqWXm8oMUqyd/9Dfp8b3R2oeIHtwlEYqWx4NP99yWRP2wp
VkwQTxbXhD3/KCYrjjNSI6016h9x4V6RVhH0v4La5HTOexHYVIe74OpJqeBMIYQ+
+kZEht0wy8gKKW6EEZndjBgkG3ZKr0WAaLw9pV2yUesSfK8/a9wJ6EKZu7LLXsHA
hhxcSJ1dD4jUcVhwk2NNeXJxMn0gMPWFHBqzU6+GBIQAPw4uKgzW/xH3oR52xH3V
JYA9fjn8so+MmFM/csDRLI+XoAvTSQIZadQ7e+bkMQXBF5G1k/ouNnahlUtI64zM
fTpx/OxiUKznZeujHASbafB5jeOvBaopzIaaFu5uy18KK4tJ9Nj5PddmnKNtBCLO
/CFRtM+w8g8QqIn06C0XbrzkTMEv+flu7I/xm1uWHSMJpuXhNwzTUjuG9ApHqdaL
NsMcQk/M4l0DmG9NmvL5gm/GEg/gxA5TApEbMXgQI6u4+lXG4V/owYOb+v6C/GiO
9fxa6+ABODt4XV2CBLurgPKQWs3tg5RnKGctf4FIOObxt5OOSEYYsGk0GVL2CJmN
uE2CF50o1AUOcxEFbNRjWHlHngLxa1PtZsx1E+LQPSPIzzmNXkhxmhouVkwk5Scm
+wm5t6rI9RApldqrWYQ8
=E3mB
-----END PGP SIGNATURE-----

--C5qdTpGPae3OXCeXGMRDM8sDPR9TXXRwb--
