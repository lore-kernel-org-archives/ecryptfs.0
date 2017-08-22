From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] eCryptfs: use after free in ecryptfs_release_messaging()
Date: Tue, 22 Aug 2017 23:41:28 +0300
Message-ID: <20170822204128.7xhtrlpvueucbisl@mwanda>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51986 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbdHVUly (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 22 Aug 2017 16:41:54 -0400
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>, Michael Halcrow <mhalcrow@us.ibm.com>
Cc: ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org

We're freeing the list iterator so we should be using the _safe()
version of hlist_for_each_entry().

Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's also possible that I misunderstood this code.  Please review with
caution.

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index 286f10b0363b..4f457d5c4933 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -442,15 +442,16 @@ void ecryptfs_release_messaging(void)
 	}
 	if (ecryptfs_daemon_hash) {
 		struct ecryptfs_daemon *daemon;
+		struct hlist_node *n;
 		int i;
 
 		mutex_lock(&ecryptfs_daemon_hash_mux);
 		for (i = 0; i < (1 << ecryptfs_hash_bits); i++) {
 			int rc;
 
-			hlist_for_each_entry(daemon,
-					     &ecryptfs_daemon_hash[i],
-					     euid_chain) {
+			hlist_for_each_entry_safe(daemon, n,
+						  &ecryptfs_daemon_hash[i],
+						  euid_chain) {
 				rc = ecryptfs_exorcise_daemon(daemon);
 				if (rc)
 					printk(KERN_ERR "%s: Error whilst "
