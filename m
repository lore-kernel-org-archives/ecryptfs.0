From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: add missing \n to end of various error messages
Date: Mon, 10 Oct 2016 15:05:20 -0500
Message-ID: <9b417d5b-10ea-3562-bba3-36f182ceacd8@canonical.com>
References: <20160927121802.30574-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="I47jvaMUtt2HtUEjkXDeeNNAcLqxlaA11"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbcJJUF1 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 10 Oct 2016 16:05:27 -0400
In-Reply-To: <20160927121802.30574-1-colin.king@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I47jvaMUtt2HtUEjkXDeeNNAcLqxlaA11
Content-Type: multipart/mixed; boundary="HDiTirGU20jApqnoaHmR5LhRUFiQ9fPwN";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org
Message-ID: <9b417d5b-10ea-3562-bba3-36f182ceacd8@canonical.com>
Subject: Re: [PATCH] ecryptfs: add missing \n to end of various error messages
References: <20160927121802.30574-1-colin.king@canonical.com>
In-Reply-To: <20160927121802.30574-1-colin.king@canonical.com>

--HDiTirGU20jApqnoaHmR5LhRUFiQ9fPwN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2016 07:18 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trival fix, some error messages are missing a \n, so add it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This looks good to me. I'll take it from here. Thanks!

Tyler

> ---
>  fs/ecryptfs/keystore.c | 2 +-
>  fs/ecryptfs/main.c     | 2 +-
>  fs/ecryptfs/miscdev.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 3cf1546..11d39ab 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1326,7 +1326,7 @@ parse_tag_1_packet(struct ecryptfs_crypt_stat *cr=
ypt_stat,
>  	if ((*new_auth_tok)->session_key.encrypted_key_size
>  	    > ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES) {
>  		printk(KERN_WARNING "Tag 1 packet contains key larger "
> -		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES");
> +		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES\n");
>  		rc =3D -EINVAL;
>  		goto out;
>  	}
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 6120044..3c41b35 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -426,7 +426,7 @@ static int ecryptfs_parse_options(struct ecryptfs_s=
b_info *sbi, char *options,
>  		mount_crypt_stat->global_default_cipher_key_size);
>  	if (!cipher_code) {
>  		ecryptfs_printk(KERN_ERR,
> -				"eCryptfs doesn't support cipher: %s",
> +				"eCryptfs doesn't support cipher: %s\n",
>  				mount_crypt_stat->global_default_cipher_name);
>  		rc =3D -EINVAL;
>  		goto out;
> diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
> index e4141f2..595e684 100644
> --- a/fs/ecryptfs/miscdev.c
> +++ b/fs/ecryptfs/miscdev.c
> @@ -383,7 +383,7 @@ ecryptfs_miscdev_write(struct file *file, const cha=
r __user *buf,
>  		goto memdup;
>  	} else if (count < MIN_MSG_PKT_SIZE || count > MAX_MSG_PKT_SIZE) {
>  		printk(KERN_WARNING "%s: Acceptable packet size range is "
> -		       "[%d-%zu], but amount of data written is [%zu].",
> +		       "[%d-%zu], but amount of data written is [%zu].\n",
>  		       __func__, MIN_MSG_PKT_SIZE, MAX_MSG_PKT_SIZE, count);
>  		return -EINVAL;
>  	}
>=20



--HDiTirGU20jApqnoaHmR5LhRUFiQ9fPwN--

--I47jvaMUtt2HtUEjkXDeeNNAcLqxlaA11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX+/SAAAoJENaSAD2qAscKpnAQAL1lKoji/fSfBaWZYRYu4wxk
6mzA+xepXninsrb7VE4U0/9zgEVU/dBWsgzVEct1bKReo+NJ0006WONbQrheW64Y
kbu+NPoXY2XZQPhXy0X1qYxhoDCmdzwt2jPqTVD4Tf0sfmI/8cS4lkCAXdyENZQ1
1H0hxtUtgNOagyjYG9iFCFpfQ5G9zoxGjRagM0VLB4aKlO24SolmmdU+9s0CH5FT
ECRVv02kI2yee3CQbvh7V+aqNsfvqtOQgfyNFRiaRhVzlMwr5lYfQOeA3YNwJi/C
+ny33TTDU3LlQy4u56AwkPCeTtEUB0OXI0ETcZ3OYXigf+D4kMOuwdDS3qtDGlH+
2WBRe5SsXBK0ua+ZrL+/VK+ltmZJ/rhWWO5f0crXQ/wo6qQfvdNvZesZDi4h2Y3b
4xYC7o4D51z04esKWo3AkDwSINZrkImd9JcrjxKja0d8SLTAzM+ulbvGDEfw+NL/
ANzo0Oj/SSxiK/bjOvGn5un4WknlTMQSe/J/BDlrjDWQay2pM0MjSOaTUj3DBEjT
/Bq1tKJ+9a6JfadrMuWVoyoWr55/OXahZunPgy++tookdOnVXkDo4VCRflEWDgJ1
3YBrqYSC/yBC8T2M6s0wXLvFDL3ERI/418bXiCh6TM3EMI3IGXyZ9/W/ORFssAWT
kpPKAeMic/LDLDc5qUHv
=fWy/
-----END PGP SIGNATURE-----

--I47jvaMUtt2HtUEjkXDeeNNAcLqxlaA11--
