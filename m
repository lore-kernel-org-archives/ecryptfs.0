From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: ensure copy to crypt_stat->cipher does not
 overrun
Date: Mon, 23 Feb 2015 18:31:02 -0600
Message-ID: <20150224003101.GA11593@boyd>
References: <1424691250-24458-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424691250-24458-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-02-23 11:34:10, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The patch 237fead61998: "[PATCH] ecryptfs: fs/Makefile and
> fs/Kconfig" from Oct 4, 2006, leads to the following static checker
> warning:
>=20
>   fs/ecryptfs/crypto.c:846 ecryptfs_new_file_context()
>   error: off-by-one overflow 'crypt_stat->cipher' size 32.  rl =3D '0-32'
>=20
> There is a mismatch between the size of ecryptfs_crypt_stat.cipher
> and ecryptfs_mount_crypt_stat.global_default_cipher_name causing the
> copy of the cipher name to cause a off-by-one string copy error. This
> fix ensures the space reserved for this string is the same size including
> the trailing zero at the end throughout ecryptfs.
>=20
> This fix avoids increasing the size of ecryptfs_crypt_stat.cipher
> and also ecryptfs_parse_tag_70_packet_silly_stack.cipher_string and inste=
ad
> reduces the of ECRYPTFS_MAX_CIPHER_NAME_SIZE to 31 and includes the + 1 f=
or
> the end of string terminator.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the patch, Colin! It looks to me like it is the correct
change.

I've added Dan to cc and will add a Reported-by patch tag to give him
proper credit.

However, I don't think that this overflow can be triggered. The
ecryptfs_mount_crypt_stat.global_default_cipher_name buffer is filled
=66rom the value of the 'ecryptfs_cipher' mount argument. That mount
argument value is validated by the ecryptfs_code_for_cipher_string()
function. It requires that the string matches one of the strings in this
array:

static struct ecryptfs_cipher_code_str_map_elem
ecryptfs_cipher_code_str_map[] =3D {
        {"aes",RFC2440_CIPHER_AES_128 },
        {"blowfish", RFC2440_CIPHER_BLOWFISH},
        {"des3_ede", RFC2440_CIPHER_DES3_EDE},
        {"cast5", RFC2440_CIPHER_CAST_5},
        {"twofish", RFC2440_CIPHER_TWOFISH},
        {"cast6", RFC2440_CIPHER_CAST_6},
        {"aes", RFC2440_CIPHER_AES_192},
        {"aes", RFC2440_CIPHER_AES_256}
};

None of those cipher strings are long enough to overflow the 32 byte
ecryptfs_crypt_stat.cipher or
ecryptfs_parse_tag_70_packet_silly_stack.cipher_string buffers.

This is a valid cleanup that will protect us from accidentally
overflowing the buffer in the future so I'm going to go ahead and apply
it to my next branch. I'll add a comment making it clear that this is
hardening/cleanup and there is no actual overflow.

Tyler

> ---
>  fs/ecryptfs/ecryptfs_kernel.h | 4 ++--
>  fs/ecryptfs/keystore.c        | 2 +-
>  fs/ecryptfs/main.c            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 90d1882..5ba029e 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -124,7 +124,7 @@ ecryptfs_get_key_payload_data(struct key *key)
>  }
> =20
>  #define ECRYPTFS_MAX_KEYSET_SIZE 1024
> -#define ECRYPTFS_MAX_CIPHER_NAME_SIZE 32
> +#define ECRYPTFS_MAX_CIPHER_NAME_SIZE 31
>  #define ECRYPTFS_MAX_NUM_ENC_KEYS 64
>  #define ECRYPTFS_MAX_IV_BYTES 16	/* 128 bits */
>  #define ECRYPTFS_SALT_BYTES 2
> @@ -237,7 +237,7 @@ struct ecryptfs_crypt_stat {
>  	struct crypto_ablkcipher *tfm;
>  	struct crypto_hash *hash_tfm; /* Crypto context for generating
>  				       * the initialization vectors */
> -	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
> +	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
>  	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
>  	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
>  	struct list_head keysig_list;
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 917bd5c..6bd67e2 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -891,7 +891,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
>  	struct blkcipher_desc desc;
>  	char fnek_sig_hex[ECRYPTFS_SIG_SIZE_HEX + 1];
>  	char iv[ECRYPTFS_MAX_IV_BYTES];
> -	char cipher_string[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
> +	char cipher_string[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
>  };
> =20
>  /**
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index d9eb84b..76dfb01 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -407,7 +407,7 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_=
info *sbi, char *options,
>  	if (!cipher_name_set) {
>  		int cipher_name_len =3D strlen(ECRYPTFS_DEFAULT_CIPHER);
> =20
> -		BUG_ON(cipher_name_len >=3D ECRYPTFS_MAX_CIPHER_NAME_SIZE);
> +		BUG_ON(cipher_name_len > ECRYPTFS_MAX_CIPHER_NAME_SIZE);
>  		strcpy(mount_crypt_stat->global_default_cipher_name,
>  		       ECRYPTFS_DEFAULT_CIPHER);
>  	}
> --=20
> 2.1.4
>=20

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU68ZFAAoJENaSAD2qAscKlA0QAJPW1xG45Yf6ve36U6+Ak4KW
dfHQWmxEPSTpe9lEltN3tSNmWuT0W7CrDY6pZrZbYv5H5I5FCCqzIOlb2j+e1i8C
VOhMqFlR9Rn7Q7eLgyhMb+H40j//9q9kH0WCEX5+QiJqiDEHpIHEqzn6RGH+3oV5
973Lmr0EmrdUQVkEK8e3QFALGv2ftr5Rw8qTmoH+pkkKn8+N+IWDfb5VHI6F//Xa
5LiWp7SYo8Ud+uYDGduCfvkwacixRfy2T4NyIdWgJmfeRF6eFxZSfF+eOzyh7kri
SPw1h0wrDzWq2/Ojb4pU/wSV9YVheukXAmumYNoObPfx+kfXYu1rBUdLwsL88qDb
hW5AJd6yNnLpV1Tj3e3mE8rrUgO82BqFTj1e5Qq4nRTcG7i2PwnK3bEnzvPfc7Hk
+uTl2714AO6P8so/9fkQ9/czG1wYaZp0XUAAgAnl3RGY9zBJRvIoAS8SE5tjKWMS
ZsQMHsT5oR4bac73pwLoX8d6IjKP46pYarPbqVjRuaQ4LNynjQ4GvahWVfI4g4WE
2qtmicqv/8lz9V4TdWSlGD5Uee1eRTcwwQ9jt9kWjp+4bmUmUq4oFY0DKHf3KOaa
MQq50WfFrjIvZBOHCCiueNgvqnB/nrs15fQJLz1FjqzDj8nrHZxAlsQzz49wdXG2
Ji99+LtFLtSupJXdVa49
=jWKs
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
