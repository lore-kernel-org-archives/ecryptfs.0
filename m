From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/3] ecryptfs: remove unused helpers
Date: Mon, 19 Apr 2021 15:27:24 +0000
Message-ID: <YH2hXFAd0RJLO54G@zeniv-ca.linux.org.uk>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-2-brauner@kernel.org>
 <20210419044850.GF398325@elm>
 <YH2KVPsPdSFMEhEY@zeniv-ca.linux.org.uk>
 <20210419142258.GC4991@sequoia>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhDSP2D (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Apr 2021 11:28:03 -0400
Content-Disposition: inline
In-Reply-To: <20210419142258.GC4991@sequoia>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>

On Mon, Apr 19, 2021 at 09:22:58AM -0500, Tyler Hicks wrote:
> On 2021-04-19 13:49:08, Al Viro wrote:
> > On Sun, Apr 18, 2021 at 11:48:50PM -0500, Tyler Hicks wrote:
> > > On 2021-04-09 18:24:20, Christian Brauner wrote:
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > 
> > > > Remove two helpers that are unused.
> > > > 
> > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > Cc: Tyler Hicks <code@tyhicks.com>
> > > > Cc: ecryptfs@vger.kernel.org
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > I'll pick this patch up now as it looks like it didn't make it into your
> > > v2 of the port to private mounts. I'll review those patches separately.
> > 
> > FWIW, there's also a series in vfs.git #work.ecryptfs (posted Mar 20),
> > and that, AFAICS, duplicates 483bc7e82ccfc in there...
> 
> Yeah, I noticed that after I pushed Christian's commit to my next
> branch. I've fallen behind on eCryptfs patch review. :/
> 
> I plan to review vfs.git #work.ecryptfs in the next couple days. If
> everything looks good, do you want me to take it via my tree or were you
> planning on taking those yourself?

Entirely up to you.  The only patch in there that might have some interplay
with VFS work is lock_parent() changes (#2/4) and the stuff it might be
a prereq for is not going to get ready until the next cycle - you are not
the only one with clogged queue ;-/

So even if you prefer to cherry-pick those one by one, I've no problem with
that; just tell me when to drop that branch and I'll do so.
