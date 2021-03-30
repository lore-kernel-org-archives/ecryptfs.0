From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 30/31] fs: ecryptfs: inode: Help out nearly-there header and demote non-conformant ones
Date: Tue, 30 Mar 2021 17:44:57 +0100
Message-ID: <20210330164458.1625478-31-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhC3Qpc (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE5C061765
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v11so16859568wro.7
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:32 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, "Michael C. Thompsion" <mcthomps@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/inode.c:27: warning: Function parameter or member 'dentry' not described in 'lock_parent'
 fs/ecryptfs/inode.c:27: warning: Function parameter or member 'lower_dentry' not described in 'lock_parent'
 fs/ecryptfs/inode.c:27: warning: Function parameter or member 'lower_dir' not described in 'lock_parent'
 fs/ecryptfs/inode.c:27: warning: expecting prototype for eCryptfs(). Prototype was for lock_parent() instead
 fs/ecryptfs/inode.c:211: warning: Function parameter or member 'ecryptfs_dentry' not described in 'ecryptfs_initialize_file'
 fs/ecryptfs/inode.c:211: warning: Function parameter or member 'ecryptfs_inode' not described in 'ecryptfs_initialize_file'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'mnt_userns' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'directory_inode' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'ecryptfs_dentry' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'excl' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Excess function parameter 'dir' description in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Excess function parameter 'dentry' description in 'ecryptfs_create'
 fs/ecryptfs/inode.c:320: warning: Function parameter or member 'dentry' not described in 'ecryptfs_lookup_interpose'
 fs/ecryptfs/inode.c:320: warning: Function parameter or member 'lower_dentry' not described in 'ecryptfs_lookup_interpose'
 fs/ecryptfs/inode.c:887: warning: Function parameter or member 'mnt_userns' not described in 'ecryptfs_setattr'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompsion" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 861a01713f3f4..9ac527e498e16 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
@@ -198,7 +198,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	return inode;
 }
 
-/**
+/*
  * ecryptfs_initialize_file
  *
  * Cause the file to be changed from a basic empty file to an ecryptfs
@@ -241,10 +241,8 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_create
- * @dir: The inode of the directory in which to create the file.
- * @dentry: The eCryptfs dentry
  * @mode: The mode of the new file.
  *
  * Creates a new file.
@@ -312,7 +310,7 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 	return 0;
 }
 
-/**
+/*
  * ecryptfs_lookup_interpose - Dentry interposition for a lookup
  */
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
@@ -872,6 +870,7 @@ ecryptfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 
 /**
  * ecryptfs_setattr
+ * @mnt_userns: user namespace of the target mount
  * @dentry: dentry handle to the inode to modify
  * @ia: Structure with flags of what to change and values
  *
-- 
2.27.0

