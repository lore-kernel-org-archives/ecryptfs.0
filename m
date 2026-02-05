Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF23D3327
	for <ecryptfs@vger.kernel.org>; Thu,  5 Feb 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297954; cv=none; b=a3X/CxKtq+qqfl89ozRAtrnr/jPn/rheoh6Nv6/0ZSkCEFgt/uPsITSEehud4K6Y0G+RHF1ntll+0t+raz//umzp8p8rgWyDJZ6SGMB6rdLRMHspS3u7MXQ9wSOIt4NfXLB4C3i934CI7Us8iV2w2HwP0QhUTcLP4wxWjPzadpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297954; c=relaxed/simple;
	bh=vGAiSd5RINZ18iLVlfJyKMx/ilvW9bhLBsN6bupcwUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abQ3smK2yZ93jCc1ZWRgaaikQonHqpCFDGLkLnWiqAjN+47Ve1Duy+xuh1deAgu4zYX26kUKUAroSShM5R/aooZDCx2PvX75Mw7v56v9VAWpvgZlhMEw5AEkD63QFheL6daNFzGEPPN8uAVRiNJ4OAaxW6esOtbQYYIVRm20EQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDF9zIEw; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDF9zIEw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770297941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F9INFmCeG8m4mTLtVGVLw1SNSXYLotttmqstDkwTK9g=;
	b=pDF9zIEwBbic+FPtJISaNb8qCEb0MV+MRQA8tWJTagoszqiPRspgxSLH+Fwem6qGJrBM4Y
	/UMsKZMiVxL1Iob+uIkmyApKDjAS+bpQPbkoOhcVutfE5V+Rx/CUaOaxKJTVuQTO4YawXD
	DpeDkYG/nR2J49eGOzMtM75Kc/9f97E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ecryptfs: Fix tag number in encrypt_filename() error message
Date: Thu,  5 Feb 2026 14:25:32 +0100
Message-ID: <20260205132535.1011291-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Report the correct tag number (70) instead of tag 72.

Use ecryptfs_printk() and reformat the string to silence the checkpatch
warning: "WARNING: quoted string split across lines".

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ecryptfs/crypto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 260f8a4938b0..6012e4360096 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1378,9 +1378,9 @@ ecryptfs_encrypt_filename(struct ecryptfs_filename *filename,
 			mount_crypt_stat, NULL,
 			filename->filename_size);
 		if (rc) {
-			printk(KERN_ERR "%s: Error attempting to get packet "
-			       "size for tag 72; rc = [%d]\n", __func__,
-			       rc);
+			ecryptfs_printk(KERN_ERR,
+				"Error attempting to get packet size for tag 70; rc = [%d]\n",
+				rc);
 			filename->encrypted_filename_size = 0;
 			goto out;
 		}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

