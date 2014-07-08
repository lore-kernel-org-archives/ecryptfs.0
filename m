From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] ecryptfs: remove unnecessary break after goto
Date: Tue,  8 Jul 2014 18:30:07 +0200
Message-ID: <1404837007-7089-1-git-send-email-fabf@skynet.be>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:22807 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754710AbaGHQaL (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 8 Jul 2014 12:30:11 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org

Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/ecryptfs/keystore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 4725a07..8f0d619 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1846,7 +1846,6 @@ int ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 					"(Tag 11 not allowed by itself)\n");
 			rc = -EIO;
 			goto out_wipe_list;
-			break;
 		default:
 			ecryptfs_printk(KERN_DEBUG, "No packet at offset [%zd] "
 					"of the file header; hex value of "
-- 
1.8.4.5
