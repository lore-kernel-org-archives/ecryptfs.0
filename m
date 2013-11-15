From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: ecryptfs-mount-private fails the first time after boot
Date: Fri, 15 Nov 2013 17:51:49 -0500
Message-ID: <CAAk6P0VYWJA+pC6CfeLKhZc6kZ5EVASS+8ELoAUEWCOnqVhhuw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57879 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3KOWvu (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 15 Nov 2013 17:51:50 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so4111316wgh.23
        for <ecryptfs@vger.kernel.org>; Fri, 15 Nov 2013 14:51:49 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

I don't know if this list is the right place to be asking this
question; please let me know if there's a better place.  I'm not
subscribed to the list so please CC me on replies.

I'm using ecryptfs on Scientific Linux 6.4 (kernel
2.6.32-358.23.2.el6.x86_64, ecryptfs-utils 82-6.el6_1.3) and I'm
having a minor but annoying problem.  The first time I run
'ecryptfs-mount-private' after booting the system, it always fails.
(It's happened at least 10 times; I'm quite certain that I'm entering
the passphrase correctly.)  I then need to run
'ecryptfs-umount-private' and 'ecryptfs-mount-private' again in order
for my files to finally show up.

I believe I selected all the default options when I set the filesystem
up, except that I had it use a separate passphrase, not my login
password.  It's encrypted with AES and filename encryption is enabled.
 It's mounted at /home/benjamin/Private/ and the encrypted files are
stored in /home/benjamin/.Private/.

When I run ecryptfs-mount-private for the first time, it shows the following:

$ ecryptfs-mount-private
Enter your wrapping passphrase:
Inserted auth tok with sig [...] into the user session keyring
keyctl_search: Required key not available
Perhaps try the interactive 'ecryptfs-mount-private'

At this point, the following messages appear in dmesg:

$ dmesg
...
TECH PREVIEW: ecryptfs may not be fully supported.
Please review provided documentation for limitations.
SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts

And at this point, the filesystem is *mounted* but the files are not
correctly decrypted (i.e. Private appears to be an exact mirror of
.Private):

$ ls Private/
ECRYPTFS_FNEK_ENCRYPTED.FWaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLCHzv3PNoOtExPXP.Ei0KiAE--
ECRYPTFS_FNEK_ENCRYPTED.FXaO.4n6KQUoiUR2FAbPNmeUAR1Zw4f3.rLC-NRvX4ESyXeGh90V8z6JRo2qp.xjwPLn8Fz1BXP8u22-
...

I then unmount and remount it:

$ ecryptfs-umount-private
keyctl_search: Required key not available
Perhaps try the interactive 'ecryptfs-mount-private'

$ ecryptfs-mount-private
Enter your wrapping passphrase:
Inserted auth tok with sig [...] into the user session keyring

at which point it works as expected.  If I later run
ecryptfs-umount-private again, it doesn't display the 'keyctl_search'
error message.

So, does anyone know why this might be happening?  Is it a known bug
in the kernel and/or ecryptfs-utils?  If it's not easy to fix, is
there a workaround?

Thanks in advance,
Benjamin Moody
