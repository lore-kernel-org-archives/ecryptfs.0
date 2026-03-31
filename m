Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF5413241;
	Tue, 31 Mar 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971499; cv=none; b=GfIa4LLJUkOLIgVK7M+4p5HUviNAtyXeGmBfBkY+DR4BCBtu3ss4P5l4yJ+ggW811vQAE34SdeN8FNGUGsOHXA4JIlLAUxwIsgKb/hi5SATTjFkXxHE02Y++MmZypv6zO1j8IyKW7wY25TMd9Qu1G17My6mD02AKu/plUg3coqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971499; c=relaxed/simple;
	bh=GCjU8VmWOqWFk6waIurChh7kQ5JfLaTwWrsh9aTcfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1SrVSw84GGe+0qGMGeM8E7i7etMUcliWrDTCWhHukUbqUTd4+O2Fm2UBpW1C6oALr25nB0A0FMvG3E/lCCXpf+gOMkglx8S0i/VRKhlbh4jzATs5dyrI7oHPBGTE71I5X8lk0xqatR/LMoyRZeEWASLlhpGsyDDq73i/W5L38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yPML2qwe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yPML2qwe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k5hzf+2WitMD3bLb9qaTKiy+YgjAMvvStEbHAfO+bq8=; b=yPML2qwefEXMYopAOfq0Lfx3lo
	KVcs+66aB0C1abtYjBsUcOQEnEwd9jBNN7Vk76AYn2eKbh9QTDQ86kZJaCmlErXDz+m8R+o8Eq2O8
	uBhgqhgKPT4b81dQm6EpW+axWhwbHfaoit4tKeqri19TfrmnUWaOCpI+e23rDbAIiBzJkgr84DHSN
	EaRqkq8I+Z7vjJ88qTJMMSGGgovjkyV/qYS4UXPihMruiEb12jxjhE2K3ub66AFnOQY7jrSpcEMX5
	r8L3HRHJtAQkCkX3hJlFlxElN4eKCX5wfY+IJIWa+BdqTOXJ/b8Dg+EZYZF5K+KJmN/Av4xTc/C2X
	ZDJdoY0w==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7bAU-0000000DCAr-0xiN;
	Tue, 31 Mar 2026 15:38:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] ecryptfs: call notify_change from truncate_upper
Date: Tue, 31 Mar 2026 17:37:28 +0200
Message-ID: <20260331153752.4049454-8-hch@lst.de>
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

Keep all the truncation logic in one place by also moving the call to
notify_change into truncate_upper.  Rename the resulting function to
__ecryptfs_truncate as it deals with both the lower and upper inodes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ecryptfs/inode.c | 61 +++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c87ee3c6ecba..256beed0e47d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -707,7 +707,7 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
 }
 
 /**
- * truncate_upper
+ * __ecryptfs_truncate
  * @dentry: The ecryptfs layer dentry
  * @lower_ia: Address of the lower inode's attributes
  *
@@ -721,9 +721,10 @@ upper_size_to_lower_size(struct ecryptfs_crypt_stat *crypt_stat,
  *
  * Returns zero on success; non-zero otherwise
  */
-static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
+static int __ecryptfs_truncate(struct dentry *dentry, struct iattr *lower_ia)
 {
 	struct inode *inode = d_inode(dentry);
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	struct ecryptfs_crypt_stat *crypt_stat;
 	loff_t i_size = i_size_read(inode);
 	loff_t lower_size_before_truncate;
@@ -731,10 +732,8 @@ static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
 	size_t num_zeros;
 	int rc;
 
-	if (unlikely(lower_ia->ia_size == i_size)) {
-		lower_ia->ia_valid &= ~ATTR_SIZE;
+	if (unlikely(lower_ia->ia_size == i_size))
 		return 0;
-	}
 
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	lower_size_before_truncate =
@@ -767,13 +766,12 @@ static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
 		 * new and of the file.
 		 */
 		rc = ecryptfs_write(inode, zero, lower_ia->ia_size - 1, 1);
-		lower_ia->ia_valid &= ~ATTR_SIZE;
 		goto out;
 	}
 
 	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		truncate_setsize(inode, lower_ia->ia_size);
-		goto out;
+		goto set_size;
 	}
 
 	/*
@@ -803,10 +801,14 @@ static int truncate_upper(struct dentry *dentry, struct iattr *lower_ia)
 	 * We are reducing the size of the ecryptfs file, and need to know if we
 	 * need to reduce the size of the lower file.
 	 */
-	if (lower_size_after_truncate < lower_size_before_truncate)
-		lower_ia->ia_size = lower_size_after_truncate;
-	else
-		lower_ia->ia_valid &= ~ATTR_SIZE;
+	if (lower_size_after_truncate >= lower_size_before_truncate)
+		goto out;
+
+	lower_ia->ia_size = lower_size_after_truncate;
+set_size:
+	inode_lock(d_inode(lower_dentry));
+	rc = notify_change(&nop_mnt_idmap, lower_dentry, lower_ia, NULL);
+	inode_unlock(d_inode(lower_dentry));
 out:
 	ecryptfs_put_lower_file(inode);
 	return rc;
@@ -828,18 +830,8 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 		.ia_valid	= ATTR_SIZE,
 		.ia_size	= new_length,
 	};
-	int rc;
-
-	rc = truncate_upper(dentry, &lower_ia);
-	if (!rc && lower_ia.ia_valid & ATTR_SIZE) {
-		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 
-		inode_lock(d_inode(lower_dentry));
-		rc = notify_change(&nop_mnt_idmap, lower_dentry,
-				   &lower_ia, NULL);
-		inode_unlock(d_inode(lower_dentry));
-	}
-	return rc;
+	return __ecryptfs_truncate(dentry, &lower_ia);
 }
 
 static int
@@ -867,7 +859,6 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *ia)
 {
 	struct inode *inode = d_inode(dentry);
-	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	struct inode *lower_inode = ecryptfs_inode_to_lower(inode);
 	struct iattr lower_ia;
 	struct ecryptfs_crypt_stat *crypt_stat;
@@ -918,13 +909,6 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 		goto out;
 
 	memcpy(&lower_ia, ia, sizeof(lower_ia));
-	if (ia->ia_valid & ATTR_FILE)
-		lower_ia.ia_file = ecryptfs_file_to_lower(ia->ia_file);
-	if (ia->ia_valid & ATTR_SIZE) {
-		rc = truncate_upper(dentry, &lower_ia);
-		if (rc < 0)
-			goto out;
-	}
 
 	/*
 	 * mode change is for clearing setuid/setgid bits. Allow lower fs
@@ -933,9 +917,20 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	if (lower_ia.ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
 		lower_ia.ia_valid &= ~ATTR_MODE;
 
-	inode_lock(d_inode(lower_dentry));
-	rc = notify_change(&nop_mnt_idmap, lower_dentry, &lower_ia, NULL);
-	inode_unlock(d_inode(lower_dentry));
+	if (ia->ia_valid & ATTR_SIZE) {
+		if (ia->ia_valid & ATTR_FILE)
+			lower_ia.ia_file = ecryptfs_file_to_lower(ia->ia_file);
+		rc = __ecryptfs_truncate(dentry, &lower_ia);
+		if (rc < 0)
+			goto out;
+	} else {
+		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+
+		inode_lock(d_inode(lower_dentry));
+		rc = notify_change(&nop_mnt_idmap, lower_dentry, &lower_ia,
+			NULL);
+		inode_unlock(d_inode(lower_dentry));
+	}
 out:
 	fsstack_copy_attr_all(inode, lower_inode);
 	return rc;
-- 
2.47.3

