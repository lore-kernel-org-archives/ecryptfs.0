From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 20/31] fs: ecryptfs: debug: Demote a couple of kernel-doc abuses
Date: Tue, 30 Mar 2021 17:44:47 +0100
Message-ID: <20210330164458.1625478-21-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhC3QpW (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865CC061762
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 12so8739297wmf.5
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:22 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/debug.c:13: warning: Incorrect use of kernel-doc format:  * ecryptfs_dump_auth_tok - debug function to print auth toks
 fs/ecryptfs/debug.c:19: warning: Function parameter or member 'auth_tok' not described in 'ecryptfs_dump_auth_tok'
 fs/ecryptfs/debug.c:19: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_dump_auth_tok() instead

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 1f65e99f9a414..cf6d0e8e25a16 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * Functions only useful for debugging.
  *
@@ -9,7 +9,7 @@
 
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * ecryptfs_dump_auth_tok - debug function to print auth toks
  *
  * This function will print the contents of an ecryptfs authentication
-- 
2.27.0

