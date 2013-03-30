From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Subject: async crashes
Date: Sat, 30 Mar 2013 15:57:10 +0200
Message-ID: <1364651830.2286.140661211073081.738964DE@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39897 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755620Ab3C3N5L (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sat, 30 Mar 2013 09:57:11 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DA75920A20
	for <ecryptfs@vger.kernel.org>; Sat, 30 Mar 2013 09:57:10 -0400 (EDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hi

I've been experimenting with async branch of ecryptfs for some
workloads. Sometimes it crashes so that ecryptfs_encrypt_extent_done()
first reports -EINPROGRESS (-115) to kernel log. After that it crashes
in ablkcipher_walk_phys().

I looked at ecryptfs_encrypt_extent_done() and this made me think
whether it should have special case for having -EBUSY and -EINPROGRESS.

Sorry about bit coares "bug report" but I'm not expert either with
ecryptfs or crypto implementation.

Thanks.

/Jarkko
