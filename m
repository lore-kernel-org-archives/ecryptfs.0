From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 22/31] fs: ecryptfs: kthread: Demote file header and provide description for 'cred'
Date: Tue, 30 Mar 2021 17:44:49 +0100
Message-ID: <20210330164458.1625478-23-lee.jones@linaro.org>
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

 fs/ecryptfs/kthread.c:16: warning: cannot understand function prototype: 'struct ecryptfs_open_req '
 fs/ecryptfs/kthread.c:120: warning: Function parameter or member 'cred' not described in 'ecryptfs_privileged_open'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index a7c903cb01a05..ae4cb4e2e1348 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2008 International Business Machines Corp.
@@ -108,6 +108,7 @@ void ecryptfs_destroy_kthread(void)
  * @lower_file: Result of dentry_open by root on lower dentry
  * @lower_dentry: Lower dentry for file to open
  * @lower_mnt: Lower vfsmount for file to open
+ * @cred: credential to use for this call
  *
  * This function gets a r/w file opened against the lower dentry.
  *
-- 
2.27.0

