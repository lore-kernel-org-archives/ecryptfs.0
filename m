From: Jakob Unterwurzacher <jakobunt@gmail.com>
Subject: Re: ecryptfs =?UTF-8?B?ZG9lc27CtHQgbGlrZSBub2F1dG8gYW5kIG5vYXRpbQ==?=
 =?UTF-8?B?ZQ==?=
Date: Tue, 17 Jan 2012 10:46:43 +0100
Message-ID: <4F154383.6040201@gmail.com>
References: <201201161044.21718.Martin@lichtvoll.de> <4F14C9DE.80101@gmail.com> (sfid-20120117_093128_614446_D328282A) <201201170937.10613.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48002 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab2AQJqq (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 17 Jan 2012 04:46:46 -0500
Received: by wibhm6 with SMTP id hm6so1215361wib.19
        for <ecryptfs@vger.kernel.org>; Tue, 17 Jan 2012 01:46:45 -0800 (PST)
In-Reply-To: <201201170937.10613.Martin@lichtvoll.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: ecryptfs@vger.kernel.org

On 17.01.2012 09:37, Martin Steigerwald wrote:
> Am Dienstag, 17. Januar 2012 schrieb Jakob Unterwurzacher:
>> On 16.01.2012 10:44, Martin Steigerwald wrote:
>>> Hi!
>>>
>>> I have
>>>
>>> merkaba:~> grep ecrypt /etc/fstab
>>> /home/.ms               /home/ms                ecryptfs
>>> noatime,noauto  0       0
>>>
>>> And get:
>>>
>>> merkaba:~> mount /home/ms
>>> Passphrase:
> [=E2=80=A6]
>>> Error mounting eCryptfs: [-5] Input/output error
> [=E2=80=A6]
>>> Still it works.
>>>
>>>
>>> In dmesg I see:
>>>
>>> [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
>>> [noauto]
>>> [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
>>> [noatime]
>>> [ 2657.913215] alg: No test for __gcm-aes-aesni
>>> (__driver-gcm-aes-aesni)
>>>
>>>
>>> Thus I removed at least noatime, but then I still see:
>>>
>>> [ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized optio=
n
>>> [noauto]
> [=E2=80=A6]
>>> Without noatime it would ask me the passwort upon boot, but I do no=
t
>>> like that since I do not use that user everytime.
>=20
> noauto that is.
>=20
>>> I could use mounting via pam, but I like to have a different passwo=
rd
>>> for the user stored in /etc/shadow than the password from the
>>> filesystem itself.
>>
>> Note that this should work by creating ~/.ecryptfs/wrapping-independ=
ent
>> . Pam will ask for the ecryptfs password explicitely then.
>=20
> Thanks.
>=20
> Would that also work within a display manager like kdm?
>=20
> Ciao,

Yes! It will ask for two passwords on login.
Jakob
