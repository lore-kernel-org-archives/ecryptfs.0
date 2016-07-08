From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] eCryptfs fixes for 4.7-rc7
Date: Fri, 8 Jul 2016 10:49:40 -0500
Message-ID: <20160708154918.GA5442@boyd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56866 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbcGHPtu (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 8 Jul 2016 11:49:50 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

  Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-4.7-rc7-fixes

for you to fetch changes up to f0fe970df3838c202ef6c07a4c2b36838ef0a88b:

  ecryptfs: don't allow mmap when the lower fs doesn't support it (2016-07-08 10:35:28 -0500)

----------------------------------------------------------------
eCryptfs fixes for 4.7-rc7:

- Provide a more concise fix for CVE-2016-1583
  + Additionally fixes linux-stable regressions caused by the cherry-picking of
    the original fix
- Some very minor changes that have queued up
  + Fix typos in code comments
  + Remove unnecessary check for NULL before destroying kmem_cache

----------------------------------------------------------------
Chris J Arges (1):
      ecryptfs: fix spelling mistakes

Jeff Mahoney (2):
      Revert "ecryptfs: forbid opening files without mmap handler"
      ecryptfs: don't allow mmap when the lower fs doesn't support it

Julia Lawall (1):
      ecryptfs: drop null test before destroy functions

Wei Yuan (1):
      eCryptfs: fix typos in comment

 fs/ecryptfs/crypto.c  |  8 ++++----
 fs/ecryptfs/file.c    | 19 ++++++++++++++++---
 fs/ecryptfs/kthread.c | 13 ++-----------
 fs/ecryptfs/main.c    |  3 +--
 4 files changed, 23 insertions(+), 20 deletions(-)

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXf8t+AAoJENaSAD2qAscKQX0QAL+UZIDT/l+0Ihn8dX/9Y8iu
nkHshjYfL5WCOC3/MKOoxnvVUSAxxgmxBn/EHxYwihpxJbim1xjI9qzDW05nOcxT
cfz1KTKZdPRHmW/4PkaxCNVlf3tpGGeNu/l1g+XtzfC1sR5v6Sv4KeFPym1C6NkM
BaJpByZ/Z18W+o71ABHhjBnO54EsJs1wjW4a4/zv8hI3nyi+FmZKUbodp4XPou7S
T29+dRQPiZXHbI1diVbH8Q3OtPOCY/NeN2uEEl5R0edpUoT3TDscrhEhe5qg9lRh
vYYk1SGFGPl9Ev0xOVk6sQtuf/4LsIPFyCkH8uU0tyvPAR+eHP5jJE0WAeiDpFot
B2dNGIn8asXTUT9Z1xgT4/AGoCIaYbXMgnqnUsnXoWiVLqeXl4hYJ0nOLL9GSiul
eMS4Ond5bZGvuGIpw8Ci26fMQuC8G615CBnyCUAUNsrYgu4C4RYtqRRlguEmesR5
WqN5YqEsGqFq65XUUXjtG+jAqQ2rItFQijKPJRaNAVTLHhSq7RQ8mqxjQSpGLJJA
nM5+wu8Khdvs00sPHlIQ94BkEJ4McbuQ+69NjqU4VRLD6A2cZ4NgYUUkNIm07mj0
1b8QJogKTvNxSYeRxeuBBILcoRVWny+ueQrc9+4pquFeM8j2pFPnc7CGxPVjiUL6
thRz4+FB2JMHC3vci0yL
=UAyi
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
