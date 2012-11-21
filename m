From: Greg KH <greg@kroah.com>
Subject: Re: [3.0.y, 3.2.y, 3.4.y] Re: ecryptfs: corrupted files on a disk
 full event
Date: Tue, 20 Nov 2012 17:18:30 -0800
Message-ID: <20121121011830.GB5381@kroah.com>
References: <20121009173522.5563.81022.reportbug@klapprechner>
 <20121009193342.GA3993@elie.Belkin>
 <1349874250.6874.6.camel@klapprechner>
 <20121010213203.GC4517@elie.Belkin>
 <20121112195606.GF3342@herton-Z68MA-D2H-B3>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59395 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752344Ab2KUBSc (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Nov 2012 20:18:32 -0500
Content-Disposition: inline
In-Reply-To: <20121112195606.GF3342@herton-Z68MA-D2H-B3>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, stable@vger.kernel.org, Sebastian Heinlein <devel@glatzor.de>, Tyler Hicks <tyhicks@canonical.com>, Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org

On Mon, Nov 12, 2012 at 05:56:07PM -0200, Herton Ronaldo Krzesinski wrote:
> On Wed, Oct 10, 2012 at 02:32:03PM -0700, Jonathan Nieder wrote:
> > Hi Ben and Greg,
> > 
> > Please consider
> > 
> >   8bc2d3cf6129 eCryptfs: Unlink lower inode when ecryptfs_create() fails
> >   e3ccaa976120 eCryptfs: Initialize empty lower files when opening them
> >   821f7494a776 eCryptfs: Revert to a writethrough cache model
> >   7149f2558d5b eCryptfs: Write out all dirty pages just before releasing the
> >                lower file
> >   64e6651dcc10 eCryptfs: Call lower ->flush() from ecryptfs_flush()
> 
> What about also picking the following two for stables?
> 
> 069ddcda37b2cf5bb4b6031a944c0e9359213262
> eCryptfs: Copy up POSIX ACL and read-only flags from lower mount
> 
> 5f5b331d5c21228a6519dcb793fc1629646c51a6
> eCryptfs: check for eCryptfs cipher support at mount

Both now applied to the 3.0 and 3.4 stable trees, thanks.

greg k-h
