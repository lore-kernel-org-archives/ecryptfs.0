From: Tyler Hicks <tyhicks@canonical.com>
Subject: [GIT PULL] eCryptfs fixes for 5.3-rc1
Date: Mon, 15 Jul 2019 01:08:43 +0000
Message-ID: <20190715010612.GA13363@sec>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

Hi Linus,

The following changes since commit 5ded5871030eb75017639148da0a58931dfbfc25:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2019-02-15 13:36:43 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-5.3-rc1-fixes

for you to fetch changes up to 7451c54abc9139585492605d9e91dec2d26c6457:

  ecryptfs: Change return type of ecryptfs_process_flags (2019-07-02 19:28:02 +0000)

----------------------------------------------------------------
- Fix error handling when ecryptfs_read_lower() encounters an error
- Fix read-only file creation when the eCryptfs mount is configured to
  store metadata in xattrs
- Minor code cleanups

----------------------------------------------------------------
Dan Carpenter (2):
      eCryptfs: fix a couple type promotion bugs
      ecryptfs: re-order a condition for static checkers

Hariprasad Kelam (1):
      ecryptfs: Change return type of ecryptfs_process_flags

Robbie Ko (1):
      eCryptfs: fix permission denied with ecryptfs_xattr mount option when create readonly file

Sascha Hauer (1):
      ecryptfs: use print_hex_dump_bytes for hexdump

YueHaibing (2):
      ecryptfs: remove unnessesary null check in ecryptfs_keyring_auth_tok_for_sig
      ecryptfs: Make ecryptfs_xattr_handler static

 fs/ecryptfs/crypto.c   | 42 +++++++++++++++++++++++++-----------------
 fs/ecryptfs/debug.c    | 22 +++-------------------
 fs/ecryptfs/inode.c    |  2 +-
 fs/ecryptfs/keystore.c |  9 +++++----
 4 files changed, 34 insertions(+), 41 deletions(-)
