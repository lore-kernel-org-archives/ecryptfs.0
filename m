From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH] MAINTAINERS: eCryptfs: Update maintainer address and downgrade status
Date: Thu, 13 Feb 2020 21:23:06 +0000
Message-ID: <20200213212306.19693-1-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57339 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgBMVX2 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 13 Feb 2020 16:23:28 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Adjust my email address to a personal account. Downgrade the status of
eCryptfs maintenance to 'Odd Fixes' since it has not been part of my
work responsibilities recently and I've had little personal time to
devote to it.

eCryptfs hasn't seen active development in some time. New deployments of
file level encryption should use more modern solutions, such as fscrypt,
where possible.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..e56936dc7c1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5932,12 +5932,12 @@ S:	Maintained
 F:	drivers/media/dvb-frontends/ec100*
 
 ECRYPT FILE SYSTEM
-M:	Tyler Hicks <tyhicks@canonical.com>
+M:	Tyler Hicks <code@tyhicks.com>
 L:	ecryptfs@vger.kernel.org
 W:	http://ecryptfs.org
 W:	https://launchpad.net/ecryptfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git
-S:	Supported
+S:	Odd Fixes
 F:	Documentation/filesystems/ecryptfs.txt
 F:	fs/ecryptfs/
 
-- 
2.17.1

