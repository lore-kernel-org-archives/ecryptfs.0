From: Joe Lauer <joe@greenback.com>
Subject: Max 26 concurrent ecryptfs mounts?
Date: Mon, 21 Mar 2016 17:20:40 -0400
Message-ID: <CAOgMywMKtc6Bzr88z97GHSeTTmj-rOZk7kCzDQgCoR2xZLCWuw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35225 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953AbcCUVUl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 21 Mar 2016 17:20:41 -0400
Received: by mail-yw0-f173.google.com with SMTP id g127so230745082ywf.2
        for <ecryptfs@vger.kernel.org>; Mon, 21 Mar 2016 14:20:41 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi ecryptfs community,

We're trying to use ecryptfs to create a large number of uniquely
encrypted directories.  We really like the idea that these are
overlayed on the existing filesystem and can all have different
encryption keys assigned.  So I'm hoping we can make ecryptfs work.

It appears that we can create 26 directories (which also means 26
different mounts), but then we get a exit value of 134 from
mount.ecryptfs on the 27th user.  Here is the exact error message:

Error attempting to evaluate mount options: [-122] Disk quota exceeded
Check your system logs for details on why this happened.
Try updating your ecryptfs-utils package, and/or
submit a bug report on https://bugs.launchpad.net/ecryptfs

My theory is that since we mount everything using "sudo" and thus as
root, that its reusing the same keyring and maybe is hitting the 32K
limit on kernel keyrings.

So my questions:

1) Is my theory correct?

2) Are there any workarounds?  Any magic kernel settings I can tune to
allow for more?  Or can we actually mount a directory under a
different account than root so that a new keyring is used as opposed
for root.

Thx.
