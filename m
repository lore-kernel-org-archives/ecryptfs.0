From: Martin Steigerwald <ms@teamix.de>
Subject: Re: ecryptfs_write_metadata: Error writing metadata out to lower file; rc = [-13]
Date: Tue, 20 Dec 2011 09:46:13 +0100
Message-ID: <201112200946.14550.ms@teamix.de>
References: <201112191326.20172.ms@teamix.de> <20111220010617.GF14413@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:49520 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638Ab1LTIqS convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Dec 2011 03:46:18 -0500
In-Reply-To: <20111220010617.GF14413@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Am Dienstag, 20. Dezember 2011 schrieb Tyler Hicks:
> On 2011-12-19 13:26:19, Martin Steigerwald wrote:
> > Hi!
> >=20
> > Today I tested again whether ecryptfs would be suitable to replace =
encfs
> > on my
>=20
> > laptop. But I found several problems. The blocking one is:
> Sorry, hopefully we can get them straightened out.

Thanks for taking care.

There is no hurry. Encfs basically works reliably. Only thing is, that =
it is=20
slow at times and tends to use quite a bit of CPU time even on this Thi=
nkPad=20
T520 with Intel Sandybridge i5 and Intel SSD 320. I hope that this will=
 be=20
better with ecryptfs.
=20
> > ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning#2> LANG=3D=
C make
> > [=E2=80=A6]
> > sed: couldn't open temporary file ./sedhqlAcd: Permission denied
> > [=E2=80=A6]
> >=20
> > ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> LANG=3DC=
 ls -l |
> > tail -6
> > ls: cannot access sedhqlAcd: No such file or directory
> > ls: cannot access sedChky0a: No such file or directory
> > ls: cannot access sed1eW8Ek: No such file or directory
> > ls: cannot access sedEjR2oA: No such file or directory
> > ls: cannot access sedb4JEiI: No such file or directory
> > ls: cannot access sedy0KQnt: No such file or directory
> > -?????????  ? ?  ?            ?            ? sedChky0a
> > -?????????  ? ?  ?            ?            ? sedEjR2oA
> > ----------  1 ms teamix 1143445 Dec  5 10:01 sedNL1bTk
> > -?????????  ? ?  ?            ?            ? sedb4JEiI
> > -?????????  ? ?  ?            ?            ? sedhqlAcd
> > -?????????  ? ?  ?            ?            ? sedy0KQnt
> >=20
> >=20
> > Output in dmesg is:
> >=20
> > ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> sudo tai=
l -2
> > /var/log/syslog
> > Dec 19 13:23:30 merkaba kernel: [50999.570071] ecryptfs_write_metad=
ata:
> > Error writing metadata out to lower file; rc =3D [-13]
> > Dec 19 13:23:30 merkaba kernel: [50999.570083] Error writing header=
s; rc
> > =3D [-13]
> >=20
> >=20
> > Ecryptfs is configured as follows:
> >=20
> > merkaba:~> cat .ecryptfsrc
> > ecryptfs_unlink_sigs
> > ecryptfs_sig=3D[=E2=80=A6]
> > ecryptfs_fnek_sig=3D[=E2=80=A6]
> > ecryptfs_xattr
> > ecryptfs_key_bytes=3D32
> > ecryptfs_cipher=3Daes
> > ecryptfs_passthrough=3Dn
> >=20
> > I am using extended attributes to avoid the space waste of 8 KiB pe=
r
> > file.
>=20
> I must warn you that the ecryptfs_xattr_metadata option is rarely use=
d
> by anyone and gets little testing from me upstream. I understand the
> desire to save some space, but you should also consider stability her=
e.
> I'm working to automate some of that testing soon, so there is hope t=
hat
> things could get better in this area.

Okay. Thanks for the warning.

Why is that? Obviously it seems to me that xattr has quite some advanta=
ges? I=20
find 8 KiB per file quite some space waste. Rsync can copy xattrs so ba=
ckup is=20
possible. But then the directory I want to encrypt is only about 63600 =
files.=20
That would make 508800 KiB. Well even that is about half an GiB. Well c=
ould be=20
acceptable for now since its at least an 300 GB SSD.

But does it also mean more writes? Not that it should matter much. Migh=
t make=20
sense to test it this way anyway. When I understand it correctly, this =
error=20
should not happen then. I think I will try it.

My other home directory has about 852550 files and there about 3,25 GiB=
 would=20
be wasted. Too good that I do not plan to encrypt it right now. ;)

Do you now about xfstests test suite? Maybe a suitable sub selection of=
 tests=20
in there could help with testing ecryptfs.
=20
> > The underlying filesystem is:
> >=20
> > merkaba:~> grep /home /proc/mounts
> > /dev/mapper/merkaba-home /home ext4
> > rw,noatime,user_xattr,acl,barrier=3D1,stripe=3D128,data=3Dordered 0=
 0
> > /home/.ms /home/ms ecryptfs
> > rw,relatime,ecryptfs_fnek_sig=3D[=E2=80=A6],ecryptfs_sig=3D[=E2=80=A6=
],ecryptfs_cipher=3Daes,ec
> > ryptfs_key_bytes=3D32,ecryptfs_xattr_metadata,ecryptfs_unlink_sigs =
0 0
> >=20
> > Kernel is:
> >=20
> > ms@merkaba:~> cat /proc/version
> > Linux version 3.2.0-rc4-amd64 (Debian 3.2~rc4-1~experimental.1)
>=20
> Ok, I was able to reproduce this on roughly the same kernel version b=
y
> untar'ing the kernel source.
>=20
> I'll have to do some more investigation into how we can handle this
> error better. ext4 is returning an error when we're trying to create =
the
> xattr upon file creation, so how we convey that to userspace through =
the
> creat() return value and how we clean up after ourselves is probably =
the
> issue here.

Why is Ext4 returning an error? Shouldn=C2=B4t it just set the attribut=
e and thats=20
it? Maybe it has an issue doing it upon file creation? Could an Ext4 bu=
g be=20
involved here? I am willing to report with to Ext4 developers if need b=
e.

Thanks,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
