From: Zeev Zilberman <zeev@annapurnaLabs.com>
Subject: Re: eCryptfs ablkcipher patch
Date: Sun, 20 Jan 2013 13:26:34 +0000
Message-ID: <068EA2D22589DD4FBD9A55E6FF1EA0B50F1E3E65@SIXPRD0211MB419.apcprd02.prod.outlook.com>
References: <20130110183649.GA30916@boyd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:45010
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923Ab3ATN0k convert rfc822-to-8bit
	(ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 20 Jan 2013 08:26:40 -0500
In-Reply-To: <20130110183649.GA30916@boyd>
Content-Language: en-US
Content-ID: <2FAB83CC8D0F5D429E9A396D42B46876@apcprd02.prod.outlook.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

Hi Tyler,

The patch below adds the workqueue for write operations.
This patch depends on the ecryptfs ablkcipher support patch rebased to 3.7.

Regards,
Ze'ev

---

From 606ea815140caa30ff93bdcd998f43d7f95edf61 Mon Sep 17 00:00:00 2001
From: Zeev Zilberman <zeev@annapurnalabs.com>
Date: Mon, 17 Dec 2012 17:59:22 +0200
Subject: [PATCH] ecryptfs ablkcipher support - add workqueue

ablkcipher callback may called from tasklet, so it can't sleep.
Using work queue for write operations allows using sleeping functions.

Signed-off-by: Zeev Zilberman <zeev@annapurnalabs.com>
---
fs/ecryptfs/crypto.c          |   93
+++++++++++++++++++++++++++++-----------
fs/ecryptfs/ecryptfs_kernel.h |    1 +
2 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7f5ff05..27b1702 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -34,6 +34,7 @@
#include <linux/file.h>
#include <linux/scatterlist.h>
#include <linux/slab.h>
+#include <linux/workqueue.h>
#include <asm/unaligned.h>
#include "ecryptfs_kernel.h"
@@ -562,6 +563,53 @@ out:
	}
}
+static struct workqueue_struct *crypto_cmp_write_queue;
+
+/**
+ * ecryptfs_encrypt_extent_write
+ * @work: The extent work structure
+ *
+ * This function is called performs the io operations after
+ * the encryption is completed. It is queued in a workqueue by
+ * ecryptfs_encrypt_extent_done, so it can sleep.
+ */
+static void ecryptfs_encrypt_extent_write(struct work_struct *work)
+{
+	struct ecryptfs_extent_crypt_req *extent_crypt_req = container_of(
+			work, struct ecryptfs_extent_crypt_req, work);
+	struct ecryptfs_page_crypt_req *page_crypt_req =
+				extent_crypt_req->page_crypt_req;
+	char *enc_extent_virt = NULL;
+	struct page *page = page_crypt_req->page;
+	struct page *enc_extent_page = extent_crypt_req->enc_extent_page;
+	loff_t offset;
+	int rc = 0;
+
+	enc_extent_virt = kmap(enc_extent_page);
+	ecryptfs_lower_offset_for_extent(
+		&offset,
+		((((loff_t)page->index)
+		  * (PAGE_CACHE_SIZE
+		     / extent_crypt_req->crypt_stat->extent_size))
+		    + extent_crypt_req->extent_offset),
+		extent_crypt_req->crypt_stat);
+	rc = ecryptfs_write_lower(extent_crypt_req->inode, enc_extent_virt,
+				  offset,
+				  extent_crypt_req->crypt_stat->extent_size);
+	if (rc < 0) {
+		atomic_set(&page_crypt_req->rc, rc);
+		ecryptfs_printk(KERN_ERR, "Error attempting "
+				"to write lower page; rc = [%d]"
+				"\n", rc);
+		goto out;
+	}
+out:
+	if (enc_extent_virt)
+		kunmap(enc_extent_page);
+	__free_page(enc_extent_page);
+	ecryptfs_free_extent_crypt_req(extent_crypt_req);
+}
+
/**
  * ecryptfs_encrypt_extent_done
  * @req: The original extent encrypt request
@@ -576,14 +624,11 @@ static void ecryptfs_encrypt_extent_done(
	struct ecryptfs_extent_crypt_req *extent_crypt_req = req->data;
	struct ecryptfs_page_crypt_req *page_crypt_req =
				extent_crypt_req->page_crypt_req;
-	char *enc_extent_virt = NULL;
	struct page *page = page_crypt_req->page;
	struct page *enc_extent_page = extent_crypt_req->enc_extent_page;
	struct ecryptfs_crypt_stat *crypt_stat = extent_crypt_req->crypt_stat;
	loff_t extent_base;
	unsigned long extent_offset = extent_crypt_req->extent_offset;
-	loff_t offset;
-	int rc = 0;
	if (!err && unlikely(ecryptfs_verbosity > 0)) {
		extent_base = (((loff_t)page->index)
@@ -600,32 +645,14 @@ static void ecryptfs_encrypt_extent_done(
		atomic_set(&page_crypt_req->rc, err);
		printk(KERN_ERR "%s: Error encrypting extent; "
		       "rc = [%d]\n", __func__, err);
+		__free_page(enc_extent_page);
+		ecryptfs_free_extent_crypt_req(extent_crypt_req);
		goto out;
	}
-
-	enc_extent_virt = kmap(enc_extent_page);
-	ecryptfs_lower_offset_for_extent(
-		&offset,
-		((((loff_t)page->index)
-		  * (PAGE_CACHE_SIZE
-		     / extent_crypt_req->crypt_stat->extent_size))
-		    + extent_crypt_req->extent_offset),
-		extent_crypt_req->crypt_stat);
-	rc = ecryptfs_write_lower(extent_crypt_req->inode, enc_extent_virt,
-				  offset,
-				  extent_crypt_req->crypt_stat->extent_size);
-	if (rc < 0) {
-		atomic_set(&page_crypt_req->rc, rc);
-		ecryptfs_printk(KERN_ERR, "Error attempting "
-				"to write lower page; rc = [%d]"
-				"\n", rc);
-		goto out;
-	}
+	INIT_WORK(&extent_crypt_req->work, ecryptfs_encrypt_extent_write);
+	queue_work(crypto_cmp_write_queue, &extent_crypt_req->work);
out:
-	if (enc_extent_virt)
-		kunmap(enc_extent_page);
-	__free_page(enc_extent_page);
-	ecryptfs_free_extent_crypt_req(extent_crypt_req);
+	return;
}
/**
@@ -2124,6 +2151,17 @@ int __init ecryptfs_init_crypto(void)
{
	mutex_init(&key_tfm_list_mutex);
	INIT_LIST_HEAD(&key_tfm_list);
+
+	crypto_cmp_write_queue = alloc_workqueue("ecryptfs_cmp_write",
+				       WQ_NON_REENTRANT|
+				       WQ_MEM_RECLAIM,
+				       1);
+	if (!crypto_cmp_write_queue) {
+		printk(KERN_ERR "%s: failed to alloc crypto write workqueue\n",
+				__func__);
+		return -ENOMEM;
+	}
+
	return 0;
}
@@ -2136,6 +2174,9 @@ int ecryptfs_destroy_crypto(void)
{
	struct ecryptfs_key_tfm *key_tfm, *key_tfm_tmp;
+	if (crypto_cmp_write_queue)
+		destroy_workqueue(crypto_cmp_write_queue);
+
	mutex_lock(&key_tfm_list_mutex);
	list_for_each_entry_safe(key_tfm, key_tfm_tmp, &key_tfm_list,
				 key_tfm_list) {
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 5af953f..7d4dafd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -571,6 +571,7 @@ struct ecryptfs_extent_crypt_req {
	unsigned long extent_offset;
	struct scatterlist src_sg;
	struct scatterlist dst_sg;
+	struct work_struct work;
};
struct inode *ecryptfs_get_inode(struct inode *lower_inode,
--
1.7.0.4


