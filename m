From: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] ecryptfs: use DEFINE_MUTEX() for mutex lock
Date: Thu, 24 Dec 2020 21:22:33 +0800
Message-ID: <20201224132233.30852-1-zhengyongjun3@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:9486 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXNWp (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 24 Dec 2020 08:22:45 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zheng Yongjun <zhengyongjun3@huawei.com>

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/ecryptfs/crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 0681540c48d9..be906b9bbb11 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1590,11 +1590,10 @@ ecryptfs_process_key_cipher(struct crypto_skcipher **key_tfm,
 
 struct kmem_cache *ecryptfs_key_tfm_cache;
 static struct list_head key_tfm_list;
-struct mutex key_tfm_list_mutex;
+DEFINE_MUTEX(key_tfm_list_mutex);
 
 int __init ecryptfs_init_crypto(void)
 {
-	mutex_init(&key_tfm_list_mutex);
 	INIT_LIST_HEAD(&key_tfm_list);
 	return 0;
 }
-- 
2.22.0

