From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 25/31] fs: ecryptfs: messaging: Add missing param descriptions and demote abuses
Date: Tue, 30 Mar 2021 17:44:52 +0100
Message-ID: <20210330164458.1625478-26-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhC3Qp2 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 30 Mar 2021 12:45:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF1C061762
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so16872464wrq.11
        for <ecryptfs@vger.kernel.org>; Tue, 30 Mar 2021 09:45:27 -0700 (PDT)
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, David Howells <dhowells@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, "Michael A. Halcrow" <mhalcrow@us.ibm.com>, ecryptfs@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/messaging.c:15: warning: Function parameter or member 'ecryptfs_msg_ctx_free_list' not described in 'LIST_HEAD'
 fs/ecryptfs/messaging.c:15: warning: expecting prototype for eCryptfs(). Prototype was for LIST_HEAD() instead
 fs/ecryptfs/messaging.c:157: warning: Function parameter or member 'daemon' not described in 'ecryptfs_exorcise_daemon'
 fs/ecryptfs/messaging.c:207: warning: Function parameter or member 'daemon' not described in 'ecryptfs_process_response'
 fs/ecryptfs/messaging.c:207: warning: expecting prototype for ecryptfs_process_reponse(). Prototype was for ecryptfs_process_response() instead
 fs/ecryptfs/messaging.c:262: warning: Function parameter or member 'msg_type' not described in 'ecryptfs_send_message_locked'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael A. Halcrow" <mhalcrow@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/messaging.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index c0dfd9647627a..b38bd742fd973 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2004-2008 International Business Machines Corp.
@@ -147,7 +147,7 @@ ecryptfs_spawn_daemon(struct ecryptfs_daemon **daemon, struct file *file)
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_exorcise_daemon - Destroy the daemon struct
  *
  * Must be called ceremoniously while in possession of
@@ -181,7 +181,8 @@ int ecryptfs_exorcise_daemon(struct ecryptfs_daemon *daemon)
 }
 
 /**
- * ecryptfs_process_reponse
+ * ecryptfs_process_response
+ * @daemon: eCryptfs daemon object
  * @msg: The ecryptfs message received; the caller should sanity check
  *       msg->data_len and free the memory
  * @seq: The sequence number of the message; must match the sequence
@@ -250,6 +251,7 @@ int ecryptfs_process_response(struct ecryptfs_daemon *daemon,
  * ecryptfs_send_message_locked
  * @data: The data to send
  * @data_len: The length of data
+ * @msg_type: Type of message
  * @msg_ctx: The message context allocated for the send
  *
  * Must be called with ecryptfs_daemon_hash_mux held.
-- 
2.27.0

