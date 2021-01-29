From: Tyler Hicks <code@tyhicks.com>
Subject: [GIT PULL] eCryptfs fix for 5.11-rc6
Date: Thu, 28 Jan 2021 19:24:31 -0600
Message-ID: <20210129012431.GA633037@sequoia>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhA2BZ3 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 28 Jan 2021 20:25:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCC2C061573
        for <ecryptfs@vger.kernel.org>; Thu, 28 Jan 2021 17:24:49 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w8so8245188oie.2
        for <ecryptfs@vger.kernel.org>; Thu, 28 Jan 2021 17:24:49 -0800 (PST)
Content-Disposition: inline
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>

Hi Linus,

The following changes since commit 83d09ad4b950651a95d37697f1493c00d888d0db:

  Merge tag 'for-linus' of git://github.com/openrisc/linux (2021-01-21 18:35:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-5.11-rc6-setxattr-fix

for you to fetch changes up to 0b964446c63f9d7d7cd1809ee39277b4f73916b5:

  ecryptfs: fix uid translation for setxattr on security.capability (2021-01-26 01:47:14 +0000)

----------------------------------------------------------------
Fix a regression, introduced in v5.11-rc1, that resulted in two rounds
of UID translations to occur, in some configurations, when setting v3
namespaced file capabilities.

----------------------------------------------------------------
Miklos Szeredi (1):
      ecryptfs: fix uid translation for setxattr on security.capability

 fs/ecryptfs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
