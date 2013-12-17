From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: eCryptfs using openssl encountered "Transport endpoint is not
 connected" when writting file into the mounted folder
Date: Tue, 17 Dec 2013 10:41:23 -0800
Message-ID: <20131217184122.GB5177@boyd>
References: <0f6d01cef4ca$06b35430$1419fc90$@b2b.com.my>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33108 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab3LQSl3 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Dec 2013 13:41:29 -0500
Content-Disposition: inline
In-Reply-To: <0f6d01cef4ca$06b35430$1419fc90$@b2b.com.my>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: cc chen <cheanchaeng.chen@b2b.com.my>
Cc: ecryptfs@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-12-09 18:32:54, cc chen wrote:
> Greetings,=20
>=20
>=20
> I am having the error as per subject when I am using the openssl
> (passphrase) key type, the thing is I don't get this error when using the
> passphrase as key type.

The OpenSSL support in eCryptfs has never been very polished. There's
not much user demand for it at this time, so the focus has primarily
been placed on passphrase support.

>=20
> Below is the steps using openssl as key type, appreciate someone can help=
 to
> advise what are the mistake:
>=20
> (A) Create test.pem public/private cert using using "ecryptfs-manager"
> (B) List of commands to mount the disk and result output:
>=20
> # mount -t ecryptfs  /secure/.s3 /secure/s3
> Select key type to use for newly created files:
>  1) openssl
>  2) passphrase
>  3) tspi
> Selection: 1
> PEM key file [/root/.ecryptfs/pki/openssl/key.pem]: test.pem
> Method of providing the passphrase:
>  1) openssl_passwd: Enter on Console
>  2) openssl_passwd_file: File Containing Passphrase
>  3) openssl_passwd_fd: File Descriptor for File Containing Passphrase
> Selection [openssl_passwd]: 1
> Passphrase:
> Select cipher:
>  1) aes: blocksize =3D 16; min keysize =3D 16; max keysize =3D 32 (not lo=
aded)
>  2) blowfish: blocksize =3D 16; min keysize =3D 16; max keysize =3D 56 (n=
ot
> loaded)
>  3) des3_ede: blocksize =3D 8; min keysize =3D 24; max keysize =3D 24 (no=
t loaded)
>  4) cast6: blocksize =3D 16; min keysize =3D 16; max keysize =3D 32 (not =
loaded)
>  5) cast5: blocksize =3D 8; min keysize =3D 5; max keysize =3D 16 (not lo=
aded)
> Selection [aes]:
> Select key bytes:
>  1) 16
>  2) 32
>  3) 24
> Selection [16]:
> Enable plaintext passthrough (y/n) [n]:
> Enable filename encryption (y/n) [n]:
> Attempting to mount with the following options:
>   ecryptfs_unlink_sigs
>   ecryptfs_key_bytes=3D16
>   ecryptfs_cipher=3Daes
>   ecryptfs_sig=3D74c90d4c6548e015
> WARNING: Based on the contents of [/root/.ecryptfs/sig-cache.txt],
> it looks like you have never mounted with this key
> before. This could mean that you have typed your
> passphrase wrong.
>=20
> Would you like to proceed with the mount (yes/no)? : yes
> Would you like to append sig [74c90d4c6548e015] to
> [/root/.ecryptfs/sig-cache.txt]
> in order to avoid this warning in the future (yes/no)? : no
> Not adding sig to user sig cache file; continuing with mount.
> Mounted eCryptfs
>=20
> # cd s3
> # touch test1
> touch: cannot touch `test1': Input/output error

You need to have an ecryptfsd process running for each user that will be
accessing the mount point. The kernel asks ecryptfsd to wrap/unwrap the
file encryption key using the public/private key that you generated with
OpenSSL.

Performance is bad and I wouldn't expect as stable of an experience as
with passphrase based mounts. It would be great if someone was
interested in fostering the OpenSSL feature to make bring it up to the
same level of maturity as passphrase.

Tyler

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSsJrSAAoJENaSAD2qAscKdTwQAMb/cIjTW/5uN3klKhkJSSRA
PyvBgG4iqWw0cXbQ0s89IAc5b/ldeIe6TORTysVu30E8qwS5waSrTiBY3Ioku6zk
UGvloHAsiCLyqJ9rKCpkyvM8ExxZt1QsVqEsq9DSRdJ/9vVgPtNIo7Z0BbCAloUF
IjnRknCy0B+e7us99OEsptPCX9PUrDC4/0N3QVVV9OLBclv5xpmK88UbRjZtMVNV
czyraWlSTpW4PViVCpm+pv/nke1OZRXniI3cDcxUdKOBHumW3OLa5dH3OjYXGojt
1M9xNv3YLL4mPOpwUyVp+NMuqv63khkdHtGIVDgYNH0lCE5qcS2xf4EttdLtMVAu
9k8f1cP8WnR+k4gzzp/Q2B4ef9PcQ7l4/hQNFA3Js8jp6ZDa50tHfT/1yNLuz+tp
hGcgZwtn2oibxLXWFc5YDhlulzmL3GQB3EBZEhvIj4Q8RR1GOOAweGG3N+HsKLKy
ZkywYGkJbhd7FaUgF6d4jZaCNWInp/AbwkkcFZLLe9zb2rNh9pTqtNbSaoy3u0s4
emY3bbAN3kHJDFgeiOzZB7hWuLg+7aZ+rOVNxrgvq8VdZw13qsQBWdVDxOupSTHm
LPJGviwu2pqZfrGBq92PqqOwDHV3MX3c1VAotDNavvwFQsXTzS3CponCQFR5Ok4x
25qMNu+zqrfIDnDMnzd3
=RwV1
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
