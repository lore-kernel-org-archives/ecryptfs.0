From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: remove private bin2hex implementation
Date: Mon, 10 Oct 2016 15:08:46 -0500
Message-ID: <b24afe53-3a45-fe24-f446-bfbd9b9d7639@canonical.com>
References: <1474413444-19974-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9Pc5MrL8g6TS0HVtpj7WcT7V9s0A0oMU9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474413444-19974-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Pc5MrL8g6TS0HVtpj7WcT7V9s0A0oMU9
Content-Type: multipart/mixed; boundary="OEeNnMLeqrEmFBaRC21fbUc7nna3XoQpp";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <b24afe53-3a45-fe24-f446-bfbd9b9d7639@canonical.com>
Subject: Re: [PATCH] ecryptfs: remove private bin2hex implementation
References: <1474413444-19974-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1474413444-19974-1-git-send-email-linux@rasmusvillemoes.dk>

--OEeNnMLeqrEmFBaRC21fbUc7nna3XoQpp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/20/2016 06:17 PM, Rasmus Villemoes wrote:
> Calling sprintf in a loop is not very efficient, and in any case, we
> already have an implementation of bin-to-hex conversion in lib/ which
> we might as well use.
>=20
> Note that ecryptfs_to_hex used to nul-terminate the destination (and
> the kernel doc was wrong about the required output size), while
> bin2hex doesn't. [All but one user of ecryptfs_to_hex explicitly
> nul-terminates the result anyway.]
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

ecryptfs_kernel.h needs to include <linux/kernel.h> for the declaration
of bin2hex() (it didn't cause a problem because other included header
files, such as <linux/namei.h> pulled in <linux/kernel.h>). I've made
that change and will push the patch to the eCryptfs next branch. Thank yo=
u!

Tyler

> ---
>  fs/ecryptfs/crypto.c          | 15 ---------------
>  fs/ecryptfs/ecryptfs_kernel.h |  8 +++++++-
>  2 files changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e5e29f8c920b..7acd57da4f14 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -42,21 +42,6 @@
>  #define ENCRYPT		1
> =20
>  /**
> - * ecryptfs_to_hex
> - * @dst: Buffer to take hex character representation of contents of
> - *       src; must be at least of size (src_size * 2)
> - * @src: Buffer to be converted to a hex string representation
> - * @src_size: number of bytes to convert
> - */
> -void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
> -{
> -	int x;
> -
> -	for (x =3D 0; x < src_size; x++)
> -		sprintf(&dst[x * 2], "%.2x", (unsigned char)src[x]);
> -}
> -
> -/**
>   * ecryptfs_from_hex
>   * @dst: Buffer to take the bytes from src hex; must be at least of
>   *       size (src_size / 2)
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kerne=
l.h
> index 4ba1547bb9ad..548caac3a907 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -51,7 +51,13 @@
>  #define ECRYPTFS_XATTR_NAME "user.ecryptfs"
> =20
>  void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok);
> -extern void ecryptfs_to_hex(char *dst, char *src, size_t src_size);
> +static inline void
> +ecryptfs_to_hex(char *dst, char *src, size_t src_size)
> +{
> +	char *end =3D bin2hex(dst, src, src_size);
> +	*end =3D '\0';
> +}
> +
>  extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
> =20
>  struct ecryptfs_key_record {
>=20



--OEeNnMLeqrEmFBaRC21fbUc7nna3XoQpp--

--9Pc5MrL8g6TS0HVtpj7WcT7V9s0A0oMU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX+/VOAAoJENaSAD2qAscKju0P/iaYPkMW13zHCMtzGs7n4cpD
c+3n8gRztTguSOsfFuAoypsN1C+l7yqyw/ZGXyNOmVhQvP7tbHT6envpGxcIRSAf
cSGQPET+Mc6CK0ahFvqw+hxhoyudwaAzU9VBPoPEpNzpe/3RGu3ySWhBMj35P0ZP
25vaf9af2idAG/7kDH7cePBcGPgD7G4Cssgym3t2aq8lHSZxq32KuRAlzTF9EIaV
so5TZB7DCLGnYHKAy4ThfAUL3+l2T4uvS8wVBssFmtgHokpxHx7NYIyM1PD52YND
UG3A4Gy57PrROECKUcuURHARGCwBJLnVQivKpOJ4F20IR8LOzqlud49U+9+008uc
MaYEv9RQ64a5D78rtsyqrL2qYI/8gaM+yJrPM4WrbYnfzhU3uMur3IKxZW2W9iux
SA5Vn9A99uepi2R/f2xKAAk8y4rprRYbkicGYIcWP4Iff1pABZaZosXnZFIexzrq
PrmRauSdpDTRkRKMJVRY4Ipzx99MCwmmZJ9IFnmGm7XZnm4sWNqEVuT73qPsNnVp
FSslftvA2C6zI5/d2uH5avveHh5QKNd/GIQTYiLej2/szW4gWTTKS/+ievbfaiTf
wAnR85NbnepVNhldh+LbW0oFv0rJhWbr2ZCf7EIEFGn6gG8i0vn/F0bSOlEU/KdY
uxOG3JUrTSUhh3nDVrDE
=do8A
-----END PGP SIGNATURE-----

--9Pc5MrL8g6TS0HVtpj7WcT7V9s0A0oMU9--
