Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D65413259;
	Tue, 31 Mar 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971493; cv=none; b=e56xgw1anBl7rPHACOX0no7SAilnaLe379GPgvtSNwZFDozYZg1h4s2rraVpcKNJa8OctuGqcuMXLPEeKqpbWtgf/s0w0kPSSIOtKhOltEEk1kUpZKaot9doTCoIlNtzifUqKrpTJCZfuAob1IsXgDdGnd2vT/UZzxsz3M/cDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971493; c=relaxed/simple;
	bh=+vtz0HUfugraruvr2/7ELI54YzxPR5VxlRWAJdest4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJu+OX9qv8RnQtxvBRWdZHc8EhyYgNGR8/7KeZykBwbCZtW4hva8IIGuYBbprV0gRfjrIALsMw6eF4KuDiig56Ct2kvlMusILwNJ9VrmNVRr8HR6PpIhghgwhXhddYmdqEZhElZcRr3S57wg79TjUQqt8W1O3ntN0fdYQ2e7MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hPv9eXaf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPv9eXaf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K2X32DpmjcwRErdv1ZeSNXWrqHscgWjx43TI//8wgLM=; b=hPv9eXafYeyufMWlNtqqIyD8QG
	Vxs83Ibg58URBow3ikxXnFXGlpzqhrQ/J07KjHjPJZibjCCgRo95ZISmqFnxjqvu7sa9cnz+HRR+t
	mYgsSnvmYTV2D/pdxuNzwamtYQBuSo2YZ9Iy9GiMivxChEk6O5OkOFFj2X5gb8QoQVpObWeEgr6bO
	J6JHkCx8CEEaECRVuq6ZOOakgHiRiHj7a/Z89q4SYb9A0P8auUq2qoko/khc6LnVSKF9jwoT6Va9J
	vVRc3GPbGJWtTC3gmwAuxoQ82+Bxkr5e+PFWVqR8XEHxw7u+FV+r3SmEAeif5jdduNFxa3jAxmzIA
	P8M1naWw==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7bAR-0000000DCAM-1LGh;
	Tue, 31 Mar 2026 15:38:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] ecryptfs: merge ecryptfs_inode_newsize_ok into truncate_upper
Date: Tue, 31 Mar 2026 17:37:27 +0200
Message-ID: <20260331153752.4049454-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331153752.4049454-1-hch@lst.de>
References: <20260331153752.4049454-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Both callers of ecryptfs_inode_newsize_ok call truncate_upper right
after.  Merge ecryptfs_inode_newsize_ok into truncate_upper to simplify
the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ecryptfs/inode.c | 53 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index a7dc25fae8ee..c87ee3c6ecba 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -736,6 +736,23 @@ static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
 		return 0;
 	}
 
+	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
+	lower_size_before_truncate =
+		upper_size_to_lower_size(crypt_stat, i_size);
+	lower_size_after_truncate =
+		upper_size_to_lower_size(crypt_stat, lower_ia->ia_size);
+	if (lower_size_after_truncate > lower_size_before_truncate) {
+		/*
+		 * The eCryptfs inode and the new *lower* size are mixed here
+		 * because we may not have the lower i_mutex held and/or it may
+		 * not be appropriate to call inode_newsize_ok() with inodes
+		 * from other filesystems.
+		 */
+		rc = inode_newsize_ok(inode, lower_size_after_truncate);
+		if (rc)
+			return rc;
+	}
+
 	rc = ecryptfs_get_lower_file(dentry, inode);
 	if (rc)
 		return rc;
@@ -754,7 +771,6 @@ static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
 		goto out;
 	}
 
-	crypt_stat = &ecryptfs_inode_to_private(d_inode(dentry))->crypt_stat;
 	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		truncate_setsize(inode, lower_ia->ia_size);
 		goto out;
@@ -787,42 +803,15 @@ static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
 	 * We are reducing the size of the ecryptfs file, and need to know if we
 	 * need to reduce the size of the lower file.
 	 */
-	lower_size_before_truncate =
-		upper_size_to_lower_size(crypt_stat, i_size);
-	lower_size_after_truncate =
-		upper_size_to_lower_size(crypt_stat, lower_ia->ia_size);
 	if (lower_size_after_truncate < lower_size_before_truncate)
 		lower_ia->ia_size = lower_size_after_truncate;
 	else
 		lower_ia->ia_valid &= ~ATTR_SIZE;
-
 out:
 	ecryptfs_put_lower_file(inode);
 	return rc;
 }
 
-static int ecryptfs_inode_newsize_ok(struct inode *inode, loff_t offset)
-{
-	struct ecryptfs_crypt_stat *crypt_stat;
-	loff_t lower_oldsize, lower_newsize;
-
-	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
-	lower_oldsize = upper_size_to_lower_size(crypt_stat,
-						 i_size_read(inode));
-	lower_newsize = upper_size_to_lower_size(crypt_stat, offset);
-	if (lower_newsize > lower_oldsize) {
-		/*
-		 * The eCryptfs inode and the new *lower* size are mixed here
-		 * because we may not have the lower i_mutex held and/or it may
-		 * not be appropriate to call inode_newsize_ok() with inodes
-		 * from other filesystems.
-		 */
-		return inode_newsize_ok(inode, lower_newsize);
-	}
-
-	return 0;
-}
-
 /**
  * ecryptfs_truncate
  * @dentry: The ecryptfs layer dentry
@@ -841,10 +830,6 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 	};
 	int rc;
 
-	rc = ecryptfs_inode_newsize_ok(d_inode(dentry), new_length);
-	if (rc)
-		return rc;
-
 	rc = truncate_upper(dentry, &lower_ia);
 	if (!rc && lower_ia.ia_valid & ATTR_SIZE) {
 		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
@@ -936,10 +921,6 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	if (ia->ia_valid & ATTR_FILE)
 		lower_ia.ia_file = ecryptfs_file_to_lower(ia->ia_file);
 	if (ia->ia_valid & ATTR_SIZE) {
-		rc = ecryptfs_inode_newsize_ok(inode, ia->ia_size);
-		if (rc)
-			goto out;
-
 		rc = truncate_upper(dentry, &lower_ia);
 		if (rc < 0)
 			goto out;
-- 
2.47.3

