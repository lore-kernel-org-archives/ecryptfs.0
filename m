From: Tyler Hicks <code@tyhicks.com>
Subject: [GIT PULL] eCryptfs updates for 5.13-rc1
Date: Wed, 5 May 2021 21:28:51 -0500
Message-ID: <20210506022851.GA622556@elm>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhEFCaF (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 5 May 2021 22:30:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B9C06174A
        for <ecryptfs@vger.kernel.org>; Wed,  5 May 2021 19:29:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so3708613qkb.0
        for <ecryptfs@vger.kernel.org>; Wed, 05 May 2021 19:29:07 -0700 (PDT)
Content-Disposition: inline
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

Hi Linus,

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-5.13-rc1-updates

for you to fetch changes up to 9046625511ad8dfbc8c6c2de16b3532c43d68d48:

  ecryptfs: fix kernel panic with null dev_name (2021-04-19 05:50:32 +0000)

Note that there's a "back merge" in here because I forgot to send out a
5.12 PR for two small cleanups that were queued up so my branch was
still on a 5.11-rc release. I did the back merge because the W=1 fixes
needed the idmapped mounts changes that landed in 5.12 and I had hoped
to merge (but didn't) some additional changes to switch over to using a
private clone of the lower mount, which also relied on the idmapped
mounts changes. I won't make a habit out of back merging but wanted to
mention the reasoning since this is the first time I've felt I needed to
do it. Please let me know if it is a problem.

----------------------------------------------------------------
Code cleanups and a bug fix
- W=1 compiler warning cleanups
- Mutex initialization simplification
- Protect against NULL pointer exception during mount

----------------------------------------------------------------
Christian Brauner (1):
      ecryptfs: remove unused helpers

Jeffrey Mitchell (1):
      ecryptfs: fix kernel panic with null dev_name

Lee Jones (13):
      ecryptfs: read_write: File headers do not make good candidates for kernel-doc
      ecryptfs: debug: Demote a couple of kernel-doc abuses
      ecryptfs: dentry: File headers are not good candidates for kernel-doc
      ecryptfs: kthread: Demote file header and provide description for 'cred'
      ecryptfs: file: Demote kernel-doc abuses
      ecryptfs: super: Fix formatting, naming and kernel-doc abuses
      ecryptfs: messaging: Add missing param descriptions and demote abuses
      ecryptfs: main: Demote a bunch of non-conformant kernel-doc headers
      ecryptfs: miscdev: File headers are not good kernel-doc candidates
      ecryptfs: crypto: Supply some missing param descriptions and demote abuses
      ecryptfs: mmap: Help out one function header and demote other abuses
      ecryptfs: inode: Help out nearly-there header and demote non-conformant ones
      ecryptfs: keystore: Fix some kernel-doc issues and demote non-conformant headers

Sascha Hauer (1):
      ecryptfs: Fix typo in message

Tom Rix (1):
      eCryptfs: add a semicolon

Tyler Hicks (1):
      Merge tag 'v5.12-rc7' into ecryptfs/next

Ye Bin (1):
      eCryptfs: Use DEFINE_MUTEX() for mutex lock

Zheng Yongjun (1):
      ecryptfs: use DEFINE_MUTEX() for mutex lock

 fs/ecryptfs/crypto.c          | 25 ++++++++++++-------------
 fs/ecryptfs/debug.c           |  4 ++--
 fs/ecryptfs/dentry.c          |  2 +-
 fs/ecryptfs/ecryptfs_kernel.h | 14 +-------------
 fs/ecryptfs/file.c            |  4 ++--
 fs/ecryptfs/inode.c           | 11 +++++------
 fs/ecryptfs/keystore.c        | 15 ++++++++-------
 fs/ecryptfs/kthread.c         |  3 ++-
 fs/ecryptfs/main.c            | 30 ++++++++++++++++++------------
 fs/ecryptfs/messaging.c       | 14 +++++++-------
 fs/ecryptfs/miscdev.c         |  3 ++-
 fs/ecryptfs/mmap.c            | 11 ++++++-----
 fs/ecryptfs/read_write.c      |  4 +++-
 fs/ecryptfs/super.c           |  8 ++++----
 14 files changed, 73 insertions(+), 75 deletions(-)
