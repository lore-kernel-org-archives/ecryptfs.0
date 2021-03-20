From: Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH] ecryptfs: fix incorrect kernel-doc comment syntax in files
Date: Sat, 20 Mar 2021 13:45:51 +0530
Message-ID: <20210320081551.13954-1-yashsri421@gmail.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTLX3 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 20 Mar 2021 07:23:29 -0400
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: code@tyhicks.com
Cc: yashsri421@gmail.com, lukas.bulwahn@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org, christian.brauner@ubuntu.com

The opening comment mark '/**' is used for kernel-doc comments.
There are files in fs/encrypts which follows this syntax, but the content
inside does not comply with kernel-doc.
This causes unexpected warnings from kernel-doc.

E.g., header comment for fs/ecryptfs/dentry.c follows kernel-doc syntax
for comments(i.e., '/**'), but the content inside does not.

Running kernel-doc -none on fs/ecryptfs/dentry.c causes these
unexpected warnings:
"warning: Incorrect use of kernel-doc format:  * ecryptfs_d_revalidate - revalidate an ecryptfs dentry"
"warning: Function parameter or member 'dentry' not described in 'ecryptfs_d_revalidate'"
"warning: Function parameter or member 'flags' not described in 'ecryptfs_d_revalidate'"
"warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_d_revalidate() instead"

Similarly for other files too.

Provide a simple fix by replacing such occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210312

 fs/ecryptfs/crypto.c          |  2 +-
 fs/ecryptfs/debug.c           |  2 +-
 fs/ecryptfs/dentry.c          |  2 +-
 fs/ecryptfs/ecryptfs_kernel.h |  2 +-
 fs/ecryptfs/file.c            |  2 +-
 fs/ecryptfs/inode.c           |  2 +-
 fs/ecryptfs/keystore.c        |  6 +++---
 fs/ecryptfs/kthread.c         |  2 +-
 fs/ecryptfs/main.c            | 10 +++++-----
 fs/ecryptfs/messaging.c       |  2 +-
 fs/ecryptfs/miscdev.c         |  2 +-
 fs/ecryptfs/mmap.c            |  6 +++---
 fs/ecryptfs/read_write.c      |  2 +-
 fs/ecryptfs/super.c           |  2 +-
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7671412b8f0b..48184ff65f90 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 1f65e99f9a41..65702d7fc4b9 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * Functions only useful for debugging.
  *
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 44606f079efb..acaa0825e9bb 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4a62a7dcc4f5..f8aa99e41c48 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * Kernel declarations.
  *
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 5fb45d865ce5..2d8344774885 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..541b46d76f89 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 2abd219cfeec..475d939ff695 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * In-kernel key management code.  Includes functions to parse and
  * write authentication token-related packets with the underlying
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * request_key returned an error instead of a valid key address;
  * determine the type of error, make appropriate log entries, and
  * return an error code.
@@ -576,7 +576,7 @@ ecryptfs_find_auth_tok_for_sig(
 	return rc;
 }
 
-/**
+/*
  * write_tag_70_packet can gobble a lot of stack space. We stuff most
  * of the function's parameters in a kmalloc'd struct to help reduce
  * eCryptfs' overall stack usage.
diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index a7c903cb01a0..d1b1c3546972 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2008 International Business Machines Corp.
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index cdf40a54a35d..9bc19a092917 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
@@ -24,7 +24,7 @@
 #include <linux/magic.h>
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * Module parameter that defines the ecryptfs_verbosity level.
  */
 int ecryptfs_verbosity = 0;
@@ -34,7 +34,7 @@ MODULE_PARM_DESC(ecryptfs_verbosity,
 		 "Initial verbosity level (0 or 1; defaults to "
 		 "0, which is Quiet)");
 
-/**
+/*
  * Module parameter that defines the number of message buffer elements
  */
 unsigned int ecryptfs_message_buf_len = ECRYPTFS_DEFAULT_MSG_CTX_ELEMS;
@@ -43,7 +43,7 @@ module_param(ecryptfs_message_buf_len, uint, 0);
 MODULE_PARM_DESC(ecryptfs_message_buf_len,
 		 "Number of message buffer elements");
 
-/**
+/*
  * Module parameter that defines the maximum guaranteed amount of time to wait
  * for a response from ecryptfsd.  The actual sleep time will be, more than
  * likely, a small amount greater than this specified value, but only less if
@@ -57,7 +57,7 @@ MODULE_PARM_DESC(ecryptfs_message_wait_timeout,
 		 "sleep while waiting for a message response from "
 		 "userspace");
 
-/**
+/*
  * Module parameter that is an estimate of the maximum number of users
  * that will be concurrently using eCryptfs. Set this to the right
  * value to balance performance and memory use.
diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index c0dfd9647627..9f42fca7fc36 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2004-2008 International Business Machines Corp.
diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 742ece22c1d4..7e741e36dfe7 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2008 International Business Machines Corp.
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 2f333a40ff4d..485f6c1e19b5 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  * This is where eCryptfs coordinates the symmetric encryption and
  * decryption of the file data as it passes between the lower
@@ -78,7 +78,7 @@ static void strip_xattr_flag(char *page_virt,
 	}
 }
 
-/**
+/*
  *   Header Extent:
  *     Octets 0-7:        Unencrypted file size (big-endian)
  *     Octets 8-15:       eCryptfs special marker
@@ -229,7 +229,7 @@ static int ecryptfs_readpage(struct file *file, struct page *page)
 	return rc;
 }
 
-/**
+/*
  * Called with lower inode mutex held.
  */
 static int fill_zeros_to_end_of_page(struct page *page, unsigned int to)
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 0438997ac9d8..384b383b4a48 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2007 International Business Machines Corp.
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 6b1853f1c06a..cc16d044165d 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
-- 
2.17.1

