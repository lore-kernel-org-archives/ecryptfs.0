From: Artur Rataj <arturrataj@gmail.com>
Subject: Fwd: How best to crack wrapped-passphrase?
Date: Mon, 20 Jan 2014 17:50:39 +0100
Message-ID: <CACO3_sDAGU52BPpONLfdmOSF4ij+mGxVib_6WgRhYPbcTgbdvw@mail.gmail.com>
References: <CACO3_sAgbSWb_JbZrCWZNbmJuPkmkimt9-oMOhwiCgaoROXrwQ@mail.gmail.com>
	<CACO3_sAKEg0ScQnd4fyis5r4g9teGO3VEhU-iYmdfa1cCAE1QQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:46692 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaATQuk (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 Jan 2014 11:50:40 -0500
Received: by mail-qe0-f45.google.com with SMTP id 1so904297qec.4
        for <ecryptfs@vger.kernel.org>; Mon, 20 Jan 2014 08:50:39 -0800 (PST)
In-Reply-To: <CACO3_sAKEg0ScQnd4fyis5r4g9teGO3VEhU-iYmdfa1cCAE1QQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs <ecryptfs@vger.kernel.org>

Hi

I have no idea how to crack the passphrase, but just want to add, that
I once knew both the password and the passphrase, and still could not
decrypt the directory despite using two tutorials, until I have found
ecryptfs-recover-private by Dustin Kirkland. So perhaps you wrote down
the pasphrase correctly.

Unfortunately passphrase can not be disabled even if not needed in the
first place - I used ecryptfs to protect from deletion etc., and not
for encryption, a misuse that does not work anyway, as bad credentials
still allow to delete files, and even turned out to corrupt the
filesystem.
