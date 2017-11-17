From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] eCryptfs fixes for 4.15-rc1
Date: Fri, 17 Nov 2017 21:27:04 +0000
Message-ID: <20171117212244.GA1244@sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51353 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762466AbdKQV1J (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 17 Nov 2017 16:27:09 -0500
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/e=
cryptfs-4.15-rc1-fixes

for you to fetch changes up to 4670269faba728683f7250319a65390946c028e3:

  eCryptfs: constify attribute_group structures. (2017-11-08 17:38:14 +0000)

----------------------------------------------------------------
* Miscellaneous code cleanups and refactoring
* Fix a possible use after free bug when unloading the module

----------------------------------------------------------------
Arvind Yadav (1):
      eCryptfs: constify attribute_group structures.

Colin Ian King (1):
      ecryptfs: add missing \n to end of various error messages

Dan Carpenter (1):
      eCryptfs: use after free in ecryptfs_release_messaging()

Jeff Layton (1):
      ecryptfs: remove unnecessary i_version bump

J=E9r=E9my Lefaure (1):
      ecryptfs: use ARRAY_SIZE

Markus Elfring (3):
      ecryptfs: Delete 21 error messages for a failed memory allocation
      ecryptfs: Return an error code only as a constant in ecryptfs_add_glo=
bal_auth_tok()
      ecryptfs: Adjust four checks for null pointers

Rasmus Villemoes (1):
      ecryptfs: remove private bin2hex implementation

 fs/ecryptfs/crypto.c          | 44 ++++++---------------------------------
 fs/ecryptfs/ecryptfs_kernel.h |  9 +++++++-
 fs/ecryptfs/inode.c           |  4 ----
 fs/ecryptfs/keystore.c        | 48 +++++++++++----------------------------=
----
 fs/ecryptfs/main.c            |  4 ++--
 fs/ecryptfs/messaging.c       | 13 ++++--------
 fs/ecryptfs/miscdev.c         |  8 ++------
 fs/ecryptfs/mmap.c            |  2 --
 8 files changed, 34 insertions(+), 98 deletions(-)

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJaD1QlAAoJENaSAD2qAscKcn0P+QHE+u3anKjIXzmycMD64tLT
OrJ80yUh8ejz1IdRVpz/8p/Oc4i9SBfWuejUflcED3Y3maFMJjEYMF4mD1Yh47XI
uFwal7bA3xLifcmejNl6xwaKUJhAuTmqrIBW3b0victmrnDpRx3b80RR54TL5UY/
+0gPdYkC/mnK9jKdc6TRSTrRarqgC+L16Y8fVOVkKkVIMECcpoe7yam611dPO7k0
nBpkq0haxr4es0/BY6OTEwrdQHD8NkNsBMvGjUvdoGiP9Nps6X9e3NvnQ5wHakIX
cysIevHRead/48p0iShLRRCeeNFqL4eDIPNJLArxitIvNH/6VmdpHZReRN6sj5Yb
ovnDsvnA8M5x5dnol7Ibt5cE+OlSE24WxDEINSh9c7Z79a9Os2wO4gazKk+iCBl1
93MUv2uPHPiXVylRMLGcraF33DpJXYF/mFRdYhDG5QNwxWiM1h34BDUVxVGxeRjW
xVXY6zEoKtllbw6Ks/QSquIb1wg7ZX1pL54Jhh1nwNfHsLCcZjYURe5cjYzrbfIu
ZcqU2y3zXaENBw/uRkLEkKfgMd1Vcc99nUUQCrh1CoI5pvkI1uIHbZwWTkewwmaG
qK4daoaZ45vWWZNsRQX2mPbTh85NwezfcHfTRdsEsJMCDoyXHcevDh/1JYlMm+ZT
Y+mwUiyvTmrfPOGCRE8g
=R1m1
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
