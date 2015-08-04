From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Tue, 4 Aug 2015 09:52:11 -0500
Message-ID: <20150804145210.GC6887@boyd>
References: <1438338190-22518-1-git-send-email-richard@nod.at>
 <20150802010259.GA19522@boyd>
 <55BDCBF4.1050305@nod.at>
 <20150803052758.GA24915@boyd>
 <55BFB39D.5070702@nod.at>
 <20150803230754.GB2342@boyd>
 <55C051CA.60009@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C051CA.60009@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-08-04 07:46:50, Richard Weinberger wrote:
> Tyler,
>=20
> Am 04.08.2015 um 01:07 schrieb Tyler Hicks:
> >> Okay, then I'd argument to give my patch a try although it is not the =
solution
> >> to the problem I've reported. :-)
> >> If you don't mind I'll resend with a proper changelog.
> >=20
> > That patch isn't correct since it assumes that all eCryptfs super blocks
> > are equal if the lower paths (and, ultimately, the lower inode) are
> > equal. However, the lower path is only one of many properties of an
> > eCryptfs superblock. For example, the second mount may have been
> > configured to use a different file encryption key.
>=20
> How would this work if I mount /foo using AES to /mnt_a
> and /foo again using 3DES to /mnt_b?
> Wouldn't both ecrytpfs instances kill each other's files?

No, they shouldn't. Each file contains metadata that describes the
cipher, cipher mode, key signature, etc., that was used to encrypt the
file.

When the file is initially opened, the process must have the correct key
in the keyrings that it has access to. After that requirement has been
met, eCryptfs is smart enough to parse the metadata and use the correct
cipher and mode.

The mount options, such as ecryptfs_cipher, only specify what should be
used when creating new files.

Tyler

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwNGaAAoJENaSAD2qAscKYBkP/R6DntxTu5ddbhCMWh8n2EGG
Q5667UnfS2fgv+QmSBIwNXfPbzBNi88rZnm6G3qWDxMnN/XxUyudMkDEzIPkKfdh
aqsmv5z6GRO+qzTQW9CEYmyEBlsYtBlDa3KTAWBD/S7bto/BBoExe49+v92l6Tn5
ckxqTU18aophaFS6R568Xyg7LKrxgNAcrhbDCvU+WVZKPZgN5wE/6XiktgLFQkva
AZij5cRZhuZ4Te98/aO+ku53IqBqdDrmC5kaicFbOKr1pHR4kzq/STCExA8/Esh/
En9uMAvF3/CPQa7r/mM7HJN7EtlG6tWfsgw6bnEZzkPVj0DdkobJ/Xkm3ae9UM2E
/VS0KcKlMm+fwPk/VwIikWqYwxtDIJjdqNnoHleDm9vT2xEnSee3fqEniYQ+zR95
9ZIfnclW4Nz6+cpFlXlxVTa9clQN1nB0cizUbHJY38grZTljOhEsuvOQYJXR5NNY
e4vPAn2LZ6gujeoeTYypz7Eykz5jCb/7WFlOI0KlaC1se1aUDiFLiM2IczpjZLK6
yAZ+C37lT+9hKHoki1H78s6p4N6ABuOoY8N8NGPD2qsACgb6/ylD+jnabG5ym/Dk
nuoreEG6H/Iqm8tP0+dflAZNIUzbciono6p6sidTEQrRbIyEqeEbcvmnCmx1UIAD
rRJIfP0SatSO0zY19Sjb
=KUao
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
