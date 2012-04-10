From: "Li Wang" <liwang@nudt.edu.cn>
Subject: [RFC] eCryptfs file system with HMAC verification
Date: Tue, 10 Apr 2012 21:26:58 +0800
Message-ID: <534063324.06707@eyou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.nudt.edu.cn ([61.187.54.11]:45199 "HELO eyou.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752762Ab2DJN1R (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 10 Apr 2012 09:27:17 -0400
Message-ID: <000a01cd171d$9e6c23b0$db446b10$@edu.cn>
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
