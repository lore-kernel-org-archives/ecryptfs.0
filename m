Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EA312819
	for <ecryptfs@vger.kernel.org>; Sun, 25 Jan 2026 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381335; cv=none; b=NdOME9E+a3wAxOZ/+g5QCODJzbdf1RVHGnWJ1BaIJbfFte4+q/Bq6bVOdZ+kzVWQN8NiSuw3J90zQmaJf58LJQ9R8bh9rOFrkMwFA4lsSaL8YSMV8jZFsGFy4QXO3KJMO+0VAxx77gRaN5LaoHD7wQ5eRIv4Hx7mMgw9sGEytiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381335; c=relaxed/simple;
	bh=PwhNRGFiV2sIvxzGz9RICT2dErXSowdnS8ASs70rO78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmN0myy7bhXXXB2NYmlUnbCh2OZZdD5tcLM61bqiSnA7c6WLXkB6hDNU7O3cc+z1w4DH6pqwM+tTTyAL4nzfDVGpmuK3sT8vfrFvEx+okXRlTAZMm4dTU7Lr/T4mBjNu+dbr2vb3U/YqOSZzwIV9lsIrNk4MF4EOHmT6UumV/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/ggqRtE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/ggqRtE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769381322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yG9k0WJCRKkjY/N/BZZfrJa044NUOlXAfp1FzXgUxg8=;
	b=P/ggqRtEsU0ZUKwFlbbI7SjiohGOF6a0pFi5JBkrMqmi6np1JMqCk2BJu8wK9Sad3qlIC7
	Pfx9MjPUyRXsv96CKHiPifK2NIjoEZhElnckqU+pXhlNl5uSVpGGVUF0jBfTyNpa/ffIku
	P38lAsITDZ3Gsokgy+Ms/jdq/xO476I=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Zipeng Zhang <zhangzipeng0@foxmail.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: Log function name only once in decode_and_decrypt_filename
Date: Sun, 25 Jan 2026 23:43:41 +0100
Message-ID: <20260125224343.155960-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ecryptfs_printk() already prints the function name using %s and
__func__. Drop the redundant function name from the debug log message.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ecryptfs/crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index a13229d49b7e..8f2e1ea1f9f8 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1937,8 +1937,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 						  decoded_name_size);
 		if (rc) {
 			ecryptfs_printk(KERN_DEBUG,
-					"%s: Could not parse tag 70 packet from filename\n",
-					__func__);
+					"Could not parse tag 70 packet from filename\n");
 			goto out_free;
 		}
 	} else {
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

