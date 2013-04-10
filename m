From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC v3 1/1] eCryptfs: Use the ablkcipher crypto API
Date: Wed, 10 Apr 2013 10:08:11 -0700
Message-ID: <20130410170810.GA4613@boyd>
References: <1365482389-4949-1-git-send-email-tyhicks@canonical.com>
 <1365534479-13202-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36536 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3DJRIX (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 10 Apr 2013 13:08:23 -0400
Content-Disposition: inline
In-Reply-To: <1365534479-13202-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: ecryptfs@vger.kernel.org
Cc: Colin King <colin.king@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>, Thieu Le <thieule@google.com>, Li Wang <dragonylffly@163.com>, Zeev Zilberman <zeev@annapurnaLabs.com>, Jarkko Sakkinen <jarkko.sakkinen@iki.fi>


--dc+cDN39EJAMEtIO
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-04-09 12:07:59, Tyler Hicks wrote:
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
>=20
> * I only made the changes mentioned in RFC v2 to encrypt_scatterlist(). T=
his
>   patch also makes those same changes to decrypt_scatterlist():
>   - Unlock cs_tfm_mutex if ablkcipher_request_alloc() fails
>   - Add CRYPTO_TFM_REQ_MAY_SLEEP flag to the ablkcipher_request_set_callb=
ack()
>     parameters
>=20
> I won't have a chance to gather new performance numbers until later tonig=
ht or
> tomorrow morning.

I've attached a PDF of the tiobench results using vanilla 3.9-rc5,
3.9-rc5 plus the async patches, and 3.9-rc5 plus the ablkcipher patch.

After looking a bunch of these test results, I've noticed some
variations in the results. For example, the attached numbers show the
ablkcipher patch causing a slow down on the SSD when doing
single-threaded sequential writes. But, I've seen another set of results
that had a similar slow down with the async patches but not the
ablkcipher patch.

So, my take away is that the ablkcipher patch and async patches perform
the same. The ablkcipher patch does not have any effect when using AES
or 3DES when hardware acceleration is not available.

I plan on queuing up the ablkcipher patch for the 3.10 merge window
unless anyone speaks up between now and then. It is simple  and performs
the same as the async patches.

Tyler

>=20
>  fs/ecryptfs/crypto.c          | 143 ++++++++++++++++++++++++++++++------=
------
>  fs/ecryptfs/ecryptfs_kernel.h |   3 +-
>  2 files changed, 105 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index d5c25db..eb50bce 100644
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
> @@ -349,24 +362,48 @@ static int encrypt_scatterlist(struct ecryptfs_cryp=
t_stat *crypt_stat,
>  		ecryptfs_dump_hex(crypt_stat->key,
>  				  crypt_stat->key_size);
>  	}
> -	/* Consider doing this once, when the file is opened */
> +
> +	init_completion(&ecr.completion);
> +
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
> -	if (!(crypt_stat->flags & ECRYPTFS_KEY_SET)) {
> -		rc =3D crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
> -					     crypt_stat->key_size);
> -		crypt_stat->flags |=3D ECRYPTFS_KEY_SET;
> -	}
> -	if (rc) {
> -		ecryptfs_printk(KERN_ERR, "Error setting key; rc =3D [%d]\n",
> -				rc);
> +	req =3D ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
> +	if (!req) {
>  		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc =3D -EINVAL;
> +		rc =3D -ENOMEM;
>  		goto out;
>  	}
> -	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
> -	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
> +
> +	ablkcipher_request_set_callback(req,
> +			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
> +			extent_crypt_complete, &ecr);
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
> @@ -624,35 +661,62 @@ static int decrypt_scatterlist(struct ecryptfs_cryp=
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
> +	req =3D ablkcipher_request_alloc(crypt_stat->tfm, GFP_NOFS);
> +	if (!req) {
>  		mutex_unlock(&crypt_stat->cs_tfm_mutex);
> -		rc =3D -EINVAL;
> +		rc =3D -ENOMEM;
>  		goto out;
>  	}
> -	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
> -	rc =3D crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
> +
> +	ablkcipher_request_set_callback(req,
> +			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
> +			extent_crypt_complete, &ecr);
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
> @@ -746,8 +810,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_sta=
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
> @@ -757,7 +820,7 @@ int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_sta=
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

--n8g4imXOkfNTN/H1
Content-Type: application/pdf
Content-Disposition: attachment; filename="3.9-rc5-async-ablkcipher-tiobench.pdf"
Content-Transfer-Encoding: base64

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
IorOYlf6DWe+6/2GMt+1fpP8nwKejz/90jXf/22eT++mefm7edv8D+TgO3EKZW5kc3RyZWFt
CmVuZG9iagoKMyAwIG9iagoxODA5CmVuZG9iagoKNCAwIG9iago8PC9UeXBlL1hPYmplY3QK
L1N1YnR5cGUvRm9ybQovQkJveFsgMTcgMzk1IDU5NCAzOTUuMSBdCi9Hcm91cDw8L1MvVHJh
bnNwYXJlbmN5L0NTL0RldmljZVJHQi9LIHRydWU+PgovTGVuZ3RoIDgKL0ZpbHRlci9GbGF0
ZURlY29kZQo+PgpzdHJlYW0KeJwDAAAAAAEKZW5kc3RyZWFtCmVuZG9iagoKNSAwIG9iago8
PC9DQSAwLjUKICAgL2NhIDAuNQo+PgplbmRvYmoKCjcgMCBvYmoKPDwvTGVuZ3RoIDggMCBS
L0ZpbHRlci9GbGF0ZURlY29kZT4+CnN0cmVhbQp4nMWZS4vbMBDH7/kUPhealUaSZcESsPMo
9LY00EPprY9bS7eHfv1Kmok9jh7ebRzKguLY0d+j+c1D9oqtbP5sfjXC/7USGuugef66+fim
+bERWyuka5vrz+fvG9NubWOM3qpGKhHGTm7DzObbGz/P0e/nn34eGLntaGKr/eF83sL9/J1k
o0D7Ywn+EKfFa1pENbQFjB/x4lOixlRx2SIcDueNsV7HSu3tOX9pHk7QSNGcv316FP0OHsWw
e6se5SGMYh9Ht3sLdNHEEwO7qOnyYee/HNnvT2GUIqrJcDGZK2H3+fx+czxvnq5MBAgeyNko
uzizZaOJN9JR91hUNLB1WUWIJlbGgqKSJT/+qyKCEbA+GPTai8EIvYgmY6W0UdISiAkNntcL
aDKKN6JZUTGiaV1Y+tpo9IpoTMFK6aIkmqkYGlWHktO6DcqaigjFdqsjGVbOltRGBEJZsmdA
upeUsVTvRiir6SESo7yRV1CwLKDzWDWSxx05Vp52F3fTz+7YWrImHqf6hVnJmfhmU1LsdGCS
UaSZnDUqDnXKSruCG0lxSGzE467ORYdNybpcVu8sOSNnq1YvXzWRySnaKfNmZHSdtTIm7ugy
impiTfZeFKtMIKBemcmaLSUyyRhJVat9dbdHJjlFxzzIt3YD0a/XsIzibVXMy7Zrk1mxsygd
yGSMJDIXb9Y55ObzejUwDv1CbsiS227iYJzamte0+P/UUrJ28pbimCtd3ZUIJ6dIcPvrtKPj
YtphS1lSnLUUW087hOMfa/U94KzeV3KWzh4m+S5seElfySpa1qOGBHi5hiGenCLPRh5C+zpw
xNM6367ugWftFpOzdHymzzeEhdKWVRwKTauvA8fSllO8rbT58T541n6CyVk66zM8exYKB+HJ
KVq2e1IJnoUdQE7xX/GAFT4TjVKXh1U58nHB8b3Qu9GH9V238Q5M+kJcKGgPjSGEBSHRJdUB
3IgVsCe0YzhoPOMvFlRl1wW0GdkYXUgD5FiNZ3jwbjGeWNwJFloUkBC/AQbaJAkHfws4xqko
oOEUr1o29uPyKIyLcRpdpJ1Jn3CmmPcOnmlCvXrqTiXvKpTwZiuJQ3WyLWHHETWKy0E22ksV
HoZ4v+bZHle7JKtN6cXqTbIK0t2FZrL9awWlKz2l93Xni9RvSoWYDoGNsUWxasZoWISRES0E
Nxl5eWyt5x+IJP+Upnod8zC2AWjR7Fndjq5Uhm7U1T1Dq8ikiGpDTdNUOZh0TBiWO8qOi1Pd
lLrQMjdS18JJwecEvEWx/XieLY7ujGL9lP+U9BFaTy2xvrpSyvJ+iR5smYvJkRorDTIFvgTN
p8qp6mE50ILv8DvWEJNjGKZf0vGetbtiQaLl2TRWsIaSH3k3Yb6/rjsx+2axGxMgUrn02jFh
kfRsQx5qPeK000KUpgUt1Gg/Xif1rKrCbOMytrPTFG/KTWGhpve5Op5Rvf9aNSBT/VIP3deE
TKVEdWxRaAe1xTub4mts/u0vT0eyhW8op6QEwyrpgScX7VpjtJ3Y5cvWgL1OYUmVLHW0v/o/
zofjuw9+Ad9/Nw/nZ9ccfjZPm79MUXJUCmVuZHN0cmVhbQplbmRvYmoKCjggMCBvYmoKMTE4
MwplbmRvYmoKCjkgMCBvYmoKPDwvVHlwZS9YT2JqZWN0Ci9TdWJ0eXBlL0Zvcm0KL0JCb3hb
IDE3IDM5NSA1OTQgMzk1LjEgXQovR3JvdXA8PC9TL1RyYW5zcGFyZW5jeS9DUy9EZXZpY2VS
R0IvSyB0cnVlPj4KL0xlbmd0aCA4Ci9GaWx0ZXIvRmxhdGVEZWNvZGUKPj4Kc3RyZWFtCnic
AwAAAAABCmVuZHN0cmVhbQplbmRvYmoKCjEwIDAgb2JqCjw8L0NBIDAuNQogICAvY2EgMC41
Cj4+CmVuZG9iagoKMTIgMCBvYmoKPDwvTGVuZ3RoIDEzIDAgUi9GaWx0ZXIvRmxhdGVEZWNv
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
CjEzIDAgb2JqCjU0NjUKZW5kb2JqCgoxNCAwIG9iago8PC9UeXBlL0ZvbnREZXNjcmlwdG9y
L0ZvbnROYW1lL0JBQUFBQStMaWJlcmF0aW9uU2Fucy1Cb2xkCi9GbGFncyA0Ci9Gb250QkJv
eFstMTg0IC0zMDMgMTA2MSAxMDMzXS9JdGFsaWNBbmdsZSAwCi9Bc2NlbnQgOTA1Ci9EZXNj
ZW50IC0yMTEKL0NhcEhlaWdodCAxMDMzCi9TdGVtViA4MAovRm9udEZpbGUyIDEyIDAgUgo+
PgplbmRvYmoKCjE1IDAgb2JqCjw8L0xlbmd0aCAyNzUvRmlsdGVyL0ZsYXRlRGVjb2RlPj4K
c3RyZWFtCnicXZHLbsMgEEX3fAXLdBGBHdtJJctSmtSSF32obj8Aw9hFqgFhvPDfl0faSl2A
ztyZOxoGcumunZKOvFrNe3B4lEpYWPRqOeABJqlQlmMhubtF8eYzM4h4b78tDuZOjbquEXnz
ucXZDe/OQg9wh8iLFWClmvDu49L7uF+N+YIZlMMUNQ0WMPo+T8w8sxlIdO074dPSbXtv+St4
3wzgPMZZGoVrAYthHCxTE6Ca0gbXbdsgUOJfLrtZhpF/MutLM19KaXFqPOeJi8CHyOUhcBH5
GPUycnUNXCWdBj4mvQp8Snr03qeej4HPqaYN/JC4jEPepgnjhn3+rAHz1Vq/grj0+Pbwaqng
91+MNsEVzzdAeIT9CmVuZHN0cmVhbQplbmRvYmoKCjE2IDAgb2JqCjw8L1R5cGUvRm9udC9T
dWJ0eXBlL1RydWVUeXBlL0Jhc2VGb250L0JBQUFBQStMaWJlcmF0aW9uU2Fucy1Cb2xkCi9G
aXJzdENoYXIgMAovTGFzdENoYXIgMTEKL1dpZHRoc1szNjUgNzIyIDcyMiA2NjYgMzMzIDg4
OSA2MTAgMzMzIDU1NiA3MjIgNjEwIDU1NiBdCi9Gb250RGVzY3JpcHRvciAxNCAwIFIKL1Rv
VW5pY29kZSAxNSAwIFIKPj4KZW5kb2JqCgoxNyAwIG9iago8PC9MZW5ndGggMTggMCBSL0Zp
bHRlci9GbGF0ZURlY29kZS9MZW5ndGgxIDIzNzY4Pj4Kc3RyZWFtCnic3bwLeBTHlShcp6p7
Zlqj0fS89JZmRqP3oJlGg94aqQFpGCFAAiSQBEISSOgB6C3eNsIGDAJbsk2wMbYhCXGMXww2
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
rmH9taprTddGr529xmt//2Gi9d9/57Pqfwfy73yR1n+b8FnfnbgycW2CyBOeXN+EL9r6G++V
2t96Se0VILW/JtNW/S+tv8TKQ/5JdJzv3R/Da+PF1h9Vp1pf/WG6dfoVqL7Qe2H4AlEOzF0w
ZvusL5e+XPVyz8t7Xj758tmX1b3Pn3o+8DzRPw9jL0LgRdC/CBr9C6UvXHuBDAfGAjgQGA9c
DhD32dKz+NSzgWfx+LOXn8XuZ0qfwSefhvGnLj+Fq86MnsHuMz1nLp2ZPsM9eiLZWn0Ceo7B
pWNwzJdg/dbRKOueo6NHp48S6X75fjx8P/SODo/isVEYH708iquONB3pOUIO+KatJ/fDvrvn
WgcHSq0DtAc93cXWbl+ONRaia2M80bVqD6lV0T4307Qmeq/1zbWuafBbG+jblG2s5SlNuGxS
20NAT0oJvrZ8ejmWl+fk++TlKem+d+Waaqjw2ax+WuYiep/1wRXfNR8e9kFktqXWAPpaMVtf
iwHVAgKrVV+qb9Lv0XN6vVtfpe/Rj+qv6Kf16lIKu6Yn1FQcjgQeLsDYuZqVTmflBfX0isqA
unpNAA4GUlayp7y8IaA6GEC1DWvqzgHcV7//3nvRgoTKQPbKukBzQn1loJUGZBYYpgEx4Vwk
WlA/ODA4pPyUHQQDaNDpHBhgIbavhII/cwdKCJwDNJmiDQwO0MjgEBpwDgzCwAAV5EEKH4B1
NDwwwMADQHPQe8AZLJ6WQAteRwugj8Fg0QMDFH+A5h+IXkf5+n8BkGmteQplbmRzdHJlYW0K
ZW5kb2JqCgoxOCAwIG9iagoxNjI1NwplbmRvYmoKCjE5IDAgb2JqCjw8L1R5cGUvRm9udERl
c2NyaXB0b3IvRm9udE5hbWUvQ0FBQUFBK0xpYmVyYXRpb25TYW5zCi9GbGFncyA0Ci9Gb250
QkJveFstMjAzIC0zMDMgMTA0OSA5MTBdL0l0YWxpY0FuZ2xlIDAKL0FzY2VudCA5MDUKL0Rl
c2NlbnQgLTIxMQovQ2FwSGVpZ2h0IDkxMAovU3RlbVYgODAKL0ZvbnRGaWxlMiAxNyAwIFIK
Pj4KZW5kb2JqCgoyMCAwIG9iago8PC9MZW5ndGggNDgwL0ZpbHRlci9GbGF0ZURlY29kZT4+
CnN0cmVhbQp4nF2TzY6bMBSF9zyFl9PFCOxrICNFSJlkImXRHzXTByDgZJAmgByyyNuXcw9t
pS6CPuDcy+cbO90edoe+m9IfcWiOYTLnrm9juA332ARzCpeuT6wzbddMy51em2s9Julce3zc
pnA99OdhvU7Sn/O72xQf5mnTDqfwJUm/xzbErr+Yp1/b43x/vI/jZ7iGfjJZUlWmDee5z9d6
/FZfQ6pVz4d2ft1Nj+e55F/g/TEG4/TeUqUZ2nAb6ybEur+EZJ1llVnv91US+va/d/mKJadz
81HHOWrnaJb5XTWzIzuwKLs92CuXAs6VixxckPV5qZwrr5i34Bf2ycAbZrT/K2s1syV78I75
FfhNWTSzZ09kbMY8Mpb+JXpa+rsXMP2lANNftJb+7g1Mf9E8/QXrsvQX7Ul/KcH0F6zF0l/U
gf6CtVv6F9qf/rnW0r/Atxz9HfKO/g7zd/Qv4ezoX2zBy/y1dpk/3Nwy/1cw/Uu4OfoX2pP+
uT6nf4H/1NHfY7aO/h5rd/T38Hf09/rdZf7ICP091i7L/sFshf6yAdPfY41C/1wz9C+1lv65
9lzmD2ehv8fchP4FZiL0Lze6sZcdjC2OM/jn6JjmHuN8bPSg6nnBSen68Pcsj8OIKv39Blxu
8sgKZW5kc3RyZWFtCmVuZG9iagoKMjEgMCBvYmoKPDwvVHlwZS9Gb250L1N1YnR5cGUvVHJ1
ZVR5cGUvQmFzZUZvbnQvQ0FBQUFBK0xpYmVyYXRpb25TYW5zCi9GaXJzdENoYXIgMAovTGFz
dENoYXIgNTgKL1dpZHRoc1szNjUgODMzIDY2NiAyNzcgNTAwIDU1NiA1MDAgNjY2IDU1NiAy
NzcgNzIyIDU1NiA1NTYgMzMzIDU1NiAyNzcKNTU2IDMzMyAzMzMgNTU2IDU1NiAyNzcgNTU2
IDU1NiA1NTYgNTU2IDU1NiA1NTYgNTU2IDU1NiA5NDMgMjIyCjU1NiAzMzMgNTAwIDIyMiA1
MDAgNTU2IDUwMCA1NTYgODMzIDY2NiA1NTYgNjY2IDY2NiA3MjIgMjc3IDU1Ngo3MjIgNzIy
IDI3NyA3MjIgNjEwIDUwMCA3MjIgNTgzIDc3NyAyNzcgNTAwIF0KL0ZvbnREZXNjcmlwdG9y
IDE5IDAgUgovVG9Vbmljb2RlIDIwIDAgUgo+PgplbmRvYmoKCjIyIDAgb2JqCjw8L0YxIDE2
IDAgUi9GMiAyMSAwIFIKPj4KZW5kb2JqCgoyMyAwIG9iago8PC9Gb250IDIyIDAgUgovWE9i
amVjdDw8L1RyNCA0IDAgUi9UcjkgOSAwIFI+PgovRXh0R1N0YXRlPDwvRUdTMTAgMTAgMCBS
L0VHUzUgNSAwIFI+PgovUHJvY1NldFsvUERGL1RleHQvSW1hZ2VDL0ltYWdlSS9JbWFnZUJd
Cj4+CmVuZG9iagoKMSAwIG9iago8PC9UeXBlL1BhZ2UvUGFyZW50IDExIDAgUi9SZXNvdXJj
ZXMgMjMgMCBSL01lZGlhQm94WzAgMCA2MTIgNzkyXS9Hcm91cDw8L1MvVHJhbnNwYXJlbmN5
L0NTL0RldmljZVJHQi9JIHRydWU+Pi9Db250ZW50cyAyIDAgUj4+CmVuZG9iagoKNiAwIG9i
ago8PC9UeXBlL1BhZ2UvUGFyZW50IDExIDAgUi9SZXNvdXJjZXMgMjMgMCBSL01lZGlhQm94
WzAgMCA2MTIgNzkyXS9Hcm91cDw8L1MvVHJhbnNwYXJlbmN5L0NTL0RldmljZVJHQi9JIHRy
dWU+Pi9Db250ZW50cyA3IDAgUj4+CmVuZG9iagoKMjQgMCBvYmoKPDwvQ291bnQgMS9GaXJz
dCAyNSAwIFIvTGFzdCAyNSAwIFIKPj4KZW5kb2JqCgoyNSAwIG9iago8PC9Db3VudCAwL1Rp
dGxlPEZFRkYwMDUzMDA2ODAwNjUwMDY1MDA3NDAwMzE+Ci9EZXN0WzEgMCBSL1hZWiAwIDc5
MiAwXS9QYXJlbnQgMjQgMCBSPj4KZW5kb2JqCgoxMSAwIG9iago8PC9UeXBlL1BhZ2VzCi9S
ZXNvdXJjZXMgMjMgMCBSCi9NZWRpYUJveFsgMCAwIDYxMiA3OTIgXQovS2lkc1sgMSAwIFIg
NiAwIFIgXQovQ291bnQgMj4+CmVuZG9iagoKMjYgMCBvYmoKPDwvVHlwZS9DYXRhbG9nL1Bh
Z2VzIDExIDAgUgovT3BlbkFjdGlvblsxIDAgUiAvWFlaIG51bGwgbnVsbCAwXQovT3V0bGlu
ZXMgMjQgMCBSCj4+CmVuZG9iagoKMjcgMCBvYmoKPDwvQXV0aG9yPEZFRkYwMDU0MDA3OTAw
NkMwMDY1MDA3MjAwMjAwMDQ4MDA2OTAwNjMwMDZCMDA3Mz4KL0NyZWF0b3I8RkVGRjAwNDMw
MDYxMDA2QzAwNjM+Ci9Qcm9kdWNlcjxGRUZGMDA0QzAwNjkwMDYyMDA3MjAwNjUwMDRGMDA2
NjAwNjYwMDY5MDA2MzAwNjUwMDIwMDAzNDAwMkUwMDMwPgovQ3JlYXRpb25EYXRlKEQ6MjAx
MzA0MTAwOTU1NDQtMDcnMDAnKT4+CmVuZG9iagoKeHJlZgowIDI4CjAwMDAwMDAwMDAgNjU1
MzUgZiAKMDAwMDAyNzY2MCAwMDAwMCBuIAowMDAwMDAwMDE5IDAwMDAwIG4gCjAwMDAwMDE4
OTkgMDAwMDAgbiAKMDAwMDAwMTkyMCAwMDAwMCBuIAowMDAwMDAyMDk3IDAwMDAwIG4gCjAw
MDAwMjc4MDQgMDAwMDAgbiAKMDAwMDAwMjEzNyAwMDAwMCBuIAowMDAwMDAzMzkxIDAwMDAw
IG4gCjAwMDAwMDM0MTIgMDAwMDAgbiAKMDAwMDAwMzU4OSAwMDAwMCBuIAowMDAwMDI4MTA5
IDAwMDAwIG4gCjAwMDAwMDM2MzAgMDAwMDAgbiAKMDAwMDAwOTE4MSAwMDAwMCBuIAowMDAw
MDA5MjAzIDAwMDAwIG4gCjAwMDAwMDk0MDYgMDAwMDAgbiAKMDAwMDAwOTc1MSAwMDAwMCBu
IAowMDAwMDA5OTYyIDAwMDAwIG4gCjAwMDAwMjYzMDYgMDAwMDAgbiAKMDAwMDAyNjMyOSAw
MDAwMCBuIAowMDAwMDI2NTI1IDAwMDAwIG4gCjAwMDAwMjcwNzUgMDAwMDAgbiAKMDAwMDAy
NzQ2OSAwMDAwMCBuIAowMDAwMDI3NTEyIDAwMDAwIG4gCjAwMDAwMjc5NDggMDAwMDAgbiAK
MDAwMDAyODAwNCAwMDAwMCBuIAowMDAwMDI4MjE1IDAwMDAwIG4gCjAwMDAwMjgzMTcgMDAw
MDAgbiAKdHJhaWxlcgo8PC9TaXplIDI4L1Jvb3QgMjYgMCBSCi9JbmZvIDI3IDAgUgovSUQg
WyA8RUM2MjZBMjQwREYwQTg1QjhCMEVBMTZEMkEzOEUxODc+CjxFQzYyNkEyNDBERjBBODVC
OEIwRUExNkQyQTM4RTE4Nz4gXQovRG9jQ2hlY2tzdW0gLzY0MTY0OTBFQkNCRjA3MDhBREVE
MkE1MTRFNjlDNjY4Cj4+CnN0YXJ0eHJlZgoyODU0MgolJUVPRgo=

--n8g4imXOkfNTN/H1--

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRZZx6AAoJENaSAD2qAscKDJsP/0yRYVSUHW07Bazi37815Y00
PiMh09magWSewf19IGtB7f7yfUsH8xrPeIhyQkzwovBDwqwIRF2A8iSVOUbuAQ6Y
iTpxKsYnV76CGK1HjMbNz262UjPsGJoYZT4vH5lqkrm6AzqoFc9ooefCMp+jy0Ty
w330ATpX7n18Z60pB8k5OvpaoKzo0u8uNENXGl261dkcsrpuyXQE0h9NAyujLC/f
HeByN9oHiScAckVSz0Bn3cZeQu/D8xalbnrlbCe5yrAhB/XyAEcvCHtSNbrl3COq
XDFf7jHV6gDP/x2ND6ErfmWaqAm/oM73Wk7a7J5O/yGK8cGBkp36Dl0Qys/N8vi0
DObIxVhvX9wyTMnkrGkBiw/qxjxtJDN+idkPGmY4Sf3+mvcr6yis3GSaHYWw3yT+
q04xf4Nk+CSLwDHAhLE4NOGcOrx+Er6/esUHVH4BCJDQr7FLqjxmY8APY7TVGd5O
5TlmGpGTUfHJb/DQ5CPnj0jWD8tTNpjcZjZ5pGSacsBx/4rB7Mb99fGh9ncUvWww
B+TGMYKC1pK6/B80PNrWDpsYdQRvROWqeNeBcVjAfhWaKsggNPtovoq2E8LPL4Wj
r3Z82z/Gkf3SgKaBOlSihizsSjRLjFyO5ewV7tZDGkxq4/0ufz1OTZHBdrPP9V5V
V5AE6NrUzCszSIZEuTzt
=Ztb3
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
