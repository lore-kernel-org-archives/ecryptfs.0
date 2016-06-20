From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: fix spelling mistakes
Date: Mon, 20 Jun 2016 10:11:08 -0500
Message-ID: <5768078C.4080701@canonical.com>
References: <1465504293-23323-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mJHTFIpWvHsrRTt0q13VfH6SO59r4bklI"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47814 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbcFTPLW (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 Jun 2016 11:11:22 -0400
In-Reply-To: <1465504293-23323-1-git-send-email-chris.j.arges@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mJHTFIpWvHsrRTt0q13VfH6SO59r4bklI
Content-Type: multipart/mixed; boundary="VdokRdwbNTdATBC8J2bujF3gwSn3pHSok"
From: Tyler Hicks <tyhicks@canonical.com>
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <5768078C.4080701@canonical.com>
Subject: Re: [PATCH] ecryptfs: fix spelling mistakes
References: <1465504293-23323-1-git-send-email-chris.j.arges@canonical.com>
In-Reply-To: <1465504293-23323-1-git-send-email-chris.j.arges@canonical.com>

--VdokRdwbNTdATBC8J2bujF3gwSn3pHSok
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/09/2016 03:31 PM, Chris J Arges wrote:
> Noticed some minor spelling errors when looking through the code.
>=20
> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>

Hey Chris - thanks for these fixups. The first two hunks
(respresentation -> representation) were already fixed by an older patch
that is pending in the eCryptfs next branch. I dropped those hunks,
added my S-o-b, and pushed this patch to the eCryptfs next branch.

Tyler

> ---
>  fs/ecryptfs/crypto.c | 8 ++++----
>  fs/ecryptfs/file.c   | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 0d8eb34..e5e29f8 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -45,7 +45,7 @@
>   * ecryptfs_to_hex
>   * @dst: Buffer to take hex character representation of contents of
>   *       src; must be at least of size (src_size * 2)
> - * @src: Buffer to be converted to a hex string respresentation
> + * @src: Buffer to be converted to a hex string representation
>   * @src_size: number of bytes to convert
>   */
>  void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
> @@ -60,7 +60,7 @@ void ecryptfs_to_hex(char *dst, char *src, size_t src=
_size)
>   * ecryptfs_from_hex
>   * @dst: Buffer to take the bytes from src hex; must be at least of
>   *       size (src_size / 2)
> - * @src: Buffer to be converted from a hex string respresentation to r=
aw value
> + * @src: Buffer to be converted from a hex string representation to ra=
w value
>   * @dst_size: size of dst buffer, or number of hex characters pairs to=
 convert
>   */
>  void ecryptfs_from_hex(char *dst, char *src, int dst_size)
> @@ -953,7 +953,7 @@ struct ecryptfs_cipher_code_str_map_elem {
>  };
> =20
>  /* Add support for additional ciphers by adding elements here. The
> - * cipher_code is whatever OpenPGP applicatoins use to identify the
> + * cipher_code is whatever OpenPGP applications use to identify the
>   * ciphers. List in order of probability. */
>  static struct ecryptfs_cipher_code_str_map_elem
>  ecryptfs_cipher_code_str_map[] =3D {
> @@ -1410,7 +1410,7 @@ int ecryptfs_read_and_validate_xattr_region(struc=
t dentry *dentry,
>   *
>   * Common entry point for reading file metadata. From here, we could
>   * retrieve the header information from the header region of the file,=

> - * the xattr region of the file, or some other repostory that is
> + * the xattr region of the file, or some other repository that is
>   * stored separately from the file itself. The current implementation
>   * supports retrieving the metadata information from the file contents=

>   * and from the xattr region.
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index 7000b96..53d0141 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -171,7 +171,7 @@ out:
> =20
>  /**
>   * ecryptfs_open
> - * @inode: inode speciying file to open
> + * @inode: inode specifying file to open
>   * @file: Structure to return filled in
>   *
>   * Opens the file specified by inode.
> @@ -240,7 +240,7 @@ out:
> =20
>  /**
>   * ecryptfs_dir_open
> - * @inode: inode speciying file to open
> + * @inode: inode specifying file to open
>   * @file: Structure to return filled in
>   *
>   * Opens the file specified by inode.
>=20



--VdokRdwbNTdATBC8J2bujF3gwSn3pHSok--

--mJHTFIpWvHsrRTt0q13VfH6SO59r4bklI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXaAeNAAoJENaSAD2qAscKEqIP/jyr0+Vrc0sgxE3ecBb9iCX/
WJEnnAyucFCyB+NjH9+YlXDyekPujTcL5mfOBYE3MtvA8Q0lZ4IjjYSO/xYCyh8S
sVWKe0t8rpGwPpy7vVUaNuM1PkzQLeKU3DecWUYaFjgPpeJgpdZB54TiR0CoIT/9
Jf1stxuNRuGlULmI4s4NnKU67Humx1S/G1OvV9nlDc2gUW3NurvKEv5on1y/OAaI
pyLUIzmuZBAvojNyPpC6EkBrMZxaxCghoFYFaELjBQeC8SF0crrOHcUbvyFuK+Q1
9zxDiM96Ax9Ug5s6PpPGBwu3/9KbeGHqWNy3x4SxCkYZX2TYCLdQkaRlK6I8WsPF
BBCxMGjCrRlamSMcDC7YecZSAuO58N5YAtEZE9EKWmOuswJ10PzDRks4oQ0Gpw9b
EK/+YlL+ymKzVOwH9tWMoKyF7yYA+q89sxoNlLjcgGab4W0Tgp/jAPQbehzqYBKy
S9zxn/cRRAvpYCtoxwr+UfKLox93cBoFr8iCKUJWqjOulTQgF9516vbCK0ZASn/1
iUzeGQJU6eHqmWiqvJ+HrKe3SV21EnvcyMkwMlKxphXTsKJuCnwLn+4IbEnjQYd2
nRVZQT78i4PtQAI0YH9YpjWQ71ZK58HkkGyixXymwMVRKXfHIQTK/0umACUujCDZ
IDlQNBuW0xECCsjXnjRV
=B5eE
-----END PGP SIGNATURE-----

--mJHTFIpWvHsrRTt0q13VfH6SO59r4bklI--
