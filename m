From: Ivan Yosifov <iyosifov@gmail.com>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Wed, 24 Apr 2013 21:59:05 +0300
Message-ID: <CAHHtCV8PCU0v=96Oj8pP3seyh-out_2F=24ekBFio1k1zTwK6g@mail.gmail.com>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
	<alpine.DEB.2.10.1304211324450.13746@trent.utfs.org>
	<CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
	<alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
	<CAHHtCV8Efp+OJ3Rx54_d_dMcSvZnNxdodBK96hSj9=1iLUSB7g@mail.gmail.com>
	<20130423193016.GB7389@boyd>
	<CAHHtCV-1kwcXESyYLgm9-quTiZJ0XRZXqXcFgMT9pURB0Vw0Ug@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:52286 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab3DXS7G (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 24 Apr 2013 14:59:06 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so1984923vbb.37
        for <ecryptfs@vger.kernel.org>; Wed, 24 Apr 2013 11:59:05 -0700 (PDT)
In-Reply-To: <CAHHtCV-1kwcXESyYLgm9-quTiZJ0XRZXqXcFgMT9pURB0Vw0Ug@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Christian Kujau <lists@nerdbynature.de>, Mike Reinstein <reinstein.mike@gmail.com>, ecryptfs@vger.kernel.org

Sorry, the mail got sent incomplete, resending:

> Does this happen when only using sshfs (without eCryptfs mounted on
> top)?

No, cp --preserve=timestamps to sshfs alone works.

> Does this happen when only using eCryptfs (mounted locally on top of
> something like ext4)?

No, cp --preserve=timestamps to ecryptfs on top of ext4 works too.

> Nothing like that should be a problem from eCryptfs' standpoint. I have
> no idea about sshfs.

Well, the existence of the allow_root and allow_other sshfs options
suggest it somehow cares.

> Why didn't adding user,noauto to the fstab entry work for you? What
> error message did you see? Anything relevant in the system log?

For example, I just tried with the following line (the key '1' is
obviously just for testing):

/home/obelix/evil_host /home/obelix/bak ecryptfs
user,noauto,verbose,key=passphrase:passphrase_passwd=1 0 0

I got:

$ mount ./bak
Exiting. Unable to obtain passwd info

I didn't get anything written to /var/log/messages.log or dmesg.

If I run the mount as root, I get asked for the other parameters and
in the end it mounts.
I tried with a more comprehensive fstab line too:

/home/obelix/evil_host /home/obelix/bak ecryptfs
user,noauto,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,verbose,key=passphrase:passphrase_passwd=1,ecryptfs_passthrough,ecryptfs_enable_filename_crypto=n
0 0

This mounts as root without asking any questions and fails as user
with the same error.
