Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A73C3BF4
	for <ecryptfs@vger.kernel.org>; Tue, 10 Mar 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138431; cv=none; b=f/LJvaseJSKFGKJ3W4z93+QHN86YMHgv64WXmrJUTjHRUVGxsUnITg6dzAVOJCw/5KCrbsh0j6/PeYExoWkibTZjBK86PDvokzwVU6LzZVDPs2uI5WIYaLVHy7xki2f0AMQhecHfKNkylBiRy861xfR5IXbS7RQmWKjYSZY23S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138431; c=relaxed/simple;
	bh=/JIaiXJ8+hehHjg1miPVUoV2YLxDXYRfp/WxLyC/Qk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSHDgK5QnLQyuGiPbWoQbEPdB13Wm0VzHJaJ43UwbLyip4T/NegmYO/HpbEYy6W4/JrlEFeXFjXEgjZtfnJGqdYVSiuPhwpOEonNv4NQ1H5fVQNM40hxNf0/KdRvDYxksLktZOHmMqFRbUIZewfvdAIrdv7hZzdeMwt+k3OdBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lc0DuUB8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lc0DuUB8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773138428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F74mGeS4/3xMiY/VwEEabl6hErMNoRRUVx7ASXgOwbI=;
	b=lc0DuUB8qQ03Y/+MwakD7USF5UwFaQ0xJBOtowV6Ie1B5N9qA50xRHbTjMra2tEEK56B+R
	wWB4piF5lOVH8ZhvbDu5CjMBVf39noxwlx9yxIrGqtxJCsxd4FxN+p4Ywv/UnOkaK2GNsD
	aIDzULWCCLkTbCahWmsny6LxtLb9fUw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Zipeng Zhang <zhangzipeng0@foxmail.com>,
	Kees Cook <kees@kernel.org>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ecryptfs: Log function name only once in decode_and_decrypt_filename
Date: Tue, 10 Mar 2026 11:26:53 +0100
Message-ID: <20260310102654.209016-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: ecryptfs@vger.kernel.org
List-Id: <ecryptfs.vger.kernel.org>
List-Subscribe: <mailto:ecryptfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ecryptfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=thorsten.blum@linux.dev; h=from:subject; bh=/JIaiXJ8+hehHjg1miPVUoV2YLxDXYRfp/WxLyC/Qk8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnrP77bEqz8deOuE70WDotE3MxL2XaHK2sFvX3Nenz7r mjTL3/KOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiNcKMDI3XPzgbMaf29Mmz JxZ/6v5buyD75eePk1ma7I4eZvkbNo+RYbeEpqT+7Q1zVt/5u3Bp1UzPrvCidTlvSp4pbA0s0NJ /yA0A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ecryptfs_printk() already prints the function name using %s and
__func__. Drop the redundant function name from the debug log message.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ecryptfs/crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 3b59346d68c5..d4e714912429 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1925,8 +1925,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 						  decoded_name_size);
 		if (rc) {
 			ecryptfs_printk(KERN_DEBUG,
-					"%s: Could not parse tag 70 packet from filename\n",
-					__func__);
+					"Could not parse tag 70 packet from filename\n");
 			goto out_free;
 		}
 	} else {
