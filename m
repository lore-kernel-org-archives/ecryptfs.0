From: Wilson <wilson.ubuntu@gmail.com>
Subject: Mount parameters
Date: Fri, 3 Oct 2014 00:41:43 +0200
Message-ID: <CAPJTpio229msbOvRTrE_6GCVLaLeU=O4aUsfEShoOpVypMC-GQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55830 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbaJBWmO (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 2 Oct 2014 18:42:14 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so63878lbg.32
        for <ecryptfs@vger.kernel.org>; Thu, 02 Oct 2014 15:42:13 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs <ecryptfs@vger.kernel.org>

Hi,

is it possible to mount a ecryptfs home directory with mount
parameters such as noexec?

I'm trying to build an hardened Ubuntu install (it's just an hobby for
learning something, noting professional) and I'm stuck trying to
prevent execution from home even for users with cyphered home.

I'm mounting the whole /home with noexec in fstab, but cyphered home
are obviously unaffected and I'm unable to find a way to say to
ecryptfs to do so, can it be done?

Thanks,

Wilson
