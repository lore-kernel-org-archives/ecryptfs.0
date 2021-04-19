From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from GFS2 and EncryptFS
Date: Mon, 19 Apr 2021 00:09:26 -0500
Message-ID: <20210419050926.GB405651@elm>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhDSFJ7 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Apr 2021 01:09:59 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B74C061760
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 22:09:29 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b3so19545786oie.5
        for <ecryptfs@vger.kernel.org>; Sun, 18 Apr 2021 22:09:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Bob Peterson <rpeterso@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, cluster-devel@redhat.com, David Howells <dhowells@redhat.com>, ecryptfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>, James Morris <jamorris@linux.microsoft.com>, Johannes Weiner <hannes@cmpxchg.org>, "Michael A. Halcrow" <mahalcro@us.ibm.com>, "Michael A. Halcrow" <mhalcrow@us.ibm.com>, "Michael C. Thompsion" <mcthomps@us.ibm.com>, Michal Hocko <mhocko@suse.com>, "Trevor S. Highland" <trevor.highland@gmail.com>, Tycho Andersen <tycho@tycho.pizza>, Waiman Long <longman@redhat.com>

On 2021-03-30 17:44:27, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> There is more to do in filesystems.  Another set will follow.
> 
> Lee Jones (31):
...
>   fs: ecryptfs: read_write: File headers do not make good candidates for
>     kernel-doc
>   fs: ecryptfs: debug: Demote a couple of kernel-doc abuses
>   fs: ecryptfs: dentry: File headers are not good candidates for
>     kernel-doc
>   fs: ecryptfs: kthread: Demote file header and provide description for
>     'cred'
>   fs: ecryptfs: file: Demote kernel-doc abuses
>   fs: ecryptfs: super: Fix formatting, naming and kernel-doc abuses
>   fs: ecryptfs: messaging: Add missing param descriptions and demote
>     abuses
>   fs: ecryptfs: main: Demote a bunch of non-conformant kernel-doc
>     headers
>   fs: ecryptfs: miscdev: File headers are not good kernel-doc candidates
>   fs: ecryptfs: crypto: Supply some missing param descriptions and
>     demote abuses
>   fs: ecryptfs: mmap: Help out one function header and demote other
>     abuses
>   fs: ecryptfs: inode: Help out nearly-there header and demote
>     non-conformant ones
>   fs: ecryptfs: keystore: Fix some kernel-doc issues and demote
>     non-conformant headers

I've applied the eCryptfs fixes to the next branch of
tyhicks/ecryptfs.git. Thanks for the clean-up!

Tyler
