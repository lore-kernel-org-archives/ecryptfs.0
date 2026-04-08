Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30435CB8B;
	Wed,  8 Apr 2026 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628445; cv=none; b=EnAbc1uZVJdwSh/PT8tJJpSXbKbX0WSMmSeqrIIEKJYkDxriizZVVF0orfYyZSMBB3Q4bczTMKsk5s8QZos2LcjGZxWIj8t2O3CoR0Y4JbVHXIntS69/wbkub9UAre5G+Pt1OhTtRId69KMm9R1s+KK9A81dGhkD00PmBVktov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628445; c=relaxed/simple;
	bh=RlCGZgNJSpxZup+3p6zRQnd6n1X/M5wgr8ZUM4MPkTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAn7b/stX/vzhviKzGNXVdgltGML1iXNL3P8wQTe5Atw5g7BhTgo+t2oB9oNNmvsblzNKzn2geRRo6/S5F39N/s6gXdOhXtNXg1Jwzytw+l4kCaY173v2XBGNe5xzeduz6gjdOvG9zEtS6qbC3PvTPb9kiyhyAE0arks5R/918Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E9bpKHSn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E9bpKHSn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CTZ6r1qmeQj6oOlmeiOHffkyW9Eoab8H3wkR1X1slb8=; b=E9bpKHSnKTIXWXS6a4D5OUHyrC
	Is99dkAf3pplNfMtZO6mXcQRaAWa5fPqQAlYM2zjquZe7YiGM44M1Qy8SxwIpRdhqIYqXsEcde8zX
	5KzugHmuVev0naeD3krx7GMxVMApEoxDy+I9rZl/LoIDZbZ0tefrUY8jKAmdw6n3P7/aR1UxZfqXl
	D9xLgv+LnxfDy1Sy0fxIbguFTa0V47pafAb7siBBAwvzDYNehV3D3QPsPR8J5FdtJiw9T7n45CQyw
	psrFPZwufELLxJfQeZLFwP/KMQiX11m7M/iMvj2ZlQI2cq9fsJGQVDST6dGgYHXGx9UyjyUwk0v2e
	uSicfexw==;
Received: from [2001:4bb8:2d1:6f42:152:6810:a349:3502] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAM4R-00000008Jxy-0lhT;
	Wed, 08 Apr 2026 06:07:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: cleanup truncate handling in ecryptfs v3
Date: Wed,  8 Apr 2026 08:06:35 +0200
Message-ID: <20260408060719.714317-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Tyler,

this series cleans up the truncate handling in ecryptfs.  I did
it as preparation for some changes into size changing truncate
VFS interfaces I'm looking into in the moment.  The changes have
passed the regression test suite in the userspace ecryptfs
repository and against the ecryptfs next branch.

Changes since v2:
 - change the calling convention to only pass the upper ia to
   __ecryptfs_truncate

Changes since v1:
 - fix a pre-existing spelling error in a comment
 - pass an explicit new_size argument to the main truncate routines
 - fix a comment that kept obsolete information

Diffstat:
 inode.c |  257 ++++++++++++++++++++++++++++------------------------------------
 1 file changed, 115 insertions(+), 142 deletions(-)
