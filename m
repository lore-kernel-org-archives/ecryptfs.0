From: "Raj [mail list]" <rajlistuser@gmail.com>
Subject: Re: Fwd: Mounting multiple directories using ecryptfs
Date: Mon, 9 Dec 2013 11:56:07 +0530
Message-ID: <CAE56t+XSH_LpHy5j_NEt2+-qWyiV97FV7hL1zhy0DPRASV1PVg@mail.gmail.com>
References: <CAE56t+XVmmOrKXre=gjs-6N142QunV-57aBf3GBwgbw-4EtgZQ@mail.gmail.com>
	<CAE56t+U6YRPtc4q-73QgvQEbh4HKJ06i8KE3PFisY5H5w4L-gQ@mail.gmail.com>
	<52A1F1D7.5060601@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:33294 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341Ab3LIG0I (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 9 Dec 2013 01:26:08 -0500
Received: by mail-wi0-f195.google.com with SMTP id hn9so1137056wib.6
        for <ecryptfs@vger.kernel.org>; Sun, 08 Dec 2013 22:26:07 -0800 (PST)
In-Reply-To: <52A1F1D7.5060601@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org
Cc: James Muir <muir.james.a@gmail.com>

On Fri, Dec 6, 2013 at 9:18 PM, James Muir <muir.james.a@gmail.com> wrote:
>> mount  -t ecryptfs  \ -o
>> "rw,key=passphrase:passphrase_passwd_file=/root/usbpasswd.txt,\
>> ecryptfs_unlink_sigs,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,\
>> ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=y" \
>> /mnt/usb2/ /mnt/usb2/
>>
>
> have you tried dropping the quotes on the options-string?

Tried now, No change in result.

# mount  -t ecryptfs -o
rw,key=passphrase:passphrase_passwd_file=/root/usbpasswd.txt,ecryptfs_unlink_sigs,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=y
/mnt/usb2/ /mnt/usb2/
Passphrase File: /root/usbpasswd.txt
Passphrase File: ^C
#

Its again asking for Passphrase File

Thanks and Regards,

Raj
