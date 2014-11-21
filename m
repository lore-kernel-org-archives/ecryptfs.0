From: Michael Halcrow <mhalcrow@google.com>
Subject: [PATCH] eCryptfs: Allocate sufficient buffer space for encrypted filename decoding
Date: Fri, 21 Nov 2014 09:02:03 -0800
Message-ID: <1416589323-4762-1-git-send-email-mhalcrow@google.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pd0-f201.google.com ([209.85.192.201]:63915 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836AbaKURCV (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 21 Nov 2014 12:02:21 -0500
Received: by mail-pd0-f201.google.com with SMTP id ft15so884063pdb.4
        for <ecryptfs@vger.kernel.org>; Fri, 21 Nov 2014 09:02:20 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: dmitryc@google.com, ecryptfs@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>

Dmitry Chernenkov used KASAN to discover that eCryptfs writes past the
end of the allocated buffer during encrypted filename decoding. This
fix corrects the issue by ensuring that there is sufficient buffer
space allocated.

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
---
 fs/ecryptfs/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 2f6735d..53d4f2e 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1871,7 +1871,7 @@ static size_t ecryptfs_max_decoded_size(size_t encoded_size)
 	 * the caller with the maximum amount of allocated
 	 * space that @dst will need to point to in a
 	 * subsequent call. */
-	return ((encoded_size + 1) * 3) / 4;
+	return (((encoded_size + 1) * 3) / 4) + 1;
 }
 
 /**
-- 
2.1.0.rc2.206.gedb03e5
