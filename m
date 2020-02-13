From: Tyler Hicks <code@tyhicks.com>
Subject: [PATCH] eCryptfs: Replace deactivated email address
Date: Thu, 13 Feb 2020 21:26:48 +0000
Message-ID: <20200213212648.20244-1-code@tyhicks.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41541 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgBMV1A (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 13 Feb 2020 16:27:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so7060028otc.8
        for <ecryptfs@vger.kernel.org>; Thu, 13 Feb 2020 13:26:58 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Replace a recently deactived email address with one that I'll be able to
personally control and keep alive.

Signed-off-by: Tyler Hicks <code@tyhicks.com>
---
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/main.c            | 2 +-
 fs/ecryptfs/messaging.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 1c1a56be7ea2..e6ac78c62ca4 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -8,7 +8,7 @@
  * Copyright (C) 2004-2008 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *              Trevor S. Highland <trevor.highland@gmail.com>
- *              Tyler Hicks <tyhicks@ou.edu>
+ *              Tyler Hicks <code@tyhicks.com>
  */
 
 #ifndef ECRYPTFS_KERNEL_H
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index b8a7ce379ffe..e63259fdef28 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *              Michael C. Thompson <mcthomps@us.ibm.com>
- *              Tyler Hicks <tyhicks@ou.edu>
+ *              Tyler Hicks <code@tyhicks.com>
  */
 
 #include <linux/dcache.h>
diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index d668e60b85b5..be3c318ba5f0 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2004-2008 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mhalcrow@us.ibm.com>
- *		Tyler Hicks <tyhicks@ou.edu>
+ *		Tyler Hicks <code@tyhicks.com>
  */
 #include <linux/sched.h>
 #include <linux/slab.h>
-- 
2.17.1

