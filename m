From: Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 0/3] eCryptfs: Fix and cleanup miscdev read and write functions
Date: Fri, 20 Jan 2012 13:29:09 -0600
Message-ID: <1327087752-17310-1-git-send-email-tyhicks@canonical.com>
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33425 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab2ATT37 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 20 Jan 2012 14:29:59 -0500
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: Sasha Levin <levinsasha928@gmail.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

As Andrew mentioned[1], ecryptfs_miscdev_write() should do better sanitization
of the write count. While adding that, I ran into a few other needed
improvements. The first patch is intended to go to stable (which is why it
continues the trend of using magic numbers), while the other two are less
important and I'll only target them for only 3.3-rc1.

Tyler

[1] https://lkml.org/lkml/2012/1/11/394
