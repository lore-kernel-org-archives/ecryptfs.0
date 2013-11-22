From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] Minor eCryptfs fix for 3.13-rc1
Date: Fri, 22 Nov 2013 10:39:32 -0800
Message-ID: <20131122183931.GC27306@boyd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41698 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab3KVSjh (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 22 Nov 2013 13:39:37 -0500
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 42a2d923cc349583ebf6fdd52a7d35e1c2f7e6bd:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next (2013-11-13 17:40:34 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-3.13-rc1-quiet-checkers

for you to fetch changes up to 2000f5beabc9c6baf084de5f7879975408e3652c:

  eCryptfs: file->private_data is always valid (2013-11-14 12:12:15 -0800)

----------------------------------------------------------------
Quiet static checkers by removing unneeded conditionals

----------------------------------------------------------------
Tyler Hicks (1):
      eCryptfs: file->private_data is always valid

 fs/ecryptfs/file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSj6TjAAoJENaSAD2qAscKA+EP/11hPj2BAcoJvJcyWTPX3Phk
LtonSjsfVxhB1sU0Bd0tX7Zp/5vAI2NfK8gfMoq7vIzWeP3+Yyc8TgZzTLG+GhNf
sK9ivlvPqKY72xhYMgBWgYpXVWLUFb2JngkLtqHlyZvG7QzjtEpkA1rniTyI6DTy
J1gGSqblgilfeiMnbc8JrsGOD8BYlzFVLPqqsTpDayHQF38O6kK02gyg8sFjCRqW
XtoQgRwuj42Gia6ltzAqigRs41dpR2mr18NhA13iiOfZ46JoqQcujY/P9RglAMiC
/2WouBd+o59EUxm7TTY9EWif5AF3bObY81cIisLmnzdXWmRh9RspsqrC0wsbgAAM
olKJ6uxMpgJrL2C1XnKSZEed37itWH5PxWhDl0FLhJhPy133SzTnYHYyodJmkOuO
7GA+Llt8mC8jTpXRNN0q0x8oGbIviowY6/FyUcAcjTr87Shvmd3jJpucEaC5Ywm3
74ELs1M77n2oSAvjoK+SMq7nyv+TeYYyS2UGoxh5VIamPjwWdky317TTaTEKtLnB
azIJO6uCwXTvypSlUAizxasjXqS9WpGFQe/yY9zIFqBZke6fDHaDeUv3MdnPY2pa
mWznhRqI9QMV1+xj+cTdbVpCnXtMrDWmIanRYnVJIwygQExfjG4XC4SidieR2pZG
6M8g6yyOTgAP8MmNGSVi
=ZXIk
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
