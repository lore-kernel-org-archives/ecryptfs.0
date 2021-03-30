From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 31/31] fs: ecryptfs: keystore: Fix some kernel-doc issues and demote non-conformant headers
Date: Tue, 30 Mar 2021 17:44:58 +0100
Message-ID: <20210330164458.1625478-32-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, "Michael A. Halcrow" <mhalcrow@us.ibm.com>, "Michael C. Thompson" <mcthomps@us.ibm.com>, "Trevor S. Highland" <trevor.highland@gmail.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/keystore.c:25: warning: Incorrect use of kernel-doc format:  * request_key returned an error instead of a valid key address;
 fs/ecryptfs/keystore.c:30: warning: Function parameter or member 'err_code' not described in 'process_request_key_err'
 fs/ecryptfs/keystore.c:30: warning: expecting prototype for eCryptfs(). Prototype was for process_request_key_err() instead
 fs/ecryptfs/keystore.c:558: warning: Function parameter or member 'auth_tok_key' not described in 'ecryptfs_find_auth_tok_for_sig'
 fs/ecryptfs/keystore.c:558: warning: Function parameter or member 'mount_crypt_stat' not described in 'ecryptfs_find_auth_tok_for_sig'
 fs/ecryptfs/keystore.c:558: warning: Excess function parameter 'crypt_stat' description in 'ecryptfs_find_auth_tok_for_sig'
 fs/ecryptfs/keystore.c:584: warning: cannot understand function prototype: 'struct ecryptfs_write_tag_70_packet_silly_stack '
 fs/ecryptfs/keystore.c:622: warning: Function parameter or member 'dest' not described in 'ecryptfs_write_tag_70_packet'
 fs/ecryptfs/keystore.c:622: warning: Function parameter or member 'remaining_bytes' not described in 'ecryptfs_write_tag_70_packet'
 fs/ecryptfs/keystore.c:622: warning: Function parameter or member 'packet_size' not described in 'ecryptfs_write_tag_70_packet'
 fs/ecryptfs/keystore.c:622: warning: Function parameter or member 'mount_crypt_stat' not described in 'ecryptfs_write_tag_70_packet'
 fs/ecryptfs/keystore.c:622: warning: Function parameter or member 'filename_size' not described in 'ecryptfs_write_tag_70_packet'
 fs/ecryptfs/keystore.c:622: warning: expecting prototype for write_tag_70_packet(). Prototype was for ecryptfs_write_tag_70_packet() instead
 fs/ecryptfs/keystore.c:895: warning: expecting prototype for parse_tag_70_packet(). Prototype was for ecryptfs_parse_tag_70_packet() instead

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mhalcrow@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: "Trevor S. Highland" <trevor.highland@gmail.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/keystore.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 2abd219cfeec6..3fe41964c0d8d 100644
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
@@ -536,8 +536,9 @@ ecryptfs_find_global_auth_tok_for_sig(
 
 /**
  * ecryptfs_find_auth_tok_for_sig
+ * @auth_tok_key: key containing the authentication token
  * @auth_tok: Set to the matching auth_tok; NULL if not found
- * @crypt_stat: inode crypt_stat crypto context
+ * @mount_crypt_stat: inode crypt_stat crypto context
  * @sig: Sig of auth_tok to find
  *
  * For now, this function simply looks at the registered auth_tok's
@@ -576,7 +577,7 @@ ecryptfs_find_auth_tok_for_sig(
 	return rc;
 }
 
-/**
+/*
  * write_tag_70_packet can gobble a lot of stack space. We stuff most
  * of the function's parameters in a kmalloc'd struct to help reduce
  * eCryptfs' overall stack usage.
@@ -604,7 +605,7 @@ struct ecryptfs_write_tag_70_packet_silly_stack {
 	struct shash_desc *hash_desc;
 };
 
-/**
+/*
  * write_tag_70_packet - Write encrypted filename (EFN) packet against FNEK
  * @filename: NULL-terminated filename string
  *
@@ -873,7 +874,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
 };
 
 /**
- * parse_tag_70_packet - Parse and process FNEK-encrypted passphrase packet
+ * ecryptfs_parse_tag_70_packet - Parse and process FNEK-encrypted passphrase packet
  * @filename: This function kmalloc's the memory for the filename
  * @filename_size: This function sets this to the amount of memory
  *                 kmalloc'd for the filename
-- 
2.27.0

