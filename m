From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: constify attribute_group structures.
Date: Fri, 13 Oct 2017 21:27:06 -0400
Message-ID: <654de3f9-ad17-983b-43e9-8556ebaf500b@canonical.com>
References: <eea99b6294d950736f63fd6d88ab129435233bd5.1498814950.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EWvTgnXfiVnrlBxPKjMKH07maAtkinoB4"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdJNB1Y (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 13 Oct 2017 21:27:24 -0400
In-Reply-To: <eea99b6294d950736f63fd6d88ab129435233bd5.1498814950.git.arvind.yadav.cs@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, viro@zeniv.linux.org.uk
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EWvTgnXfiVnrlBxPKjMKH07maAtkinoB4
Content-Type: multipart/mixed; boundary="oktEBJ2BFb9NfMA7qC8E5AH4v08TLFH71";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, viro@zeniv.linux.org.uk
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <654de3f9-ad17-983b-43e9-8556ebaf500b@canonical.com>
Subject: Re: [PATCH] eCryptfs: constify attribute_group structures.
References: <eea99b6294d950736f63fd6d88ab129435233bd5.1498814950.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <eea99b6294d950736f63fd6d88ab129435233bd5.1498814950.git.arvind.yadav.cs@gmail.com>

--oktEBJ2BFb9NfMA7qC8E5AH4v08TLFH71
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Arvind - My apologies for the extremely slow review.

On 06/30/2017 05:33 AM, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with con=
st
> attribute_group. So mark the non-const structs as const.
>=20
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    6122	    636	     24	   6782	   1a7e	fs/ecryptfs/main.o
>=20
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    6186	    604	     24	   6814	   1a9e	fs/ecryptfs/main.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

This patch looks good. I'll get it queued up for 4.15.

Tyler

> ---
>  fs/ecryptfs/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index 9014479..eea4c0f 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -782,7 +782,7 @@ static ssize_t version_show(struct kobject *kobj,
>  	NULL,
>  };
> =20
> -static struct attribute_group attr_group =3D {
> +static const struct attribute_group attr_group =3D {
>  	.attrs =3D attributes,
>  };
> =20
>=20



--oktEBJ2BFb9NfMA7qC8E5AH4v08TLFH71--

--EWvTgnXfiVnrlBxPKjMKH07maAtkinoB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZ4WfqAAoJENaSAD2qAscKMccP+wbaeSiztLPz4UMfU7K5ZaXS
2N03pM6R5d6pK8yfBlSXrC4DCgIFCucW0nBD5s+B1iafNuRsVTuqhdS40tzjmH3/
LD334DrLShh1Pju5fKGs89m/3qamh0AKd9eH9g3yLqPya9KwZ7yFi512+QEToZP2
9MyaINLkfg07fJO2mfPfobq1g0vY/rszWqrGZbDOk+QbNZlnwOcNjy0WIwFr7nZe
ylorip0GJvCVCWgvNuLrqFBeSFHj0bqCK7nK8lskdfzgvPoBOglZ9Np6qjmYv4BA
iDZL66HvFz6NbfWjNjzjGW5FxSY5tv9BvsCyYVsc5c64QNq87Je6CP0tKFstsMK9
xjYMilJREcj35kpthUU6nOTyBJsCEaPE2HNHdp5VJvHSp6QqciVfjHsnvDm6yB21
7oB0KGdnI3QAJkRdJs/34oKwPAcWl0utAR72XpzoABDjPuFqcr3eExzGafC04UYK
OxqONpmgNjwSXaOsFEE+nWAYvXlYNSkDjSkYOzbyj/1Jh4BDS4KprddDmU2ACA7l
NNxuSZ+7bqiybLafFWu+qbf71xJsNsjQYHVx2p+UnQwzM7rrv3gfrr9FwD1/F1Df
0rmatnWyClwGtOECbjVdSyPOEr8cW8qSAK2YEPa4ZB4oluU1F+ZrUzpIGbpMp4LT
5G4qpv7ULq8quNApW+j1
=/1B8
-----END PGP SIGNATURE-----

--EWvTgnXfiVnrlBxPKjMKH07maAtkinoB4--
