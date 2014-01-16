From: Tom Vaughan <thomas.david.vaughan@gmail.com>
Subject: How best to crack wrapped-passphrase?
Date: Wed, 15 Jan 2014 21:04:22 -0300
Message-ID: <CAH7xHdguBuyLOZG8ubR1M9ftgLPJRPz5nAsZnpG4qnqAXX4=Tg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49085 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbaAPAEX (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 15 Jan 2014 19:04:23 -0500
Received: by mail-wi0-f176.google.com with SMTP id hi8so1502764wib.15
        for <ecryptfs@vger.kernel.org>; Wed, 15 Jan 2014 16:04:22 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

I'm running Ubuntu 13.10 with an encrypted, private home directory. I
changed my password today via the Ubuntu control center. I either
don't remember the password, or the password utility used a password
other than the one I entered. I attempted to change my password a
second time, but all methods I tried required that I know my current
password. So I rebooted into recovery mode, re-mounted / in read-write
mode, ran passwd, and all was well, or so I thought.

Now it seems as though wrapped-passphrase is wrapped with whatever the
new password is (whatever password was used on my first attempt to
change it). Yes, I did save the encryption key, but that doesn't work
with ecrpytfs-recover-private. Perhaps I wrote it down incorrectly.
Yes, I should have verified it somehow. But I didn't. Also, there is
no copy of the new password in /etc/shadow-.

I don't care if it takes a long time, as I'm sure it will. What's the
best method for cracking wrapped-passphrase?

Thanks.

-Tom
