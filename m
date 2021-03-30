From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 26/31] fs: ecryptfs: main: Demote a bunch of non-conformant kernel-doc headers
Date: Tue, 30 Mar 2021 17:44:53 +0100
Message-ID: <20210330164458.1625478-27-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, Christian Brauner <christian.brauner@ubuntu.com>, James Morris <jamorris@linux.microsoft.com>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, "Michael C. Thompson" <mcthomps@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/main.c:28: warning: Incorrect use of kernel-doc format:  * Module parameter that defines the ecryptfs_verbosity level.
 fs/ecryptfs/main.c:30: warning: cannot understand function prototype: 'int ecryptfs_verbosity = 0; '
 fs/ecryptfs/main.c:40: warning: cannot understand function prototype: 'unsigned int ecryptfs_message_buf_len = ECRYPTFS_DEFAULT_MSG_CTX_ELEMS; '
 fs/ecryptfs/main.c:52: warning: cannot understand function prototype: 'signed long ecryptfs_message_wait_timeout = ECRYPTFS_MAX_MSG_CTX_TTL / HZ; '
 fs/ecryptfs/main.c:65: warning: cannot understand function prototype: 'unsigned int ecryptfs_number_of_users = ECRYPTFS_DEFAULT_NUM_USERS; '
 fs/ecryptfs/main.c:106: warning: Function parameter or member 'dentry' not described in 'ecryptfs_init_lower_file'
 fs/ecryptfs/main.c:106: warning: Function parameter or member 'lower_file' not described in 'ecryptfs_init_lower_file'
 fs/ecryptfs/main.c:106: warning: Excess function parameter 'ecryptfs_dentry' description in 'ecryptfs_init_lower_file'
 fs/ecryptfs/main.c:244: warning: Function parameter or member 'sbi' not described in 'ecryptfs_parse_options'
 fs/ecryptfs/main.c:244: warning: Excess function parameter 'sb' description in 'ecryptfs_parse_options'
 fs/ecryptfs/main.c:478: warning: Function parameter or member 'fs_type' not described in 'ecryptfs_mount'
 fs/ecryptfs/main.c:478: warning: Function parameter or member 'flags' not described in 'ecryptfs_mount'
 fs/ecryptfs/main.c:478: warning: expecting prototype for ecryptfs_get_sb(). Prototype was for ecryptfs_mount() instead
 fs/ecryptfs/main.c:645: warning: Function parameter or member 'vptr' not described in 'inode_info_init_once'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: James Morris <jamorris@linux.microsoft.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index cdf40a54a35d8..0a6ef2472f205 100644
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
@@ -80,7 +80,7 @@ void __ecryptfs_printk(const char *fmt, ...)
 	va_end(args);
 }
 
-/**
+/*
  * ecryptfs_init_lower_file
  * @ecryptfs_dentry: Fully initialized eCryptfs dentry object, with
  *                   the lower dentry and the lower mount set
@@ -221,7 +221,7 @@ static void ecryptfs_init_mount_crypt_stat(
 
 /**
  * ecryptfs_parse_options
- * @sb: The ecryptfs super block
+ * @sbi: The ecryptfs super block
  * @options: The options passed to the kernel
  * @check_ruid: set to 1 if device uid should be checked against the ruid
  *
@@ -466,10 +466,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 struct kmem_cache *ecryptfs_sb_info_cache;
 static struct file_system_type ecryptfs_fs_type;
 
-/**
+/*
  * ecryptfs_get_sb
- * @fs_type
- * @flags
  * @dev_name: The path to mount over
  * @raw_data: The options passed into the kernel
  */
@@ -635,7 +633,7 @@ static struct file_system_type ecryptfs_fs_type = {
 };
 MODULE_ALIAS_FS("ecryptfs");
 
-/**
+/*
  * inode_info_init_once
  *
  * Initializes the ecryptfs_inode_info_cache when it is created
-- 
2.27.0

