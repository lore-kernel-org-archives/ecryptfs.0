Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1D2D8793;
	Sun, 12 Apr 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001860; cv=none; b=SF9RBZOPamZo0EgGzZEEfI31d5H1E6tV3Z9P2QtFRq/6Rh277AWMSJOADZX22ZVjOcW5tj1Ec7P6EN8z/mYmc+6bHY6VjdPmAXsOLjh5WJ5+XfxGAqtZcnhL2FuP/8pkzxoicJcMiBp+WFOBcBVO9vPVuPmBAptCnnrqeJcXym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001860; c=relaxed/simple;
	bh=BYwu7QtiDVDQ858XjI038y7KhYs6tSMQQC58HjgMsaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rP/5Owk5ozUgfEn8IVp5Y/tZ/YgSZxWRpfVODGbDPwf6BKHwk95vBLrGenvvJdv+/3YY8Dz7rJVzZVIUO9DiNg5Rtmyl8uSTSJBS/NcFoKr0qg4cY3u9EsbJ3eXgz1O04KGrJEGZZcDh7VepLanv+lQ3wUeapPAOQ6Ttuv0+SRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NRhVomvn; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NRhVomvn"
Received: from VelichayshiyPC.Dlink (unknown [176.65.115.160])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3699B4077934;
	Sun, 12 Apr 2026 13:50:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3699B4077934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1776001847;
	bh=8PEZCnxQHVwk6ty35JPy7MV+BGkzURZvhHOMVaDGwk8=;
	h=From:To:Cc:Subject:Date:From;
	b=NRhVomvn6lKMZl8pKA1dP54IOEBVXnxEFRGzeghaD07MlXnlXDwXSTuL+XOJgrvgV
	 6lEPHOrFPJym4LJpdDiu5mDN1uF36N7RGxorfF6Yo9xEa8mW5yPkjGhT5XkyUdFI8I
	 8WmqqIW6IGvCJ4IImkxEhG/+os3Gw93Zdg68mDpE=
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
To: Tyler Hicks <code@tyhicks.com>
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ecryptfs: remove redundant variable found_auth_tok
Date: Sun, 12 Apr 2026 16:50:08 +0300
Message-ID: <20260412135010.321286-1-a.velichayshiy@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The found_auth_tok variable is no longer needed, as the fact of finding
a token is determined directly by jumping to the found_matching_auth_tok
label inside the loop.

Remove found_auth_tok, simplifying the function logic.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
---
 fs/ecryptfs/keystore.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index e8494903bb42..0757531df5f9 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1718,7 +1718,6 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 			      struct dentry *ecryptfs_dentry)
 {
 	size_t i = 0;
-	size_t found_auth_tok;
 	size_t next_packet_is_auth_tok_packet;
 	LIST_HEAD(auth_tok_list);
 	struct ecryptfs_auth_tok *matching_auth_tok;
@@ -1822,7 +1821,6 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 	 * the metadata. There may be several potential matches, but
 	 * just one will be sufficient to decrypt to get the FEK. */
 find_next_matching_auth_tok:
-	found_auth_tok = 0;
 	list_for_each_entry(auth_tok_list_item, &auth_tok_list, list) {
 		candidate_auth_tok = &auth_tok_list_item->auth_tok;
 		if (unlikely(ecryptfs_verbosity > 0)) {
@@ -1843,17 +1841,13 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 					       &matching_auth_tok,
 					       crypt_stat->mount_crypt_stat,
 					       candidate_auth_tok_sig);
-		if (!rc) {
-			found_auth_tok = 1;
+		if (!rc)
 			goto found_matching_auth_tok;
-		}
-	}
-	if (!found_auth_tok) {
-		ecryptfs_printk(KERN_ERR, "Could not find a usable "
-				"authentication token\n");
-		rc = -EIO;
-		goto out_wipe_list;
 	}
+	ecryptfs_printk(KERN_ERR, "Could not find a usable "
+			"authentication token\n");
+	rc = -EIO;
+	goto out_wipe_list;
 found_matching_auth_tok:
 	if (candidate_auth_tok->token_type == ECRYPTFS_PRIVATE_KEY) {
 		memcpy(&(candidate_auth_tok->token.private_key),
-- 
2.43.0

