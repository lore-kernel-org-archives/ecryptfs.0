From: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] ecryptfs: fix kernel panic with null dev_name
Date: Fri, 26 Feb 2021 15:00:23 -0600
Message-ID: <20210226210023.77597-1-jeffrey.mitchell@starlab.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bl2gcc02on2131.outbound.protection.outlook.com ([40.107.89.131]:23904
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230434AbhBZVBk (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 26 Feb 2021 16:01:40 -0500
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Mitchell <jeffrey.mitchell@starlab.io>

When mounting eCryptfs, a null "dev_name" argument to ecryptfs_mount()
causes a kernel panic if the parsed options are valid. The easiest way to
reproduce this is to call mount() from userspace with an existing
eCryptfs mount's options and a "source" argument of 0.

Error out if "dev_name" is null in ecryptfs_mount()

Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
---
 fs/ecryptfs/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index e63259fdef28..b2f6a1937d23 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -492,6 +492,12 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 		goto out;
 	}
 
+	if (!dev_name) {
+		rc = -EINVAL;
+		err = "Device name cannot be null";
+		goto out;
+	}
+
 	rc = ecryptfs_parse_options(sbi, raw_data, &check_ruid);
 	if (rc) {
 		err = "Error parsing options";
-- 
2.25.1

