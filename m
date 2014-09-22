From: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
Subject: Practical questions about locking and re-encrypting
Date: Mon, 22 Sep 2014 17:32:57 +0200
Message-ID: <20140922173257.Horde.aPhFRVyqiOZUIEEpuKgAfuA@webmail.ugent.be>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtp2.ugent.be ([157.193.49.126]:42325 "EHLO smtp2.ugent.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbaIVPn3 (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 22 Sep 2014 11:43:29 -0400
Received: from localhost (mcheck2.ugent.be [157.193.49.249])
	by smtp2.ugent.be (Postfix) with ESMTP id 96DCF12C493
	for <ecryptfs@vger.kernel.org>; Mon, 22 Sep 2014 17:33:02 +0200 (CEST)
Received: from smtp2.ugent.be ([IPv6:::ffff:157.193.49.126])
	by localhost (mcheck2.UGent.be [::ffff:157.193.43.11]) (amavisd-new, port 10024)
	with ESMTP id npqjtG9Rfyz4 for <ecryptfs@vger.kernel.org>;
	Mon, 22 Sep 2014 17:32:58 +0200 (CEST)
Received: from emilio.ugent.be (emilio.ugent.be [157.193.47.117])
	by smtp2.ugent.be (Postfix) with ESMTP id 0947F12C48E
	for <ecryptfs@vger.kernel.org>; Mon, 22 Sep 2014 17:32:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by emilio.ugent.be (Postfix) with ESMTP id E3A537DCD9
	for <ecryptfs@vger.kernel.org>; Mon, 22 Sep 2014 17:32:57 +0200 (CEST)
Content-Disposition: inline
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="Yes"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi all,


We want to use ecryptfs on GPFS. How does ecryptfs handles locking if  
an encrypted directory is mounted on different boxes ? Is data  
corruption possible while writing?

Another question: Is there an easy way to re-encrypt a directory with  
another key? (when having compromised key or so).


Thank you!!

Kenneth

