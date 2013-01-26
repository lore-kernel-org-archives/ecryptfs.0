From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] eCryptfs: remove unneeded checks in virt_to_scatterlist()
Date: Sat, 26 Jan 2013 10:48:42 +0300
Message-ID: <20130126074842.GA14365@elgon.mountain>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49661 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab3AZHsu (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 26 Jan 2013 02:48:50 -0500
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org

This is always called with a valid "sg" pointer.  My static checker
complains because the call to sg_init_table() dereferences "sg" before
we reach the checks.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index a7b0c2d..d5c25db 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -301,17 +301,14 @@ int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
 	while (size > 0 && i < sg_size) {
 		pg = virt_to_page(addr);
 		offset = offset_in_page(addr);
-		if (sg)
-			sg_set_page(&sg[i], pg, 0, offset);
+		sg_set_page(&sg[i], pg, 0, offset);
 		remainder_of_page = PAGE_CACHE_SIZE - offset;
 		if (size >= remainder_of_page) {
-			if (sg)
-				sg[i].length = remainder_of_page;
+			sg[i].length = remainder_of_page;
 			addr += remainder_of_page;
 			size -= remainder_of_page;
 		} else {
-			if (sg)
-				sg[i].length = size;
+			sg[i].length = size;
 			addr += size;
 			size = 0;
 		}
