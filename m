From: Joe Perches <joe@perches.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
Date: Sat, 21 Nov 2020 10:02:17 -0800
Message-ID: <f7643c9cb0a896f3ead65e86084b7c143e21ef43.camel@perches.com>
References: <20201121165058.1644182-1-trix@redhat.com>
         <5843ef910b0e86c00d9c0143dec20f93823b016b.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:53086 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgKUSC0 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 21 Nov 2020 13:02:26 -0500
In-Reply-To: <5843ef910b0e86c00d9c0143dec20f93823b016b.camel@HansenPartnership.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Bottomley <James.Bottomley@HansenPartnership.com>, trix@redhat.com, clang-built-linux@googlegroups.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, tboot-devel@lists.sourceforge.net, kvm@vger.kernel.org, linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org, linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com, linux-mtd@lists.infradead.org, keyrings@vger.kernel.org, netfilter-devel@vger.kern

On Sat, 2020-11-21 at 09:18 -0800, James Bottomley wrote:
> On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
> > A difficult part of automating commits is composing the subsystem
> > preamble in the commit log.  For the ongoing effort of a fixer
> > producing one or two fixes a release the use of 'treewide:' does
> > not seem appropriate.
> > 
> > It would be better if the normal prefix was used.  Unfortunately
> > normal is not consistent across the tree.
> > 
> > 	D: Commit subsystem prefix
> > 
> > ex/ for FPGA DFL DRIVERS
> > 
> > 	D: fpga: dfl:
> 
> I've got to bet this is going to cause more issues than it solves. 
> SCSI uses scsi: <driver>: for drivers but not every driver has a
> MAINTAINERS entry.  We use either scsi: or scsi: core: for mid layer
> things, but we're not consistent.  Block uses blk-<something>: for all
> of it's stuff but almost no <somtehing>s have a MAINTAINERS entry.  So
> the next thing you're going to cause is an explosion of suggested
> MAINTAINERs entries.

As well as some changes require simultaneous changes across
multiple subsystems.

> Has anyone actually complained about treewide:?

It depends on what you mean by treewide:

If a treewide: patch is applied by some "higher level" maintainer,
then generally, no.

If the treewide patch is also cc'd to many individual maintainers,
then yes, many many times.

Mostly because patches cause what is in their view churn or that
changes are not specific to their subsystem grounds.

The treewide patch is sometimes dropped, sometimes broken up and
generally not completely applied.

What would be useful in many cases like this is for a pre and post
application of the treewide patch to be compiled and the object
code verified for lack of any logic change.

Unfortunately, gcc does not guarantee deterministic compilation so
this isn't feasible with at least gcc.  Does clang guarantee this?

I'm not sure it's possible:
https://blog.llvm.org/2019/11/deterministic-builds-with-clang-and-lld.html


