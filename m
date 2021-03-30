From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 23/31] fs: ecryptfs: file: Demote kernel-doc abuses
Date: Tue, 30 Mar 2021 17:44:50 +0100
Message-ID: <20210330164458.1625478-24-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhC3QpZ (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58385C061574
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g25so8781394wmh.0
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:25 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mhalcrow@us.ibm.com>, "Michael C. Thompson" <mcthomps@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/file.c:23: warning: Incorrect use of kernel-doc format:  * ecryptfs_read_update_atime
 fs/ecryptfs/file.c:34: warning: Function parameter or member 'iocb' not described in 'ecryptfs_read_update_atime'
 fs/ecryptfs/file.c:34: warning: Function parameter or member 'to' not described in 'ecryptfs_read_update_atime'
 fs/ecryptfs/file.c:34: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_read_update_atime() instead

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mhalcrow@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 5fb45d865ce51..18d5b91cb573e 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
@@ -19,7 +19,7 @@
 #include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * ecryptfs_read_update_atime
  *
  * generic_file_read updates the atime of upper layer inode.  But, it
-- 
2.27.0

