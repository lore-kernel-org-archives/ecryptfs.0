From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC] eCryptfs: Add mount option for cipher mode
Date: Mon, 3 Jun 2013 18:51:02 -0700
Message-ID: <20130604015101.GA4162@boyd>
References: <51ACCEC9.3070303@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42991 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531Ab3FDBvI (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Jun 2013 21:51:08 -0400
Content-Disposition: inline
In-Reply-To: <51ACCEC9.3070303@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Will Morrison <camocrazed@gmail.com>
Cc: ecryptfs@vger.kernel.org, Zameer Manji <zmanji@gmail.com>, Michael Chang <thenewme91@gmail.com>, Alvin Tran <althaitran@gmail.com>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-06-03 13:13:45, Will Morrison wrote:
> This patch removes the hardcoding of CBC mode in eCryptfs and adds a=20
> mount option allowing one to specify the desired mode of operation.=20
> Currently this defaults to cbc, but should would with any plain block=20
> cipher mode supported by the kernel. We've been testing with ecb to=20
> ensure we've found any implicit assumptions about cbc.
>=20
> Future work will involve supporting AEAD modes (GCM) and adding in=20
> integrity checking code.

Glad to hear that you all are making some headway.

>=20
> As this is our first kernel patch, we'd like feedback on what we've=20
> done right and what we've done wrong, not only in code, but also=20
> anything related to the patch submission itself.

Good to know. I'll be a little picky and point out everything that I
see.

To start things off... when you have a side note, such as your paragraph
above mentioning that this is your first kernel patch, you don't want
something like that to end up in the commit log history forever. A good
place for notes like that is below the --- line and above the diff
command. Most patch merging tools should ignore that content and keep it
=66rom being recorded forever in the commit history. (I know that you
didn't intend for this patch to be upstreamed at this time, but I
thought I'd mention this tip.)

>=20
> Signed-off-by: William Morrison <camocrazed@gmail.com>
> ---
> diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryp=
tfs/crypto.c ecryptfs/fs/ecryptfs/crypto.c

I'll assume that this means that you're not using git. If you plan to
continue doing kernel development (or really any open source
development) after this feature, I'd recommend that you work on
acquiring basic git skills. You previously asked what can help speed up
your development workflow and understanding git is certainly something
that will help.

In fact, this patch won't apply for me using `git am -is /path/to/mbox`.
I'm not immediately sure why, but I do see some extra '-' characters
in the areas that git complains about.

It might be because you GPG-signed the email. GPG signing patches would
seem like a good thing to do, but Documentation/email-clients.txt claims
that it causes some problems and recommends that you don't sign patches.

Running the following search and replace in vim:

:%s/^- -/-/g

and stripping off the GPG header/footer, I'm kind of able to get the
patch to apply. There's offset and fuzz issues, so git am won't apply
it (but patch will, of course). Which kernel tree did you develop the
patch against?

> --- ecryptfs_base/fs/ecryptfs/crypto.c	2013-06-03 07:49:51.734430193 -0400
> +++ ecryptfs/fs/ecryptfs/crypto.c	2013-05-23 17:51:37.814355879 -0400
> @@ -743,7 +743,8 @@ int ecryptfs_init_crypt_ctx(struct ecryp
>  	}
>  	mutex_lock(&crypt_stat->cs_tfm_mutex);
>  	rc =3D ecryptfs_crypto_api_algify_cipher_name(&full_alg_name,
> -						    crypt_stat->cipher, "cbc");
> +						crypt_stat->cipher,
> +						crypt_stat->cipher_mode);
>  	if (rc)
>  		goto out_unlock;
>  	crypt_stat->tfm =3D crypto_alloc_blkcipher(full_alg_name, 0,
> @@ -753,8 +754,9 @@ int ecryptfs_init_crypt_ctx(struct ecryp
>  		rc =3D PTR_ERR(crypt_stat->tfm);
>  		crypt_stat->tfm =3D NULL;
>  		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): "
> -				"Error initializing cipher [%s]\n",
> -				crypt_stat->cipher);
> +			"Error initializing cipher [%s] and mode [%s]\n",
> +			crypt_stat->cipher,
> +			crypt_stat->cipher_mode);
>  		goto out_unlock;
>  	}
>  	crypto_blkcipher_set_flags(crypt_stat->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
> @@ -916,6 +918,7 @@ static void ecryptfs_set_default_crypt_s
>  						      mount_crypt_stat);
>  	ecryptfs_set_default_sizes(crypt_stat);
>  	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
> +	strcpy(crypt_stat->cipher_mode, ECRYPTFS_DEFAULT_CIPHER_MODE);
>  	crypt_stat->key_size =3D ECRYPTFS_DEFAULT_KEY_BYTES;
>  	crypt_stat->flags &=3D ~(ECRYPTFS_KEY_VALID);
>  	crypt_stat->file_version =3D ECRYPTFS_FILE_VERSION;
> @@ -949,6 +952,7 @@ int ecryptfs_new_file_context(struct ino
>  	    &ecryptfs_superblock_to_private(
>  		    ecryptfs_inode->i_sb)->mount_crypt_stat;
>  	int cipher_name_len;
> +	int cipher_mode_name_len;
>  	int rc =3D 0;
> =20
>  	ecryptfs_set_default_crypt_stat_vals(crypt_stat, mount_crypt_stat);
> @@ -968,6 +972,12 @@ int ecryptfs_new_file_context(struct ino
>  	       mount_crypt_stat->global_default_cipher_name,
>  	       cipher_name_len);
>  	crypt_stat->cipher[cipher_name_len] =3D '\0';
> +	cipher_mode_name_len =3D
> +		strlen(mount_crypt_stat->global_default_cipher_mode_name);
> +	memcpy(crypt_stat->cipher_mode,
> +		mount_crypt_stat->global_default_cipher_mode_name,
> +		cipher_mode_name_len);
> +	crypt_stat->cipher_mode[cipher_mode_name_len] =3D '\0';
>  	crypt_stat->key_size =3D
>  		mount_crypt_stat->global_default_cipher_key_size;
>  	ecryptfs_generate_new_key(crypt_stat);
> diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryp=
tfs/ecryptfs_kernel.h ecryptfs/fs/ecryptfs/ecryptfs_kernel.h
> --- ecryptfs_base/fs/ecryptfs/ecryptfs_kernel.h	2013-06-03 07:49:51.73443=
0193 -0400
> +++ ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2013-05-23 17:51:37.814355879 =
-0400
> @@ -124,6 +124,7 @@ ecryptfs_get_key_payload_data(struct key
> =20
>  #define ECRYPTFS_MAX_KEYSET_SIZE 1024
>  #define ECRYPTFS_MAX_CIPHER_NAME_SIZE 32
> +#define ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE 32
>  #define ECRYPTFS_MAX_NUM_ENC_KEYS 64
>  #define ECRYPTFS_MAX_IV_BYTES 16	/* 128 bits */
>  #define ECRYPTFS_SALT_BYTES 2
> @@ -133,6 +134,7 @@ ecryptfs_get_key_payload_data(struct key
>  #define ECRYPTFS_SIZE_AND_MARKER_BYTES (ECRYPTFS_FILE_SIZE_BYTES \
>  					+ MAGIC_ECRYPTFS_MARKER_SIZE_BYTES)
>  #define ECRYPTFS_DEFAULT_CIPHER "aes"
> +#define ECRYPTFS_DEFAULT_CIPHER_MODE "cbc"
>  #define ECRYPTFS_DEFAULT_KEY_BYTES 16
>  #define ECRYPTFS_DEFAULT_HASH "md5"
>  #define ECRYPTFS_TAG_70_DIGEST ECRYPTFS_DEFAULT_HASH
> @@ -237,6 +239,7 @@ struct ecryptfs_crypt_stat {
>  	struct crypto_hash *hash_tfm; /* Crypto context for generating
>  				       * the initialization vectors */
>  	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
> +	unsigned char cipher_mode[ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE];
>  	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
>  	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
>  	struct list_head keysig_list;
> @@ -338,6 +341,8 @@ struct ecryptfs_mount_crypt_stat {
>  	size_t global_default_fn_cipher_key_bytes;
>  	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
>  						 + 1];
> +	unsigned char global_default_cipher_mode_name[
> +		ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE + 1];
>  	unsigned char global_default_fn_cipher_name[
>  		ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
>  	char global_default_fnek_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
> diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryp=
tfs/keystore.c ecryptfs/fs/ecryptfs/keystore.c
> --- ecryptfs_base/fs/ecryptfs/keystore.c	2013-06-03 07:49:51.734430193 -0=
400
> +++ ecryptfs/fs/ecryptfs/keystore.c	2013-06-03 10:45:56.142519966 -0400
> @@ -1467,6 +1467,9 @@ parse_tag_3_packet(struct ecryptfs_crypt
>  		crypt_stat->key_size =3D
>  			(*new_auth_tok)->session_key.encrypted_key_size;
>  	}
> +	strncpy(crypt_stat->cipher_mode,
> +		crypt_stat->mount_crypt_stat->global_default_cipher_mode_name,
> +		ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);

This is a problem. eCryptfs files are atomic in that they contain all of
the information needed to decrypt the file (except for the FEKEK) in the
header. So a single eCryptfs mount may contain files encrypted by
AES-128, AES-256, blowfish, the FEK can be wrapped with a public key,
multiple FEKEKs can be used, etc., and eCryptfs can seamlessly handle
it because of the various metadata stored in the file header.

At first glance, it doesn't look like RFC2440 defines a field for
different cipher modes. eCryptfs has always just made the assumption
that it should use its tweaked CBC mode and that has always been
sufficient.

We will need a place to store the cipher mode in the header and that
field will need to be read in somewhere around here.

Also, when writing out the header information, we'll need to store the
cipher mode.

>  	rc =3D ecryptfs_init_crypt_ctx(crypt_stat);
>  	if (rc)
>  		goto out_free;
> diff -uprN -X ecryptfs_base/Documentation/dontdiff ecryptfs_base/fs/ecryp=
tfs/main.c ecryptfs/fs/ecryptfs/main.c
> --- ecryptfs_base/fs/ecryptfs/main.c	2013-06-03 07:49:51.734430193 -0400
> +++ ecryptfs/fs/ecryptfs/main.c	2013-06-03 10:54:26.570524304 -0400
> @@ -171,6 +171,7 @@ void ecryptfs_put_lower_file(struct inod
> =20
>  enum { ecryptfs_opt_sig, ecryptfs_opt_ecryptfs_sig,
>         ecryptfs_opt_cipher, ecryptfs_opt_ecryptfs_cipher,
> +       ecryptfs_opt_cipher_mode, ecryptfs_opt_ecryptfs_cipher_mode,
>         ecryptfs_opt_ecryptfs_key_bytes,
>         ecryptfs_opt_passthrough, ecryptfs_opt_xattr_metadata,
>         ecryptfs_opt_encrypted_view, ecryptfs_opt_fnek_sig,
> @@ -183,7 +184,9 @@ static const match_table_t tokens =3D {
>  	{ecryptfs_opt_sig, "sig=3D%s"},
>  	{ecryptfs_opt_ecryptfs_sig, "ecryptfs_sig=3D%s"},
>  	{ecryptfs_opt_cipher, "cipher=3D%s"},
> +	{ecryptfs_opt_cipher_mode, "cipher_mode=3D%s"},
>  	{ecryptfs_opt_ecryptfs_cipher, "ecryptfs_cipher=3D%s"},
> +	{ecryptfs_opt_ecryptfs_cipher_mode, "ecryptfs_cipher_mode=3D%s"},
>  	{ecryptfs_opt_ecryptfs_key_bytes, "ecryptfs_key_bytes=3D%u"},
>  	{ecryptfs_opt_passthrough, "ecryptfs_passthrough"},
>  	{ecryptfs_opt_xattr_metadata, "ecryptfs_xattr_metadata"},
> @@ -258,10 +261,13 @@ static void ecryptfs_init_mount_crypt_st
>  static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *op=
tions,
>  				  uid_t *check_ruid)
>  {
> +	const char *mode_white_list[] =3D {"cbc", "ecb", "gcm"};

When you submit a patch, it should be able to stand on its own. This
patch doesn't stand on its own because ecb and gcm aren't supported but
this patch happily accepts them. This white list should only contain
"cbc" at this point.

The idea you had with testing with ECB was a good idea, but it isn't
something that we'd want to ever support in eCryptfs since our default
is more secure. So the "ecb" element should of just been a local change
that you made on top of this patch, only for testing.

>  	char *p;
> +	int i =3D 0;
>  	int rc =3D 0;
>  	int sig_set =3D 0;
>  	int cipher_name_set =3D 0;
> +	int cipher_mode_name_set =3D 0;
>  	int fn_cipher_name_set =3D 0;
>  	int cipher_key_bytes;
>  	int cipher_key_bytes_set =3D 0;
> @@ -274,6 +280,8 @@ static int ecryptfs_parse_options(struct
>  	char *sig_src;
>  	char *cipher_name_dst;
>  	char *cipher_name_src;
> +	char *cipher_mode_name_dst;
> +	char *cipher_mode_name_src;
>  	char *fn_cipher_name_dst;
>  	char *fn_cipher_name_src;
>  	char *fnek_dst;
> @@ -317,6 +325,18 @@ static int ecryptfs_parse_options(struct
>  			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] =3D '\0';
>  			cipher_name_set =3D 1;
>  			break;
> +		case ecryptfs_opt_cipher_mode:
> +		case ecryptfs_opt_ecryptfs_cipher_mode:
> +			cipher_mode_name_src =3D args[0].from;
> +			cipher_mode_name_dst =3D
> +				mount_crypt_stat->
> +				global_default_cipher_mode_name;

Yuck. I don't know if this is better or worse than breaking the 80 char
rule. eCryptfs uses variable names that are too long in most cases.
(This isn't something that you need to worry about)

> +			strncpy(cipher_mode_name_dst, cipher_mode_name_src,
> +				ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);
> +			cipher_mode_name_dst[
> +				ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE] =3D '\0';
> +			cipher_mode_name_set =3D 1;
> +			break;
>  		case ecryptfs_opt_ecryptfs_key_bytes:
>  			cipher_key_bytes_src =3D args[0].from;
>  			cipher_key_bytes =3D
> @@ -412,6 +432,14 @@ static int ecryptfs_parse_options(struct
>  		strcpy(mount_crypt_stat->global_default_cipher_name,
>  		       ECRYPTFS_DEFAULT_CIPHER);
>  	}
> +	if (!cipher_mode_name_set) {
> +		int cipher_mode_name_len =3D strlen(ECRYPTFS_DEFAULT_CIPHER_MODE);
> +
> +		BUG_ON(cipher_mode_name_len >=3D
> +			ECRYPTFS_MAX_CIPHER_MODE_NAME_SIZE);

I see that you copied and pasted this logic from the !cipher_name_set
conditional. So it isn't your fault, but this is terrible. :)

This is something that should be caught at build time rather than at
runtime (why force this BUG() on our users?). These BUG_ON()'s should
probably be replaced with a BUILD_BUG_ON().

> +		strcpy(mount_crypt_stat->global_default_cipher_mode_name,
> +		       ECRYPTFS_DEFAULT_CIPHER_MODE);
> +	}
>  	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)
>  	    && !fn_cipher_name_set)
>  		strcpy(mount_crypt_stat->global_default_fn_cipher_name,
> @@ -434,6 +462,22 @@ static int ecryptfs_parse_options(struct
>  		goto out;
>  	}
> =20
> +	rc =3D -EINVAL;
> +	for (i =3D 0; i < ARRAY_SIZE(mode_white_list); i++) {
> +		if (strcmp(mount_crypt_stat->global_default_cipher_mode_name,
> +				mode_white_list[i]) =3D=3D 0) {
> +			rc =3D 0;
> +			break;
> +		}
> +	}
> +	if (rc) {
> +		ecryptfs_printk(KERN_ERR,
> +				"eCryptfs doesn't support cipher mode: %s",
> +				mount_crypt_stat->
> +					global_default_cipher_mode_name);
> +		goto out;
> +	}
> +
>  	mutex_lock(&key_tfm_list_mutex);
>  	if (!ecryptfs_tfm_exists(mount_crypt_stat->global_default_cipher_name,
>  				 NULL)) {
> --

This was a nice submission for your first shot at it. The biggest
problem to fix will be figuring out where to store the mode in the
header. Take a look through RFC2440 (and 4880 and 5581) to see if
there's already a field we can use for this. If not, we'll have to give
it some more thought. I don't want to rely on the user specifying the
correct ecryptfs_cipher_mode mount option.

Thanks again for working on this!

Tyler

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRrUgFAAoJENaSAD2qAscK7wcP/0jPugWm9BF2t+lzEPZ2R/AL
O8v2Vd98x+sGzq4nrVPwHsgO9mPF/O0+UaAPAIb3fhWtkcK45g4KKdycdUCxG+VO
rM8Ww96AUw676Ps47j8J2+2YDnOyo3iz44YejEtPJ1tzX/y1HZH1QP1eBCMjscPZ
lrbgYT1K6iiJXvys8Q4PNdjLhuXbej44bdpXcKwtwWV1/aK6C4SAMQ5tSrVloXzV
aHxXxoVof7/vqDinV0It6cmCsdnZzUTof3PtP6qeMo1sjDSKsZC59nBN23sHPejS
FqicqrPlF8ubKe/1or5utiBzz7XYGFWsEulxWMp7GG1PEmM7XmJc3UgIbwW6MBVC
ocUNTa73z3HbM0ZmXI0BmgnV95LZnpCSvnHGTdzETbSUKY+qjnwpQBEJTUfu09ik
sc90E/MkQstg6yWus0EFu+Z02A9BC1Z3/KV3ft/uZH5A5N4aOzBUV0bkwiz78h6l
kJDWbxTnEdQ5btgCt00qZm+BO8mMDQ+5stKTYIsEbEpVo9rIBU5IY88It0CSQaBo
7kwES1tZAJbejE54X0JWBqc4JkbawUQSBoZiYOkDvkckz1xduLvTqql+eMhNztf0
KDTD4XE8/Xoz3NNfH2JV0X4YERVQvLSt6MQGSqoeb04EEcNcwsiR4fkWBJZtb4XL
3W9JfAdxOhYL6vPzLpmP
=9dAo
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
