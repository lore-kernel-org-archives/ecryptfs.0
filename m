From: James Muir <muir.james.a@gmail.com>
Subject: Re: Fwd: Mounting multiple directories using ecryptfs
Date: Fri, 06 Dec 2013 10:48:39 -0500
Message-ID: <52A1F1D7.5060601@gmail.com>
References: <CAE56t+XVmmOrKXre=gjs-6N142QunV-57aBf3GBwgbw-4EtgZQ@mail.gmail.com> <CAE56t+U6YRPtc4q-73QgvQEbh4HKJ06i8KE3PFisY5H5w4L-gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:38812 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694Ab3LFPsl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 6 Dec 2013 10:48:41 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so1456348ief.6
        for <ecryptfs@vger.kernel.org>; Fri, 06 Dec 2013 07:48:41 -0800 (PST)
In-Reply-To: <CAE56t+U6YRPtc4q-73QgvQEbh4HKJ06i8KE3PFisY5H5w4L-gQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Raj [mail list]" <rajlistuser@gmail.com>, ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/06/2013 06:03 AM, Raj [mail list] wrote:

> Formatting and mounting of ext2 partition works as expected. The 
> command I used for mounting the new usb device using ecryptfs is
> as follows. the password is stored (temporarily) in
> /root/usbpasswd.txt :
> 
> mount  -t ecryptfs  \ -o
> "rw,key=passphrase:passphrase_passwd_file=/root/usbpasswd.txt,\ 
> ecryptfs_unlink_sigs,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,\ 
> ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=y" \ 
> /mnt/usb2/ /mnt/usb2/
> 

have you tried dropping the quotes on the options-string?

- -James M

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKh8c4ACgkQ4Arkm0Hw/FJWxACeL1DjlzWWuTJqKnBwdHuJaEk9
Nt4AmwYcUtwoAZWeUxGgrqjuIL90w+GW
=lDxx
-----END PGP SIGNATURE-----
