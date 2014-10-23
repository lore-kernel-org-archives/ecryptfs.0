From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] eCryptfs: Remove unnecessary casts when parsing packet lengths
Date: Thu, 23 Oct 2014 10:38:27 -0400
Message-ID: <1414075107-28654-1-git-send-email-tyhicks@canonical.com>
References: <20141022075830.GE26918@mwanda>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55452 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764AbaJWOjE (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 23 Oct 2014 10:39:04 -0400
In-Reply-To: <20141022075830.GE26918@mwanda>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>

The elements in the data array are already unsigned chars and do not
need to be casted.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ecryptfs/keystore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 635e8e1..917bd5c 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -100,12 +100,12 @@ int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
 	(*size) = 0;
 	if (data[0] < 192) {
 		/* One-byte length */
-		(*size) = (unsigned char)data[0];
+		(*size) = data[0];
 		(*length_size) = 1;
 	} else if (data[0] < 224) {
 		/* Two-byte length */
-		(*size) = (((unsigned char)(data[0]) - 192) * 256);
-		(*size) += ((unsigned char)(data[1]) + 192);
+		(*size) = (data[0] - 192) * 256;
+		(*size) += data[1] + 192;
 		(*length_size) = 2;
 	} else if (data[0] == 255) {
 		/* If support is added, adjust ECRYPTFS_MAX_PKT_LEN_SIZE */
-- 
2.1.0
