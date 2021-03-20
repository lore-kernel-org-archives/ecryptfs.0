From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/4] ecryptfs: ecryptfs_dentry_info->crypt_stat is never used
Date: Sat, 20 Mar 2021 21:52:41 +0000
Message-ID: <YFZuqS7OheVDgObg@zeniv-ca.linux.org.uk>
References: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
 <YFZubuMq1akR1YDx@zeniv-ca.linux.org.uk>
 <YFZuiwhD7gKlu9Qs@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35562 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCTVyx (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 20 Mar 2021 17:54:53 -0400
Content-Disposition: inline
In-Reply-To: <YFZuiwhD7gKlu9Qs@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

... and never had anything non-NULL stored into it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/ecryptfs_kernel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 463b2d99b554..495fb4514d09 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -262,10 +262,7 @@ struct ecryptfs_inode_info {
  * vfsmount too. */
 struct ecryptfs_dentry_info {
 	struct path lower_path;
-	union {
-		struct ecryptfs_crypt_stat *crypt_stat;
-		struct rcu_head rcu;
-	};
+	struct rcu_head rcu;
 };
 
 /**
-- 
2.11.0

