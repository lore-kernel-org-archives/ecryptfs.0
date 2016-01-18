From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: Key derivation and passprhase wrapping
Date: Mon, 18 Jan 2016 11:27:37 +0100 (CET)
Message-ID: <676716416.231851.1453112857325.JavaMail.zimbra@halfgaar.net>
References: <794484591.224591.1452104561446.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:51805 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbcARKct (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 18 Jan 2016 05:32:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by meel.halfgaar.net (Postfix) with ESMTP id 5C845182101
	for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 11:27:42 +0100 (CET)
Received: from meel.halfgaar.net ([127.0.0.1])
	by localhost (meel.halfgaar.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Wk7rpw2Z4SgJ for <ecryptfs@vger.kernel.org>;
	Mon, 18 Jan 2016 11:27:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by meel.halfgaar.net (Postfix) with ESMTP id 2DDA118210F
	for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 11:27:38 +0100 (CET)
Received: from meel.halfgaar.net ([127.0.0.1])
	by localhost (meel.halfgaar.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rsVzJ06FrucU for <ecryptfs@vger.kernel.org>;
	Mon, 18 Jan 2016 11:27:37 +0100 (CET)
Received: from meel.halfgaar.net (meel.halfgaar.net [83.137.146.229])
	by meel.halfgaar.net (Postfix) with ESMTP id CB3EE182101
	for <ecryptfs@vger.kernel.org>; Mon, 18 Jan 2016 11:27:37 +0100 (CET)
In-Reply-To: <794484591.224591.1452104561446.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hi, 

I was looking at the ecryptfs source code, and saw that the actual encryption key inserted into the kernel keyring is the *original* wrapped passphrase, SHA512'ed 65536 times. Why is a user-given passphrase encrypted as key, and not data from /dev/random? I unwrapped the passphrase on my Linux Mint system and saw it is actually a random string, so the Ubuntu/Mint installer took care of it for me. But why is that responsibility given to the user / outside world? One of the problems is that I can't change it. Had I made a ecryptfs archive myself and wrapped 'hello' as passphrase, that weak key will be used and cannot be changed by rewrapping.

Would it be possible/feasible to do something like:

* generate random encryption key A for insertion into kernel keyring.
* derive encryption key B from password with 'generate_passphrase_sig(...)' to encrypt key A.
* In v2 wrapped passphrase file, Octets 26-N1, store encrypted A, instead of encrypted passphrase.

Depending on how it's implemented, it could even be done completely backwards compatible (by ignoring the to-wrap passphrase).

Regards,

Wiebe
