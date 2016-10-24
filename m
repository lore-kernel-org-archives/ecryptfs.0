From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ecryptfs: fix spelling mistake: "cadidate" -> "candidate"
Date: Mon, 24 Oct 2016 23:10:58 +0100
Message-ID: <20161024221058.8695-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in ecryptfs_printk message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 11d39ab..4bd9099 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1890,7 +1890,7 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 		candidate_auth_tok = &auth_tok_list_item->auth_tok;
 		if (unlikely(ecryptfs_verbosity > 0)) {
 			ecryptfs_printk(KERN_DEBUG,
-					"Considering cadidate auth tok:\n");
+					"Considering candidate auth tok:\n");
 			ecryptfs_dump_auth_tok(candidate_auth_tok);
 		}
 		rc = ecryptfs_get_auth_tok_sig(&candidate_auth_tok_sig,
-- 
2.9.3

