From: Colin King <colin.king@canonical.com>
Subject: [PATCH 0/1] ecryptfs: Migrate to ablkcipher API
Date: Wed, 13 Jun 2012 13:14:29 +0100
Message-ID: <1339589670-12189-1-git-send-email-colin.king@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56335 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab2FMMOc (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 13 Jun 2012 08:14:32 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: ecryptfs@vger.kernel.org, Thieu Le <thieule@google.com>

From: Colin Ian King <colin.king@canonical.com>

This is a forward port of Thieu Le's patch from 2.6.39 to migrate
to using the ablkcipher API for eCryptfs.

Performance Improvements:

I've instrumented this patch to measure TSC ticks per 4K encrypt
and decrypt operations to see how this patch compares to the original
code using the default AES generic crypto engine as well as the
new Intel AES-NI instruction capable crypto engine on an Ivybridge
i7-3770.

Patched:                TSC ticks for 4K        TSC ticks per byte
  AES-Generic Read:     5843.5                  1.42
  AES-Generic Write:    19295.8                 4.71

  AES-NI Read:          5677.0                  1.39
  AES-NI Write:         19257.9                 4.70

Unpatched:
  AES-Generic Read:     92861.5                 22.67
  AES-Generic Write:    93642                   22.61

  AES-NI Read:          91610.2                 22.37
  AES-NI Write:         93659.2                 22.87

..so at the crypto engine stage we see some considerable speed improvement
with the patch.

I've also run some simple benchmarking tests comparing this patch with
the un-patched kernel on a variety of machines (Ivybridge, Sandybridge,
Atom) and drives (HDD, SSD) to see how well it performs.  A LibreOffice
speadsheet of the test result data and a write-up are available:

http://kernel.ubuntu.com/~cking/ecryptfs-async-testing/async-patch-results-1.ods
http://kernel.ubuntu.com/~cking/ecryptfs-async-testing/async-patch-summary.txt

Soak Testing:
 * many kernel builds using -j 64, on HDD and SSD
 * eCryptfs tests with lower filesystems: ext2, ext3, ext4, xfs, btrfs
 * exercised on a 4 CPU (+hyperthreaded) build machine
 * bonnie++ and tiobench tests 

Colin Ian King (1):
  ecryptfs: Migrate to ablkcipher API

 fs/ecryptfs/crypto.c          |  678 +++++++++++++++++++++++++++++++----------
 fs/ecryptfs/ecryptfs_kernel.h |   38 ++-
 fs/ecryptfs/main.c            |   10 +
 fs/ecryptfs/mmap.c            |   87 +++++-
 4 files changed, 636 insertions(+), 177 deletions(-)

-- 
1.7.9.5
