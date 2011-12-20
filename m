From: Martin Steigerwald <ms@teamix.de>
Subject: Re: ecryptfs_write_metadata: Error writing metadata out to lower file; rc = [-13]
Date: Tue, 20 Dec 2011 10:45:04 +0100
Message-ID: <201112201045.04553.ms@teamix.de>
References: <201112191326.20172.ms@teamix.de> <20111220010617.GF14413@boyd> <201112200946.14550.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from postman.teamix.net ([194.150.191.120]:35871 "EHLO
	rproxy.teamix.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944Ab1LTJpI convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Dec 2011 04:45:08 -0500
In-Reply-To: <201112200946.14550.ms@teamix.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="utf-8"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Am Dienstag, 20. Dezember 2011 schrieb Martin Steigerwald:
> > > ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning#2> LANG=
=3DC
> > > make [=E2=80=A6]
> > > sed: couldn't open temporary file ./sedhqlAcd: Permission denied
> > > [=E2=80=A6]
> > >
> > >=20
> > >
> > > ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> LANG=3D=
C ls -l
> > > | tail -6
> > > ls: cannot access sedhqlAcd: No such file or directory
> > > ls: cannot access sedChky0a: No such file or directory
> > > ls: cannot access sed1eW8Ek: No such file or directory
> > > ls: cannot access sedEjR2oA: No such file or directory
> > > ls: cannot access sedb4JEiI: No such file or directory
> > > ls: cannot access sedy0KQnt: No such file or directory
> > > -?????????  ? ?  ?            ?            ? sedChky0a
> > > -?????????  ? ?  ?            ?            ? sedEjR2oA
> > > ----------  1 ms teamix 1143445 Dec  5 10:01 sedNL1bTk
> > > -?????????  ? ?  ?            ?            ? sedb4JEiI
> > > -?????????  ? ?  ?            ?            ? sedhqlAcd
> > > -?????????  ? ?  ?            ?            ? sedy0KQnt
> > >
> > >=20
> > >=20
> > >
> > > Output in dmesg is:
> > >=20
> > >
> > > ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> sudo t=
ail -2
> > > /var/log/syslog
> > > Dec 19 13:23:30 merkaba kernel: [50999.570071] ecryptfs_write_met=
adata:
> > > Error writing metadata out to lower file; rc =3D [-13]
> > > Dec 19 13:23:30 merkaba kernel: [50999.570083] Error writing head=
ers;
> > > rc =3D [-13]
> > >
> > >=20
> > >=20
> > >
> > > Ecryptfs is configured as follows:
> > >=20
> > >
> > > merkaba:~> cat .ecryptfsrc
> > > ecryptfs_unlink_sigs
> > > ecryptfs_sig=3D[=E2=80=A6]
> > > ecryptfs_fnek_sig=3D[=E2=80=A6]
> > > ecryptfs_xattr
> > > ecryptfs_key_bytes=3D32
> > > ecryptfs_cipher=3Daes
> > > ecryptfs_passthrough=3Dn
> > >
> > >=20
> > >
> > > I am using extended attributes to avoid the space waste of 8 KiB =
per
> > > file.
> >
> >=20
> >
> > I must warn you that the ecryptfs_xattr_metadata option is rarely u=
sed
> > by anyone and gets little testing from me upstream. I understand th=
e
> > desire to save some space, but you should also consider stability h=
ere.
> > I'm working to automate some of that testing soon, so there is hope=
 that
> > things could get better in this area.
>=20
> Okay. Thanks for the warning.
>=20
> Why is that? Obviously it seems to me that xattr has quite some advan=
tages?
> I  find 8 KiB per file quite some space waste. Rsync can copy xattrs =
so
> backup is possible. But then the directory I want to encrypt is only =
about
> 63600 files. That would make 508800 KiB. Well even that is about half=
 an
> GiB. Well could be acceptable for now since its at least an 300 GB SS=
D.
>=20
> But does it also mean more writes? Not that it should matter much. Mi=
ght
> make  sense to test it this way anyway. When I understand it correctl=
y,
> this error should not happen then. I think I will try it.

Okay, I now tried without putting metadata in extended attributes.

This works. Above issue didn=C2=B4t show up.

Space waste is approximately as estimated:

merkaba:~> du -s /home/ms=20
13672464        /home/ms
merkaba:~> du -s /home/ms2
13155688        /home/ms2

And generating slides for my linux trainings has become a *whole lot* f=
aster.=20
I didn't expect such a kind of performance improvement - more than twic=
e as=20
fast:

encfs:

ms@merkaba:/home/ms2/Training/TXS-svn/Linux_15_Performance_Tuning>=20
/usr/bin/time -v make
[=E2=80=A6]
        Command being timed: "make"
        User time (seconds): 40.25
        System time (seconds): 4.41
        Percent of CPU this job got: 87%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:51.01
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 1162240
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 68
        Minor (reclaiming a frame) page faults: 219219
        Voluntary context switches: 428959
        Involuntary context switches: 14977
        Swaps: 0
        File system inputs: 179032
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

ecryptfs:

ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> /usr/bin/tim=
e -v=20
make
[=E2=80=A6]
        Command being timed: "make"
        User time (seconds): 42.11
        System time (seconds): 1.39
        Percent of CPU this job got: 191%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:22.70
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 1221664
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 162
        Minor (reclaiming a frame) page faults: 238379
        Voluntary context switches: 7180
        Involuntary context switches: 13078
        Swaps: 0
        File system inputs: 195680
        File system outputs: 64032
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

Thanks,
--=20
Martin Steigerwald - teamix GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
