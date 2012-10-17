From: Greg KH <greg@kroah.com>
Subject: Re: [3.0.y, 3.2.y, 3.4.y] Re: ecryptfs: corrupted files on a disk
 full event
Date: Wed, 17 Oct 2012 14:51:39 -0700
Message-ID: <20121017215139.GE7083@kroah.com>
References: <20121009173522.5563.81022.reportbug@klapprechner>
 <20121009193342.GA3993@elie.Belkin>
 <1349874250.6874.6.camel@klapprechner>
 <20121010213203.GC4517@elie.Belkin>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36649 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371Ab2JQVvl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 17 Oct 2012 17:51:41 -0400
Content-Disposition: inline
In-Reply-To: <20121010213203.GC4517@elie.Belkin>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org, Sebastian Heinlein <devel@glatzor.de>, Tyler Hicks <tyhicks@canonical.com>, Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org

On Wed, Oct 10, 2012 at 02:32:03PM -0700, Jonathan Nieder wrote:
> Hi Ben and Greg,
> 
> Please consider
> 
>   8bc2d3cf6129 eCryptfs: Unlink lower inode when ecryptfs_create() fails
>   e3ccaa976120 eCryptfs: Initialize empty lower files when opening them
>   821f7494a776 eCryptfs: Revert to a writethrough cache model
>   7149f2558d5b eCryptfs: Write out all dirty pages just before releasing the
>                lower file
>   64e6651dcc10 eCryptfs: Call lower ->flush() from ecryptfs_flush()
> 
> for application to the 3.0.y, 3.2.y, and 3.4.y trees.  (These fixes were
> all applied to mainline during the 3.6 cycle.)
> 
> The patches apply cleanly to 3.2.y.  The backport to 3.0.y would take more
> work since it lacks, for example, b59db43ad443 (eCryptfs: Prevent file
> create race condition, 2011-11-21).
> 
> Patches 1-4 improve error handling and recovery.  The fifth ensures
> flushes get propagated to the underlying filesystem, which would be
> important to avoid data loss from power loss or crashes.

Applied to the 3.4 tree, they didn't work on 3.0.  If you have backports
for 3.0, that would be great to have.

thanks,

greg k-h
