From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Sun, 21 Apr 2013 13:32:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1304211324450.13746@trent.utfs.org>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from trent.utfs.org ([94.185.90.103]:45330 "EHLO trent.utfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab3DUUlc (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Sun, 21 Apr 2013 16:41:32 -0400
In-Reply-To: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ivan Yosifov <iyosifov@gmail.com>
Cc: ecryptfs@vger.kernel.org

On Sun, 21 Apr 2013 at 13:30, Ivan Yosifov wrote:
> I'm trying to use ecrypts on top of an sshfs mount for remote backup
> to an untrusted machine. I'm having a problem with timestamps however:

Nice setup. I had to try this and it's working here:

sid0# sshfs root@localhost:/mnt/disk/enc /mnt/disk/sshfs
root@localhost's password:

sid0# mount -t ecryptfs /mnt/disk/sshfs /mnt/disk/dec
Attempting to mount with the following options:
  ecryptfs_unlink_sigs
  ecryptfs_fnek_sig=14f4412383d9220f
  ecryptfs_key_bytes=16
  ecryptfs_cipher=aes
  ecryptfs_sig=14f4412383d9220f
Mounted eCryptfs

sid0# cd /mnt/disk/dec
sid0# cp -a lib/dpkg/ bak
sid0# diff -r lib/dpkg/ bak/


sid0# uname -a
Linux sid0 3.8-trunk-amd64 #1 SMP Debian 3.8-1~experimental.1 x86_64 GNU/Linux

sid0# dpkg -l | egrep 'ecryptfs|sshfs' | cut -c-80
ii  ecryptfs-utils                             103-2
ii  libecryptfs0                               103-2
ii  sshfs                                      2.4-1

Only extended attributes do not seem to be supported. What versions are 
you on? Does strace(1) reveal something useful?

Christian.
-- 
BOFH excuse #340:

Well fix that in the next (upgrade, update, patch release, service pack).
