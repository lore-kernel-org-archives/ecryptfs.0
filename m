From: Martin Steigerwald <ms@teamix.de>
Subject: rsync copies twice
Date: Mon, 19 Dec 2011 14:17:38 +0100
Message-ID: <201112191417.38799.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:37686 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974Ab1LSNRn (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 08:17:43 -0500
Received: from zimbra.of.teamix.net (unknown [172.21.242.23])
	by rproxy.teamix.net (Postfix) with ESMTP id AAA7D7EEA
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 14:17:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.of.teamix.net (Postfix) with ESMTP id 9C279146C9D
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 14:17:41 +0100 (CET)
Received: from zimbra.of.teamix.net ([127.0.0.1])
	by localhost (zimbra.of.teamix.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aRVtNV7C8A2j for <ecryptfs@vger.kernel.org>;
	Mon, 19 Dec 2011 14:17:41 +0100 (CET)
Received: from mango.localnet (mango.of.teamix.net [172.21.123.1])
	by zimbra.of.teamix.net (Postfix) with ESMTPSA id 4E57A146C87
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 14:17:41 +0100 (CET)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hi!

I used something like

rsync -a -H --acls --xattrs -S -P /home/ms2/ /home/ms

to migrate my data from encfs to ecryptfs where ms2 is the mounted encfs and 
ms is the mounted ecryptfs.

This appeared to have worked.

But: When I run the rsync again it will copy all files once again, while it 
should notice that they are already copied and do not copy them again.

Is there any known issue with ecryptfs and rsync? Might also be an issue with 
encfs as source filesystem tough. I am now copying my encfs to another machine 
via rsync+ssh onto a BTRFS filesystem to verify this. Okay, this works. On the 
second attempt no files are copied anymore. So it seems that it is an ecryptfs 
issue.

Together with the reported failure to create new files under certain 
circumstances and the more complicated handling for now I switch back to encfs 
even though it might be slower.

But I am willing to test again. Most importantly with a fix for the file 
creation issue I reported.

Thanks,
-- 
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
