From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] ecryptfs: fix non static symbol warning
Date: Fri,  9 Dec 2016 22:27:58 +0800
Message-ID: <9bb02ed75e099a2bba8fb53069b955cfe60ce622.1480487321.git.geliangtang@gmail.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36001 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbcLIO2P (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 9 Dec 2016 09:28:15 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Geliang Tang <geliangtang@gmail.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes sparse warning:

fs/ecryptfs/inode.c:1142:28: warning: symbol 'ecryptfs_xattr_handler'
 was not declared. Should it be static?

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/ecryptfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index cf390dc..a483ca1 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1139,7 +1139,7 @@ static int ecryptfs_xattr_set(const struct xattr_handler *handler,
 	}
 }
 
-const struct xattr_handler ecryptfs_xattr_handler = {
+static const struct xattr_handler ecryptfs_xattr_handler = {
 	.prefix = "",  /* match anything */
 	.get = ecryptfs_xattr_get,
 	.set = ecryptfs_xattr_set,
-- 
2.9.3
