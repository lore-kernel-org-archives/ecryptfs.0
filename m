From: Wiebe Cazemier <wiebe@halfgaar.net>
Subject: Re: Key derivation and passprhase wrapping
Date: Wed, 20 Jan 2016 21:03:13 +0100 (CET)
Message-ID: <497366096.234710.1453320193682.JavaMail.zimbra@halfgaar.net>
References: <794484591.224591.1452104561446.JavaMail.zimbra@halfgaar.net> <676716416.231851.1453112857325.JavaMail.zimbra@halfgaar.net> <20160120030556.GC5623@boyd> <1032370780.234696.1453319503133.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from meel.halfgaar.net ([83.137.146.229]:45020 "EHLO
	meel.halfgaar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbcATUDU convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 20 Jan 2016 15:03:20 -0500
In-Reply-To: <1032370780.234696.1453319503133.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

----- Original Message -----
> From: "Wiebe Cazemier" <wiebe@halfgaar.net>
> To: "Tyler Hicks" <tyhicks@canonical.com>
> Cc: ecryptfs@vger.kernel.org
> Sent: Wednesday, 20 January, 2016 8:51:43 PM
> Subject: Re: Key derivation and passprhase wrapping
>=20
> I think I missed an important bit. I was looking at ecryptfs-wrap-pas=
sphrase,
> which makes you supply the FEK and FEKEK, but ecryptfs-setup-private
> actually already uses a random passphrase:
>=20
> -m, --mountpass MOUNTPASS
>     Passphrase for mounting the ecryptfs directory, default is 16 byt=
es from
>     /dev/urandom if omitted
>=20

I do see an issue though. The bash script says:

  random_data=3D`head -c 16000 /dev/urandom | od -x` || error_testing "=
$temp" "$(gettext 'Could not generate random data')"

But when urandom can't be read (doesn't exist, no file handles, whateve=
r):

  random_data=3D`head -c 16000 /dev/urando | od -x` || echo "fail"
  head: cannot open =E2=80=98/dev/urando=E2=80=99 for reading: No such =
file or directory

Note, no 'fail' and $? =3D=3D 0. And:

  echo $random_data
  0000000


Regards,

Wiebe
