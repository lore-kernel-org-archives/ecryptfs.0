From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 28/39] ecryptfs: drop null test before destroy functions
Date: Sun, 13 Sep 2015 14:15:21 +0200
Message-ID: <1442146532-9100-29-git-send-email-Julia.Lawall@lip6.fr>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org

Remove unneeded NULL test.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@ expression x; @@
-if (x != NULL)
  \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 fs/ecryptfs/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 4f4d047..e83f31c 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -737,8 +737,7 @@ static void ecryptfs_free_kmem_caches(void)
 		struct ecryptfs_cache_info *info;
 
 		info = &ecryptfs_cache_infos[i];
-		if (*(info->cache))
-			kmem_cache_destroy(*(info->cache));
+		kmem_cache_destroy(*(info->cache));
 	}
 }
 
