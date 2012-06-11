From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: ecryptfs o_direct
Date: Mon, 11 Jun 2012 08:04:06 -0700
Message-ID: <20120611150405.GA4748@boyd>
References: <4FD59617.1010608@thomas-krenn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46875 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab2FKPEM (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 11 Jun 2012 11:04:12 -0400
Content-Disposition: inline
In-Reply-To: <4FD59617.1010608@thomas-krenn.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Georg =?iso-8859-1?Q?Sch=F6nberger?= <gschoenberger@thomas-krenn.com>
Cc: ecryptfs@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-11 08:54:15, Georg Sch=F6nberger wrote:
> Hello everyone,
>=20
> is there a short explanation available why ecryptfs is not working with
> direct I/O?

No one has written the code required for eCryptfs to support direct I/O.

Tyler

> According to Jens Axboe I cannot use FIO with option "direct=3D1" because
> my encrypted home partition with ecryptfs is not supporting O_DIRECT.
>=20
> -Georg
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP1gjlAAoJENaSAD2qAscKeEAP/3mvyHx3yMYAuBnSIPVGcuYC
diL1rU/DyzpXQeI/IYUgTwOJGa3e17ni4B5e96hSDGqabBKkm/8e/FgC3V3Sn6iX
OjAsfck4MsB3wkryEz4tlViP+krLgFPMlQvk4vt7opdkNFaCTHFH3CIb6VD/U88p
f6FKQph/EYOLpfdGspfrz1Hfrynx6M83ptb3KTVHPNg4XNx7G6sL+hCMbE3hAmJU
ZKqh8KEoyClyO9WJrqhgt2g0Zn6ucIDQDTcpaxEcHikeGM88gYHGjdE2WkLreJLb
zNIxSg3DgD27/z6peUupdFPStEmqw/jv89h3iDC8jCgirzHMUwbUvc8yofOE1ZU7
ZUpQyHKweVkYkakqH/0GNWY+isDki3OB87RkEFyXAVqmqwE/+BkEN2HRm89Kn5d+
ecLn4VEU2aQzVXd/JiXW8cAAP+qb9iv8DGR3zqjtXfz+fkBnywKnHEvecvjTetRm
8s5UuSrgFXexF126XyZJGq8uOfmUvd6QzL2mPPaj5wy6481LlFAYsvkFbwVd5OYk
TI/Z1tmtS+gHimkfIGThDnmdV9pkA/orSV91hAjMuPyDhlvFo1SZtY/xnZpnpHCz
N/R+kokLvTls7LzbJiA86CT9NSl0VBS5ydcaLm1Js5gz3HhpSkA4+5YZk9MAvgqi
yXqu13V41cR4FCiDlxIX
=iiEA
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
