From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: ecryptfs & ssh authentication
Date: Tue, 13 Dec 2011 00:25:39 -0800 (PST)
Message-ID: <alpine.DEB.2.01.1112130002380.787@trent.utfs.org>
References: <alpine.DEB.2.01.1112120042000.787@trent.utfs.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from trent.utfs.org ([194.246.123.103]:51924 "EHLO trent.utfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab1LMIZm (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 13 Dec 2011 03:25:42 -0500
Received: from trent.utfs.org (localhost [127.0.0.1])
	by trent.utfs.org (Postfix) with ESMTP id 32A1B3DAD3
	for <ecryptfs@vger.kernel.org>; Tue, 13 Dec 2011 09:25:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trent.utfs.org (Postfix) with ESMTP id 1B2113DAD2
	for <ecryptfs@vger.kernel.org>; Tue, 13 Dec 2011 09:25:39 +0100 (CET)
In-Reply-To: <alpine.DEB.2.01.1112120042000.787@trent.utfs.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

On Mon, 12 Dec 2011 at 03:06, Christian Kujau wrote:
> But I also wanted to login via SSH keys - so I configured openssh to use  
> /etc/ssh/authorized_keys.%u as its AuthorizedKeysFile and I can login with 
> public key authentication - so far, so good.
> 
> For the first few logins the home directory is mounted - but then it 
> stops and a few logins (and logouts) later I still can login via SSH
> keys - but the home directory just isn't mounted any more.

After a very helpful chat in #ecryptfs I was told that sshd will have no 
way to unlock $HOME when SSH keys are being used, since no passphrase is 
provided. When logging in locally (via "login") or with password 
authentication, $HOME is unlocked.

> 3) login joe    -> logged in, $HOME is mounted -> OK
> 4) login via ssh, with keys/passwords a few times. After
>    some 5 or 10 logins the home directory is only mounted for
>    password logins. Logging in via key still succeeds, but
>    the home directory is not mounted any more

It was a bit of a mystery that it worked a few times and then suddenly 
stopped. But it turned out that even after logging out (and $HOME being 
unmounted), therer were leftover processes ("login" for local, "sshd" for 
remote logins) which would not terminate until after a while. But 
eventually these leftover process would clear and all what is left from 
the logged-out user is a shared memory segment and a semaphore:

-----------
# ipcs

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status
0x3c81b7f5 32768      joe        666        4096       0

------ Semaphore Arrays --------
key        semid      owner      perms      nsems
0x3c81b7f6 32768      joe        666        1

------ Message Queues --------
key        msqid  
-----------

And while these things are still present, I could always login with 
ssh-keys and $HOME would be unlocked & mounted every time (although it 
should not!) and unmounted on logout.

As soon as I remove (ipcrm) the shm segment *and* the semaphore (I really 
needed to remove both), this behaviour could not longer be reproduced and
I had to use password logins ("login" or ssh-with-passord) to unlock
(and mount) the $HOME directory - now it would work as expected!

@Tyler: Yes, this shm business might just be a coincidence and maybe it
        is. That's just what I'm currently seeing.

But all this was with ecryptfs-utils-83-4 on a Debian/squeeze system and 
could NOT be reproduced any more with ecryptfs-utils-92-0ubuntu1 
(Ubuntu/oneiric) - except for those leftover processes. I've opened 
#903582[0] for those to be looked at.

So, this PowerPC system of mine was actually behaving correctly (it 
eventually stopped unlocking my $HOME when ssh keys were used) while
the faster i386 machine is acting erroneously - who would've thought? :-)

Thanks for listening,
Christian.

[0] https://bugs.launchpad.net/ecryptfs/+bug/903582
-- 
BOFH excuse #82:

Yeah, yo mama dresses you funny and you need a mouse to delete files.
