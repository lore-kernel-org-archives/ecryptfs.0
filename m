From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Subject: Odd problem with ECryptFS keys
Date: Fri, 9 Nov 2012 08:49:10 +0200
Message-ID: <CAMR49Lo8PuAsngRwYtPeTQW02T3gkbak=TuU5v-UcUQhPvMHgA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52412 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2KIGtL (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 9 Nov 2012 01:49:11 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so3701551obb.19
        for <ecryptfs@vger.kernel.org>; Thu, 08 Nov 2012 22:49:10 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi

I'm experiencing a bizarre problem with ECryptFS keys.

Preconditions:
- 3.7-rc4 mainline kernel.
- Minimal RootFS made with BuildRoot, bundled into kernel image
  (initramfs).
- Fresh boot.
- 32 MB FAT loopback image mounted on /mnt.

I execute the following sequence:

mykeyid=`keyctl add encrypted 1000100010001000 "new ecryptfs
user:device-key 64" @u`
echo $mykeyid
keyctl print $mykeyid
keyctl list @u
mount -t ecryptfs
-oecryptfs_sig=1000100010001000,ecryptfs_fnek_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32
/mnt /mnt
echo "mount returned $?"
mount|grep ecryptfs
keyctl list @u

Execution:

# mykeyid=`keyctl add encrypted 1000100010001000 "new ecryptfs
user:device-key 64" @u`
# echo $mykeyid
541909842
# keyctl print $mykeyid
keyctl_read_alloc: Cannot allocate memory
# EXPECTED
# keyctl list @u
1 key in keyring:
541909842: --alswrv     0     0 encrypted: 1000100010001000
# mount -t ecryptfs
-oecryptfs_sig=1000100010001000,ecryptfs_fnek_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32
/mnt /mnt
# echo "mount returned $?"
mount returned 0
# mount|grep ecryptfs
/mnt on /mnt type ecryptfs
(rw,relatime,ecryptfs_fnek_sig=1000100010001000,ecryptfs_sig=1000100010001000,ecryptfs_cipher=aes,ecryptfs_key_bytes=32)
# NOT EXPECTED. Shouldn't this fail?
# keyctl list @u
1 key in keyring:
541909842: --alswrv     0     0 encrypted: 1000100010001000

Why does mount work? Thanks.

/Jarkko
