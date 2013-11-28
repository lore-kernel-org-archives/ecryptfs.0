From: "Raj [mail list]" <rajlistuser@gmail.com>
Subject: Mounting multiple directories using ecryptfs
Date: Thu, 28 Nov 2013 11:27:51 +0530
Message-ID: <CAE56t+XVmmOrKXre=gjs-6N142QunV-57aBf3GBwgbw-4EtgZQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:44072 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab3K1F5w (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 28 Nov 2013 00:57:52 -0500
Received: by mail-lb0-f195.google.com with SMTP id l4so1567821lbv.10
        for <ecryptfs@vger.kernel.org>; Wed, 27 Nov 2013 21:57:51 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
