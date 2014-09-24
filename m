From: Christian =?ISO-8859-1?Q?St=FCble?= <stueble@sirrix.com>
Subject: Separating different ecryptfs mounts
Date: Wed, 24 Sep 2014 10:50:57 +0200
Message-ID: <6009718.QGyqnh1K9Q@hp-stueble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx.sirrix.com ([176.9.214.66]:56168 "EHLO mx.sirrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbaIXJJq (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Wed, 24 Sep 2014 05:09:46 -0400
Received: from [172.25.20.101] (helo=exchange2010.sirrix.de)
	by mx.sirrix.com with esmtp (Exim 4.76)
	(envelope-from <c.stueble@sirrix.com>)
	id 1XWiHq-0008Ii-Fp
	for ecryptfs@vger.kernel.org; Wed, 24 Sep 2014 10:50:58 +0200
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: ecryptfs@vger.kernel.org

Hi,

is it possible with ecryptfs to have two different ecryptfs mounts, e.g.,

plain1 -> raw1
plain2 -> raw2

using two different openssl keys, and to ensure that each key is _only_
used by its own mount? That is, I want to prevent that files copied between 
raw1 and raw2 are automatically decrypted. 

To my understanding of the IBM paper about ecryptfs, it should be possible to 
set a policy defining which mount is allowed to use which key, but I could not 
find any documentation about it. 

When it is possible, can you explain or point me to some docs describing how I 
can do this?

Thanks,
Chris

