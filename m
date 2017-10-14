From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 0/3] eCryptfs: Adjustments for several function
 implementations
Date: Fri, 13 Oct 2017 21:29:42 -0400
Message-ID: <66a69c57-4dff-bed7-75e8-2ebb92f20909@canonical.com>
References: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ov4WWWjSgSW6mm1b0lKD8BP50r4agkujA"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, ecryptfs@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ov4WWWjSgSW6mm1b0lKD8BP50r4agkujA
Content-Type: multipart/mixed; boundary="UBcVc1NFnnhKc91KDtf49M2bfwBP31rSg";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 ecryptfs@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <66a69c57-4dff-bed7-75e8-2ebb92f20909@canonical.com>
Subject: Re: [PATCH 0/3] eCryptfs: Adjustments for several function
 implementations
References: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
In-Reply-To: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>

--UBcVc1NFnnhKc91KDtf49M2bfwBP31rSg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/19/2017 12:54 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 19 Aug 2017 18:15:14 +0200
>=20
> Some update suggestions were taken into account
> from static source code analysis.
>=20
> Markus Elfring (3):
>   Delete 21 error messages for a failed memory allocation
>   Return an error code only as a constant in ecryptfs_add_global_auth_t=
ok()
>   Adjust four checks for null pointers

Hello! I'm sorry for just now getting to these patches. All three look
fine to me. I'll get them into 4.15.

Tyler

>=20
>  fs/ecryptfs/crypto.c    | 22 +++-------------------
>  fs/ecryptfs/inode.c     |  3 ---
>  fs/ecryptfs/keystore.c  | 46 +++++++++++------------------------------=
-----
>  fs/ecryptfs/messaging.c |  6 ------
>  fs/ecryptfs/miscdev.c   |  6 +-----
>  fs/ecryptfs/mmap.c      |  2 --
>  6 files changed, 15 insertions(+), 70 deletions(-)
>=20



--UBcVc1NFnnhKc91KDtf49M2bfwBP31rSg--

--Ov4WWWjSgSW6mm1b0lKD8BP50r4agkujA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZ4WiGAAoJENaSAD2qAscKq1cP/2uPMyQ+2FoI84hohQlNHu5b
IObzjYhzOPu5NQDMaJi7l652bo27RhbAiMDHc6/uJBBItNt5Tdn1VCsee6XwP8Ur
uN/wZjn7K+FXFrj1HKVQPqdYcXVoG3x7srrrZ1caKJaOIKLBo0aZ1WhnOR7QpeRc
2+hCpW3rxnuuqEuYZyXC3KCGjuuaAoUoTQa3WNWBjgBNxJFjM8vBZUEDRdxVYB0m
0KyYNjZ0ybIQaJQ0zL16pHufF6+m7c3XfB26znYldXzy9jJkny37u8IaBxAlVOF/
qgliWI2lkKKUWxfBu+TjYLoLGsmfO7J9uwEosS3fJtEBYP0xdaOVp3VHxIOVNmQf
LyE0iwwUJd0tNe7eKdxIn7hNVONtZhG+j6XsesoNF+/yTYYdmfe4+flr1SSSsB/u
QsPaMLK0T3muBe3+Vg5Qz52h2+o16RS/x8xDiqFlc49ch9CyqkmTqApSsZpOZh3E
PBdplqKQIsSB/D6VwpQbTBVu/iKj2CKGPXFJo4SnkSLvtfSGIaS+JbNVT5mjta8W
kZranCXCCq15wHMqYckt0a+sYGLw46d7omhiMxh44nSUxQ2u8xz9j91IGPJDJKD8
25JuOmXZzztPTne0BqjGUadoTQJsihkz0p/mIqKFjPkdsoghP70ks9hGT+26LZ3S
1/FqjCMQkJhfWYkjYuzA
=/yJ7
-----END PGP SIGNATURE-----

--Ov4WWWjSgSW6mm1b0lKD8BP50r4agkujA--
