From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] ecryptfs: fixes and port to private mounts
Date: Fri,  9 Apr 2021 18:24:19 +0200
Message-ID: <20210409162422.1326565-1-brauner@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIQ0F (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:05 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

Similar to what we do in overlayfs and now in cachefiles too ecryptfs
should rely on a private mount that can't change mount properties
underneath it and puts ecryptfs in full control (apart from changes that
affect the superblock of the underlying fs of course) over the mount it
is using to store its encrypted files in.

Thanks!
Christian

Christian Brauner (3):
  ecryptfs: remove unused helpers
  ecryptfs: use private mount in path
  ecryptfs: extend ro check to private mount

 fs/ecryptfs/ecryptfs_kernel.h | 12 ------------
 fs/ecryptfs/main.c            | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 13 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.27.0

