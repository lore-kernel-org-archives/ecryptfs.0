From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] eCryptfs fixes for 4.0-rc3
Date: Wed, 4 Mar 2015 16:14:34 -0600
Message-ID: <20150304221433.GA25320@boyd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-4.0-rc3-fixes

for you to fetch changes up to 6d65261a09adaa374c05de807f73a144d783669e:

  eCryptfs: don't pass fs-specific ioctl commands through (2015-03-03 02:03:56 -0600)

----------------------------------------------------------------
Fixes for proper ioctl handling and an untriggerable buffer overflow
- The eCryptfs ioctl handling functions should only pass known-good ioctl
  commands to the lower filesystem
- A static checker found a potential buffer overflow. Upon inspection, it is
  not triggerable due to input validation performed on the mount parameters.

----------------------------------------------------------------
Colin Ian King (1):
      eCryptfs: ensure copy to crypt_stat->cipher does not overrun

Tyler Hicks (1):
      eCryptfs: don't pass fs-specific ioctl commands through

 fs/ecryptfs/ecryptfs_kernel.h |  4 ++--
 fs/ecryptfs/file.c            | 34 ++++++++++++++++++++++++++++++----
 fs/ecryptfs/keystore.c        |  2 +-
 fs/ecryptfs/main.c            |  2 +-
 4 files changed, 34 insertions(+), 8 deletions(-)

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU94PJAAoJENaSAD2qAscKSbAQAKSCfk98UcfG9Rn/dGCFtSWt
Dbo68tuF8Rhw4ZaBiqeV1F4KmB01yhnpeHck1Hm3yhyx10td7iOA3MemNK/vhCkz
+6dRC55cWcp2sfkrQhVmZDUj5MMjIAdZWdB4z2NlB5JONCvi5XbQYqkA2g1Yv6TF
8bD3hUafwMlYtTMDhxH5fcFI0BOP/hrGxcX+vJGPjx2/hU5Eu7eCLWEMarxgumQq
Nx8McNPnPIOWjBDQPTQXZ6bbm0lhuO1hAOAwR7EqFn19b+TO1N3/IQKsJT+VgpP8
DZXp+K6ObJ1i3VAywzEZEreb1Xl/L7rO3XbKBWAPlTBaSsF6TNhU1G1bafw6drUV
4DBytppqlsvh1r90SHpoLHGwKyfPS0FlH+fsLONDVXMCn64bSk7jGXb3LFUy5fKb
fIt5j6OcowlDIwsHXvYfb+A01sZZWybEO1nFb54W6cfIIEC8cfv/HO5Tl5S/z0Go
am8H7+zfk8M3l8TfC5a7842yzDqD0aIBcryWHcZ4h0cTFGOSdWLYDgadiErzkuq6
5RkgUP0LhnxqtS09N4d+5mVWp5QL98PA0Gap70KgnS1hC776bO2ptK/Ml1NXXIVZ
T35OblP5pre3h1htVIPOFt03ET5Zn3CZHutfB8WreyPnj0MEtCHUZ/44V2wiZi3G
BbVPcRnmE8uKMzJ+Nguc
=2V/O
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
