From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] eCryptfs: use list_for_each_safe() when the loop involves
 delete items
Date: Tue, 21 Aug 2012 08:38:14 +0800
Message-ID: <CAPgLHd_S3EcvrE+wCd7VMmwUqioX1vOpO54xcxL2o=gp9hHAhA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46290 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab2HUAiP (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 Aug 2012 20:38:15 -0400
Received: by qaas11 with SMTP id s11so3305468qaa.19
        for <ecryptfs@vger.kernel.org>; Mon, 20 Aug 2012 17:38:14 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tyhicks@canonical.com, dustin.kirkland@gazzang.com
Cc: yongjun_wei@trendmicro.com.cn, ecryptfs@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>


From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Since we will be removing items off the list using list_del() we need
to use a safer version of the list_for_each() macro aptly named
list_for_each_safe(). Note that we MUST use this macro if the loop
involves deletions of items (or moving items from one list to another).

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 fs/ecryptfs/kthread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index 809e67d..072ceee 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -102,11 +102,11 @@ int __init ecryptfs_init_kthread(void)
 
 void ecryptfs_destroy_kthread(void)
 {
-	struct ecryptfs_open_req *req;
+	struct ecryptfs_open_req *req, *tmp;
 
 	mutex_lock(&ecryptfs_kthread_ctl.mux);
 	ecryptfs_kthread_ctl.flags |= ECRYPTFS_KTHREAD_ZOMBIE;
-	list_for_each_entry(req, &ecryptfs_kthread_ctl.req_list,
+	list_for_each_entry_safe(req, tmp, &ecryptfs_kthread_ctl.req_list,
 			    kthread_ctl_list) {
 		list_del(&req->kthread_ctl_list);
 		*req->lower_file = ERR_PTR(-EIO);

