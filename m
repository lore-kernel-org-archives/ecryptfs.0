From: Martin Steigerwald <ms@teamix.de>
Subject: Re: rsync copies twice
Date: Tue, 20 Dec 2011 10:50:30 +0100
Message-ID: <201112201050.30557.ms@teamix.de>
References: <201112191417.38799.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:35550 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752053Ab1LTJue (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Dec 2011 04:50:34 -0500
Received: from zimbra.of.teamix.net (unknown [172.21.242.23])
	by rproxy.teamix.net (Postfix) with ESMTP id 252017F39
	for <ecryptfs@vger.kernel.org>; Tue, 20 Dec 2011 10:50:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.of.teamix.net (Postfix) with ESMTP id 16A5C146CAC
	for <ecryptfs@vger.kernel.org>; Tue, 20 Dec 2011 10:50:33 +0100 (CET)
Received: from zimbra.of.teamix.net ([127.0.0.1])
	by localhost (zimbra.of.teamix.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70RkJQdeZ7Nx for <ecryptfs@vger.kernel.org>;
	Tue, 20 Dec 2011 10:50:32 +0100 (CET)
Received: from mango.localnet (mango.of.teamix.net [172.21.123.1])
	by zimbra.of.teamix.net (Postfix) with ESMTPSA id A679C146BB8
	for <ecryptfs@vger.kernel.org>; Tue, 20 Dec 2011 10:50:32 +0100 (CET)
In-Reply-To: <201112191417.38799.ms@teamix.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Am Montag, 19. Dezember 2011 schrieben Sie:
> Hi!
> 
> I used something like
> 
> rsync -a -H --acls --xattrs -S -P /home/ms2/ /home/ms
> 
> to migrate my data from encfs to ecryptfs where ms2 is the mounted encfs
> and ms is the mounted ecryptfs.
> 
> This appeared to have worked.
> 
> But: When I run the rsync again it will copy all files once again, while it
> should notice that they are already copied and do not copy them again.

This also is an issue that only appears when storing metadata in extended 
attributes. When storing them in the files itself on the second rsync attempt I 
get:

merkaba:~> rsync -a -H --acls -S -P /home/ms2/ /home/ms/               
sending incremental file list

sent 2920748 bytes  received 9094 bytes  177566.18 bytes/sec
total size is 13239183088  speedup is 4518.74

Thus this is probably another testcase for ecryptfs. Rsync twicing and see 
whether the second time rsync still transfers files or not.

I am now feeling much more confident about ecryptfs. I do like when rsync 
behaves this way ;).

Ciao,
-- 
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
