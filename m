From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 08/18] ecryptfs: use ARRAY_SIZE
Date: Fri, 13 Oct 2017 21:31:40 -0400
Message-ID: <3c5e2bb7-7c16-87cb-899f-8c9c322ce5da@canonical.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-9-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9k395uSrvgeGEJTESlhDJDm0RIqcljEB3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001193101.8898-9-jeremy.lefaure@lse.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9k395uSrvgeGEJTESlhDJDm0RIqcljEB3
Content-Type: multipart/mixed; boundary="9cba0v77ddawdJXVH3RJ7mvoLN0Ud9dQn";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <3c5e2bb7-7c16-87cb-899f-8c9c322ce5da@canonical.com>
Subject: Re: [PATCH 08/18] ecryptfs: use ARRAY_SIZE
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-9-jeremy.lefaure@lse.epita.fr>
In-Reply-To: <20171001193101.8898-9-jeremy.lefaure@lse.epita.fr>

--9cba0v77ddawdJXVH3RJ7mvoLN0Ud9dQn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/01/2017 03:30 PM, J=C3=A9r=C3=A9my Lefaure wrote:
> Using the ARRAY_SIZE macro improves the readability of the code.
>=20
> Found with Coccinelle with the following semantic patch:
> @r depends on (org || report)@
> type T;
> T[] E;
> position p;
> @@
> (
>  (sizeof(E)@p /sizeof(*E))
> |
>  (sizeof(E)@p /sizeof(E[...]))
> |
>  (sizeof(E)@p /sizeof(T))
> )
>=20
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@lse.epita.fr>

Hey J=C3=A9r=C3=A9my - Thanks for the nice cleanup. I'll get it into 4.15=
=2E

Tyler

> ---
>  fs/ecryptfs/crypto.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 7acd57da4f14..2e78e851788e 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -36,6 +36,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <asm/unaligned.h>
> +#include <linux/kernel.h>
>  #include "ecryptfs_kernel.h"
> =20
>  #define DECRYPT		0
> @@ -884,8 +885,7 @@ static int ecryptfs_process_flags(struct ecryptfs_c=
rypt_stat *crypt_stat,
>  	u32 flags;
> =20
>  	flags =3D get_unaligned_be32(page_virt);
> -	for (i =3D 0; i < ((sizeof(ecryptfs_flag_map)
> -			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
> +	for (i =3D 0; i < ARRAY_SIZE(ecryptfs_flag_map); i++)
>  		if (flags & ecryptfs_flag_map[i].file_flag) {
>  			crypt_stat->flags |=3D ecryptfs_flag_map[i].local_flag;
>  		} else
> @@ -922,8 +922,7 @@ void ecryptfs_write_crypt_stat_flags(char *page_vir=
t,
>  	u32 flags =3D 0;
>  	int i;
> =20
> -	for (i =3D 0; i < ((sizeof(ecryptfs_flag_map)
> -			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
> +	for (i =3D 0; i < ARRAY_SIZE(ecryptfs_flag_map); i++)
>  		if (crypt_stat->flags & ecryptfs_flag_map[i].local_flag)
>  			flags |=3D ecryptfs_flag_map[i].file_flag;
>  	/* Version is in top 8 bits of the 32-bit flag vector */
>=20



--9cba0v77ddawdJXVH3RJ7mvoLN0Ud9dQn--

--9k395uSrvgeGEJTESlhDJDm0RIqcljEB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZ4Wj8AAoJENaSAD2qAscKtnUP/j9ZvKUQbdSihpbSQeW2wUrI
AtH+HBUKKlDpdQU/JoPBWndbuWgXBOoaPhDqiryNPlnq3/zlONh5aAfS8ayNXZdS
4bsw53XEdPUuSadsK/hcEUFQ24eZA/d3NGOcDedyToXbR8Q6RmRFRPZ4ygNMhFzi
H48HSpjKfuImXOziXotbORxUHZNb5128w0T979OT39JSIEPC85vf2PLbDCPbdMmC
W3nAiLHHdDT4BTSU4hPoEnPX56o4wbRMgi4IG8bG5EN6EkbzJgk95kL13hHw9gld
Da3Nih9PRFpdaIZYJv7QpDcWy+p+CdjGlb1N9cdpSEqpKDTJJni6JQqNbBi+a2pT
ugLawB+iXUo2AeWiHZBxPVEk7QAXg3zDF6U0Eyy7SdhEXJ9cu9TlexEO3cTcZxI0
BATHu9q2eWxYPKzO7udYKM66i/UjZj7jvfBlpab29jeE2LsowU4pfRWgmIYZRIP8
IEu0yUpii65zZTG/Y9MKVdXjf+9KsIPVeuKzgIXS1ZO1SS9ivosTrQvsK1JRaGQ7
fT6EaoSm7dmZ42b3g512aeCCdsJlizZgDIJnNPbQv1ajFBhh+MNtxUA34fUWfFvD
MQ4ZrvPbUrMD1i5mafoAJ2tvuIOuo0yUyQFhW7MqXEUP6mD+uyGkQ9HkOYC/uu2i
ABTFmuwKTR+BOFHkHmUd
=0ZF0
-----END PGP SIGNATURE-----

--9k395uSrvgeGEJTESlhDJDm0RIqcljEB3--
