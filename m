From: Michael Schneider <michael8schneider@gmail.com>
Subject: Will there be a multi CPU core version of eCryptfs?
Date: Thu, 14 Mar 2013 10:53:54 +0000 (UTC)
Message-ID: <loom.20130314T111312-931@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44334 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959Ab3CNK7r (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Thu, 14 Mar 2013 06:59:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1UG5tF-0006ro-Bo
	for ecryptfs@vger.kernel.org; Thu, 14 Mar 2013 12:00:05 +0100
Received: from HSI-KBW-5-10-164-97.hsi19.kabel-badenwuerttemberg.de ([HSI-KBW-5-10-164-97.hsi19.kabel-badenwuerttemberg.de])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Thu, 14 Mar 2013 12:00:05 +0100
Received: from michael8schneider by HSI-KBW-5-10-164-97.hsi19.kabel-badenwuerttemberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Thu, 14 Mar 2013 12:00:05 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hello,

When using eCryptfs on a low end devices like NASs, 
the CPU is often limiting the performance of reading/writing dramatically
because of the intense cryptographic workload.

I know that using cryptography on such systems is always a trade off,
 but I ask myself about a possible optimization which would help very much:

On my NAS the throughput with eCryptfs drops by about 70% 
(Synology DS412+, Atom D2700 - 2 Cores, Hyperthreading).

For non-encrypted operation the CPU nearly idles, when using eCryptfs
its at about 25% load. I assume that only one of the possible
four parallel CPU threads are used. 

My question is "Will there be a multi CPU core version?" which would improve
performance on low powered CPUs.

I don't know, if this is the right place to ask, but it would be great
if any of the developers could give me feedback if this will be possible
in the future - crossing fingers :)

Thanks.

Best regards,
Michael
