From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: bcrypt or other key derivation algorithm
Date: Mon, 18 Jan 2016 11:51:36 +0100 (CET)
Message-ID: <477778683.231885.1453114296832.JavaMail.zimbra@halfgaar.net>
References: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:51925 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbcARKvl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 18 Jan 2016 05:51:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by meel.halfgaar.net (Postfix) with ESMTP id DF871182101
	for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 11:51:38 +0100 (CET)
Received: from meel.halfgaar.net ([127.0.0.1])
	by localhost (meel.halfgaar.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xRjFHN7xyhw7 for <ecryptfs@vger.kernel.org>;
	Mon, 18 Jan 2016 11:51:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by meel.halfgaar.net (Postfix) with ESMTP id A171118210F
	for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 11:51:37 +0100 (CET)
Received: from meel.halfgaar.net ([127.0.0.1])
	by localhost (meel.halfgaar.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6ljEAWfuivNd for <ecryptfs@vger.kernel.org>;
	Mon, 18 Jan 2016 11:51:37 +0100 (CET)
Received: from meel.halfgaar.net (meel.halfgaar.net [83.137.146.229])
	by meel.halfgaar.net (Postfix) with ESMTP id 50346182101
	for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 11:51:37 +0100 (CET)
In-Reply-To: <148109963.231852.1453113382610.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hi, 

What are the thoughts on implementing bcrypt as key derivation algorithm? I already found a TODO in the code that ecryptfs should support more algorithms than just SHA512 * 65536. I tried brute forcing this, and got no further than about 20/s, but on FPGAs/GPUs this would be a lot faster.

It should be easy enough to borrow code from OpenSSH, which uses bcrypt in their secure new private key file format (ssh-keygen -o; their old format is pretty weak (MD5 once, encrypt with AES 128)).

Questions:

1) The v2 wrapped does not have a field to indicate which algorithm is used (like /etc/shadow (crypt API) has). Does this necessitate a v3, which does have said field?

2) Are there objections to including BSD licensed code from OpenSSH?

Regards,

Wiebe
