From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Subject: Re: async crashes
Date: Thu, 18 Apr 2013 23:45:06 +0300
Message-ID: <1366317906.13274.140661219700802.0639DF04@webmail.messagingengine.com>
References: <1364651830.2286.140661211073081.738964DE@webmail.messagingengine.com>
 <20130405235258.GA11632@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35894 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936581Ab3DRUpH (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 18 Apr 2013 16:45:07 -0400
In-Reply-To: <20130405235258.GA11632@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Hi

Sorry I haven't answered this before. And sorry for top-posting
but I can now summarize this so it makes sense..

I tested this with Intel Medfield hardware and SEP driver
(drivers/staging/sep). It turned out that SEP driver
crashed while encrypting extents of a page.

I also did a test where I mocked "err = -EINPROGRESS;" into
ecryptfs_encrypt_extent_done and tested what it would produce.
No crashes/oops whatsoever. So I guess this was completely
false alarm from ecryptfs perspective.

/Jarkko

On Sat, Apr 6, 2013, at 2:52, Tyler Hicks wrote:
> On 2013-03-30 15:57:10, Jarkko Sakkinen wrote:
> > Hi
> > 
> > I've been experimenting with async branch of ecryptfs for some
> > workloads. Sometimes it crashes so that ecryptfs_encrypt_extent_done()
> > first reports -EINPROGRESS (-115) to kernel log. After that it crashes
> > in ablkcipher_walk_phys().
> 
> Were you building with Zeev's patch titled "eCryptfs: ablkcipher support
> - add workqueue"? A (temporary) link to the patch can be found here:
> 
> http://git.kernel.org/cgit/linux/kernel/git/tyhicks/ecryptfs.git/commit/?h=async
> 
> Do you have a way to reproduce this? Any exotic hardware? Any crypto
> acceleration hardware?
> 
> > I looked at ecryptfs_encrypt_extent_done() and this made me think
> > whether it should have special case for having -EBUSY and -EINPROGRESS.
> 
> Looking at other ablkcipher callbacks, I'd think we'd at least need a
> special case for -EINPROGRESS.
> 
> > 
> > Sorry about bit coares "bug report" but I'm not expert either with
> > ecryptfs or crypto implementation.
> 
> No problem, thanks for bringing it to our attention!
> 
> 
> Additionally, I just cc'ed you on a different patch that I have been
> working as an alternative to the async patch. Maybe you can give it a
> try, as well.
> 
> Tyler
> Email had 1 attachment:
> + signature.asc
>   1k (application/pgp-signature)
