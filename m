From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: how to retrun different size to different process when I use
 ecryptfs
Date: Fri, 29 Jan 2016 16:24:22 -0600
Message-ID: <20160129222422.GB15683@boyd>
References: <loom.20160122T080227-125@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39884 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbcA2WY1 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 29 Jan 2016 17:24:27 -0500
Content-Disposition: inline
In-Reply-To: <loom.20160122T080227-125@post.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: zhangzhilei <sdhzdmzzl@sina.com>
Cc: ecryptfs@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-01-22 07:28:11, zhangzhilei wrote:
> Hi
>=20
>     a file named 1.txt ,and the content is 1234,when mounted ecryptfs, si=
ze
> is 4,after umounted ecryptfs, size is 12288.
>     I have  implemented a feature like this by modify ecryptfs source cod=
e:
>     1:when gedit read this file, return size is 4,and the content  is 123=
4;
>     2:when some other process read this file, the content is like what
> umounted read;
>=20
>     when file is close, I use i_size_write to write back the size of file;
>     after gedit close the file ,use stat ,size is 4;
>     after any other process close the file,use stat ,size is 12288;
>=20
>     what I want to ask is how can different size return when different
> process read size by stat=E3=80=82=20
>      i.e=EF=BC=9Athe file size is 100;when process a stats it, return siz=
e 1000,and
> when process stats it, return size 100;
>      but when I use stat, it appears that stat direct read cache ,not goes
> into ecryptfs's procedure;

This is either a bug or the process seeing the encrypted file size is
stat'ing the file in the lower mount point.

Can you please provide the (trimmed, if necessary) strace output of
these two processes as they stat(2) the file? Please use the -v option
of strace so that we can see the entire struct stat. Thanks!

Tyler

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWq+aWAAoJENaSAD2qAscKNAoP/00hptKaxiVKjhCQAqFYFwev
7lYQOVrlcyZEzOZyvopR1T+QSgUBB3L4wlUVEQiagVLvNQEeIm5gNFbl4wRGIhM1
PhEu7f53xBnP65tBoBCUL4XyJFOwFxDIcT2PJFwAC62vUoCqP5Edia164eq6oldH
/UpYZz06xSMSJn+1VxzVj8PGDPPbxyKD0oNYuceAOgylX3ig0ynXYwN0U/OV72V3
2NybkwMczW1rVGFyikSrcJ06HyLoGKS9b86FOjOaWIplfwZZudcZjC4XEUgWLj7v
b5nVp4ljZCPKTsueSFbjLNVRE+/m2+bAOA1MPRAapVlvB8LS6R2aNLJCfXlQoKVl
DoRVrHFTzQbrB2MBXp1H+2acTzb+i+jZBEHnyi8xNYs2WNYHQr7TZdEWUvq35jBc
GmHtHD7IvIyvLAp1hlsmpkQAXTNAbyi1pRAfzt0N+F4x74Q/poBbi5HlB4mJeBlU
/nnQ7t5lw+B/pRNtv/297N5PSVpMWzKoFEleXAL0lb8B0BF2ooLwexj9yk6huqqi
Bu9oeUUWf3oGstF4FW8V3gDZsFhvCDivDBPZOSxjxK0hhOCoEQeVoHBJ+fTXcGRm
2Ihu1MSpXrWYqEvsXEz0PLjRgaGt5LVpuoKuNhyhv5H9Hjq4jBziOQYuoqwSnI5c
0mdHZNxeOjS7CKq9PMwc
=qMyh
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
