From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: eCryptfs: how to submit a patch
Date: Thu, 15 Dec 2011 17:00:40 -0600
Message-ID: <CANT6BaOQVv6TnnEVqmHYadAAeFv-u7J1T7F1BuBo=WQoka_PMw@mail.gmail.com>
References: <4EEA6267.2020509@qoben.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39923 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759655Ab1LOXAk (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 15 Dec 2011 18:00:40 -0500
Received: by pbdu13 with SMTP id u13so483994pbd.19
        for <ecryptfs@vger.kernel.org>; Thu, 15 Dec 2011 15:00:40 -0800 (PST)
In-Reply-To: <4EEA6267.2020509@qoben.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Siemerink <ben@qoben.com>
Cc: Tyler C Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org

On Thu, Dec 15, 2011 at 3:11 PM, Ben Siemerink <ben@qoben.com> wrote:
> Hello Douglas,

Howdy, I go by "Dustin", FWIW...

> How are you?
>
> I am looking into eCryptfs and Ubuntu's auto-mounting private home
> directory. I already use it on my laptop, but now want to secure the home
> directories on my development computer as well.
>
> Anyway, I saw that the key length is hard-coded in the
> mount.ecryptfs_private utility and tried to change it and recompile it.
> Doing so I encountered the incorrect usage of the locally defined KEY_LENGTH
> for the signature length, which should be ECRYPTFS_SIG_SIZE_HEX as defined
> in ecryptfs.h.

I think you should be able to do this already, using the "ALIAS"
feature, as described in the manpage:
 * http://manpg.es/mount.ecryptfs_private

> I have a patch ready, but have no experience with submitting code to
> Launchpad. What is the preferred way to submit the code? Create a new branch
> on Launchpad? Send you the patch by email?

Ah, well, that's a good question!  As a response, I just committed a
new file to the repository, CONTRIBUTING, which you can see here:
 * http://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/CONTRIBUTING

> Furthermore I would like the Private directory feature to accept various key
> lengths (16, 24 and 32 bytes). I saw that the current code explicitly
> ignores mount options in the alias.conf files. I guess that there may be
> security reasons for doing so, perhaps because of the set-uid permission.
> Could you please shed some light on it?

Right, it is essential that any user-provided input to
mount.ecryptfs_private is *totally* sanitized, since it is a setuid
binary.

I'd suggest first that you try the aforementioned ALIAS feature, and
see if that works well enough for you.  If it doesn't, then yeah, send
your patch along!  We're always happy to have new contributions :-)

-- 
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
