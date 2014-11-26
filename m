From: Michael Halcrow <mhalcrow@google.com>
Subject: [PATCH] eCryptfs: Remove buggy and unnecessary write in file name decode routine
Date: Wed, 26 Nov 2014 09:09:16 -0800
Message-ID: <1417021756-30233-1-git-send-email-mhalcrow@google.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-yk0-f202.google.com ([209.85.160.202]:43271 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaKZRRy (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Nov 2014 12:17:54 -0500
Received: by mail-yk0-f202.google.com with SMTP id 9so178686ykp.5
        for <ecryptfs@vger.kernel.org>; Wed, 26 Nov 2014 09:17:54 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com
Cc: dmitryc@google.com, keescook@google.com, ecryptfs@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>

Dmitry Chernenkov used KASAN to discover that eCryptfs writes past the
end of the allocated buffer during encrypted filename decoding. This
fix corrects the issue by getting rid of the unnecessary 0 write when
the current bit offset is 2.

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
---
 fs/ecryptfs/crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 2f6735d..31b148f 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1917,7 +1917,6 @@ ecryptfs_decode_from_filename(unsigned char *dst, size_t *dst_size,
 			break;
 		case 2:
 			dst[dst_byte_offset++] |= (src_byte);
-			dst[dst_byte_offset] = 0;
 			current_bit_offset = 0;
 			break;
 		}
-- 
2.2.0.rc0.207.ga3a616c
