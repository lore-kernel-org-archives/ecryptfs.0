From: James Muir <muir.james.a@gmail.com>
Subject: porting to android
Date: Sun, 15 Sep 2013 00:05:20 -0400
Message-ID: <52353200.9040101@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45845 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3IOEFY (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 15 Sep 2013 00:05:24 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so2586019oag.36
        for <ecryptfs@vger.kernel.org>; Sat, 14 Sep 2013 21:05:21 -0700 (PDT)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello list,

I'm interested in porting some of the ecryptfs userland tools to android
- -- specifically, I want to get the mount and umount utilities working.

I've hacked around a bit and see that there is a dependency with Mozilla
NSS (e.g. in the functions ecryptfs_wrap_passphrase and
ecryptfs_unwrap_passphrase).  Apparently, NSS can be built for Android,
but before I go further down the hole, I wondered if someone more
familiar with the user tools might have some perspective to share.  My
impression is that getting the tools working on Android shouldn't
be too difficult, but I wonder if I am being too optimistic...  if I
sort out NSS, will it be smooth sailing?

Note the ./configure script suggests that it is possible to build
against gcrypt rather than NSS ("--disable-nss           Build against
gcrypt rather than NSS"), but I suspect that configuration hasn't
actually been implemented yet.  Has anyone built the user tools using
gcrypt?

More generally, has anyone worked on porting these utilities
previously?  I've googled and found mention that ecryptfs is used on
the Droid X but the source code was not published:

http://android.stackexchange.com/questions/20105/motorola-droidx-ecryptfs-related-sources

Also, the following blueprint suggests that an android port has been on
the Linaro backlog for some time:

https://blueprints.launchpad.net/linaro-android/+spec/linaro-android-integrate-ecryptfs

thanks for your help,

- -James

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI1MgAACgkQ4Arkm0Hw/FLFYgCbBoS8p2yHQjpx0b/zW9xzPxRs
d98AoIGvDYK3EK35zISXxc9I3tXQnWAb
=8Nr5
-----END PGP SIGNATURE-----
