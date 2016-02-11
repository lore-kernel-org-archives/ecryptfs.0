From: tmg <t.m.gerlach@freenet.de>
Subject: File recovery via testdisk / photorec
Date: Thu, 11 Feb 2016 21:15:23 +0000 (UTC)
Message-ID: <loom.20160211T215847-237@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46647 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbcBKVkG (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Thu, 11 Feb 2016 16:40:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1aTyy3-0002Q1-MA
	for ecryptfs@vger.kernel.org; Thu, 11 Feb 2016 22:40:03 +0100
Received: from dslb-188-104-158-193.188.104.pools.vodafone-ip.de ([188.104.158.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Thu, 11 Feb 2016 22:40:03 +0100
Received: from t.m.gerlach by dslb-188-104-158-193.188.104.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Thu, 11 Feb 2016 22:40:03 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Dear developers and users,

I've searched a lot around the web, but didn't find any satisfying answer.
Consider the following situation:

- You have your home directory /home/<user> encrypted with ecryptfs
- You know your passphrase, that is, no trouble to decrypt the directory

Question: How do you recover deleted files from the mounted (decrypted) home 
or the ecryptfs container?

All the ecryptfs recover strategies I've read so far were like
- use a livecd
- go and fire ecryptfs-recover-private, and mount your home readonly
- copy your files to a save place

But what about files that I can't regularly copy, because they are deleted?

If it was an unencrypted ext4, I would do (using ubuntu)
$ dd if=/dev/sda of=/media/user/sda.img
$ testdisk /media/user/sda.img

Can we run testdisk on the .ecryptfs container, or even the mounted home?


Thank you for any suggestion and best regards,

TMG
