From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ecryptfs: Adjust four checks for null pointers
Date: Sat, 19 Aug 2017 18:57:50 +0200
Message-ID: <b6809bfc-991b-881a-90ac-eb08d4bfef4c@users.sourceforge.net>
References: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56e0a575-2a9e-120f-6a22-96d9fa4b151e@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: ecryptfs@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 19 Aug 2017 18:00:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/ecryptfs/crypto.c   | 6 +++---
 fs/ecryptfs/keystore.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 4a7ef33d4d79..1cd0902bc936 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1649,7 +1649,7 @@ ecryptfs_add_new_key_tfm(struct ecryptfs_key_tfm **key_tfm, char *cipher_name,
 	BUG_ON(!mutex_is_locked(&key_tfm_list_mutex));
 
 	tmp_tfm = kmem_cache_alloc(ecryptfs_key_tfm_cache, GFP_KERNEL);
-	if (key_tfm != NULL)
+	if (key_tfm)
 		(*key_tfm) = tmp_tfm;
 	if (!tmp_tfm) {
 		rc = -ENOMEM;
@@ -1668,7 +1668,7 @@ ecryptfs_add_new_key_tfm(struct ecryptfs_key_tfm **key_tfm, char *cipher_name,
 		       "cipher with name = [%s]; rc = [%d]\n",
 		       tmp_tfm->cipher_name, rc);
 		kmem_cache_free(ecryptfs_key_tfm_cache, tmp_tfm);
-		if (key_tfm != NULL)
+		if (key_tfm)
 			(*key_tfm) = NULL;
 		goto out;
 	}
@@ -1859,7 +1859,7 @@ ecryptfs_decode_from_filename(unsigned char *dst, size_t *dst_size,
 	size_t src_byte_offset = 0;
 	size_t dst_byte_offset = 0;
 
-	if (dst == NULL) {
+	if (!dst) {
 		(*dst_size) = ecryptfs_max_decoded_size(src_size);
 		goto out;
 	}
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 47c1fd73638d..5c961e76b211 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -678,7 +678,7 @@ ecryptfs_write_tag_70_packet(char *dest, size_t *remaining_bytes,
 	 *    separator, and then the filename */
 	s->max_packet_size = (ECRYPTFS_TAG_70_MAX_METADATA_SIZE
 			      + s->block_aligned_filename_size);
-	if (dest == NULL) {
+	if (!dest) {
 		(*packet_size) = s->max_packet_size;
 		goto out_unlock;
 	}
-- 
2.14.0

