From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 27/31] fs: ecryptfs: miscdev: File headers are not good kernel-doc candidates
Date: Tue, 30 Mar 2021 17:44:54 +0100
Message-ID: <20210330164458.1625478-28-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhC3Qp3 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84288C061762
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so16947119wrn.0
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:29 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mhalcrow@us.ibm.com>, ecryptfs@vger.kernel.org

Supply description for the 'daemon' param too.

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/miscdev.c:19: warning: cannot understand function prototype: 'atomic_t ecryptfs_num_miscdev_opens; '
 fs/ecryptfs/miscdev.c:323: warning: Function parameter or member 'daemon' not described in 'ecryptfs_miscdev_response'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mhalcrow@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/miscdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 742ece22c1d43..4e62c3cef70fb 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2008 International Business Machines Corp.
@@ -312,6 +312,7 @@ ecryptfs_miscdev_read(struct file *file, char __user *buf, size_t count,
 
 /**
  * ecryptfs_miscdev_response - miscdevess response to message previously sent to daemon
+ * @daemon: eCryptfs daemon object
  * @data: Bytes comprising struct ecryptfs_message
  * @data_size: sizeof(struct ecryptfs_message) + data len
  * @seq: Sequence number for miscdev response packet
-- 
2.27.0

