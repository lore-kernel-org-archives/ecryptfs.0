From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [3.0.y, 3.2.y, 3.4.y] Re: ecryptfs: corrupted files on a disk full
 event
Date: Wed, 10 Oct 2012 14:32:03 -0700
Message-ID: <20121010213203.GC4517@elie.Belkin>
References: <20121009173522.5563.81022.reportbug@klapprechner>
 <20121009193342.GA3993@elie.Belkin>
 <1349874250.6874.6.camel@klapprechner>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:59131 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab2JJVcM (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 10 Oct 2012 17:32:12 -0400
Content-Disposition: inline
In-Reply-To: <1349874250.6874.6.camel@klapprechner>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: Sebastian Heinlein <devel@glatzor.de>, Tyler Hicks <tyhicks@canonical.com>, Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org

Hi Ben and Greg,

Please consider

  8bc2d3cf6129 eCryptfs: Unlink lower inode when ecryptfs_create() fails
  e3ccaa976120 eCryptfs: Initialize empty lower files when opening them
  821f7494a776 eCryptfs: Revert to a writethrough cache model
  7149f2558d5b eCryptfs: Write out all dirty pages just before releasing the
               lower file
  64e6651dcc10 eCryptfs: Call lower ->flush() from ecryptfs_flush()

for application to the 3.0.y, 3.2.y, and 3.4.y trees.  (These fixes were
all applied to mainline during the 3.6 cycle.)

The patches apply cleanly to 3.2.y.  The backport to 3.0.y would take more
work since it lacks, for example, b59db43ad443 (eCryptfs: Prevent file
create race condition, 2011-11-21).

Patches 1-4 improve error handling and recovery.  The fifth ensures
flushes get propagated to the underlying filesystem, which would be
important to avoid data loss from power loss or crashes.

Sebastian Heinlein wrote[1], testing against 3.2.y:

> After a running into a full disk event with my ecrypts encrypted home directory
[...]
> I see a lot of random broken files on my system:
[...]
> Applying all 5 patches fixed all issues for me.
[...]
> I don't get any zero sized files anymore with a full disk (find
> $HOME/.Private/ -size 0c). I can even login with the user having a full
> disk (before often a broken .ICEauthority made this inpossible. I could
> not see any data corruptions in applications (Evolution, Iceweasel).
[...]
> The dd command which fills up the disk also exits correctly.

Thoughts welcome, as always.

Thanks,
Jonathan

[1] http://bugs.debian.org/690071
