From: Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] eCryptfs: Use DEFINE_MUTEX() for mutex lock
Date: Fri, 9 Apr 2021 17:51:42 +0800
Message-ID: <20210409095142.2294032-1-yebin10@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:16875 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhDIJnj (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 9 Apr 2021 05:43:39 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: yebin10@huawei.com, Tyler Hicks <code@tyhicks.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>
Cc: ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ecryptfs/messaging.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index c0dfd9647627..25ed9baf524e 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -14,10 +14,10 @@
 
 static LIST_HEAD(ecryptfs_msg_ctx_free_list);
 static LIST_HEAD(ecryptfs_msg_ctx_alloc_list);
-static struct mutex ecryptfs_msg_ctx_lists_mux;
+static DEFINE_MUTEX(ecryptfs_msg_ctx_lists_mux);
 
 static struct hlist_head *ecryptfs_daemon_hash;
-struct mutex ecryptfs_daemon_hash_mux;
+DEFINE_MUTEX(ecryptfs_daemon_hash_mux);
 static int ecryptfs_hash_bits;
 #define ecryptfs_current_euid_hash(uid) \
 	hash_long((unsigned long)from_kuid(&init_user_ns, current_euid()), ecryptfs_hash_bits)
@@ -359,7 +359,6 @@ int __init ecryptfs_init_messaging(void)
 		       "too large, defaulting to [%d] users\n", __func__,
 		       ecryptfs_number_of_users);
 	}
-	mutex_init(&ecryptfs_daemon_hash_mux);
 	mutex_lock(&ecryptfs_daemon_hash_mux);
 	ecryptfs_hash_bits = 1;
 	while (ecryptfs_number_of_users >> ecryptfs_hash_bits)
@@ -383,7 +382,6 @@ int __init ecryptfs_init_messaging(void)
 		rc = -ENOMEM;
 		goto out;
 	}
-	mutex_init(&ecryptfs_msg_ctx_lists_mux);
 	mutex_lock(&ecryptfs_msg_ctx_lists_mux);
 	ecryptfs_msg_counter = 0;
 	for (i = 0; i < ecryptfs_message_buf_len; i++) {

