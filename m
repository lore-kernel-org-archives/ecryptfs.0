Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADE41C314;
	Tue, 31 Mar 2026 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971488; cv=none; b=O0Be624ry2PbjQ9nFRCpNLj5vY7ZU4ZqFFpgfpYI09XqNzqg8edtpJRsiyJsD4cNJf5E8wkkAk4sZN1jtiuY5CvbOhh4S3PAiqRsEANwsbYKtt6Xxhe5u+WasGI2O2fMn5lqCA8JhjC3zUYxiF+nJ53Lemcg5mrNbVhstyRZmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971488; c=relaxed/simple;
	bh=/RM8wi4qIZUeICmqKryklJg/UnGFiRCbRbj6G9Eb/iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7u43v+8XkpYZp3E5fKbH6RlUsOvk2nbAyeyZjsn0k4ZlQuBgCg1SzFQFl4qJqZ8/nBsx0exmFwrH91Tu0plZ1y5cSArbBM9PFp5QTdkGK8hltkYvbbNp7iBWp5mV45lFLxWU0l9ZAqvud2hwyNmPgmlcTd3KrUsh5q6sO9Nkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0CXfuDZA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0CXfuDZA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O3FwPP9s95qkF9MnLuAH41g3CBizW3JZNIew9rScUPo=; b=0CXfuDZAuU1yLupgsLW3reD2Qs
	ion1mLCJ6a6Rr0SgOSo6mKFdVYHIHEcwzcGtoGLII09o2un9Vfk+IKA6DUqL5FzYM9H32lgB1bKhQ
	KLiZqWXtYho6GoYlbkBxqz27z6g31OxspXmQO3LBdLJ7MqlsAJ2Oy/dQXlKmIAgIrvsPdSGp5MSha
	qEnFdaDVZ5Snk5hB0wYn2NXsxZUKp9BM4o5jzhEL4k69iao2AHDkwXyGtmqlPifk6vWxFQDy6Czkj
	ZV0dQoPVRdzTlTiOxCcKDW4EPS6C9eamV8llWbvKsgjZHL+GBZbMwQT38jJFwAEQMn1FDv6MnOJuJ
	EOLKrYpQ==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7bAM-0000000DC9y-0SKg;
	Tue, 31 Mar 2026 15:38:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] ecryptfs: combine the two ATTR_SIZE blocks in ecryptfs_setattr
Date: Tue, 31 Mar 2026 17:37:25 +0200
Message-ID: <20260331153752.4049454-5-hch@lst.de>
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

Simplify the logic in ecryptfs_setattr by combining the two ATTR_SIZE
blocks.  This initializes lower_ia before the size check, which is
obviously correct as the size check doesn't look at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ecryptfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 57df35a22e9c..7a3da72eb3c6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -934,16 +934,15 @@ static int ecryptfs_setattr(struct mnt_idmap *idmap,
 	rc = setattr_prepare(&nop_mnt_idmap, dentry, ia);
 	if (rc)
 		goto out;
-	if (ia->ia_valid & ATTR_SIZE) {
-		rc = ecryptfs_inode_newsize_ok(inode, ia->ia_size);
-		if (rc)
-			goto out;
-	}
 
 	memcpy(&lower_ia, ia, sizeof(lower_ia));
 	if (ia->ia_valid & ATTR_FILE)
 		lower_ia.ia_file = ecryptfs_file_to_lower(ia->ia_file);
 	if (ia->ia_valid & ATTR_SIZE) {
+		rc = ecryptfs_inode_newsize_ok(inode, ia->ia_size);
+		if (rc)
+			goto out;
+
 		rc = truncate_upper(dentry, ia, &lower_ia);
 		if (rc < 0)
 			goto out;
-- 
2.47.3

