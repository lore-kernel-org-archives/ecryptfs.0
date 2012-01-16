From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: ecryptfs =?iso-8859-1?q?doesn=B4t_like_noauto_and?= noatime
Date: Mon, 16 Jan 2012 10:44:21 +0100
Message-ID: <201201161044.21718.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:53373 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJoX convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 16 Jan 2012 04:44:23 -0500
Received: from merkaba.localnet (blackhole.teamix.net [194.150.191.251])
	by mail.lichtvoll.de (Postfix) with ESMTPSA id D368632A
	for <ecryptfs@vger.kernel.org>; Mon, 16 Jan 2012 10:44:43 +0100 (CET)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: ecryptfs@vger.kernel.org

Hi!

I have

merkaba:~> grep ecrypt /etc/fstab
/home/.ms               /home/ms                ecryptfs       =20
noatime,noauto  0       0

And get:

merkaba:~> mount /home/ms
Passphrase:=20
Attempting to mount with the following options:
  ecryptfs_unlink_sigs
  ecryptfs_fnek_sig=3D0408d19ec184c207
  ecryptfs_key_bytes=3D32
  ecryptfs_cipher=3Daes
  ecryptfs_sig=3D0408d19ec184c207
Error mounting eCryptfs: [-5] Input/output error
Check your system logs; visit <http://launchpad.net/ecryptfs>


Still it works.


In dmesg I see:

[ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized option=20
[noauto]
[ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized option=20
[noatime]
[ 2657.913215] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni=
)


Thus I removed at least noatime, but then I still see:

[ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized option=20
[noauto]


On could argue about noatime when ecryptfs doesn=B4t override the setti=
ng of=20
the underlying filesystem - i.e. doesn=B4t write the atime itself. But =
I=20
think noauto should be silently ignored.

Without noatime it would ask me the passwort upon boot, but I do not li=
ke=20
that since I do not use that user everytime.

I could use mounting via pam, but I like to have a different password f=
or=20
the user stored in /etc/shadow than the password from the filesystem=20
itself.


Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
