From: David Obadia <dav-ecryptfs@odav.org>
Subject: Re: Wrapper to mount Private directories without root
Date: Tue, 15 Jan 2013 23:59:44 +0000 (UTC)
Message-ID: <loom.20130116T004804-557@post.gmane.org>
References: <loom.20121212T175359-906@post.gmane.org> <20130115191820.GA5302@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58611 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932524Ab3AOX77 (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 15 Jan 2013 18:59:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfe-ecryptfs@m.gmane.org>)
	id 1TvGQP-0005W3-8L
	for ecryptfs@vger.kernel.org; Wed, 16 Jan 2013 01:00:13 +0100
Received: from 108.61.50.108.choopa.net ([108.61.50.108.choopa.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Wed, 16 Jan 2013 01:00:13 +0100
Received: from dav-ecryptfs by 108.61.50.108.choopa.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ecryptfs@vger.kernel.org>; Wed, 16 Jan 2013 01:00:13 +0100
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Tyler Hicks <tyhicks <at> canonical.com> writes:
> On 2012-12-12 16:58:41, David Obadia wrote:
> > Not sure why ecryptfs-recover-private requires root, I've found a way to do 
the
> > same thing without root.
> 
> A quick glance at that script shows that it needs root to do the
> `mount -t ecryptfs ...` command. The main eCryptfs mount helper
> (/sbin/mount.ecryptfs) is big and complex.

Understood, that makes sense. That script might pre-date mount.ecryptfs_private? 
I say this because I was able to achieve the same functionality using only 
mount.ecryptfs_private, not mount.ecryptfs in my Python script.

> > Also I think it would be helpful to have a user friendly API for
> > creating/mounting/unmounting ecrypted folders that doesn't require root 
using
> > the setuid in mount.ecryptfs_private.
> 
> That might be a nice thing to have, but we want mount.ecryptfs_private
> to stay as simple as possible so that it can be audited and so that we
> don't introduce new security flaws into the code. It is intentionally
> locked down to do very specific actions.

Sounds reasonable. Maybe providing a wrapper script gives the best of both 
world? 
1) Minimizes the amount of setuid code that needs to be audited
2) Gives flexibility to the end-user to do as much as can possibly be done, in a 
user-friendly manner, and without requiring root access.

Would be glad to help,
David- 
