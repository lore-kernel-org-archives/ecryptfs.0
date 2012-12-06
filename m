From: CACook@quantum-sci.com
Subject: Re: Encrypting BTRFS Volume
Date: Thu, 6 Dec 2012 14:34:58 -0800
Message-ID: <201212061434.58476.CACook@quantum-sci.com>
References: <201212011306.59255.CACook@quantum-sci.com> <201212061328.15342.CACook@quantum-sci.com> <CAHcyQ+7UeWtYmfNFOMp6zuqVN=K2o=ebyhGuOAPDF5-oEBFU+w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from gateway04.websitewelcome.com ([67.18.103.14]:45076 "EHLO
	gateway04.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964839Ab2LFWlS (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 6 Dec 2012 17:41:18 -0500
Received: from getz.websitewelcome.com (getz.websitewelcome.com [174.121.36.226])
	by gateway04.websitewelcome.com (Postfix) with ESMTP id 0D47FA463F709
	for <ecryptfs@vger.kernel.org>; Thu,  6 Dec 2012 16:34:59 -0600 (CST)
Received: from [67.183.170.11] (port=36103 helo=hydra.localnet)
	by getz.websitewelcome.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <CACook@quantum-sci.com>)
	id 1Tgk20-0007fO-6P
	for ecryptfs@vger.kernel.org; Thu, 06 Dec 2012 16:35:00 -0600
In-Reply-To: <CAHcyQ+7UeWtYmfNFOMp6zuqVN=K2o=ebyhGuOAPDF5-oEBFU+w@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org


Not too worried about the workload because this is just a backups server.

But I don't understand the structure you're suggesting.  Can you explain?


On Thursday, December 06, 2012 02:18:45 PM you wrote:
> If you haven't changed the data before encryption, eCryptFS won't
> change the backing file.
> 
> Deduping will probably be less efficient because a small change in a
> large file could cause a larger part (maybe the whole) file to change,
> but on a per-file basis you shouldn't see that much difference.
> 
> It'll depend on your exact workload, though.
> 
> On Thu, Dec 6, 2012 at 4:28 PM,  <CACook@quantum-sci.com> wrote:
> >
> > On Wednesday, December 05, 2012 03:39:03 PM you wrote:
> >> If the only use of subvolumes is for snapshotting, it seems to me that
> >> you could make one subvolume contain the encrypted directory, and then
> >> take snapshots of the encrypted directory/subvolume instead of taking
> >> snapshots of the unencrypted volume.
> >
> > So the array is /media/backups and subvolumes are /media/backups/droog, droog-snap-{date}, /media/backups/hex, hex-snap-{date}, etc.  The subvolumes and snaps have a special BTRFS relationship which eliminates dupes, and what I don't know is if ecryptfs would interfere with that.  Seems like it would.
> >
> 
> 
> 
> 
