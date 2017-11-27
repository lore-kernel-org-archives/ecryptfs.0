From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: bug: msm8998, ecryptfs, cannot create files due to invalid
 keysize
Date: Mon, 27 Nov 2017 12:04:46 -0600
Message-ID: <5092f3db-d574-43e7-dec9-5662a2ee3e3e@canonical.com>
References: <CAL=R1-=TT+A4cW+y7uNHZrPpK+47pQ_z74ZZzHW=zCgJtBsYOA@mail.gmail.com>
 <CAL=R1-mG_xs=rGo+adqOfs279EW5TAzeVXZ_JZGH8xt5=s-p8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tiaRTOvlxWnihQsbaOtMnulnXtsBwXhVA"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37735 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbdK0SEw (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Mon, 27 Nov 2017 13:04:52 -0500
In-Reply-To: <CAL=R1-mG_xs=rGo+adqOfs279EW5TAzeVXZ_JZGH8xt5=s-p8w@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: James Muir <james.muir@graphitesoftware.com>, linux-arm-msm@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tiaRTOvlxWnihQsbaOtMnulnXtsBwXhVA
Content-Type: multipart/mixed; boundary="JHAHtxH3fJfkXUFx34Rv2ANqSMIdBt5WW";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: James Muir <james.muir@graphitesoftware.com>,
 linux-arm-msm@vger.kernel.org
Cc: ecryptfs@vger.kernel.org
Message-ID: <5092f3db-d574-43e7-dec9-5662a2ee3e3e@canonical.com>
Subject: Re: bug: msm8998, ecryptfs, cannot create files due to invalid
 keysize
References: <CAL=R1-=TT+A4cW+y7uNHZrPpK+47pQ_z74ZZzHW=zCgJtBsYOA@mail.gmail.com>
 <CAL=R1-mG_xs=rGo+adqOfs279EW5TAzeVXZ_JZGH8xt5=s-p8w@mail.gmail.com>
In-Reply-To: <CAL=R1-mG_xs=rGo+adqOfs279EW5TAzeVXZ_JZGH8xt5=s-p8w@mail.gmail.com>

--JHAHtxH3fJfkXUFx34Rv2ANqSMIdBt5WW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 09:33 AM, James Muir wrote:
> On Fri, Oct 27, 2017 at 4:43 PM, James Muir
> <james.muir@graphitesoftware.com> wrote:
>> There were some changes made in the msm linux kernel (msm8998) to add
>> hw support to ecryptfs.
>>
>> Unfortunately, those changes break basic ecryptfs usage;
>=20
> <snip>
>=20
>> This regression was introduced in the following commit:
>>
>>   https://github.com/sonyxperiadev/kernel/commit/8928f8683bcd0236f5653=
963deee3bc225fb2206
>>
>> That commit is also present in aosp (e.g. the Pixel 2 uses the
>> msm8998; but note that the aosp kernels do not enable ecryptfs).
>=20
> Since my message was essentially a bug report (without a patch), it
> might be that linux-arm-msm was not the right place to submit it.
>=20
> Does anyone know of a better way to report msm kernel bugs to Qualcomm?=


I can't help here but it might be useful to directly contact the author
of the patch that introduced the regression.

Tyler

>=20
> Due to the high volume of traffic on the list, it seems likely a bug
> report would get overlooked here.
>=20
> -James M
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--JHAHtxH3fJfkXUFx34Rv2ANqSMIdBt5WW--

--tiaRTOvlxWnihQsbaOtMnulnXtsBwXhVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJaHFO+AAoJENaSAD2qAscKLJEQAKHkVT31emgNZRLBwjsLsFbS
Nah5tNSSZwUGk/U4Z86jMRpHbAPG94YXnZzCAhaOVbhqDOXLZzPdypcKKtb/naxc
uzJOKuOGRIQbapMX4ICe+lky+22/X4Me5YwfuBnpI/1vKJ+wAhAs6vK/0D88nMDx
Hhl3zOMqXyJdDzpdwLx20i/2LRiaJtFbuXnlSdElIM53Dobs6e3zWLsn1q0k7LP0
nfQdYdqJg1BmI+Q6xPEQq1/H3lKV7vYtToX2Uo8yO5Q6J96Gg75Ups553cvlIO8R
SraIn8o2Zjmpja/2jNJQjHp1Rpl6GgB/l9l0EibvTRYgFvKfRStOSQgpf0ccAhG6
oXS/B6Oi7OtQ04PjJdYnM3Pj26MzGrYVGFiIg1FMFqjcx7UbPAt4KhWlYYDCzcxa
Erp1Q04L81QbRpPVJ4Bc/aiIo9jm7X846ceBrOYdq5/w1v1Z7I84tGHCrvEXoOyn
O3F8/KpLZDgc6ZNEDkW09RIdzPdYp7xM9AOkGQYEIahiZB1ssRBZk4qvN+IMP0ut
xEGZ1LjbLJtaU4Ahn436E429Q3DNFWD14oAXpNc4u9QlxskYCBI6mdtdcp1O+iZU
ndqQPOUYSYlVFj+5A2tcg1Id52UPzFumy9/egPFtX91sIhz+KPWX4RKindOUhfse
vcBLOLmjApWqfi/8oI60
=26GP
-----END PGP SIGNATURE-----

--tiaRTOvlxWnihQsbaOtMnulnXtsBwXhVA--
