From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 21/31] fs: ecryptfs: dentry: File headers are not good candidates for kernel-doc
Date: Tue, 30 Mar 2021 17:44:48 +0100
Message-ID: <20210330164458.1625478-22-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/dentry.c:19: warning: Incorrect use of kernel-doc format:  * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
 fs/ecryptfs/dentry.c:32: warning: Function parameter or member 'dentry' not described in 'ecryptfs_d_revalidate'
 fs/ecryptfs/dentry.c:32: warning: Function parameter or member 'flags' not described in 'ecryptfs_d_revalidate'
 fs/ecryptfs/dentry.c:32: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_d_revalidate() instead

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/dentry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 44606f079efb0..acaa0825e9bbe 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
-- 
2.27.0

