From: "B. J. Potter" <bjpotter@gmail.com>
Subject: Possible error in ecryptfs-recover-private
Date: Mon, 26 Nov 2012 15:32:07 -0600
Message-ID: <CACDOv82xsXsO6KgLFKbHApszk0OYwACgvo7Ffpnx4Nj1yQpnDQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64485 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab2KZVcJ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 26 Nov 2012 16:32:09 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4838071bkw.19
        for <ecryptfs@vger.kernel.org>; Mon, 26 Nov 2012 13:32:07 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hello all,

I believe there is an error in the ecryptfs-recover-private script
that was exposed when I tried to mount my ecryptfs manually on my
recently updated Arch Linux system (some of the ecryptfs setup was
done when the same RAID drive was attached to an Ubuntu Linux system).
First I issued an ecryptfs recover command:

ecryptfs-recover-private /home/.ecryptfs/bpotter/.Private

This will:

Find the directory, I tell it to recover (yes)
It finds the wrapped passphrase, I tell it yes I know my login
password and enter it
It inserts token with correct sig into the keyring, but then errors
out with this error:

sed: can't read /home/.ecryptfs/bpotter/.Private/../.ecryptfs/Private.sig:...
No such file or directory

At this point I run 'sudo mount /home/bpotter', which mounts as per my fstab:

/home/.ecryptfs/bpotter/.Private /home/bpotter ecryptfs...
rw,user,noauto,exec,relatime,ecryptfs_fnek_sig=07fa32a41b76c74a,...
ecryptfs_sig=07fa32a41b76c74a,ecryptfs_cipher=aes,...
ecryptfs_key_bytes=32,ecryptfs_passthrough,...
ecryptfs_unlink_sigs 0 0

Next it asks me to select the key type for newly created files. I pick
2) passpharse and give it my login passphrase. It tells me it hasn't
seen this combination, but mounts just fine. I can read and write all
of my files. I covered this and tried to find an answer as to why this
is happening in Stack Exchange's Super User as well:
http://superuser.com/questions/507948/ecryptfs-home-directory-does-not-automatically-mount

I just wanted to inform the list of the possible error in the
ecryptfs-recover-private script. If anyone can help me find why my
automatic mounting has failed, then that's a bonus.

Thanks,

B. J. Potter
