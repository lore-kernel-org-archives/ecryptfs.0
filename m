From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Improve statfs reporting
Date: Mon, 19 Dec 2011 13:47:39 -0600
Message-ID: <20111219194739.GD14413@boyd>
References: <1324313961-16531-1-git-send-email-tyhicks@canonical.com>
 <CAGXu5jKPML0DB55umbVNc1bbZsLB6yosjTtYKNimctyQSytMEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58678 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab1LSTrp (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 14:47:45 -0500
Content-Disposition: inline
In-Reply-To: <CAGXu5jKPML0DB55umbVNc1bbZsLB6yosjTtYKNimctyQSytMEQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: ecryptfs@vger.kernel.org, John Johansen <john.johansen@canonical.com>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2011-12-19 09:35:44, Kees Cook wrote:
> On Mon, Dec 19, 2011 at 8:59 AM, Tyler Hicks <tyhicks@canonical.com> wrot=
e:
> > statfs() calls on eCryptfs files returned the wrong filesystem type and,
> > when using filename encryption, the wrong maximum filename length.
>=20
> Thanks for getting this fixed up!

I appreciate the review!

>=20
> > +#define ENC_NAME_MAX_BLOCKLEN_8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0143
> > +#define ENC_NAME_MAX_BLOCKLEN_16 =A0 =A0 =A0 143
> ...
> > + =A0 =A0 =A0 /* Return an exact amount for the common cases */
> > + =A0 =A0 =A0 if (lower_namelen =3D=3D NAME_MAX) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cipher_blocksize =3D=3D 8) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*namelen) =3D ENC_NAME_M=
AX_BLOCKLEN_8;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (cipher_blocksize =3D=3D 16) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*namelen) =3D ENC_NAME_M=
AX_BLOCKLEN_16;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
>=20
> Why different paths here when the defines are the same?

I'll get that fixed. I had the 8 byte block size in as just a placeholder
until I could test the max length (I knew 16 byte block size max was 143
characters, but didn't know the 8 byte max). I should have merged the
two paths after discovering that they were both the same value.

> Also, what math is used to determine the "143"?

No math involved. Just testing.

>=20
> > + =A0 =A0 =A0 /* Return a safe estimate for the uncommon cases */
> > + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_FNEK_ENCRYPTED_FILENAME_PREFIX_S=
IZE;
> > + =A0 =A0 =A0 /* Since this is the max decoded size, subtract 1 "decode=
d block" len */
> > + =A0 =A0 =A0 (*namelen) =3D ecryptfs_max_decoded_size(*namelen) - 3;
> > + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_TAG_70_MAX_METADATA_SIZE;
> > + =A0 =A0 =A0 (*namelen) -=3D ECRYPTFS_FILENAME_MIN_RANDOM_PREPEND_BYTE=
S;
> > + =A0 =A0 =A0 /* Worst case is that the filename is padded nearly a ful=
l block size */
> > + =A0 =A0 =A0 (*namelen) -=3D cipher_blocksize - 1;

I should probably add a check here to make sure namelen isn't negative at t=
his point.

>=20
> Would it be less fragile to just use this path for all the
> calculations? Almost everything is a literal value.

I agree that just having one path would be cleaner, but this calculation
is just a rounded down estimate and the hard-coded common cases above
should be sufficient the vast majority of the time.

For the most common case of lower_f_namelen being 255 and a
cipher_blocksize of 16, this math comes out to 130. To try to give
userspace apps a little more room to work with, I figured it would be
better to hard-code in the two common cases.

>=20
> > +#define ECRYPTFS_TAG_70_MIN_METADATA_SIZE (1 + 1 + ECRYPTFS_SIG_SIZE +=
 1 + 1)
> > +#define ECRYPTFS_TAG_70_MAX_METADATA_SIZE (ECRYPTFS_TAG_70_MIN_METADAT=
A_SIZE \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0+ 1)
> ...
> > - =A0 =A0 =A0 s->max_packet_size =3D (1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* Tag 70 identifier */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + 3 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* Max Tag 70 packet size */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + ECRYPTFS_SI=
G_SIZE /* FNEK sig */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + 1 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* Cipher identifier */
> > + =A0 =A0 =A0 s->max_packet_size =3D (ECRYPTFS_TAG_70_MAX_METADATA_SIZE
>=20
> Would it make sense to reproduce the sizing comments from here into
> the #defines above, just to avoid losing this documentation?

These comments were actually a repeat of the comments right above this
line. That comment section is still there and is what I consider the
"official" in-code documentation of a tag 70 packet. Here is the comment
section:

        /* Octet 0: Tag 70 identifier
         * Octets 1-N1: Tag 70 packet size (includes cipher identifier
         *              and block-aligned encrypted filename size)
         * Octets N1-N2: FNEK sig (ECRYPTFS_SIG_SIZE)
         * Octet N2-N3: Cipher identifier (1 octet)
         * Octets N3-N4: Block-aligned encrypted filename
         *  - Consists of a minimum number of random characters, a \0
         *    separator, and then the filename */

Tyler

>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
> --=20
> Kees Cook
> ChromeOS Security
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJO75TbAAoJENaSAD2qAscKDsEP/2HAj8fRhexTHWASOmvzvrSN
0Kw+wWkB13kT197qBCGEizbGhTpYW08rPdHJtcYXAzF/ZqckLO04IuJVUNwLp6VO
4gYqGtvqzG6FOhRtrFDxE8TVFv7cw8tXeVAPn/j4HiPWitohYs4/oJGZw+vDbJHr
xENvps0cU/8FlhfAg3xI6ehs/XgOEQjMTopg5xVGcZscmIFQpYQnYJtzjggXKqas
RvirPHxyEG6O5DSZRiZrpssRoeA8tmQir35j7HpdbI+HDPy26wJQL7tGT66UJ3vn
mG1wm5cWTei1ao8fy3vFwGgkF2hD646ii2jXePp3m6Z0Na1GZe1e3aeIo9rdtE6D
MNNcI33iURIOLvp/qEYvrt2N4BFaIl21KkPKhAsYtTcZogJf47PCisknfq7IzBJX
XIkP/K6y8iF+O4M51v+iPJoBKynvfOHeewBL2AAdfCwY+8kEhAjzSsghL8yXXuan
eXa+1o3jTvhmBoykxPjj2dZ2xrLd5uGfUIeu0h7A/TRkZRykxqt30U8KfGhoYqCF
iaLrjEH/3kmt1Sojvotrpo5GYm8ktylXOxwVIZrKegLRAg1r6hrzOVnDtblELtv8
fLR46OMABrnq01v5NX+6ptSU7b+gP4dg4+IzIYmNZ9fSMfY2mD3pWDqpoZgAhHep
Hra93docUu6Qi0ho9RwL
=PRDM
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
