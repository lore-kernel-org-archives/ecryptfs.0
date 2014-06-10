From: Hanks Wang <wangwenjie@cmos.net>
Subject: kernel crash after enable ecryptfs under abnormal power off
Date: Tue, 10 Jun 2014 22:13:22 +0800
Message-ID: <53971282.3070909@cmos.net>
References: <536E62DD.8156.E36EA@jafojtik.seznam.cz> <20140527090609.GA26330@boyd> <53970CB4.5050004@cmos.net> <5397116B.2040502@cmos.net> <539711F6.4040804@cmos.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34919 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaFJON1 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 10 Jun 2014 10:13:27 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so6291600pbb.21
        for <ecryptfs@vger.kernel.org>; Tue, 10 Jun 2014 07:13:26 -0700 (PDT)
In-Reply-To: <539711F6.4040804@cmos.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, =?UTF-8?B?6YKi5Yip5oyv?= <xinglizhen@cmos.net>


Hi Tyler,

It happened kernel crash if we enable ecryptfs in kernel-space and moun=
t=20
ecryptfs in the user-space if we reboot device after the device is=20
powered off abnormally, such as the device is pulled off power line. At=
=20
the same time, if we normally power off the device and reboot it, it=20
works well. I don't try this case on the computer device, it just=20
happened on my own mobile device, because I want to use ecryptfs on the=
=20
mobile area.

I also read your formal mail thread about kernel crash=20
http://lkml.iu.edu/hypermail/linux/kernel/1203.1/03801.html, which seem=
s=20
to be crashed on the same line. Actually, I used the parameter of=20
ecryptfs_passthrouth to enable plain test readable. Could you kindly=20
give me some suggestion about how to quick debug or resolve this proble=
m?



My method to mount ecryptfs file system is following:

mount -t ecryptfs =EF=BD=9E/encrypt  ~/encrypt  -o ecryptfs_key_bytes=3D=
32 -o=20
ecryptfs_cipher=3Daes -o no_sig_cache -o passphrase_passwd=3D%s -o=20
ecryptfs_enable_filename_crypto=3Dn  -o ecryptfs_passthrough -o key=3Dp=
assphrase


Detail crash information is:
-----------------------------------------------------------------------=
---------------------------
[   87.924154] c3 kernel BUG at=20
/home/abuild/rpmbuild/BUILD/kernel-pachira-3.4.5/kernel/fs/ecryptfs/cry=
pto.c:464!
[   87.934258] c3 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   87.940376] c3 Modules linked in: ittiam mali(O) ump(O)
[   87.945661] c3 CPU: 3    Tainted: G           O  (3.4.5 #1)
[   87.951261] c3 PC is at ecryptfs_encrypt_page+0x34/0x390
[   87.956646] c3 LR is at ecryptfs_writepage+0x4c/0x9c
[   87.961623] c3 pc : [<c0202a4c>]    lr : [<c0201574>]    psr: 400700=
13
[   87.961635] c3 sp : c37d3c50  ip : c37d3ce0  fp : c37d3cdc
[   87.973668] c3 r10: 00000000  r9 : db6f1948  r8 : c0fb1874
[   87.979199] c3 r7 : c0fb1874  r6 : dc914840  r5 : dc914918  r4 : dc9=
149c4
[   87.985985] c3 r3 : 00000003  r2 : c37d3ce0  r1 : c37d3e40  r0 : c0f=
b1874
[   87.992836] c3 Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM=20
Segment kernel
[   88.000477] c3 Control: 10c53c7d  Table: 9b6ec06a  DAC: 00000015
[   88.006497] c3
[   88.006503] c3 PC: 0xc02029cc:
[   88.011351] c3 29cc  e0614004 ea000003 e3560000 e0855004 15834008=20
e3a04000 e2800001 e2833010
[   88.019773] c3 29ec  e1500007 a3a02000 b3a02001 e3540000 d3a02000=20
e3520000 1affffd9 e3540000
[   88.028275] c3 2a0c  c3e0000b e89daff8 c0bea5d0 e1a0c00d e92ddff0=20
e24cb004 e24dd064 e92d4000
=2E.....

[   89.134149] c3 [<c0202a4c>] (ecryptfs_encrypt_page+0x34/0x390) from=20
[<c0201574>] (ecryptfs_writepage+0x4c/0x9c)
[   89.134173] c3 [<c0201574>] (ecryptfs_writepage+0x4c/0x9c) from=20
[<c00e2a58>] (__writepage+0x24/0x48)
[   89.134195] c3 [<c00e2a58>] (__writepage+0x24/0x48) from [<c00e305c>=
]=20
(write_cache_pages+0x2f4/0x404)
[   89.134215] c3 [<c00e305c>] (write_cache_pages+0x2f4/0x404) from=20
[<c00e31bc>] (generic_writepages+0x50/0x6c)
[   89.134234] c3 [<c00e31bc>] (generic_writepages+0x50/0x6c) from=20
[<c00e4934>] (do_writepages+0x3c/0x48)
[   89.134255] c3 [<c00e4934>] (do_writepages+0x3c/0x48) from=20
[<c0143ca8>] (writeback_single_inode+0x1c4/0x40c)
[   89.134276] c3 [<c0143ca8>] (writeback_single_inode+0x1c4/0x40c) fro=
m=20
[<c0144200>] (writeback_sb_inodes+0x15c/0x214)
[   89.134295] c3 [<c0144200>] (writeback_sb_inodes+0x15c/0x214) from=20
[<c014432c>] (__writeback_inodes_wb+0x74/0xc0)
[   89.134315] c3 [<c014432c>] (__writeback_inodes_wb+0x74/0xc0) from=20
[<c0144538>] (wb_writeback+0x1c0/0x364)
[   89.134333] c3 [<c0144538>] (wb_writeback+0x1c0/0x364) from=20
[<c0144bd4>] (wb_do_writeback+0xf8/0x26c)
[   89.134352] c3 [<c0144bd4>] (wb_do_writeback+0xf8/0x26c) from=20
[<c0144e34>] (bdi_writeback_thread+0xec/0x2e4)
[   89.134373] c3 [<c0144e34>] (bdi_writeback_thread+0xec/0x2e4) from=20
[<c005f3d8>] (kthread+0x9c/0xa8)
[   89.134393] c3 [<c005f3d8>] (kthread+0x9c/0xa8) from [<c000ff54>]=20
(kernel_thread_exit+0x0/0x8)
[   89.134408] c3 Code: e2864f61 e5963184 e3130004 1a000000 (e7f001f2)
