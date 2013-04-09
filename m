From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC 1/1] eCryptfs: Use the ablkcipher crypto API
Date: Mon, 8 Apr 2013 21:30:47 -0700
Message-ID: <20130409043046.GA3795@boyd>
References: <1365205375-15921-1-git-send-email-tyhicks@canonical.com>
 <1365205375-15921-2-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50162 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250Ab3DIEa4 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 9 Apr 2013 00:30:56 -0400
Content-Disposition: inline
In-Reply-To: <1365205375-15921-2-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>, Thieu Le <thieule@google.com>, Li Wang <dragonylffly@163.com>, Zeev Zilberman <zeev@annapurnaLabs.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-04-05 16:42:55, Tyler Hicks wrote:
> Make the switch from the blkcipher kernel crypto interface to the
> ablkcipher interface.
>=20
> encrypt_scatterlist() and decrypt_scatterlist() now use the ablkcipher
> interface but, from the eCryptfs standpoint, still treat the crypto
> operation as a synchronous operation. They submit the async request and
> then wait until the operation is finished before they return. Most of
> the changes are contained inside those two functions.
>=20
> Despite waiting for the completion of the crypto operation, the
> ablkcipher interface provides performance increases in most cases when
> used on AES-NI capable hardware. However, sequential I/O with one or two
> threads on slow storage media does exhibit a sizeable decrease in
> performance.
>=20
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> Cc: Colin King <colin.king@canonical.com>
> Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Ying Huang <ying.huang@intel.com>
> Cc: Thieu Le <thieule@google.com>
> Cc: Li Wang <dragonylffly@163.com>
> Cc: Zeev Zilberman <zeev@annapurnaLabs.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
> ---

I noticed two changes that need to be made to this patch. See the inline
comments for details. I'll respond to this email with a v2 of the patch.

I'll run tiobench overnight and share the new results in the morning.

