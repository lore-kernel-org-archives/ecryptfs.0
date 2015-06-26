From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] eCryptfs: Delete a check before the function call "key_put"
Date: Fri, 26 Jun 2015 18:25:09 +0200
Message-ID: <558D7CE5.1090205@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:54295 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbbFZQZN (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Fri, 26 Jun 2015 12:25:13 -0400
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 26 Jun 2015 18:18:54 +0200

The key_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around this call might not be needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/ecryptfs/crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 97315f2..80d6901 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -258,8 +258,7 @@ void ecryptfs_destroy_mount_crypt_stat(
 				 &mount_crypt_stat->global_auth_tok_list,
 				 mount_crypt_stat_list) {
 		list_del(&auth_tok->mount_crypt_stat_list);
-		if (auth_tok->global_auth_tok_key
-		    && !(auth_tok->flags & ECRYPTFS_AUTH_TOK_INVALID))
+		if (!(auth_tok->flags & ECRYPTFS_AUTH_TOK_INVALID))
 			key_put(auth_tok->global_auth_tok_key);
 		kmem_cache_free(ecryptfs_global_auth_tok_cache, auth_tok);
 	}
-- 
2.4.4
