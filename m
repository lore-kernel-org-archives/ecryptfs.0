From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 19/31] fs: ecryptfs: read_write: File headers do not make good candidates for kernel-doc
Date: Tue, 30 Mar 2021 17:44:46 +0100
Message-ID: <20210330164458.1625478-20-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, ecryptfs@vger.kernel.org

Provide missing param description for 'page_index' too.

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/read_write.c:16: warning: Incorrect use of kernel-doc format:  * ecryptfs_write_lower
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'ecryptfs_inode' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'data' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'offset' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: Function parameter or member 'size' not described in 'ecryptfs_write_lower'
 fs/ecryptfs/read_write.c:29: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_write_lower() instead
 fs/ecryptfs/read_write.c:248: warning: Function parameter or member 'page_index' not described in 'ecryptfs_read_lower_page_segment'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/read_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 0438997ac9d87..60bdcaddcbe57 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2007 International Business Machines Corp.
@@ -230,6 +230,8 @@ int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
  * ecryptfs_read_lower_page_segment
  * @page_for_ecryptfs: The page into which data for eCryptfs will be
  *                     written
+ * @page_index: Page index in @page_for_ecryptfs from which to start
+ *		writing
  * @offset_in_page: Offset in @page_for_ecryptfs from which to start
  *                  writing
  * @size: The number of bytes to write into @page_for_ecryptfs
-- 
2.27.0

