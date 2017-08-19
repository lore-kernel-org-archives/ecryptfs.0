From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] eCryptfs: Adjustments for several function
 implementations
Date: Sat, 19 Aug 2017 18:54:14 +0200
Message-ID: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:64320 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdHSQyR (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Sat, 19 Aug 2017 12:54:17 -0400
Content-Language: en-GB
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 19 Aug 2017 18:15:14 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete 21 error messages for a failed memory allocation
  Return an error code only as a constant in ecryptfs_add_global_auth_tok()
  Adjust four checks for null pointers

 fs/ecryptfs/crypto.c    | 22 +++-------------------
 fs/ecryptfs/inode.c     |  3 ---
 fs/ecryptfs/keystore.c  | 46 +++++++++++-----------------------------------
 fs/ecryptfs/messaging.c |  6 ------
 fs/ecryptfs/miscdev.c   |  6 +-----
 fs/ecryptfs/mmap.c      |  2 --
 6 files changed, 15 insertions(+), 70 deletions(-)

-- 
2.14.0
