From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: fix spelling mistake: "cadidate" -> "candidate"
Date: Wed, 28 Mar 2018 20:46:13 -0500
Message-ID: <ad0e32a8-e07d-4e9d-8042-b3920b4a40c7@canonical.com>
References: <20180302090708.25729-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gTuYeQdrMhs9w1OkPRtfbAAkmHDhMrjBE"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302090708.25729-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gTuYeQdrMhs9w1OkPRtfbAAkmHDhMrjBE
Content-Type: multipart/mixed; boundary="o6GL6HIyPbUuG0ZuiXt4InQk9boJ8kIZs";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ad0e32a8-e07d-4e9d-8042-b3920b4a40c7@canonical.com>
Subject: Re: [PATCH] ecryptfs: fix spelling mistake: "cadidate" -> "candidate"
References: <20180302090708.25729-1-colin.king@canonical.com>
In-Reply-To: <20180302090708.25729-1-colin.king@canonical.com>

--o6GL6HIyPbUuG0ZuiXt4InQk9boJ8kIZs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/02/2018 03:07 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in debug message text.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good to me. Thanks!

Tyler

> ---
>  fs/ecryptfs/keystore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index c89a58cfc991..e74fe84d0886 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -1880,7 +1880,7 @@ int ecryptfs_parse_packet_set(struct ecryptfs_cry=
pt_stat *crypt_stat,
>  		candidate_auth_tok =3D &auth_tok_list_item->auth_tok;
>  		if (unlikely(ecryptfs_verbosity > 0)) {
>  			ecryptfs_printk(KERN_DEBUG,
> -					"Considering cadidate auth tok:\n");
> +					"Considering candidate auth tok:\n");
>  			ecryptfs_dump_auth_tok(candidate_auth_tok);
>  		}
>  		rc =3D ecryptfs_get_auth_tok_sig(&candidate_auth_tok_sig,
>=20



--o6GL6HIyPbUuG0ZuiXt4InQk9boJ8kIZs--

--gTuYeQdrMhs9w1OkPRtfbAAkmHDhMrjBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlq8RWUACgkQ1pIAPaoC
xwp3zQ//SBJKNpt480oSsUkg5h/BlqiZgf2jT67eNisdA7e0KS37//7ir+Ed1XjT
yatYwHThDWydOABLnseIIYTiveXDHAVILpqaAL39j6DDvqM8plO8lVk3Diby0fWJ
bebqaFk8gAVrRWrMxQUCBg7d8Xi1RjD5JMNFeQzEzF+b/MTl+uud1Oq08mRGAPcS
36USF3iF9V1KwbWS/7AIok2k8HnrsMVpQ7mgvSDRhfvE9z4yfPB2xv0NZS9Q4N96
Yn5ChX3clyJAnqYLAoFwVKnrJMd+8rcSsuHLNpj57BagvHMagz7+kQV/cM6XAjoH
FsFBoXkycpTEpt+fHqpmMb3TOXuzIYqO5xpvSzIPbAQgaKXc3nfHY3thCrjWQxoC
9r9ODgxq2dE8wuP8PH8Cq7GS9dBv5+7Gom07VqzleQ0XCvDgd7Mgv2FIQv3hJqUj
lmOp69ausRhvuWBjxNiSb2qe1qUoXtoHAhs9qtgdwlKmI0RG8jcSjRunwfUj4cx1
A+rNgRLDixw+Tmz1NJrNhuN5S9mY5IGNqgMdPedunnylAQ7c3TtsZZyywZNVygy1
2Kb2GGjtArq3hPsSlI9xRIqT3EcyJBaXphauVBHdS+uwJysw2h5/BiDkMxJxlHyF
LRzVNSFAHo1iZ9ZsWHAbiP6avvwlo+9oU3zm32Qt+61tFDrcnu8=
=7LXN
-----END PGP SIGNATURE-----

--gTuYeQdrMhs9w1OkPRtfbAAkmHDhMrjBE--
