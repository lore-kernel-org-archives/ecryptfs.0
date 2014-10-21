From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: is size correct in ecryptfs_parse_packet_length()
Date: Tue, 21 Oct 2014 17:29:53 -0400
Message-ID: <20141021212952.GA18270@boyd>
References: <20141021120435.GA19969@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44879 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933517AbaJUV35 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 21 Oct 2014 17:29:57 -0400
Content-Disposition: inline
In-Reply-To: <20141021120435.GA19969@mwanda>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: ecryptfs@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan - Thanks for taking a look at the code!

On 2014-10-21 15:04:35, Dan Carpenter wrote:
> fs/ecryptfs/keystore.c +93
>     85  /**
>     86   * ecryptfs_parse_packet_length
>     87   * @data: Pointer to memory containing length at offset
>     88   * @size: This function writes the decoded size to this memory
>     89   *        address; zero on error
>     90   * @length_size: The number of bytes occupied by the encoded leng=
th
>     91   *
>     92   * Returns zero on success; non-zero on error
>     93   */
>     94  int ecryptfs_parse_packet_length(unsigned char *data, size_t *siz=
e,
>     95                                   size_t *length_size)
>     96  {
>     97          int rc =3D 0;
>     98 =20
>     99          (*length_size) =3D 0;
>    100          (*size) =3D 0;
>    101          if (data[0] < 192) {
>    102                  /* One-byte length */
>    103                  (*size) =3D (unsigned char)data[0];
>    104                  (*length_size) =3D 1;
>    105          } else if (data[0] < 224) {
>    106                  /* Two-byte length */
>    107                  (*size) =3D (((unsigned char)(data[0]) - 192) * 2=
56);
>                                     ^^^^^^^^^^^^^^^
>    108                  (*size) +=3D ((unsigned char)(data[1]) + 192);
>                                     ^^^^^^^^^^^^^^^
> These casts are no-ops because they are "data" is an unsigned char
> pointer already.  Then the value is type promoted to int, we subtract
> 192 giving a negative number and we multiply by 256 giving a slightly
> larger negative then we save it as a very large positive.

Subtracting 192 from data[0] should never result in a negative number.
We know that data[0] is greater than or equal to 192 (and less than 224)
because the previous conditional was false.

>=20
> I don't know this well enough to say what the intent was.

This method of specifying packet sizes came from RFC2440 "OpenPGP
Message Format" (https://tools.ietf.org/html/rfc2440#section-4.2.2).

Tyler

>=20
>    109                  (*length_size) =3D 2;
>    110          } else if (data[0] =3D=3D 255) {
>    111                  /* If support is added, adjust ECRYPTFS_MAX_PKT_L=
EN_SIZE */
>    112                  ecryptfs_printk(KERN_ERR, "Five-byte packet lengt=
h not "
>    113                                  "supported\n");
>    114                  rc =3D -EINVAL;
>    115                  goto out;
>    116          } else {
>    117                  ecryptfs_printk(KERN_ERR, "Error parsing packet l=
ength\n");
>    118                  rc =3D -EINVAL;
>    119                  goto out;
>    120          }
>    121  out:
>    122          return rc;
>    123  }
>=20
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJURtBQAAoJENaSAD2qAscKMqkQAMIaENcEWyF9i30hCv66pypf
h21h2DWQ9VDyrc05soJkrOIZJAcyB6td/84cs+TRVLZPVcSNvRbb5ul9aoCQQxs9
fBjY+bLJBcrcmerVQKMSBkfqeb02Tu1d+VcoCx+wE4BaDXELoes2z8EvNP5Rvfra
WrTmAx/38V/YmZ9rj6NkhZDDyFaPHh4mzzQql7vYLDcTVDmxc2n0unb6l7JThWP5
Xp7nWeuUBa0UETyHQMIqD7ZpTQPRLJvOSDdVfOfNmLOIobgbgGOzk+UkxcWBBQdJ
UBwSUir+afTwOr0paZu83yWU5NFiVrfSbL/44ful3dOMlVuiF0XKFPtPBrz/TRh6
ZCySJN8hHQq2AAhl+27dhVzjD7V2pCylxoWsDLJoRPGQl8ytH6HWJOl8MZtjPpDY
gdDRBGimHzZCa5rhawKxN99xd1C9BExQhhS3S0Uh5F4bNw48BMmCbS5hFfxdwlmX
/knPRhH/BTbBTVpvw3Ul6xr2HRswGw06Ktpc3njsClTv7c91FwaO/HWaQBXe1ESQ
gpgNeo/WaPR3fMYKUv1PVjJqlx9xFNIBym3BjkEcQ4r4ohPuBxaIIkVSGsBHP6Cl
4t/JaCuR/mvDOS923l2kmEtJXJNtGKP5WEIexqKw8ZHLCWnsCfBtIm9CW2vCiRqD
a5dIDAV9Y5y3N3V76/B8
=O9us
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
