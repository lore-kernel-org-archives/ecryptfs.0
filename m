From: Artur Rataj <arturrataj@gmail.com>
Subject: Re: How best to crack wrapped-passphrase?
Date: Mon, 20 Jan 2014 18:08:39 +0100
Message-ID: <CACO3_sAmQFu0raHhd3Mc60dCWUuzE4Z_u4dG_F06x8G5Qh4g2Q@mail.gmail.com>
References: <CACO3_sAgbSWb_JbZrCWZNbmJuPkmkimt9-oMOhwiCgaoROXrwQ@mail.gmail.com>
	<CACO3_sAKEg0ScQnd4fyis5r4g9teGO3VEhU-iYmdfa1cCAE1QQ@mail.gmail.com>
	<CACO3_sDAGU52BPpONLfdmOSF4ij+mGxVib_6WgRhYPbcTgbdvw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:61510 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaATRIj (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 20 Jan 2014 12:08:39 -0500
Received: by mail-qc0-f182.google.com with SMTP id c9so6193700qcz.27
        for <ecryptfs@vger.kernel.org>; Mon, 20 Jan 2014 09:08:39 -0800 (PST)
In-Reply-To: <CACO3_sDAGU52BPpONLfdmOSF4ij+mGxVib_6WgRhYPbcTgbdvw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs <ecryptfs@vger.kernel.org>, Tom Vaughan <thomas.david.vaughan@gmail.com>

And if the passphrase is really mispelled, perhaps the best approach
is to "mutate" it. I would wrote some simple looping program that
would do some resonable insertions/deletions/replacements over the
original passphrase and would use the result to brute-force the
decryption. If there are some fixed time delays anywhere, removing
them and re-compiling some kernel module or tool would likely be
needed too.
