From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
Date: Sun, 22 Nov 2020 08:49:41 -0800
Message-ID: <751803306cd957d0e7ef6a4fc3dbf12ebceaba92.camel@HansenPartnership.com>
References: <20201121165058.1644182-1-trix@redhat.com>
         <20201122032304.GE4327@casper.infradead.org>
         <ddb08a27-3ca1-fb2e-d51f-4b471f1a56a3@redhat.com>
         <20201122145635.GG4327@casper.infradead.org>
         <0819ce06-c462-d4df-d3d9-14931dc5aefc@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:55320 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbgKVQtp (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sun, 22 Nov 2020 11:49:45 -0500
In-Reply-To: <0819ce06-c462-d4df-d3d9-14931dc5aefc@redhat.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tom Rix <trix@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: joe@perches.com, clang-built-linux@googlegroups.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, tboot-devel@lists.sourceforge.net, kvm@vger.kernel.org, linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org, linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com, linux-mtd@lists.infradead.org

On Sun, 2020-11-22 at 08:10 -0800, Tom Rix wrote:
> On 11/22/20 6:56 AM, Matthew Wilcox wrote:
> > On Sun, Nov 22, 2020 at 06:46:46AM -0800, Tom Rix wrote:
> > > On 11/21/20 7:23 PM, Matthew Wilcox wrote:
> > > > On Sat, Nov 21, 2020 at 08:50:58AM -0800, trix@redhat.com
> > > > wrote:
> > > > > The fixer review is
> > > > > https://reviews.llvm.org/D91789
> > > > > 
> > > > > A run over allyesconfig for x86_64 finds 62 issues, 5 are
> > > > > false positives. The false positives are caused by macros
> > > > > passed to other macros and by some macro expansions that did
> > > > > not have an extra semicolon.
> > > > > 
> > > > > This cleans up about 1,000 of the current 10,000 -Wextra-
> > > > > semi-stmt warnings in linux-next.
> > > > Are any of them not false-positives?  It's all very well to
> > > > enable stricter warnings, but if they don't fix any bugs,
> > > > they're just churn.
> > > > 
> > > While enabling additional warnings may be a side effect of this
> > > effort
> > > 
> > > the primary goal is to set up a cleaning robot. After that a
> > > refactoring robot.
> > Why do we need such a thing?  Again, it sounds like more churn.
> > It's really annoying when I'm working on something important that
> > gets derailed by pointless churn.  Churn also makes it harder to
> > backport patches to earlier kernels.
> > 
> A refactoring example on moving to treewide, consistent use of a new
> api may help.
> 
> Consider
> 
> 2efc459d06f1630001e3984854848a5647086232
> 
> sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output
> 
> A new api for printing in the sysfs.  How do we use it treewide ?
> 
> Done manually, it would be a heroic effort requiring high level
> maintainers pushing and likely only get partially done.
> 
> If a refactoring programatic fixit is done and validated on a one
> subsystem, it can run on all the subsystems.
> 
> The effort is a couple of weeks to write and validate the fixer,
> hours to run over the tree.
> 
> It won't be perfect but will be better than doing it manually.

Here's a thought: perhaps we don't.  sysfs_emit isn't a "new api" its a
minor rewrap of existing best practice.  The damage caused by the churn
of forcing its use everywhere would far outweigh any actual benefit
because pretty much every bug in this area has already been caught and
killed by existing tools.  We can enforce sysfs_emit going forwards
using tools like checkpatch but there's no benefit and a lot of harm to
be done by trying to churn the entire tree retrofitting it (both in
terms of review time wasted as well as patch series derailed).

James


