From: Artur Rataj <arturrataj@gmail.com>
Subject: Did I lost an encrypted folder?
Date: Sun, 15 Dec 2013 15:20:41 +0100
Message-ID: <CACO3_sCk-hX=-eoyHs3CFkqNMHAnvrOhi-r5CFyDS0=xWQdPGg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:51938 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3LOOUm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 15 Dec 2013 09:20:42 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so3115014qeb.16
        for <ecryptfs@vger.kernel.org>; Sun, 15 Dec 2013 06:20:42 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

I have a .Private folder in my home directory. It worked ok after I
logged in, until I reinstalled the system. The same folder, user,
password, .ecryptfs with wrapped-passphrase. Yet, the contents of the
mounted .Private folder is scrambled.

ecryptfs-unwrap-passphrase returns some of my old passwords. What can
I do? If the folder can not be decrypted anymore, what was
modified/deleted by the installation process so that it is not
possible?

I am sorry if questions like that were already asked, the list's
archive does not work now.

Best regards,
Artur
