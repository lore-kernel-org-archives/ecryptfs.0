From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 0/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 08:54:46 -0700
Message-ID: <20120613155445.GA21062@boyd>
References: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57566 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab2FMPyv (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 11:54:51 -0400
Content-Disposition: inline
In-Reply-To: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: ecryptfs@vger.kernel.org, Thieu Le <thieule@google.com>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-13 13:14:29, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> This is a forward port of Thieu Le's patch from 2.6.39 to migrate
> to using the ablkcipher API for eCryptfs.
>=20
> Performance Improvements:
>=20
> I've instrumented this patch to measure TSC ticks per 4K encrypt
> and decrypt operations to see how this patch compares to the original
> code using the default AES generic crypto engine as well as the
> new Intel AES-NI instruction capable crypto engine on an Ivybridge
> i7-3770.
>=20
> Patched:                TSC ticks for 4K        TSC ticks per byte
>   AES-Generic Read:     5843.5                  1.42
>   AES-Generic Write:    19295.8                 4.71
>=20
>   AES-NI Read:          5677.0                  1.39
>   AES-NI Write:         19257.9                 4.70
>=20
> Unpatched:
>   AES-Generic Read:     92861.5                 22.67
>   AES-Generic Write:    93642                   22.61
>=20
>   AES-NI Read:          91610.2                 22.37
>   AES-NI Write:         93659.2                 22.87
>=20
> ..so at the crypto engine stage we see some considerable speed improvement
> with the patch.

Colin - Thanks again for carrying out this performance testing!

Tyler

>=20
> I've also run some simple benchmarking tests comparing this patch with
> the un-patched kernel on a variety of machines (Ivybridge, Sandybridge,
> Atom) and drives (HDD, SSD) to see how well it performs.  A LibreOffice
> speadsheet of the test result data and a write-up are available:
>=20
> http://kernel.ubuntu.com/~cking/ecryptfs-async-testing/async-patch-result=
s-1.ods
> http://kernel.ubuntu.com/~cking/ecryptfs-async-testing/async-patch-summar=
y.txt
>=20
> Soak Testing:
>  * many kernel builds using -j 64, on HDD and SSD
>  * eCryptfs tests with lower filesystems: ext2, ext3, ext4, xfs, btrfs
>  * exercised on a 4 CPU (+hyperthreaded) build machine
>  * bonnie++ and tiobench tests=20
>=20
> Colin Ian King (1):
>   ecryptfs: Migrate to ablkcipher API
>=20
>  fs/ecryptfs/crypto.c          |  678 +++++++++++++++++++++++++++++++----=
------
>  fs/ecryptfs/ecryptfs_kernel.h |   38 ++-
>  fs/ecryptfs/main.c            |   10 +
>  fs/ecryptfs/mmap.c            |   87 +++++-
>  4 files changed, 636 insertions(+), 177 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJP2LfFAAoJENaSAD2qAscKY8oP/2HdKWi68tA5sS7yf6d0gPDt
F9i6ZUPOpsqeIGRPDWgNsQui74ksAFXbWMfoKeea2Z5h04F6CQ6pwnzYrJOYObgv
Ri9Sxq7M6h6RepoHgeBd5kFLWMFM69s7GgGMxnrOSqgISBWV2/llMPCIHybg96EP
WCzvf4DCgM30yTDxx7EHCP0BB0f6wpj8nOppxZQVFbzdSIpTDgqr+lbsUeUgBjcw
HSl/oD7ijVXSiFpu7R9lNB9IEvIvp0yYmuXb37z346Th4u+UvBLlCcqGAD+MmqEf
61XM+qbteFxy5p/5zeqqxuWFkUExFUBhrwxrtPkFv9uhZZwnPzzWozBl+uDGOf0A
Qje4KLUG7qI9ToNElgDAo7/Q63JV1rNMCVJXfFIRzXchxYaoD5loeCWyJ0SwfEmY
SbUuhGG9rWrRhuGJlpPRVyB727jySUgu+B0kIcfNaWT1iRFH2ww8irHgpFPyUGG1
kYtokmlI/s7UB036qZnCtqBwsBtNPzktBUCTVORRMCKZpNp0Tcpxy/rAMTKtYrYC
2EBirW+yCJskWfxnheThXm+Nraiedy7fg2n38Zn7pYsD3de+fEnU8kaz0jOPcBK0
vxWRD3+ttMsNKuFXJT4ptLcxf34dCUrtKe64svz7DRtInKnvAr1onQJGF8vvREK7
jXVQnRGQCgNftTzMLdMi
=TJmp
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
