From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH v2] ecryptfs: replace BUG_ON with error handling code
Date: Fri, 14 Feb 2020 12:21:01 -0600
Message-ID: <20200214182101.17165-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33466 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbgBNSVL (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 14 Feb 2020 13:21:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 48K1sf69B5z9vZTH
        for <ecryptfs@vger.kernel.org>; Fri, 14 Feb 2020 18:21:10 +0000 (UTC)
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kdbln-8goQ-5 for <ecryptfs@vger.kernel.org>;
        Fri, 14 Feb 2020 12:21:10 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 48K1sf4zLGz9vZSs
        for <ecryptfs@vger.kernel.org>; Fri, 14 Feb 2020 12:21:10 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id 62so8372831ybt.9
        for <ecryptfs@vger.kernel.org>; Fri, 14 Feb 2020 10:21:10 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Tyler Hicks <tyhicks@canonical.com>, Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>, Adrian Bunk <bunk@stusta.de>, Randy Dunlap <rdunlap@infradead.org>, Theodore Ts'o <tytso@mit.edu>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

In crypt_scatterlist, if the crypt_stat argument is not set up
correctly, the kernel crashes. Instead, by returning an error code
upstream, the error is handled safely.

The issue is detected via a static analysis tool written by us.

Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Add missing fixes tag suggested by Markus and Tyler.
---
 fs/ecryptfs/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index db1ef144c63a..2c449aed1b92 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
+	if (!crypt_stat || !crypt_stat->tfm
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
+		return -EINVAL;
+
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
 				crypt_stat->key_size);
-- 
2.20.1

