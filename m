From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: ecryptfs & ssh authentication
Date: Mon, 12 Dec 2011 16:59:33 -0800 (PST)
Message-ID: <alpine.DEB.2.01.1112121652050.787@trent.utfs.org>
References: <alpine.DEB.2.01.1112120042000.787@trent.utfs.org> <4EE61D58.8010607@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from trent.utfs.org ([194.246.123.103]:47943 "EHLO trent.utfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab1LMA7g (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 12 Dec 2011 19:59:36 -0500
In-Reply-To: <4EE61D58.8010607@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Freeman-Day <presgas@gmail.com>
Cc: ecryptfs@vger.kernel.org

On Mon, 12 Dec 2011 at 10:27, Robert Freeman-Day wrote:
> The reason your local logins mound the ecryptfs system is because you
> are using the pam stack.  ecryptfs-utils offers a pam module that auto
> mounts it, see first entry here:

Yes, I know - that's the module I'm using, see 
http://nerdbynature.de/bits/ecryptfs/pam.d.txt

> The ssh packages offer no method to tie in with ecryptfs unless you tell
> sshd to use the pam stack.  Then you will likely need to use libpam-ssh
> (http://packages.debian.org/squeeze/libpam-ssh).

SSH can be configured to use PAM ("UsePAM yes") and I've configured it 
that way. And it's working...but only a few times when SSH keys are 
being used.

> You will really want to take a look at this security-wise.  It is likely
> that your key passphrase as well as your login/ecryptfs unwrap
> passphrase will need to be the same

Um, yes - that's what ecryptfs-migrate-home took care of: the password to 
login to the system is being used to unlock the ecryptfs container. I'm 
not sure what this has to do with my problem though.

> http://pam-ssh.sourceforge.net/
> http://www.clasohm.com/blog/one-entry?entry_id=12085

This is about some SSO magic, not sure how it relates to my "ecrypt stops 
unlocking my $HOME when SSH public key authentication is used" problem.

Thanks,
Christian.
-- 
BOFH excuse #348:

We're on Token Ring, and it looks like the token got loose.
