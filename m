From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] ecryptfs: remove private bin2hex implementation
Date: Wed, 21 Sep 2016 01:17:24 +0200
Message-ID: <1474413444-19974-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35139 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbcITXRv (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Sep 2016 19:17:51 -0400
Received: by mail-wm0-f47.google.com with SMTP id l132so236413366wmf.0
        for <ecryptfs@vger.kernel.org>; Tue, 20 Sep 2016 16:17:46 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Calling sprintf in a loop is not very efficient, and in any case, we
already have an implementation of bin-to-hex conversion in lib/ which
we might as well use.

Note that ecryptfs_to_hex used to nul-terminate the destination (and
the kernel doc was wrong about the required output size), while
bin2hex doesn't. [All but one user of ecryptfs_to_hex explicitly
nul-terminates the result anyway.]

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/ecryptfs/crypto.c          | 15 ---------------
 fs/ecryptfs/ecryptfs_kernel.h |  8 +++++++-
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e5e29f8c920b..7acd57da4f14 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -42,21 +42,6 @@
 #define ENCRYPT		1
 
 /**
- * ecryptfs_to_hex
- * @dst: Buffer to take hex character representation of contents of
- *       src; must be at least of size (src_size * 2)
- * @src: Buffer to be converted to a hex string representation
- * @src_size: number of bytes to convert
- */
-void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
-{
-	int x;
-
-	for (x = 0; x < src_size; x++)
-		sprintf(&dst[x * 2], "%.2x", (unsigned char)src[x]);
-}
-
-/**
  * ecryptfs_from_hex
  * @dst: Buffer to take the bytes from src hex; must be at least of
  *       size (src_size / 2)
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4ba1547bb9ad..548caac3a907 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -51,7 +51,13 @@
 #define ECRYPTFS_XATTR_NAME "user.ecryptfs"
 
 void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok);
-extern void ecryptfs_to_hex(char *dst, char *src, size_t src_size);
+static inline void
+ecryptfs_to_hex(char *dst, char *src, size_t src_size)
+{
+	char *end = bin2hex(dst, src, src_size);
+	*end = '\0';
+}
+
 extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
 
 struct ecryptfs_key_record {
-- 
2.1.4
