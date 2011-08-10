From: Tyler Hicks <tyhicks@linux.vnet.ibm.com>
Subject: [GIT PULL] eCryptfs fixes for 3.1-rc2
Date: Wed, 10 Aug 2011 00:21:35 -0500
Message-ID: <20110810052134.GA26944@boyd.l.tihix.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:44594 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1HJFVn (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 10 Aug 2011 01:21:43 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

Hi Linus,

John has added an eCryptfs mount option to do a mount time check
ensuring that the source mount point is owned by the real uid of the
process performing the mount. Roberto's Kconfig patch fixes a
dependency-based compile error when encrypted keys are built as a module
but eCryptfs is a built-in. My first patch removes a call to BUG() when
we should be returning an error and my second patch simply fixes a
compiler warning.

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ecryptfs/ecryptfs-2.6.git for-linus

John Johansen (1):
      Ecryptfs: Add mount option to check uid of device being mounted = expect uid

Roberto Sassu (1):
      eCryptfs: fix compile error

Tyler Hicks (2):
      eCryptfs: Return error when lower file pointer is NULL
      eCryptfs: Fix payload_len unitialized variable warning

 fs/ecryptfs/Kconfig      |    2 +-
 fs/ecryptfs/keystore.c   |    2 +-
 fs/ecryptfs/main.c       |   23 +++++++++++++++++++++--
 fs/ecryptfs/read_write.c |   18 ++++++++++--------
 4 files changed, 33 insertions(+), 12 deletions(-)
