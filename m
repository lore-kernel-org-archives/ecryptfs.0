From: Sylvain Pelissier <sylvain.pelissier@gmail.com>
Subject: Changing salt value
Date: Tue, 10 Feb 2015 10:04:07 +0100
Message-ID: <CAOkUe-CMpJNpStZTOPnASaiEA8VC3kJAqKMBon6xodRgMJ5A1A@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:48573 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbbBJJEJ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 10 Feb 2015 04:04:09 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so31833262wgh.10
        for <ecryptfs@vger.kernel.org>; Tue, 10 Feb 2015 01:04:08 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

 Hi,

I am trying to change the default salt value used by ecryptfs-utils to
wrapped the encryption key stored in
"/home/.ecryptfs/user/.ecryptfs/wrapped-passphrase". I'm using Ubuntu
14.04 with the complete home folder encryption. I created a file
.ecryptfsrc in the unencrypted home folder of the user which contains:

salt=04ae48987b177f01

Then I wrap the passphrase key with the tool
ecryptfs-unwrap-passphrase, I noticed that the result has changed and
thus I think it uses the new salt value. However, when I replace the
file /home/.ecryptfs/user/.ecryptfs/wrapped-passphrase with the new
one, then when I log with the user credential I have the error telling
that the key is not in the kernel keyring.
Did I miss something ?

Sylvain
