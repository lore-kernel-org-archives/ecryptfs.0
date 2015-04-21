From: Pablo Castellano <pablo@anche.no>
Subject: Re: Way to decrypt an encrypted /home
Date: Tue, 21 Apr 2015 10:57:54 +0000 (UTC)
Message-ID: <loom.20150421T114722-828@post.gmane.org>
References: <CAHTahaZZetDg8=X=G4rTRJJWJBRXrN4N1dK86kUqwOXXKhh7bQ@mail.gmail.com> <20150401144211.GA11872@boyd> <CAHTahaZ262EtzX+sZ013rfR0JvwK+zmzJCy+yusEYjR+nKehhw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33585 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbDULPG (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 21 Apr 2015 07:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1YkW8t-0000BX-W9
	for ecryptfs@vger.kernel.org; Tue, 21 Apr 2015 13:15:04 +0200
Received: from 128.242.134.37.dynamic.jazztel.es ([37.134.242.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Tue, 21 Apr 2015 13:15:03 +0200
Received: from pablo by 128.242.134.37.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Tue, 21 Apr 2015 13:15:03 +0200
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Marc de Verdelhan <mdeverdelhan <at> gmail.com> writes:
> [...]
> What I'm wondering is: What if a user (for instance: me) has a v2
> wrapped-passphrase file but try to mount its encrypted directory with
> a version of ecryptfs-utils inferior to v104? Did you consider this
> case?
> After this adventure I can say that returning "ERROR: Your passphrase
> is incorrect" when you run a "ecryptfs-mount-private" in that kind of
> configuration may get some users to think they really have an
> incorrect password and to give up, loosing their data.
> At [the very] least you should put a very big warning on
> http://ecryptfs.org/ to inform all the users in that situation (which
> may occur again since Debian Stable has the version 99-1 of
> ecryptfs-utils (https://packages.debian.org/stable/misc/ecryptfs-utils)
> and is still maintained).
> 

I have experienced this same issue today.
I had ubuntu 14.04 with ecryptfs-utils 104-0ubuntu1.14.04.3.
I reinstalled Linux Mint 17 in / and kept /home.

As the installation ships with ecryptfs-utils 104-0ubuntu1 and my home
actually had the rewrapped version using a random salt, it was saying my
passphrase was incorrect and made me very nervous.
Fortunately I upgraded all the packages and after reboot everything was fine
again.


