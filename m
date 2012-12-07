From: Cong Ding <dinggnu@gmail.com>
Subject: [PATCH] fs/ecryptfs/crypto.c: make ecryptfs_encode_for_filename() static
Date: Fri,  7 Dec 2012 22:21:56 +0000
Message-ID: <1354918916-31587-1-git-send-email-dinggnu@gmail.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45196 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab2LGWWG (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 7 Dec 2012 17:22:06 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Cong Ding <dinggnu@gmail.com>

the function ecryptfs_encode_for_filename() is only used in this file

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 fs/ecryptfs/crypto.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ea99312..a7b0c2d 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1935,7 +1935,7 @@ static const unsigned char filename_rev_map[256] = {
  * @src: Source location for the filename to encode
  * @src_size: Size of the source in bytes
  */
-void ecryptfs_encode_for_filename(unsigned char *dst, size_t *dst_size,
+static void ecryptfs_encode_for_filename(unsigned char *dst, size_t *dst_size,
 				  unsigned char *src, size_t src_size)
 {
 	size_t num_blocks;
-- 
1.7.4.5
