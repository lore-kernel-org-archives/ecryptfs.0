From: "Warren H. Prince" <wprince@princelaw.com>
Subject: size limitations?
Date: Thu, 3 Jan 2013 18:56:49 -0500
Message-ID: <2ADEBEF7-C8C5-40BE-A308-FDFEAC36BFC2@princelaw.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Transfer-Encoding: 8BIT
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from 70-91-46-201-philadelphia-pa.hfc.comcastbusiness.net ([70.91.46.201]:60919
	"EHLO mail.princelaw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab3ADAIX convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 3 Jan 2013 19:08:23 -0500
Received: from localhost (unknown [127.0.0.1])
	by mail.princelaw.com (Postfix) with ESMTP id 06285414DDB3
	for <ecryptfs@vger.kernel.org>; Thu,  3 Jan 2013 18:56:50 -0500 (EST)
Received: from mail.princelaw.com ([127.0.0.1])
	by localhost (mail.princelaw.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l5Y26msUJC8o for <ecryptfs@vger.kernel.org>;
	Thu,  3 Jan 2013 18:56:49 -0500 (EST)
Received: from [10.1.1.112] (unknown [10.1.1.112])
	by mail.princelaw.com (Postfix) with ESMTPSA id EAA63414DDAA
	for <ecryptfs@vger.kernel.org>; Thu,  3 Jan 2013 18:56:49 -0500 (EST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

I've read some posts about efficiency dropping with large numbers of encrypted files.  Is there any way to determine when encryptfs is no longer an appropriate solution?  For example, I have pretty well filled a 200 G AWS volume with pdf files.  I have no idea how many are there, but I do know I have close to 20K sub directories.  These files are all of a sensitive nature.  My guess would be that this is way too big to be an ecryptfs volume without very major overhead.  Am I correct?