From: Alexis Hafner <alexis.hafner@gmail.com>
Subject: Re: ecryptfs_write_metadata: Error writing metadata out to lower
 file; rc = [-13]
Date: Tue, 20 Dec 2011 13:05:34 +0100
Message-ID: <-573303501705934429@unknownmsgid>
References: <201112191326.20172.ms@teamix.de> <20111220010617.GF14413@boyd>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48905 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1LTMFe convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 20 Dec 2011 07:05:34 -0500
Received: by qadc12 with SMTP id c12so2931248qad.19
        for <ecryptfs@vger.kernel.org>; Tue, 20 Dec 2011 04:05:33 -0800 (PST)
In-Reply-To: <20111220010617.GF14413@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Martin Steigerwald <ms@teamix.de>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

Hi Tyler,

I can report the same bug on a 64-bits Rhel server 6.2 machine running
the default Red Hat kernel, also with ext4 as the lower file-system :
using extended attributes fails with the same error logs. This could
indicate that the problem is not limited to the last development
kernels, but has been here a little longer.

Alexis

Le 20 d=E9c. 2011 =E0 02:06, Tyler Hicks <tyhicks@canonical.com> a =E9c=
rit :

> On 2011-12-19 13:26:19, Martin Steigerwald wrote:
>> Hi!
>>
>> Today I tested again whether ecryptfs would be suitable to replace e=
ncfs on my
>> laptop. But I found several problems. The blocking one is:
>
> Sorry, hopefully we can get them straightened out.
>
>>
>> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning#2> LANG=3D=
C make
>> [=85]
>> sed: couldn't open temporary file ./sedhqlAcd: Permission denied
>> [=85]
>>
>> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> LANG=3DC =
ls -l | tail
>> -6
>> ls: cannot access sedhqlAcd: No such file or directory
>> ls: cannot access sedChky0a: No such file or directory
>> ls: cannot access sed1eW8Ek: No such file or directory
>> ls: cannot access sedEjR2oA: No such file or directory
>> ls: cannot access sedb4JEiI: No such file or directory
>> ls: cannot access sedy0KQnt: No such file or directory
>> -?????????  ? ?  ?            ?            ? sedChky0a
>> -?????????  ? ?  ?            ?            ? sedEjR2oA
>> ----------  1 ms teamix 1143445 Dec  5 10:01 sedNL1bTk
>> -?????????  ? ?  ?            ?            ? sedb4JEiI
>> -?????????  ? ?  ?            ?            ? sedhqlAcd
>> -?????????  ? ?  ?            ?            ? sedy0KQnt
>>
>>
>> Output in dmesg is:
>>
>> ms@merkaba:~/Training/TXS-svn/Linux_15_Performance_Tuning> sudo tail=
 -2
>> /var/log/syslog
>> Dec 19 13:23:30 merkaba kernel: [50999.570071] ecryptfs_write_metada=
ta: Error
>> writing metadata out to lower file; rc =3D [-13]
>> Dec 19 13:23:30 merkaba kernel: [50999.570083] Error writing headers=
; rc =3D
>> [-13]
>>
>>
>> Ecryptfs is configured as follows:
>>
>> merkaba:~> cat .ecryptfsrc
>> ecryptfs_unlink_sigs
>> ecryptfs_sig=3D[=85]
>> ecryptfs_fnek_sig=3D[=85]
>> ecryptfs_xattr
>> ecryptfs_key_bytes=3D32
>> ecryptfs_cipher=3Daes
>> ecryptfs_passthrough=3Dn
>>
>> I am using extended attributes to avoid the space waste of 8 KiB per=
 file.
>
> I must warn you that the ecryptfs_xattr_metadata option is rarely use=
d
> by anyone and gets little testing from me upstream. I understand the
> desire to save some space, but you should also consider stability her=
e.
> I'm working to automate some of that testing soon, so there is hope t=
hat
> things could get better in this area.
>
>>
>> The underlying filesystem is:
>>
>> merkaba:~> grep /home /proc/mounts
>> /dev/mapper/merkaba-home /home ext4
>> rw,noatime,user_xattr,acl,barrier=3D1,stripe=3D128,data=3Dordered 0 =
0
>> /home/.ms /home/ms ecryptfs
>> rw,relatime,ecryptfs_fnek_sig=3D[=85],ecryptfs_sig=3D[=85],ecryptfs_=
cipher=3Daes,ecryptfs_key_bytes=3D32,ecryptfs_xattr_metadata,ecryptfs_u=
nlink_sigs
>> 0 0
>>
>> Kernel is:
>>
>> ms@merkaba:~> cat /proc/version
>> Linux version 3.2.0-rc4-amd64 (Debian 3.2~rc4-1~experimental.1)
>
> Ok, I was able to reproduce this on roughly the same kernel version b=
y
> untar'ing the kernel source.
>
> I'll have to do some more investigation into how we can handle this
> error better. ext4 is returning an error when we're trying to create =
the
> xattr upon file creation, so how we convey that to userspace through =
the
> creat() return value and how we clean up after ourselves is probably =
the
> issue here.
>
> Tyler
>
>> (ben@decadent.org.uk) (gcc version 4.6.2 (Debian 4.6.2-5) ) #1 SMP S=
un Dec 4
>> 18:38:24 UTC 2011
>>
>>
>> With encfs or from my local workstation via NFS there is no such iss=
ue.
>>
>> Ciao,
>> --
>> Martin Steigerwald - teamix GmbH - http://www.teamix.de
>> gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
