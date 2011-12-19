From: Martin Steigerwald <ms@teamix.de>
Subject: ecryptfs_write_metadata: Error writing metadata out to lower file; rc = [-13]
Date: Mon, 19 Dec 2011 13:26:19 +0100
Message-ID: <201112191326.20172.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:53724 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752450Ab1LSMdt convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 19 Dec 2011 07:33:49 -0500
Received: from zimbra.of.teamix.net (unknown [172.21.242.23])
	by rproxy.teamix.net (Postfix) with ESMTP id C8C2B7EEA
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:26:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.of.teamix.net (Postfix) with ESMTP id BE85A146C23
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:26:22 +0100 (CET)
Received: from zimbra.of.teamix.net ([127.0.0.1])
	by localhost (zimbra.of.teamix.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OnznxhHunZLW for <ecryptfs@vger.kernel.org>;
	Mon, 19 Dec 2011 13:26:22 +0100 (CET)
Received: from mango.localnet (mango.of.teamix.net [172.21.123.1])
	by zimbra.of.teamix.net (Postfix) with ESMTPSA id 2F57E146BB8
	for <ecryptfs@vger.kernel.org>; Mon, 19 Dec 2011 13:26:22 +0100 (CET)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: ecryptfs@vger.kernel.org

Hi!

Today I tested again whether ecryptfs would be suitable to replace encf=
s on my=20
laptop. But I found several problems. The blocking one is:

ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning#2> LANG=3DC m=
ake
[=E2=80=A6]
sed: couldn't open temporary file ./sedhqlAcd: Permission denied
[=E2=80=A6]

ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> LANG=3DC ls =
-l | tail=20
-6
ls: cannot access sedhqlAcd: No such file or directory
ls: cannot access sedChky0a: No such file or directory
ls: cannot access sed1eW8Ek: No such file or directory
ls: cannot access sedEjR2oA: No such file or directory
ls: cannot access sedb4JEiI: No such file or directory
ls: cannot access sedy0KQnt: No such file or directory
-?????????  ? ?  ?            ?            ? sedChky0a
-?????????  ? ?  ?            ?            ? sedEjR2oA
----------  1 ms teamix 1143445 Dec  5 10:01 sedNL1bTk
-?????????  ? ?  ?            ?            ? sedb4JEiI
-?????????  ? ?  ?            ?            ? sedhqlAcd
-?????????  ? ?  ?            ?            ? sedy0KQnt


Output in dmesg is:

ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> sudo tail -2=
=20
/var/log/syslog
Dec 19 13:23:30 merkaba kernel: [50999.570071] ecryptfs_write_metadata:=
 Error=20
writing metadata out to lower file; rc =3D [-13]
Dec 19 13:23:30 merkaba kernel: [50999.570083] Error writing headers; r=
c =3D=20
[-13]


Ecryptfs is configured as follows:

merkaba:~> cat .ecryptfsrc
ecryptfs_unlink_sigs
ecryptfs_sig=3D[=E2=80=A6]
ecryptfs_fnek_sig=3D[=E2=80=A6]
ecryptfs_xattr
ecryptfs_key_bytes=3D32
ecryptfs_cipher=3Daes
ecryptfs_passthrough=3Dn

I am using extended attributes to avoid the space waste of 8 KiB per fi=
le.

The underlying filesystem is:

merkaba:~> grep /home /proc/mounts
/dev/mapper/merkaba-home /home ext4=20
rw,noatime,user_xattr,acl,barrier=3D1,stripe=3D128,data=3Dordered 0 0
/home/.ms /home/ms ecryptfs=20
rw,relatime,ecryptfs_fnek_sig=3D[=E2=80=A6],ecryptfs_sig=3D[=E2=80=A6],=
ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D32,ecryptfs_xattr_metadata,e=
cryptfs_unlink_sigs=20
0 0

Kernel is:

ms@merkaba:~> cat /proc/version
Linux version 3.2.0-rc4-amd64 (Debian 3.2~rc4-1~experimental.1)=20
(ben@decadent.org.uk) (gcc version 4.6.2 (Debian 4.6.2-5) ) #1 SMP Sun =
Dec 4=20
18:38:24 UTC 2011


With encfs or from my local workstation via NFS there is no such issue.

Ciao,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
