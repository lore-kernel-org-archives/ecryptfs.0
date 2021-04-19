From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from GFS2 and EncryptFS
Date: Mon, 19 Apr 2021 08:26:42 +0100
Message-ID: <20210419072642.GD4869@dell>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
 <20210419050926.GB405651@elm>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhDSH1P (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Apr 2021 03:27:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B06C061760
        for <ecryptfs@vger.kernel.org>; Mon, 19 Apr 2021 00:26:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c15so23883094wro.13
        for <ecryptfs@vger.kernel.org>; Mon, 19 Apr 2021 00:26:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20210419050926.GB405651@elm>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Tyler Hicks <code@tyhicks.com>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Bob Peterson <rpeterso@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, cluster-devel@redhat.com, David Howells <dhowells@redhat.com>, ecryptfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>, James Morris <jamorris@linux.microsoft.com>, Johannes Weiner <hannes@cmpxchg.org>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, "Michael A. Halcrow" <mhalcrow@us.ibm.com>, "Michael C. Thompsion" <mcthomps@us.ibm.com>, Michal Hocko <mhocko@suse.com>, "Trevor S. Highland" <trevor.highland@gmail.com>, Tycho Andersen <tycho@tycho.pizza>, Waiman Long <longman@redhat.com>

On Mon, 19 Apr 2021, Tyler Hicks wrote:

> On 2021-03-30 17:44:27, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > There is more to do in filesystems.  Another set will follow.
> > 
> > Lee Jones (31):
> ...
> >   fs: ecryptfs: read_write: File headers do not make good candidates for
> >     kernel-doc
> >   fs: ecryptfs: debug: Demote a couple of kernel-doc abuses
> >   fs: ecryptfs: dentry: File headers are not good candidates for
> >     kernel-doc
> >   fs: ecryptfs: kthread: Demote file header and provide description for
> >     'cred'
> >   fs: ecryptfs: file: Demote kernel-doc abuses
> >   fs: ecryptfs: super: Fix formatting, naming and kernel-doc abuses
> >   fs: ecryptfs: messaging: Add missing param descriptions and demote
> >     abuses
> >   fs: ecryptfs: main: Demote a bunch of non-conformant kernel-doc
> >     headers
> >   fs: ecryptfs: miscdev: File headers are not good kernel-doc candidates
> >   fs: ecryptfs: crypto: Supply some missing param descriptions and
> >     demote abuses
> >   fs: ecryptfs: mmap: Help out one function header and demote other
> >     abuses
> >   fs: ecryptfs: inode: Help out nearly-there header and demote
> >     non-conformant ones
> >   fs: ecryptfs: keystore: Fix some kernel-doc issues and demote
> >     non-conformant headers
> 
> I've applied the eCryptfs fixes to the next branch of
> tyhicks/ecryptfs.git. Thanks for the clean-up!

Thanks Tyler, much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
