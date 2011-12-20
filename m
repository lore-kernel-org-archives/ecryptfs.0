From: Martin Steigerwald <ms@teamix.de>
Subject: Re: ecryptfs_write_metadata: Error writing metadata out to lower file; rc = [-13]
Date: Tue, 20 Dec 2011 13:27:10 +0100
Message-ID: <201112201327.11445.ms@teamix.de>
References: <201112191326.20172.ms@teamix.de> <20111220010617.GF14413@boyd> <-573303501705934429@unknownmsgid>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:41227 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751257Ab1LTM1Q convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Dec 2011 07:27:16 -0500
In-Reply-To: <-573303501705934429@unknownmsgid>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="windows-1252"
To: Alexis Hafner <alexis.hafner@gmail.com>
Cc: Tyler Hicks <tyhicks@canonical.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

Am Dienstag, 20. Dezember 2011 schrieb Alexis Hafner:
> Le 20 d=E9c. 2011 =E0 02:06, Tyler Hicks <tyhicks@canonical.com> a =E9=
crit :
> > On 2011-12-19 13:26:19, Martin Steigerwald wrote:
> >> Hi!
> >>=20
> >> Today I tested again whether ecryptfs would be suitable to replace=
 encfs
> >> on my
> >=20
> >> laptop. But I found several problems. The blocking one is:
> > Sorry, hopefully we can get them straightened out.
> >=20
> >> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning#2> LANG=3D=
C make
> >> [=85]
> >> sed: couldn't open temporary file ./sedhqlAcd: Permission denied
> >> [=85]
> >>=20
> >> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> LANG=3D=
C ls -l
> >> | tail -6
> >> ls: cannot access sedhqlAcd: No such file or directory
> >> ls: cannot access sedChky0a: No such file or directory
> >> ls: cannot access sed1eW8Ek: No such file or directory
> >> ls: cannot access sedEjR2oA: No such file or directory
> >> ls: cannot access sedb4JEiI: No such file or directory
> >> ls: cannot access sedy0KQnt: No such file or directory
> >> -?????????  ? ?  ?            ?            ? sedChky0a
> >> -?????????  ? ?  ?            ?            ? sedEjR2oA
> >> ----------  1 ms teamix 1143445 Dec  5 10:01 sedNL1bTk
> >> -?????????  ? ?  ?            ?            ? sedb4JEiI
> >> -?????????  ? ?  ?            ?            ? sedhqlAcd
> >> -?????????  ? ?  ?            ?            ? sedy0KQnt
> >>=20
> >>=20
> >> Output in dmesg is:
> >>=20
> >> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> sudo ta=
il -2
> >> /var/log/syslog
> >> Dec 19 13:23:30 merkaba kernel: [50999.570071] ecryptfs_write_meta=
data:
> >> Error writing metadata out to lower file; rc =3D [-13]
> >> Dec 19 13:23:30 merkaba kernel: [50999.570083] Error writing heade=
rs; rc
> >> =3D [-13]
> >>=20
> >>=20
> >> Ecryptfs is configured as follows:
> >>=20
> >> merkaba:~> cat .ecryptfsrc
> >> ecryptfs_unlink_sigs
> >> ecryptfs_sig=3D[=85]
> >> ecryptfs_fnek_sig=3D[=85]
> >> ecryptfs_xattr
> >> ecryptfs_key_bytes=3D32
> >> ecryptfs_cipher=3Daes
> >> ecryptfs_passthrough=3Dn
> >>=20
> >> I am using extended attributes to avoid the space waste of 8 KiB p=
er
> >> file.
> >=20
> > I must warn you that the ecryptfs_xattr_metadata option is rarely u=
sed
> > by anyone and gets little testing from me upstream. I understand th=
e
> > desire to save some space, but you should also consider stability h=
ere.
> > I'm working to automate some of that testing soon, so there is hope=
 that
> > things could get better in this area.
[=85]
> I can report the same bug on a 64-bits Rhel server 6.2 machine runnin=
g
> the default Red Hat kernel, also with ext4 as the lower file-system :
> using extended attributes fails with the same error logs. This could
> indicate that the problem is not limited to the last development
> kernels, but has been here a little longer.

Can you also reproduce the rsync copies twice issue I reported in the o=
ther=20
thread? Does the bug disappear when storing metadata in files instead.

Would be nice to have confirmation for that as well.

Thanks,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
