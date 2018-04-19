From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] eCryptfs fixes for 4.17-rc2
Date: Thu, 19 Apr 2018 16:10:29 +0000
Message-ID: <20180419160750.GA16628@sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3215b9d57a2c75c4305a3956ca303d7004485200:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2018-03-20 17:44:27 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-4.17-rc2-fixes

for you to fetch changes up to e86281e700cca8a773f9a572fa406adf2784ba5c:

  eCryptfs: don't pass up plaintext names when using filename encryption (2018-04-16 18:51:22 +0000)

----------------------------------------------------------------
Minor cleanups and a bug fix to completely ignore unencrypted filenames
in the lower filesystem when filename encryption is enabled at the
eCryptfs layer.

----------------------------------------------------------------
Colin Ian King (1):
      ecryptfs: fix spelling mistake: "cadidate" -> "candidate"

Guenter Roeck (1):
      ecryptfs: lookup: Don't check if mount_crypt_stat is NULL

Tyler Hicks (1):
      eCryptfs: don't pass up plaintext names when using filename encryption

 fs/ecryptfs/crypto.c   | 41 ++++++++++++++++++++++++++++-------------
 fs/ecryptfs/file.c     | 21 ++++++++++++++++-----
 fs/ecryptfs/inode.c    |  3 +--
 fs/ecryptfs/keystore.c |  2 +-
 4 files changed, 46 insertions(+), 21 deletions(-)

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJa2L9pAAoJENaSAD2qAscKDFYP/R1LQEn6HG8SpedTnYLLBp6O
8ieCBd8LPTRXHJnchR0q3lkeZsPGoPXIQpTsQdpqECs7lzvIOw8Mm6bAPiVhMLYp
MZtnnsfuPuOA7r1G1p503ksiCtin2Y8TVT9EDzZE+Hv92zIivUlQYZYp9tzrqTpu
xd6oYU06AI7DIshVT6fpchd6hHl0J+8d1EhH62ssHqEUK2ZPSbft92cJ+uZHHqgP
UXJDxnyzvAT/wQdbg/86ZDH6+QlMgZ4Gps/YLGV3j/hGr0h2BE7RZQ7pR6u2Q+u3
H9A587K4uQTRsSSwqyJ5qhMlGPSxt7qsBeq6blx0l74/hNZqRjGfFOdKbYBqhGs3
vwI611C70y0FHXyxDp1OL5GjKgGjo3Zu/DETf2PLFvNkqDKPYe8pj2IMUboAE1f0
Cj9rqHg+jzDnGuk1LgMb6KPDkIr/S4Yye6OY96h2mQ4Runz3hxpwG1fHldBGx1Kn
aDfWFN7c5ADcLxY+f4spHCqRcO9t8YKVudovze0bbwmYO4dH+oBJoyHLfLK08VWy
t9PNDmC4vFaBko0Yxvb1RR7afD2BSC7JKaeyvfXfxVwHPiD3dxGRDSX0TSUN96SO
vjEJafZkDzDHNliH7aUj+X9FRSbMCEHbZWU+QnOWbPsRRcUjaqlF84wreJC8yVaY
K3wFCq0kXTCp6uIy0D21
=C90c
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
