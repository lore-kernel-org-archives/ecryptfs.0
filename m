From: Tom Browder <tom.browder@gmail.com>
Subject: Recovering Encrypted Directory
Date: Sun, 15 Jun 2014 20:53:27 -0500
Message-ID: <CAFMGiz9oy-G5THvZ=cdXuksA+J2Kd3OaQqPLXEjGTVxw2pEEoQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44318 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbaFPByJ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 15 Jun 2014 21:54:09 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so5066186wes.33
        for <ecryptfs@vger.kernel.org>; Sun, 15 Jun 2014 18:54:07 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

I have successfully recovered an encrypted directory, but read-only
and not mounted in the desired Private directory.  Following
instructions found in various places I have done the following:

The original encrypted system is at "/usr/local/people/user/.Private":

$ cd /usr/local/people/user
$ su
#
root@host:/home/user# ecryptfs-recover-private --rw
/usr/local/people/user/.Private
INFO: Searching for encrypted private directories (this might take a while)...
INFO: Found [/usr/local/people/user/.Private].
Try to recover this directory? [Y/n]:
INFO: Found your wrapped-passphrase
Do you know your LOGIN passphrase? [Y/n]
INFO: Enter your LOGIN passphrase...
Passphrase:
Inserted auth tok with sig [c14bc7a7948c5a32] into the user session keyring
INFO: Success!  Private data mounted read-only at [/tmp/ecryptfs.A6A68CJS].

I am able to get all my data but:

1.  The "--rw' option didn't work, nor did the explicit file name work
for "ecryptfs-recover-private".

2.  I can't figure out how to get back to normal operations.

I can read all the data in the ro tmp mount, so I could copy out all
the data and start over again, but is there an easier way to fully
recover?

Thanks.

Best regards,

-Tom
