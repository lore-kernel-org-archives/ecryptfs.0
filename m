From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Subject: Re: Odd problem with ECryptFS keys
Date: Fri, 9 Nov 2012 16:38:53 +0200
Message-ID: <CAMR49LrJuB=M-Y-QUj3wnfkUSqhgNo3a-16RMNJWa1ciiFcrRw@mail.gmail.com>
References: <CAMR49Lo8PuAsngRwYtPeTQW02T3gkbak=TuU5v-UcUQhPvMHgA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34690 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab2KIOiz (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 9 Nov 2012 09:38:55 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4080817oag.19
        for <ecryptfs@vger.kernel.org>; Fri, 09 Nov 2012 06:38:55 -0800 (PST)
In-Reply-To: <CAMR49Lo8PuAsngRwYtPeTQW02T3gkbak=TuU5v-UcUQhPvMHgA@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Found out why it works like this. Kernel keeps those keys in clear
text and encrypts FEFEK only when exported to user space. That explain
the behavior. Sorry for the extra traffic.. Thanks.

/Jarkko

On Fri, Nov 9, 2012 at 8:49 AM, Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:
> Hi
>
> I'm experiencing a bizarre problem with ECryptFS keys.
>
> Preconditions:
> - 3.7-rc4 mainline kernel.
> - Minimal RootFS made with BuildRoot, bundled into kernel image
>   (initramfs).
> - Fresh boot.
> - 32 MB FAT loopback image mounted on /mnt.
>
> I execute the following sequence:
>
> mykeyid=`keyctl add encrypted 1000100010001000 "new ecryptfs
> user:device-key 64" @u`
> echo $mykeyid
> keyctl print $mykeyid
> keyctl list @u
> mount -t ecryptfs
> -oecryptfs_sig=1000100010001000,ecryptfs_fnek_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32
> /mnt /mnt
> echo "mount returned $?"
> mount|grep ecryptfs
> keyctl list @u
>
> Execution:
>
> # mykeyid=`keyctl add encrypted 1000100010001000 "new ecryptfs
> user:device-key 64" @u`
> # echo $mykeyid
> 541909842
> # keyctl print $mykeyid
> keyctl_read_alloc: Cannot allocate memory
> # EXPECTED
> # keyctl list @u
> 1 key in keyring:
> 541909842: --alswrv     0     0 encrypted: 1000100010001000
> # mount -t ecryptfs
> -oecryptfs_sig=1000100010001000,ecryptfs_fnek_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32
> /mnt /mnt
> # echo "mount returned $?"
> mount returned 0
> # mount|grep ecryptfs
> /mnt on /mnt type ecryptfs
> (rw,relatime,ecryptfs_fnek_sig=1000100010001000,ecryptfs_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32)
> # NOT EXPECTED. Shouldn't this fail?
> # keyctl list @u
> 1 key in keyring:
> 541909842: --alswrv     0     0 encrypted: 1000100010001000
>
> Why does mount work? Thanks.
>
> /Jarkko
