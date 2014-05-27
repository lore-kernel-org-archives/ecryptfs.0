From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Please patch key_mod.c
Date: Tue, 27 May 2014 11:06:09 +0200
Message-ID: <20140527090609.GA26330@boyd>
References: <536E62DD.8156.E36EA@jafojtik.seznam.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53865 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbaE0JGN (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 27 May 2014 05:06:13 -0400
Content-Disposition: inline
In-Reply-To: <536E62DD.8156.E36EA@jafojtik.seznam.cz>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jaroslav Fojtik <jafojtik@seznam.cz>
Cc: ecryptfs@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for missing this patch, I've been traveling.

On 2014-05-10 19:33:17, Jaroslav Fojtik wrote:
> Dears,
>=20
> Please patch key_mod.c.

This change looks good to me. I've pushed it to lp:ecryptfs. Thanks!

Tyler

>=20
> If you receive following message, it is totally frustrating because you d=
o not know which
> directory attempted to open. The path at least gives some info about it.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> mount.ecryptfs /DATA/.BACKUP /DATA/BACKUP -o=20
> key=3Dpassphrase,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D16,ecryptfs_p=
assthrough=3Dno,ecryptfs_
> enable_filename_crypto=3Dyes,ecryptfs_fnek_sig=3D87f8f52c6f46cfca
> Error attempting to evaluate mount options: [-1] Operation not permitted
> Check your system logs for details on why this happened.
> Try updating your ecryptfs-utils package, and/or
> submit a bug report on https://bugs.launchpad.net/ecryptfs
>=20
> 2 keys in keyring:
> 620524981: --alswrv     0     0 user: 87f8f52C6f46cfcA
> 1017206571: --alswrv     0     0 user: 87f8f52c6f46cfca
>=20
> Mar 30 18:40:39 ESC_router mount.ecryptfs: ERROR: Could not open key_mod =
directory=20
> Mar 30 18:40:39 ESC_router mount.ecryptfs: Error attempting to get key mo=
dule list; rc =3D=20
> [-1]=20
>=20
>=20
> best regards
>    Jara
>=20
> ---------------------------------------------------
>=20
> *** key_mod.c.old	Sat May 10 17:57:51 2014
> --- key_mod.c	Sat May 10 17:58:31 2014
> ***************
> *** 252,258 ****
>   	}
>   	if (!(dp =3D opendir(dir_name))) {
>   		syslog(LOG_WARNING,
> ! 		       "ERROR: Could not open key_mod directory\n");
>   		rc =3D -EPERM;
>   		goto out;
>   	}
> --- 252,258 ----
>   	}
>   	if (!(dp =3D opendir(dir_name))) {
>   		syslog(LOG_WARNING,
> ! 		       "ERROR: Could not open key_mod directory [%s]\n", dir_name);
>   		rc =3D -EPERM;
>   		goto out;
>   	}
>=20
>=20
>=20
>=20
>=20



--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJThFWBAAoJENaSAD2qAscKe2MP/28Y/jbGie3mGwsyvY7vqReM
tNlI/tzCS8K2qSSN+kSeU+jcgdqXh0YxnOqzlHeYiE0Wa6AQoKGK0OlAhhPu1RUF
Biv+Sd3Ti3Y+yyBAHoJucBVH0DJokwEBvqgT3O9kiZSYbYre5900ipunAepE5ObM
LSDWtaiqyB1TBHg4B1NHCZzsGTkKlAJwNdAO3Pdilq9Kb1IN0+4K8BymSZZoOEhO
tArZQvC7qZluX2Fbnia+HAzDrtN6JAuhmipvI6l96JS6Qj0k4Yb6/L+KDClk2cmq
DzbDhTQYO5a68gpnhlOMnuzQbxaNRZaGAYR7U8sgaCHNaJLLSz09Biq/XpeZSj9Z
gHmupRrI5YEuTzpZS+siA3koue3DDc1cS0XLUibfOEHbJpM0sjTnArLS9f5VsqFF
PUKTwDmoqeo7sfgiWFUrV/M2TA/h2J4V+45KCMsDxvtMRj24Qi5GmJUS2uSsSuBU
oQoMpumAhNuBrX0Ikn9TT+K4VUZIFB9pQbNVXfbSz+nftcz/N2ooGlC/c4oZclFc
15vUID5U/6LwV26uJfy12Wfxqi7HeEMKaM7eH1jW9sKYuJXxLPr0Eg6c5fgwfDoj
Vcw3wnsFdwZjukEpLR7etWGSkNUQt++Wwv1cTVffhrMj6mU+hd1ZdIiOsBDuquZx
x6New0xmJq7aKafvU5Td
=SOC/
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
