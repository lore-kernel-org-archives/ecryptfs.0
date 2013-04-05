From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: async crashes
Date: Fri, 5 Apr 2013 16:52:58 -0700
Message-ID: <20130405235258.GA11632@boyd>
References: <1364651830.2286.140661211073081.738964DE@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55630 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163063Ab3DEXxD (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 5 Apr 2013 19:53:03 -0400
Content-Disposition: inline
In-Reply-To: <1364651830.2286.140661211073081.738964DE@webmail.messagingengine.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: ecryptfs@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-03-30 15:57:10, Jarkko Sakkinen wrote:
> Hi
>=20
> I've been experimenting with async branch of ecryptfs for some
> workloads. Sometimes it crashes so that ecryptfs_encrypt_extent_done()
> first reports -EINPROGRESS (-115) to kernel log. After that it crashes
> in ablkcipher_walk_phys().

Were you building with Zeev's patch titled "eCryptfs: ablkcipher support
- add workqueue"? A (temporary) link to the patch can be found here:

http://git.kernel.org/cgit/linux/kernel/git/tyhicks/ecryptfs.git/commit/?h=
=3Dasync

Do you have a way to reproduce this? Any exotic hardware? Any crypto
acceleration hardware?

> I looked at ecryptfs_encrypt_extent_done() and this made me think
> whether it should have special case for having -EBUSY and -EINPROGRESS.

Looking at other ablkcipher callbacks, I'd think we'd at least need a
special case for -EINPROGRESS.

>=20
> Sorry about bit coares "bug report" but I'm not expert either with
> ecryptfs or crypto implementation.

No problem, thanks for bringing it to our attention!


Additionally, I just cc'ed you on a different patch that I have been
working as an alternative to the async patch. Maybe you can give it a
try, as well.

Tyler

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRX2PaAAoJENaSAD2qAscKS2QP/R0emauK41NprVLZwkJMMyGh
NJizoGbCa+gSz/7a747ABHmUzPtfL2bTs9s3xjPfzts2GNJ6+v0GE0f9jw+2ZxDw
iVU95oSR0Kl4YYNUnxtQ9oBInMyrPRm2xxX0HKkkAJ3TvRzJSrJolIYGcUamNJau
pObTQSufJCpiLla1+vnKv14hqvdyg6C8Mdxvz6KNGixwnXcyyd6xHPwyvBHy8/dr
3D1bpg/VoUW3Mh++dnEbbPDomu3JRX6gnJlg79MtYmACeBbN9hqeZVLsNr/PXqZ7
cTf3uaC2Y8U86/OKXHuXUZV0qVByp1WWKoalgz4Bc+rosDuO5+03hLWf3p7H7mC+
VmY389m/wEdNpcYVYlvFPcUumrCuW+t4Ruka//ry6lk13WhB/WCJLNsiAXxBgQvH
hWCU9B4JjPF2c4XueJydVPak1JtJ6qs0Uf6G+h5AT/Ls8QpwYIoekBrbqiPCGfrK
180WAhTzOvRg3Edr6WswdnvNxHH6rJdgbyKMUcDetFZh6lEUZwfV/4dp+enW/Hi6
nNzdcXyiRSMEDPR+FVHpRAvBDhBJZBTClsNc+0LL8gFyyfLzoo8Hj+EBWBhQqci7
oHix3O3mVZT1LgGSLM1lsoeSdy1lJMrY7Sw8Nc7YoztWjIeifcXt9ruL5VY86d5o
8VHGpXn48O2H9Xf4Mj3N
=doSo
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
