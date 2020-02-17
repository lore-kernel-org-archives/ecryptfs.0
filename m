From: Tyler Hicks <code@tyhicks.com>
Subject: [GIT PULL] eCryptfs fixes for 5.6-rc3
Date: Mon, 17 Feb 2020 14:53:43 -0600
Message-ID: <20200217205343.GA280196@elm>
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

The following changes since commit 5f97cbe22b7616ead7ae267c29cad73bc1444811:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2019-08-19 16:28:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-5.6-rc3-fixes

for you to fetch changes up to 2c2a7552dd6465e8fde6bc9cccf8d66ed1c1eb72:

  ecryptfs: replace BUG_ON with error handling code (2020-02-14 20:07:46 +0000)

----------------------------------------------------------------
eCryptfs fixes for 5.6-rc3
- Downgrade the eCryptfs maintenance status to "Odd Fixes"
- Change my email address
- Fix a couple memory leaks in error paths
- Stability improvement to avoid a needless BUG_ON()

----------------------------------------------------------------
Aditya Pakki (1):
      ecryptfs: replace BUG_ON with error handling code

Tyler Hicks (2):
      MAINTAINERS: eCryptfs: Update maintainer address and downgrade status
      eCryptfs: Replace deactivated email address

Wenwen Wang (2):
      ecryptfs: fix a memory leak bug in parse_tag_1_packet()
      ecryptfs: fix a memory leak bug in ecryptfs_init_messaging()

 MAINTAINERS                   | 4 ++--
 fs/ecryptfs/crypto.c          | 6 ++++--
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/keystore.c        | 2 +-
 fs/ecryptfs/main.c            | 2 +-
 fs/ecryptfs/messaging.c       | 3 ++-
 6 files changed, 11 insertions(+), 8 deletions(-)
