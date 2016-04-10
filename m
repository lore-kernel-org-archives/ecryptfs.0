From: James Muir <muir.james.a@gmail.com>
Subject: Re: Max 26 concurrent ecryptfs mounts?
Date: Sun, 10 Apr 2016 07:59:32 -0400
Message-ID: <570A4024.9090005@gmail.com>
References: <CAOgMywMKtc6Bzr88z97GHSeTTmj-rOZk7kCzDQgCoR2xZLCWuw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33492 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbcDJL7f (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 10 Apr 2016 07:59:35 -0400
Received: by mail-qk0-f178.google.com with SMTP id k135so56860447qke.0
        for <ecryptfs@vger.kernel.org>; Sun, 10 Apr 2016 04:59:34 -0700 (PDT)
In-Reply-To: <CAOgMywMKtc6Bzr88z97GHSeTTmj-rOZk7kCzDQgCoR2xZLCWuw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Joe Lauer <joe@greenback.com>, ecryptfs@vger.kernel.org

On 16-03-21 05:20 PM, Joe Lauer wrote:
> 2) Are there any workarounds?  Any magic kernel settings I can tune to
> allow for more?  Or can we actually mount a directory under a
> different account than root so that a new keyring is used as opposed
> for root.

You can increase the quota by writing to certain proc files.  It is 
documented in the kernel source:  Documentation/security/keys.txt

quoting:

> Four new sysctl files have been added also for the purpose of controlling the
> quota limits on keys:
>
>  (*) /proc/sys/kernel/keys/root_maxkeys
>      /proc/sys/kernel/keys/root_maxbytes
>
>      These files hold the maximum number of keys that root may have and the
>      maximum total number of bytes of data that root may have stored in those
>      keys.
>
>  (*) /proc/sys/kernel/keys/maxkeys
>      /proc/sys/kernel/keys/maxbytes
>
>      These files hold the maximum number of keys that each non-root user may
>      have and the maximum total number of bytes of data that each of those
>      users may have stored in their keys.
>
> Root may alter these by writing each new limit as a decimal number string to
> the appropriate file.

-James M
