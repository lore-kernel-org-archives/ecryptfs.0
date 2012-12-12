From: David Obadia <dav-ecryptfs@odav.org>
Subject: Wrapper to mount Private directories without root
Date: Wed, 12 Dec 2012 16:58:41 +0000 (UTC)
Message-ID: <loom.20121212T175359-906@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53346 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920Ab2LLQ74 (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Wed, 12 Dec 2012 11:59:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1TipfA-0002wr-GY
	for ecryptfs@vger.kernel.org; Wed, 12 Dec 2012 18:00:06 +0100
Received: from gdrpmi.208-53-158-116.dyn.lakeshoretel.com ([208.53.158.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Wed, 12 Dec 2012 18:00:04 +0100
Received: from dav-ecryptfs by gdrpmi.208-53-158-116.dyn.lakeshoretel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Wed, 12 Dec 2012 18:00:04 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Not sure why ecryptfs-recover-private requires root, I've found a way to do the
same thing without root.

Also I think it would be helpful to have a user friendly API for
creating/mounting/unmounting ecrypted folders that doesn't require root using
the setuid in mount.ecryptfs_private.

This is what this wrapper script attempts to achieve: 
http://paste.ubuntu.com/1427904/

Sample usage is in the header.

Cheers,
David-
