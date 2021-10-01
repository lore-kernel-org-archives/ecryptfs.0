From: Matthias Bodenbinder <matthias@bodenbinder.de>
Subject: Re: bad file permissions: write but no read access
Date: Fri, 01 Oct 2021 17:11:58 +0200
Message-ID: <014f761a4baf0a18dbeb16c439b2297296976cf7.camel@bodenbinder.de>
References: <e0af3fe10229d90357dd351b4348ec6af59f2e3f.camel@bodenbinder.de>
Reply-To: matthias@bodenbinder.de
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtp-out001.kontent.com ([81.88.40.215]:52432 "EHLO
        smtp-out001.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhJAPNp (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 1 Oct 2021 11:13:45 -0400
Received: from rakete.bodenbinder.de (p4ffdb9d4.dip0.t-ipconnect.de [79.253.185.212])
        (Authenticated sender: bodenbinder_de@smtp-out001.kontent.com)
        by smtp-out001.kontent.com (Postfix) with ESMTPA id 3EE504002B19
        for <ecryptfs@vger.kernel.org>; Fri,  1 Oct 2021 17:11:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by rakete.bodenbinder.de (Postfix) with ESMTP id 14F5B2B0C858
        for <ecryptfs@vger.kernel.org>; Fri,  1 Oct 2021 17:11:58 +0200 (CEST)
In-Reply-To: <e0af3fe10229d90357dd351b4348ec6af59f2e3f.camel@bodenbinder.de>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: ecryptfs@vger.kernel.org

I notice messages like this in the journal for each such file Itry to read:

kernel: Valid eCryptfs headers not found in file header region or xattr reg=
ion, inode 105438

How can this be fixed?=20

Matthias


Am Freitag, dem 01.10.2021 um 13:04 +0200 schrieb Matthias Bodenbinder:
> Hi,
>=20
> I hundreds of files in my ecryptfs home which I can write (e.g. rename th=
em) but I can not read them resp. open them. A chmod as
> user or even as root is not working.=20
>=20
> Example:
>=20
> 34# file wencke-18te.xcf
> wencke-18te.xcf: writable, regular file, no read permission
>=20
> 35# ll wencke-18te.xcf
> .rw-r--r-- matthias matthias 41 MB Thu Aug=C2=A0 3 16:00:46 2017 wencke-1=
8te.xcf
>=20
> 36# getfacl wencke-18te.xcf=20
> # file: wencke-18te.xcf
> # owner: matthias
> # group: matthias
> user::rw-
> group::r--
> other::r--
>=20
> 37# chmod 644 wencke-18te.xcf
> chmod: changing permissions of 'wencke-18te.xcf': Input/output error
>=20
> The underlying ecryptfs directory /home/.ecryptfs/matthias/ with .Private=
 and .ecryptfs subdirectories is readable without
> error.
> I can rsync it to my backup server. But when I mount it from the backup s=
erver with ecryptfs-recover-private I have the same
> issue.
>=20
> What can I do to fix that and make the files readable again?
>=20
> Matthias
>=20


