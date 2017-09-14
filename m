From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: Re-use SSD
Date: Thu, 14 Sep 2017 15:38:51 +0200
Message-ID: <8806651.xcqe0g8Jeu@merkaba>
References: <opdsrr$7vn$1@blaine.gmane.org> <1882558.NIKn6SUjoV@merkaba>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:35495 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdINNiw (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 14 Sep 2017 09:38:52 -0400
In-Reply-To: <1882558.NIKn6SUjoV@merkaba>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: ecryptfs@vger.kernel.org
Cc: Paul van der Vlis <paul@vandervlis.nl>

Martin Steigerwald - 14.09.17, 15:21:
> Generic hint for securely erasing SSDs.
>=20
> https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase
>=20
> You rely on the SSD firmware tough. But I am not aware of another way to =

> securely delete data of an SSD other than ATA Secure Erase. However ATA
> Secure  Erase only is really safe for SSDs that use encryption like Intel
> SSD 320 (and many newer SSDs) as the SSD will overwrite the encryption
> keys. Many SSDs use encryption by default, without change using some

Hmmm, thinking about this: I am not sure about this.

Secure Erase should also safely, securely delete the device on drives that =
do=20
not use encryptions, but it would take much longer as the individual sector=
s=20
need to be wiped. With a drive with encryption by firmware, the firmware wi=
ll=20
just delete the key. With the Intel SSD 320 this took=E2=80=A6 hmm a few se=
conds,=20
definately less than a minute.

It of course always wipes the complete device.

Thanks,
--=20
Martin
