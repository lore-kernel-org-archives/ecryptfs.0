From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: kernel crash after enable ecryptfs under abnormal power off
Date: Thu, 12 Jun 2014 14:21:03 -0500
Message-ID: <20140612192102.GA3852@boyd>
References: <536E62DD.8156.E36EA@jafojtik.seznam.cz>
 <20140527090609.GA26330@boyd>
 <53970CB4.5050004@cmos.net>
 <5397116B.2040502@cmos.net>
 <539711F6.4040804@cmos.net>
 <53971282.3070909@cmos.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49093 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaFLTVN (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 12 Jun 2014 15:21:13 -0400
Content-Disposition: inline
In-Reply-To: <53971282.3070909@cmos.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Hanks Wang <wangwenjie@cmos.net>
Cc: ecryptfs@vger.kernel.org, =?utf-8?B?6YKi5Yip5oyv?= <xinglizhen@cmos.net>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-06-10 22:13:22, Hanks Wang wrote:
>=20
> Hi Tyler,
>=20
> It happened kernel crash if we enable ecryptfs in kernel-space and
> mount ecryptfs in the user-space if we reboot device after the
> device is powered off abnormally, such as the device is pulled off
> power line. At the same time, if we normally power off the device
> and reboot it, it works well. I don't try this case on the computer
> device, it just happened on my own mobile device, because I want to
> use ecryptfs on the mobile area.
>=20
> I also read your formal mail thread about kernel crash
> http://lkml.iu.edu/hypermail/linux/kernel/1203.1/03801.html, which
> seems to be crashed on the same line. Actually, I used the parameter
> of ecryptfs_passthrouth to enable plain test readable. Could you
> kindly give me some suggestion about how to quick debug or resolve
> this problem?

You don't want to enable ecryptfs_passthrough. That will treat the file
as a plaintext file and writes to the file won't be encrypted. I doubt
that's what you want.

> My method to mount ecryptfs file system is following:
>=20
> mount -t ecryptfs =EF=BD=9E/encrypt  ~/encrypt  -o ecryptfs_key_bytes=3D3=
2 -o
> ecryptfs_cipher=3Daes -o no_sig_cache -o passphrase_passwd=3D%s -o
> ecryptfs_enable_filename_crypto=3Dn  -o ecryptfs_passthrough -o
> key=3Dpassphrase
>=20
>=20
> Detail crash information is:
> -------------------------------------------------------------------------=
-------------------------
> [   87.924154] c3 kernel BUG at /home/abuild/rpmbuild/BUILD/kernel-pachir=
a-3.4.5/kernel/fs/ecryptfs/crypto.c:464!
> [   87.934258] c3 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> [   87.940376] c3 Modules linked in: ittiam mali(O) ump(O)
> [   87.945661] c3 CPU: 3    Tainted: G           O  (3.4.5 #1)
> [   87.951261] c3 PC is at ecryptfs_encrypt_page+0x34/0x390
> [   87.956646] c3 LR is at ecryptfs_writepage+0x4c/0x9c
> [   87.961623] c3 pc : [<c0202a4c>]    lr : [<c0201574>]    psr: 40070013
> [   87.961635] c3 sp : c37d3c50  ip : c37d3ce0  fp : c37d3cdc
> [   87.973668] c3 r10: 00000000  r9 : db6f1948  r8 : c0fb1874
> [   87.979199] c3 r7 : c0fb1874  r6 : dc914840  r5 : dc914918  r4 : dc914=
9c4
> [   87.985985] c3 r3 : 00000003  r2 : c37d3ce0  r1 : c37d3e40  r0 : c0fb1=
874
> [   87.992836] c3 Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA
> ARM Segment kernel
> [   88.000477] c3 Control: 10c53c7d  Table: 9b6ec06a  DAC: 00000015
> [   88.006497] c3
> [   88.006503] c3 PC: 0xc02029cc:
> [   88.011351] c3 29cc  e0614004 ea000003 e3560000 e0855004 15834008
> e3a04000 e2800001 e2833010
> [   88.019773] c3 29ec  e1500007 a3a02000 b3a02001 e3540000 d3a02000
> e3520000 1affffd9 e3540000
> [   88.028275] c3 2a0c  c3e0000b e89daff8 c0bea5d0 e1a0c00d e92ddff0
> e24cb004 e24dd064 e92d4000
> ......
>=20
> [   89.134149] c3 [<c0202a4c>] (ecryptfs_encrypt_page+0x34/0x390)
> from [<c0201574>] (ecryptfs_writepage+0x4c/0x9c)
> [   89.134173] c3 [<c0201574>] (ecryptfs_writepage+0x4c/0x9c) from
> [<c00e2a58>] (__writepage+0x24/0x48)
> [   89.134195] c3 [<c00e2a58>] (__writepage+0x24/0x48) from
> [<c00e305c>] (write_cache_pages+0x2f4/0x404)
> [   89.134215] c3 [<c00e305c>] (write_cache_pages+0x2f4/0x404) from
> [<c00e31bc>] (generic_writepages+0x50/0x6c)
> [   89.134234] c3 [<c00e31bc>] (generic_writepages+0x50/0x6c) from
> [<c00e4934>] (do_writepages+0x3c/0x48)
> [   89.134255] c3 [<c00e4934>] (do_writepages+0x3c/0x48) from
> [<c0143ca8>] (writeback_single_inode+0x1c4/0x40c)
> [   89.134276] c3 [<c0143ca8>] (writeback_single_inode+0x1c4/0x40c)
> from [<c0144200>] (writeback_sb_inodes+0x15c/0x214)
> [   89.134295] c3 [<c0144200>] (writeback_sb_inodes+0x15c/0x214)
> from [<c014432c>] (__writeback_inodes_wb+0x74/0xc0)
> [   89.134315] c3 [<c014432c>] (__writeback_inodes_wb+0x74/0xc0)
> from [<c0144538>] (wb_writeback+0x1c0/0x364)
> [   89.134333] c3 [<c0144538>] (wb_writeback+0x1c0/0x364) from
> [<c0144bd4>] (wb_do_writeback+0xf8/0x26c)
> [   89.134352] c3 [<c0144bd4>] (wb_do_writeback+0xf8/0x26c) from
> [<c0144e34>] (bdi_writeback_thread+0xec/0x2e4)
> [   89.134373] c3 [<c0144e34>] (bdi_writeback_thread+0xec/0x2e4)
> from [<c005f3d8>] (kthread+0x9c/0xa8)
> [   89.134393] c3 [<c005f3d8>] (kthread+0x9c/0xa8) from [<c000ff54>]
> (kernel_thread_exit+0x0/0x8)
> [   89.134408] c3 Code: e2864f61 e5963184 e3130004 1a000000 (e7f001f2)

This is a tough one to solve correctly. There's a small amount of time
between eCryptfs creating the file in the lower filesystem and eCryptfs
initializing that file with its metadata. Your device was likely shut
off between those two events.

I see that you're running kernel 3.4.5. In 3.5, I added a (somewhat
ugly) workaround for problems like this:

  e3ccaa9 eCryptfs: Initialize empty lower files when opening them

I think it would solve your problem if you didn't mount with
ecryptfs_passthrough. However, when ecryptfs_passthrough is used,
eCryptfs can't make an assumption about whether an uninitialized lower
file should be turned into an eCryptfs file or if it should remain as a
plaintext file.

Tyler

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTmf2eAAoJENaSAD2qAscKRv4QAL5k86Lbmxwu6F8DoTNV/DhN
exlEMiVxec53j7aud/z1p2jDCc2nwK1ztikYtA5wNB6d6Z0IjwxotNbaVy38lCAG
a0izBgYZNN2vuwGVqQcdPuXxC6cTKvVgMnPuP9qeSj4ac11FtvGF085eRuThI8lu
/p3Jggv7TYHnerUpE3KYVNous+mwnECVVz+AtFaSP4MXYZNrc3NKP8RxtSrqOVPl
KVHFsww/rMqWLfrOtVZY3ka0hfOJCqoeRHGXnYgjm+GOssyEDUcXfM9Fif7s24xa
s+oxlKC3l9zgIg6EnnnD8d6pCSlY9bToBwx/esui4Zyz0gJ6tGDjq115X6uSqclL
TtJz0C/u8f1TCK2f0D7sLGFs31aDEnfjeSksBU5HKkbmEgryTR0Jdt8EUsVbhr4v
Ya9Uzuf7pJwaK3AKvH9XelyVO3A+l5S+ZyQmg0p55cgTmuNIep2pTScbZ71vviGl
WZccY27U/sX0agT3IlCgSk2r8nCZrjiL21Ymq4rqHqBzqyr2M3Mi4OGuIj9QWEtW
pld+8SeYOt6Xq5N1eBmtdbutjnpyCoGvzOj28OohiaC+fbfiWYu2dK8rrQdc3Jdk
HXmHkdImiHhg6mKzePmZtL1i/RdblaKSWbOUqpb0y3ySoiFQ/nIGXZcA/DATj+cl
Z8iMnGkHEhRe4AwTwi4T
=SVG1
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
