From: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ecryptfs: use DEFINE_MUTEX (and mutex_init() had been too late)
Date: Wed, 23 Dec 2020 22:13:07 +0800
Message-ID: <20201223141307.615-1-zhengyongjun3@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:9916 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgLWON1 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 23 Dec 2020 09:13:27 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zheng Yongjun <zhengyongjun3@huawei.com>

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

