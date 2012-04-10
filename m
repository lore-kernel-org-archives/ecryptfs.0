From: "Li Wang" <dragonylffly@163.com>
Subject: [RFC] eCryptfs file system with HMAC verification
Date: Tue, 10 Apr 2012 21:22:24 +0800
Message-ID: <000301cd171c$f8bb4cc0$ea31e640$@com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:41005 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab2DJNXp (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 10 Apr 2012 09:23:45 -0400
Content-Language: zh-cn
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>, dustin.kirkland@gazzang.com, torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

Hi,
  we have implemented a prototype, which equips eCryptfs with HMAC verification,
based on the kernel crypto API. This enables eCryptfs to detect unauthorized (cipher) 
data modification and unexpected data corruption. And the preliminary experiments 
demonstrate the decrease in throughput is modest. As a file system highlighting security,
we think it should be useful.
  Any comments/suggestions are welcome.

Cheers,
Li Wang

