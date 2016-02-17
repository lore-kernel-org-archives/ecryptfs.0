From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: fix typos in comment
Date: Wed, 17 Feb 2016 09:35:11 -0600
Message-ID: <20160217153510.GB12281@boyd>
References: <1455691810-14274-1-git-send-email-weiyuan.wei@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54351 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422720AbcBQPfR (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 17 Feb 2016 10:35:17 -0500
Content-Disposition: inline
In-Reply-To: <1455691810-14274-1-git-send-email-weiyuan.wei@huawei.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Wei Yuan <weiyuan.wei@huawei.com>
Cc: lizefan@huawei.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the patch. It'll probably hang around in my tree until I have
a more pressing fix to send up.

Tyler

On 2016-02-17 14:50:10, Wei Yuan wrote:
> Signed-off-by: Weiyuan <weiyuan.wei@huawei.com>
> ---
>  fs/ecryptfs/crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 80d6901..d47a7d4 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -44,7 +44,7 @@
>   * ecryptfs_to_hex
>   * @dst: Buffer to take hex character representation of contents of
>   *       src; must be at least of size (src_size * 2)
> - * @src: Buffer to be converted to a hex string respresentation
> + * @src: Buffer to be converted to a hex string representation
>   * @src_size: number of bytes to convert
>   */
>  void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
> @@ -59,7 +59,7 @@ void ecryptfs_to_hex(char *dst, char *src, size_t src_s=
ize)
>   * ecryptfs_from_hex
>   * @dst: Buffer to take the bytes from src hex; must be at least of
>   *       size (src_size / 2)
> - * @src: Buffer to be converted from a hex string respresentation to raw=
 value
> + * @src: Buffer to be converted from a hex string representation to raw =
value
>   * @dst_size: size of dst buffer, or number of hex characters pairs to c=
onvert
>   */
>  void ecryptfs_from_hex(char *dst, char *src, int dst_size)
> --=20
> 2.1.0
>=20

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWxJMuAAoJENaSAD2qAscKv3AQAMrhggibqLZp+R7s3ft0a/5M
2Ic2s3U201pNkebhAIqUnKYJ+1NsT8qDWnIPul3+kGnzOa9CH0C2AMAGS474UDHY
eW3aAJKKtNrS59FhmepfO/fQNTSszKZC12p2nOxB48K84j6TLbdP5FrIhZh0NRgJ
covv+r59P5tZvewHHXiU0VPlSAZLH0wxxBXeTsDqwiHFvWzD01RV6wFDmtRNxzXD
Txkw7ZdogpFZ5bIzTpLnOH0p9sAtdIvewUXhFQu6l7vEgKd4BCBKJOdQdmUEflgw
l4PlgDpqDJ+Qek8WZe6zsMfbe4GHEDbo5ufM7L8RuPtkVfnWOq99UXNpBnoAf8zQ
Qtw23GyohdWXvQ+py9L7MdcZcbszT+1m0CTeNysYncAe5BQx9G/rvWm5Yo2Qz0nT
SIrZicCAEwBEAEi+pis9yx12mM+8dXZBb2VKMVVmXCLcU5Bsj5f5QY8WhKlwqaSF
yYtzkHZlwLg+pPiM6KC1bYusaDazuIFzvUAWD6KOZYdOH9K2rE3CKDXXti/x3U/r
H9OHwInfTuZkw5YKcSZIq0uSSOm/gU69RHq9pPMy/N6sqk71tEAf7yqaKecto8go
odaDMjeZPoPQ/6eAOrU1/U/l3wuoU5gbM7OinKqGj/9qAJ15HoMFbhoCviANh9wR
YvJIAoSDg0bnzHzP7iDu
=+c2P
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
