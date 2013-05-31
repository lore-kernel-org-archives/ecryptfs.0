From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: [PATCH] Update eCryptFS maintainers
Date: Fri, 31 May 2013 10:41:43 -0500
Message-ID: <CANT6BaPY6Ax+agTQs0eTKMY2tcKad31=jpLVhZJfaL=s9J2o=Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44736 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab3EaPlp (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 31 May 2013 11:41:45 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so1842555lbd.15
        for <ecryptfs@vger.kernel.org>; Fri, 31 May 2013 08:41:44 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler C Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gmail.com>, ecryptfs@vger.kernel.org

Remove myself from the eCryptFS kernel maintainers.

Add the ecryptfs.org website.

I will continue to actively maintain and monitor the ecryptfs-utils
user space project and packages.

Signed-off-by: Dustin Kirkland <dustin.kirkland@gazzang.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7714c3c..19ddd7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2890,8 +2890,8 @@ F:	drivers/media/dvb-frontends/ec100*

 ECRYPT FILE SYSTEM
 M:	Tyler Hicks <tyhicks@canonical.com>
-M:	Dustin Kirkland <dustin.kirkland@gazzang.com>
 L:	ecryptfs@vger.kernel.org
+W:	http://ecryptfs.org
 W:	https://launchpad.net/ecryptfs
 S:	Supported
 F:	Documentation/filesystems/ecryptfs.txt
-- 
1.7.9.5
