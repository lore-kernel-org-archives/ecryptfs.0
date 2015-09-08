From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] eCryptfs fixes for 4.3-rc1
Date: Tue, 8 Sep 2015 11:12:49 -0500
Message-ID: <20150908161248.GB2682@boyd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47959 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbbIHQMx (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 8 Sep 2015 12:12:53 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 4469942bbbe5ebf845e04971d8c74e9b6178f9fa:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2015-08-05 18:50:38 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-4.3-rc1-stale-dcache

for you to fetch changes up to 0dad87fcb732691bfd3183acccda6709e1e759ca:

  eCryptfs: Delete a check before the function call "key_put" (2015-08-18 17:29:49 -0500)

----------------------------------------------------------------
Invalidate stale eCryptfs dcache entries caused by unlinked lower inodes

----------------------------------------------------------------
Markus Elfring (1):
      eCryptfs: Delete a check before the function call "key_put"

Tyler Hicks (1):
      eCryptfs: Invalidate dcache entries when lower i_nlink is zero

 fs/ecryptfs/crypto.c |  3 +--
 fs/ecryptfs/dentry.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV7wkAAAoJENaSAD2qAscK3j4QAK5uKLChUJGwYH0+TowpOX94
sSf0BXDVASS+M9owIqhfew7C+UrB+DPEhwUrmwpi92qL4l3oCXb2/X0F6Wegt9y9
fxkgfY8xeqkOTUliG5qYKHVV4urmAATlycIarqF6y9yzZ3Bu4AKftufVhm4tMyJV
Y5SNHCBeBl2/brCQqZ7yQKodEFYG9afubSyJR2s4jYQkSoW/EJ9pQyTLLCAHnlTa
Ow89DT7Wr4KiMrnUAFf+KXzQQAnMX3YHnDWgw6xQE25M/nD9Ti3iFimx4OXtjlav
dKtsub4GiwCjbQSuy6FCTq8Xc6W0MD3NX8pNERyfFDDazhdBTFoT95hx0y031oYX
+Bi0q6eUeTvP+aaEiY91wLnbhJJS17rrctDhfNqwsxZDNWN3nbXEM+LDWsL/Ly/R
N7Y7CLDlsXIzjITegvDHpqljHzRrYnGpCuvCfVLdYe4WPCfCkgcwqfvvHxRFvbP5
52xvpRhYXjHmpapdn0S5xQem3RYSDsBIAsxFbvUTLvAUrb5eb6GBvLRYkqr9Dkfb
hg2CgQ50JgT9uGu9qWJufP+4sIsMcXsZQzY0mk3lQIpyCJ/7v0HbOqUBej+bQpNA
F/rAB93E2YcUJGzf2qUcyZWAoVivoy464FuED4xe7tN7ukvEP0PB8vz/RJvDqxvt
CS/pGPD5foRSrLUPb32R
=6TeG
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
