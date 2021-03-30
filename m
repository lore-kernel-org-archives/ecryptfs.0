From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 24/31] fs: ecryptfs: super: Fix formatting, naming and kernel-doc abuses
Date: Tue, 30 Mar 2021 17:44:51 +0100
Message-ID: <20210330164458.1625478-25-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhC3Qp0 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC78C061762
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j9so15172733wrx.12
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:26 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, "Michael C. Thompson" <mcthomps@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/super.c:22: warning: cannot understand function prototype: 'struct kmem_cache *ecryptfs_inode_info_cache; '
 fs/ecryptfs/super.c:91: warning: Function parameter or member 'dentry' not described in 'ecryptfs_statfs'
 fs/ecryptfs/super.c:91: warning: Excess function parameter 'sb' description in 'ecryptfs_statfs'
 fs/ecryptfs/super.c:120: warning: Function parameter or member 'inode' not described in 'ecryptfs_evict_inode'
 fs/ecryptfs/super.c:133: warning: Function parameter or member 'm' not described in 'ecryptfs_show_options'
 fs/ecryptfs/super.c:133: warning: Function parameter or member 'root' not described in 'ecryptfs_show_options'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 6b1853f1c06a9..39116af0390f7 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
@@ -81,7 +81,7 @@ static void ecryptfs_destroy_inode(struct inode *inode)
 
 /**
  * ecryptfs_statfs
- * @sb: The ecryptfs super block
+ * @dentry: The ecryptfs dentry
  * @buf: The struct kstatfs to fill in with stats
  *
  * Get the filesystem statistics. Currently, we let this pass right through
@@ -108,7 +108,7 @@ static int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 /**
  * ecryptfs_evict_inode
- * @inode - The ecryptfs inode
+ * @inode: The ecryptfs inode
  *
  * Called by iput() when the inode reference count reached zero
  * and the inode is not hashed anywhere.  Used to clear anything
@@ -123,7 +123,7 @@ static void ecryptfs_evict_inode(struct inode *inode)
 	iput(ecryptfs_inode_to_lower(inode));
 }
 
-/**
+/*
  * ecryptfs_show_options
  *
  * Prints the mount options for a given superblock.
-- 
2.27.0

