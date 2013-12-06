From: "Raj [mail list]" <rajlistuser@gmail.com>
Subject: Fwd: Mounting multiple directories using ecryptfs
Date: Fri, 6 Dec 2013 16:33:59 +0530
Message-ID: <CAE56t+U6YRPtc4q-73QgvQEbh4HKJ06i8KE3PFisY5H5w4L-gQ@mail.gmail.com>
References: <CAE56t+XVmmOrKXre=gjs-6N142QunV-57aBf3GBwgbw-4EtgZQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-we0-f196.google.com ([74.125.82.196]:47283 "EHLO
	mail-we0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757687Ab3LFLEC (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 6 Dec 2013 06:04:02 -0500
Received: by mail-we0-f196.google.com with SMTP id w61so144198wes.7
        for <ecryptfs@vger.kernel.org>; Fri, 06 Dec 2013 03:04:01 -0800 (PST)
In-Reply-To: <CAE56t+XVmmOrKXre=gjs-6N142QunV-57aBf3GBwgbw-4EtgZQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

A gentle reminder to see if some one can help me with this.

I have posted this to StackOverflow too, but with no results. Link to
the SO question:

http://stackoverflow.com/questions/20248427/

Thanks and regards,

Raj

---------- Forwarded message ----------
From: Raj [mail list] <rajlistuser@gmail.com>
Date: Thu, Nov 28, 2013 at 11:27 AM
Subject: Mounting multiple directories using ecryptfs
To: ecryptfs@vger.kernel.org


Hi List,

I am using ecryptyfs to store some sensitive data in my PC (Debian
wheezy). The data is in a partition and the partition is mounted
automatically on bootup using /etc/fstab I have setup
/root/.ecryptfsrc with correct parameters. Contents of my .ecryptfsrc
are as follows:

    key=passphrase:passphrase_passwd_file=/mnt/usb/password.txt
    ecryptfs_sig=deadbeefdeadbeef
    ecryptfs_cipher=aes
    ecryptfs_key_bytes=16
    ecryptfs_passthrough=n
    ecryptfs_enable_filename_crypto=n

This partition is correctly getting mounted after a system reboot. So far fine.

I also need to transport this sensitive data to a remote place in a
USB drive securely. So I want to format a usb drive with ext2 fs and
mount it using ecryptfs. I also do not want to reuse the password and
want to give an one time password to each USB drive when the ecryptfs
is mounted.

Formatting and mounting of ext2 partition works as expected. The
command I used for mounting the new usb device using ecryptfs is as
follows. the password is stored (temporarily) in /root/usbpasswd.txt :

    mount  -t ecryptfs  \
    -o "rw,key=passphrase:passphrase_passwd_file=/root/usbpasswd.txt,\
    ecryptfs_unlink_sigs,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,\
    ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=y" \
    /mnt/usb2/ /mnt/usb2/

Instead of mounting the freshly formatted /mnt/usb2 using password in
file, I am prompted for `Passphrase File` as follows:

    Passphrase File: /root/usbpasswd.txt
    Passphrase File: /mnt/usb/password.txt
    Passphrase File: /root/usbpasswd.txt
    Passphrase File: ^C

What could be wrong here?

Thanks and regards,

Raj