>  fs/ecryptfs/crypto.c          | 141 ++++++++++++++++++++++++++++++------=
------
>  fs/ecryptfs/ecryptfs_kernel.h |   3 +-
>  2 files changed, 102 insertions(+), 42 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index d5c25db..1aa8a96 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -243,7 +243,7 @@ void ecryptfs_destroy_crypt_stat(struct ecryptfs_cryp=
t_stat *crypt_stat)
>  	struct ecryptfs_key_sig *key_sig, *key_sig_tmp;
> =20
>  	if (crypt_stat->tfm)
> -		crypto_free_blkcipher(crypt_stat->tfm);
> +		crypto_free_ablkcipher(crypt_stat->tfm);
>  	if (crypt_stat->hash_tfm)
>  		crypto_free_hash(crypt_stat->hash_tfm);
>  	list_for_each_entry_safe(key_sig, key_sig_tmp,
> @@ -319,6 +319,22 @@ int virt_to_scatterlist(const void *addr, int size, =
struct scatterlist *sg,
>  	return i;
>  }
> =20
> +struct extent_crypt_result {
> +	struct completion completion;
> +	int rc;
> +};
> +
> +static void extent_crypt_complete(struct crypto_async_request *req, int =
rc)
> +{
> +	struct extent_crypt_result *ecr =3D req->data;
> +
> +	if (rc =3D=3D -EINPROGRESS)
> +		return;
> +
> +	ecr->rc =3D rc;
> +	complete(&ecr->completion);
> +}
> +
>  /**
>   * encrypt_scatterlist
>   * @crypt_stat: Pointer to the crypt_stat struct to initialize.
> @@ -334,11 +350,8 @@ static int encrypt_scatterlist(struct ecryptfs_crypt=
_stat *crypt_stat,
>  			       struct scatterlist *src_sg, int size,
>  			       unsigned char *iv)
>  {
> -	struct blkcipher_desc desc =3D {
> -		.tfm =3D crypt_stat->tfm,
> -		.info =3D iv,
> -		.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP
> -	};
> +	struct ablkcipher_request *req =3D NULL;
> +	struct extent_crypt_result ecr;
>  	int rc =3D 0;
> =20
>  	BUG_ON(!crypt_stat || !crypt_stat->tfm
> @@ -349,24 +362,46 @@ static int encrypt_scatterlist(struct ecryptfs_cryp=
t_stat *crypt_stat,
>  		ecryptfs_dump_hex(crypt_stat->key,
>  				  crypt_stat->key_size);
>  	}
> -	/* Consider doing this once, when the file is opened */
> +
> +	init_completion(&ecr.completion);
> +
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
> +	req =3D ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
> +	if (!req) {
> +		rc =3D -ENOMEM;
> +		goto out;

cs_tfm_mutex needs to be unlocked in this error path.

> +	}
> +
> +	ablkcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,

I think that we should set the CRYPTO_TFM_REQ_MAY_SLEEP flag here.

Tyler

> +					extent_crypt_complete, &ecr);
> +	/* Consider doing this once, when the file is opened */
>  	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> -		rc =3D crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -					     crypt_stat->key_size);
> +		rc =3D crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> +					      crypt_stat->key_size);
> +		if (rc) {
> +			ecryptfs_printk(KERN_ERR,
> +					"Error setting key; rc =3D [%d]\n",
> +					rc);
> +			mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
>  		crypt_stat->flags |=3D ECRYPTFS_KEY_SET;
>  	}
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc =3D [%d]\n",
> -				rc);
> -		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc =3D -EINVAL;
> -		goto out;
> -	}
> -	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> -	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> +	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
> +	rc =3D crypto_ablkcipher_encrypt(req);
> +	if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY) {
> +		struct extent_crypt_result *ecr =3D req->base.data;
> +
> +		rc =3D wait_for_completion_interruptible(&ecr->completion);
> +		if (!rc)
> +			rc =3D ecr->rc;
> +		INIT_COMPLETION(ecr->completion);
> +	}
>  out:
> +	ablkcipher_request_free(req);
>  	return rc;
>  }
> =20
> @@ -624,35 +659,60 @@ static int decrypt_scatterlist(struct ecryptfs_cryp=
t_stat *crypt_stat,
>  			       struct scatterlist *src_sg, int size,
>  			       unsigned char *iv)
>  {
> -	struct blkcipher_desc desc =3D {
> -		.tfm =3D crypt_stat->tfm,
> -		.info =3D iv,
> -		.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP
> -	};
> +	struct ablkcipher_request *req =3D NULL;
> +	struct extent_crypt_result ecr;
>  	int rc =3D 0;
> =20
> -	/* Consider doing this once, when the file is opened */
> +	BUG_ON(!crypt_stat || !crypt_stat->tfm
> +	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
> +	if (unlikely(ecryptfs_verbosity > 0)) {
> +		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
> +				crypt_stat->key_size);
> +		ecryptfs_dump_hex(crypt_stat->key,
> +				  crypt_stat->key_size);
> +	}
> +
> +	init_completion(&ecr.completion);
> +
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
> -	rc =3D crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -				     crypt_stat->key_size);
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc =3D [%d]\n",
> -				rc);
> -		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc =3D -EINVAL;
> +	req =3D ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
> +	if (!req) {
> +		rc =3D -ENOMEM;
>  		goto out;
>  	}
> -	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> -	rc =3D crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
> +
> +	ablkcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +					extent_crypt_complete, &ecr);
> +	/* Consider doing this once, when the file is opened */
> +	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> +		rc =3D crypto_ablkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> +					      crypt_stat->key_size);
> +		if (rc) {
> +			ecryptfs_printk(KERN_ERR,
> +					"Error setting key; rc =3D [%d]\n",
> +					rc);
> +			mutex_unlock(&crypt_stat->cs_tfm_mutex);
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
> +		crypt_stat->flags |=3D ECRYPTFS_KEY_SET;
> +	}
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error decrypting; rc =3D [%d]\n",
> -				rc);
> -		goto out;
> +	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> +	ablkcipher_request_set_crypt(req, src_sg, dest_sg, size, iv);
> +	rc =3D crypto_ablkcipher_decrypt(req);
> +	if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY) {
> +		struct extent_crypt_result *ecr =3D req->base.data;
> +
> +		rc =3D wait_for_completion_interruptible(&ecr->completion);
> +		if (!rc)
> +			rc =3D ecr->rc;
> +		INIT_COMPLETION(ecr->completion);
>  	}
> -	rc =3D size;
>  out:
> +	ablkcipher_request_free(req);
>  	return rc;
> +
>  }
> =20
>  /**
> @@ -746,8 +806,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_sta=
t *crypt_stat)
>  						    crypt_stat->cipher, "cbc");
>  	if (rc)
>  		goto out_unlock;
> -	crypt_stat->tfm =3D crypto_alloc_blkcipher(full_alg_name, 0,
> -						 CRYPTO_ALG_ASYNC);
> +	crypt_stat->tfm =3D crypto_alloc_ablkcipher(full_alg_name, 0, 0);
>  	kfree(full_alg_name);
>  	if (IS_ERR(crypt_stat->tfm)) {
>  		rc =3D PTR_ERR(crypt_stat->tfm);
> @@ -757,7 +816,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_sta=
t *crypt_stat)
>  				crypt_stat->cipher);
>  		goto out_unlock;
>  	}
> -	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
> +	crypto_ablkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
>  	rc =3D 0;
>  out_unlock:
>  	mutex_unlock(&crypt_stat->cs_tfm_mutex);
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index dd299b3..f622a73 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -38,6 +38,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/backing-dev.h>
>  #include <linux/ecryptfs.h>
> +#include <linux/crypto.h>
> =20
>  #define ECRYPTFS_DEFAULT_IV_BYTES 16
>  #define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
> @@ -233,7 +234,7 @@ struct ecryptfs_crypt_stat {
>  	size_t extent_shift;
>  	unsigned int extent_mask;
>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
> -	struct crypto_blkcipher *tfm;
> +	struct crypto_ablkcipher *tfm;
>  	struct crypto_hash *hash_tfm; /* Crypto context for generating
>  				       * the initialization vectors */
>  	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
> --=20
> 1.8.1.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRY5l2AAoJENaSAD2qAscK9dcP/3njiNoycBCXXNpDCIjbB+IC
M6QuuPiBE4oRibNCvGPFm/MXPQqHnCXjD5evWNbrqQLx1wLmtP6eFqe3XC8bgc1x
EVCQF4oqEGj16EGqTIZFj4A9cjjju6gn+t7VmJq/OhIZAVA5YDQvdF+nmZKBASJ5
d5gYb9SyoepjJUaGL9n+v/0r2GjJH13XZRjLSFLRWKxg5VeJ2beyeamgJqHmdS2Q
DqC6HciaA6jIlWR57dbxag9knWkTbFlCn5/TqCI3MY0w4LNTnEjDui3SXAkJ/cmH
AOzBq6+jGxjg7kaNyw4Vu4sF2pUV6vvgIe2NBWkgsht+itHC9ufkCe6CG4v/aIYc
QV4ITBXAr5ydAtET3GbWMS9h3YYsexzVlrHhHuY8anvqsP8LxV0ZIrcsHJpXeKJP
+azG16+6ELajS28+JafuTU4zkdNCir0mrypXoNedFc/oxX2H73kXEVLnddYJtcj4
DuxunvpdS29S1N2yCqLFpqDIVolO1Ji1RvaNqRre/sumvEoGYQsz7NE/wBPIMl3p
YK5aXAYcqsDKhD+11PKwTnSp9sKjqzcF3ZCOsuc5Cpk+4nLdUhYLepMlpCKRvYan
AFVB3J8u1eK/XbTQqT56XeRWEP2FSrH1jcD8QdYyT2HZ6wiBgFgJgkQpG8OPtsjA
HzzbU9Cj1+tESrmMzxKZ
=9c8I
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
