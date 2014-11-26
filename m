From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Remove buggy and unnecessary write in file
 name decode routine
Date: Wed, 26 Nov 2014 11:22:59 -0600
Message-ID: <20141126172258.GA31285@boyd>
References: <1417021756-30233-1-git-send-email-mhalcrow@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39186 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaKZRXF (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Nov 2014 12:23:05 -0500
Content-Disposition: inline
In-Reply-To: <1417021756-30233-1-git-send-email-mhalcrow@google.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Michael Halcrow <mhalcrow@google.com>
Cc: dmitryc@google.com, keescook@google.com, ecryptfs@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-11-26 09:09:16, Michael Halcrow wrote:
> Dmitry Chernenkov used KASAN to discover that eCryptfs writes past the
> end of the allocated buffer during encrypted filename decoding. This
> fix corrects the issue by getting rid of the unnecessary 0 write when
> the current bit offset is 2.
>=20
> Signed-off-by: Michael Halcrow <mhalcrow@google.com>

I like this fix better than the other where you modified
ecryptfs_max_decoded_size() to return an extra byte.
ecryptfs_max_decoded_size() is actually returning the correct size
instead of being conservative, as the comments in that function suggest
so returning an extra byte doesn't make sense.

Also, the decode operation takes blocks of 4 encoded bytes down to 3
decoded bytes so there's no reason to zero the 4th decoded byte in the
sequence when there may not even be a 4th encoded byte.

So, this one gets my ack. I'll take it from here. I'll add the correct
tag to get it backported to the appropriate stable kernels and also give
Dmitry credit with a Reported-by tag.

Thanks!

Tyler

> ---
>  fs/ecryptfs/crypto.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 2f6735d..31b148f 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1917,7 +1917,6 @@ ecryptfs_decode_from_filename(unsigned char *dst, s=
ize_t *dst_size,
>  			break;
>  		case 2:
>  			dst[dst_byte_offset++] |=3D (src_byte);
> -			dst[dst_byte_offset] =3D 0;
>  			current_bit_offset =3D 0;
>  			break;
>  		}
> --=20
> 2.2.0.rc0.207.ga3a616c
>=20

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUdgxyAAoJENaSAD2qAscKr/gQAJuLDiw58slB0Iuu8pG1COY1
NQiJQU7GxwGAj7IftJxs6jbXuFNsGrH5edWXzmRkpnJhp82MhgX70lQpnMawerfJ
uu+R3Kyqg4mOdY3U1dNxuGkioRNlrcpxUPKZXquJrH7JfPG9ZNleU3ss34d3oziN
BGD+p6CWlZXULxD0SVaM9oY0EsjadTNHBOLIg+qOgjQ+QiuFx0YAzz48KHeWI3dZ
bsCu8CtLvEv7Lk+4e+y3N3dpN3WBkMXInhyXfVrQoZHLc00T2CbcZBnEgLtFfgZd
8+NUpKj2hgLAHvLD60VMqFOIkE3O9if6i6XplRCU23cTPylKKux9OYPJCS7wODiC
7Qoy+HRw9TZq761ofij2fvdouxlYb3ri+gHLF2ExIHC2QiMEQTzlaTTu0W2UHhEz
7ftqcsw/FKFdQVZuOD9cuK1HqvYroh4+UPSdhaixx4z93hGWkFBTsTg45buzl8yo
LIupaOCTzZXh8whCXO4xcmYHyHmiyhRzH1zYy5Tp9NuHklUAmUAzfGSfp8zBPR05
IRnorbzjb0dZmUx5AfXJVqsSCGTjL3h1MwSPdGEoVE8afT1Df/oeLq1dhJ0+9Y+Z
zOmfSqDS8fyJcsMBRd5oP3JWpklPsLXHaHTw6R7tUlv+3Y1WchrzJEtV/Htd3VU8
JFoJS23f7uhPyB9yhR4I
=BRsm
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
