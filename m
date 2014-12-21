From: Eric Lan <tenoreamer@gmail.com>
Subject: 32-byte encryption key for ecryptfs-setup-private ?
Date: Sun, 21 Dec 2014 16:57:21 +0000 (UTC)
Message-ID: <loom.20141221T175441-142@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51692 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbaLURAG (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 21 Dec 2014 12:00:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1Y2jrQ-0001Yg-0R
	for ecryptfs@vger.kernel.org; Sun, 21 Dec 2014 18:00:04 +0100
Received: from 1-175-118-93.dynamic.hinet.net ([1.175.118.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Sun, 21 Dec 2014 18:00:03 +0100
Received: from tenoreamer by 1-175-118-93.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Sun, 21 Dec 2014 18:00:03 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

The default key-bytes for ecryptfs-setup-private is 16 bytes. I tried to
change "KEYBYTES" in ecryptfs-setup-private to "32" but failed when running
the script.

How about offering options for the users to determine "encryption
parameters" (like encryption algorithm, encryption key bytes, etc.) ? Or is
there a workaround now ?
