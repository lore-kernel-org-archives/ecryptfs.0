From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 29/31] fs: ecryptfs: mmap: Help out one function header and demote other abuses
Date: Tue, 30 Mar 2021 17:44:56 +0100
Message-ID: <20210330164458.1625478-30-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhC3Qpc (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C353CC061762
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j9so15173037wrx.12
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:31 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, James Morris <jamorris@linux.microsoft.com>, Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <christian.brauner@ubuntu.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/mmap.c:26: warning: Incorrect use of kernel-doc format:  * ecryptfs_get_locked_page
 fs/ecryptfs/mmap.c:34: warning: Function parameter or member 'inode' not described in 'ecryptfs_get_locked_page'
 fs/ecryptfs/mmap.c:34: warning: Function parameter or member 'index' not described in 'ecryptfs_get_locked_page'
 fs/ecryptfs/mmap.c:34: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_get_locked_page() instead
 fs/ecryptfs/mmap.c:52: warning: Function parameter or member 'wbc' not described in 'ecryptfs_writepage'
 fs/ecryptfs/mmap.c:98: warning: Incorrect use of kernel-doc format:  * ecryptfs_copy_up_encrypted_with_header
 fs/ecryptfs/mmap.c:110: warning: Function parameter or member 'page' not described in 'ecryptfs_copy_up_encrypted_with_header'
 fs/ecryptfs/mmap.c:110: warning: Function parameter or member 'crypt_stat' not described in 'ecryptfs_copy_up_encrypted_with_header'
 fs/ecryptfs/mmap.c:110: warning: expecting prototype for Header Extent(). Prototype was for ecryptfs_copy_up_encrypted_with_header() instead
 fs/ecryptfs/mmap.c:233: warning: wrong kernel-doc identifier on line:
 fs/ecryptfs/mmap.c:379: warning: Function parameter or member 'ecryptfs_inode' not described in 'ecryptfs_write_inode_size_to_header'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: James Morris <jamorris@linux.microsoft.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/mmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 2f333a40ff4d9..392e721b50a3d 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * This is where eCryptfs coordinates the symmetric encryption and
  * decryption of the file data as it passes between the lower
@@ -22,7 +22,7 @@
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * ecryptfs_get_locked_page
  *
  * Get one page from cache or lower f/s, return error otherwise.
@@ -41,6 +41,7 @@ struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
 /**
  * ecryptfs_writepage
  * @page: Page that is locked before this call is made
+ * @wbc: Write-back control structure
  *
  * Returns zero on success; non-zero otherwise
  *
@@ -78,7 +79,7 @@ static void strip_xattr_flag(char *page_virt,
 	}
 }
 
-/**
+/*
  *   Header Extent:
  *     Octets 0-7:        Unencrypted file size (big-endian)
  *     Octets 8-15:       eCryptfs special marker
@@ -229,7 +230,7 @@ static int ecryptfs_readpage(struct file *file, struct page *page)
 	return rc;
 }
 
-/**
+/*
  * Called with lower inode mutex held.
  */
 static int fill_zeros_to_end_of_page(struct page *page, unsigned int to)
@@ -368,7 +369,7 @@ static int ecryptfs_write_begin(struct file *file,
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_write_inode_size_to_header
  *
  * Writes the lower file size to the first 8 bytes of the header.
-- 
2.27.0

