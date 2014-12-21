From: Eric Lan <tenoreamer@gmail.com>
Subject: Feature Request: solving too long filenames
Date: Sun, 21 Dec 2014 16:53:30 +0000 (UTC)
Message-ID: <loom.20141221T174607-634@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51482 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaLUQzF (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 21 Dec 2014 11:55:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1Y2jmZ-000679-Ij
	for ecryptfs@vger.kernel.org; Sun, 21 Dec 2014 17:55:04 +0100
Received: from 1-175-118-93.dynamic.hinet.net ([1.175.118.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Sun, 21 Dec 2014 17:55:03 +0100
Received: from tenoreamer by 1-175-118-93.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Sun, 21 Dec 2014 17:55:03 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Is it reasonable for eCryptfs to manage a long filename (especially those
longer than 140 bytes) by specifying a short identifier followed by a serial
or sequence number  (i.e. ECRYPTFS_#####) and putting the true encrypted
filename in the header of that encrypted file?
