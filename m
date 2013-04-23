From: Ivan Yosifov <iyosifov@gmail.com>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Tue, 23 Apr 2013 22:11:40 +0300
Message-ID: <CAHHtCV8Efp+OJ3Rx54_d_dMcSvZnNxdodBK96hSj9=1iLUSB7g@mail.gmail.com>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
	<alpine.DEB.2.10.1304211324450.13746@trent.utfs.org>
	<CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
	<alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:53844 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697Ab3DWTLl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 23 Apr 2013 15:11:41 -0400
Received: by mail-vc0-f182.google.com with SMTP id ht11so1004110vcb.41
        for <ecryptfs@vger.kernel.org>; Tue, 23 Apr 2013 12:11:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian Kujau <lists@nerdbynature.de>
Cc: Mike Reinstein <reinstein.mike@gmail.com>, ecryptfs@vger.kernel.org

On Mon, Apr 22, 2013 at 2:29 AM, Christian Kujau <lists@nerdbynature.de> wrote:
> On Sun, 21 Apr 2013 at 13:54, Mike Reinstein wrote:
>> Maybe I'm just misunderstanding the problem. Is it being suggested that the
>> unencrypted copy of the data should be backed up over sshfs to an untrusted
>> machine?
>
> No, I think the untrusted machine would hold the encrypted data, which is
> mounted to a trusted machine, where it's then decrypted via ecryptfs.

You're right, that's the idea. I want to run the crypto on the trusted
machine and only use the untrusted one as dumb storage.

I'm running arch, ecryptfs-utils 103, sshfs 2.4, kernel 3.8.8, so very
similar to yours. Running strace was a good idea, the relevant bit is:

utimensat(4, NULL, {{1366539595, 699650012}, {1366539595, 699650012}},
0) = -1 EPERM (Operation not permitted)

The setup that fails is thus: The sshfs is mounted by my regular user
with -o allow_root and the ecryptfs is mounted from a root console.

I tried doing both the sshfs and ecryptfs mounts by root and that
worked. I'm assuming it's a problem if the sshfs and ecryptfs are
"running as different users". Frankly, I'm not at all sure what
"running as a user" means in the context of kernel code like fuse and
ecryptfs, does this ring any bells?

Are both mounts in your setup done by a non-root user? If yes, what's
the correct way to mount an ecryptfs as a user? I tried adding a line
to /etc/fstab with <all the options>,user,noauto and it didn't work.
The arch wiki (
https://wiki.archlinux.org/index.php/ECryptfs#Mounting_.28the_hard_way.29
) suggests /sbin/mount.ecryptf should be suid root, but that doesn't
make it work either.
