From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Fri, 1 Jul 2016 16:33:48 -0500
Message-ID: <5776E1BC.3040406@canonical.com>
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
 <5771AD13.2010408@canonical.com> <57735047.1050706@canonical.com>
 <20160701221519.229e9e43@subnote.jensen.local>
 <5776DB70.5060006@canonical.com>
 <78E8F2EB-8C8C-4ECD-83D2-2E7EF9F6526E@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ROJoolE6Ek043xecwrTEUdx2dVaO8r9nB"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53491 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbcGAVdz (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 1 Jul 2016 17:33:55 -0400
In-Reply-To: <78E8F2EB-8C8C-4ECD-83D2-2E7EF9F6526E@gmx.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Henry Jensen <hjensen@gmx.de>
Cc: Kenneth Tan <gmane@way-of-the-blade.com>, ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ROJoolE6Ek043xecwrTEUdx2dVaO8r9nB
Content-Type: multipart/mixed; boundary="Bei1KEWN8IaNTeLvhQv7rOVWh06JuXoBQ"
From: Tyler Hicks <tyhicks@canonical.com>
To: Henry Jensen <hjensen@gmx.de>
Cc: Kenneth Tan <gmane@way-of-the-blade.com>, ecryptfs@vger.kernel.org
Message-ID: <5776E1BC.3040406@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
 <5771AD13.2010408@canonical.com> <57735047.1050706@canonical.com>
 <20160701221519.229e9e43@subnote.jensen.local>
 <5776DB70.5060006@canonical.com>
 <78E8F2EB-8C8C-4ECD-83D2-2E7EF9F6526E@gmx.de>
In-Reply-To: <78E8F2EB-8C8C-4ECD-83D2-2E7EF9F6526E@gmx.de>

--Bei1KEWN8IaNTeLvhQv7rOVWh06JuXoBQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

My automated tests all pass. I was about to move onto manual testing but
I'll hold off until I hear back from you.

Tyler

On 07/01/2016 04:16 PM, Henry Jensen wrote:
> Hi Tyler,
>=20
> hold on, I think I ran into the same issue as the guys from Manjaro, se=
e
>=20
> https://forum.manjaro.org/t/kenel-4-4-14-lts-has-issues-with-ecryptfs-o=
n-testing-29-june-2016/5001/9
>=20
> and
>=20
> https://github.com/manjaro/packages-core/commit/ff5431986233877dba816e7=
7debe0bf1eacf6628
>=20
> tl;dr - the patch was malformed. Will check again with correct formatte=
d patch.
>=20
> Regards,
>=20
> Henry
>=20
> Am 1. Juli 2016 23:06:56 MESZ, schrieb Tyler Hicks <tyhicks@canonical.c=
om>:
>> On 07/01/2016 03:15 PM, Henry Jensen wrote:
>>> Hello Tyler
>>>
>>> On Tue, 28 Jun 2016 23:36:23 -0500
>>> Tyler Hicks <tyhicks@canonical.com> wrote:
>>>
>>>>> Thanks. The backported version of the patch needs to be adjusted.
>> I'll
>>>>> try to get a patch out the stable list tomorrow. =20
>>>>
>>>> I've sent a fix to the stable list (and cc'ed the ecryptfs list). I
>>>> tested on 4.4.y and 3.18.y on ext{2,3,4}, btrfs, and xfs. It should
>> fix
>>>> the regression that you hit.
>>>
>>>
>>> Sorry, the patch did not work for me. I am still getting error "Wrong=

>>> medium type" wwhen accessing directories.
>>>
>>
>> Hi Henry - Can you please double check that you're running the patched=

>> kernel? I only ask that because I have a pretty high degree of
>> confidence that the patch fixes the issue due to the amount of testing=

>> that I performed. I'm in the middle of rebuilding the linux-stable
>> 4.4.y
>> kernel with that patch applied on top to retest. If you could double
>> check your environment in the meantime, I'd appreciate it.
>>
>> If it turns out that you're still hitting the bug, I'll need reproduce=
r
>> instructions as my tests don't seem to be sufficient. Thank you!
>>
>> Tyler
>>
>>>
>>> Regards,
>>>
>>> Henry
>>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--Bei1KEWN8IaNTeLvhQv7rOVWh06JuXoBQ--

--ROJoolE6Ek043xecwrTEUdx2dVaO8r9nB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXduG9AAoJENaSAD2qAscK+tEQALI/R4GshBmCfaQU6O0lnCOK
6GM8WVkovlGvCJFQeVxdREt2LJC3jCyKcG/in7xKdAUWdWgLfsbzM9tliDXWPQ/3
bW+bfprVCGsKw5sT67Z3og2d9SnOBA5VlUwWWNHSF//t04BKGJptB1oUHQI3bWah
/3UX/kJ+Ti5F2Zwlrg6c3F6LGvutrETyI1sWkzpyb0d121JcRaSZ1FXgrPTt9wYF
28VPvIMzMzN02ovV6f5lC3LUWaC+vqC57DyhrNVqUtODRVzmm2AENxJ3kSCADwzm
R/iJwDG4pn7VSWLXanTWkgX/BBAheZ346twJVIP4Y5UP4+kSSNjmsyQ/wbuERS1M
2lI7Hu7ATlUpX7YlMAXxGaDhz2Do2t/WgxcULCRHV4yfJRPXRpjHbLwcEU2YVHRG
Kngyo3HWjbVnf2vEJN7BAQCDpoIobmOL78iYqoY8uPBo9yKDK36B/N1a1HK0JNcb
Y3Awc9N4rkjWgpwB357V87yEjckWD+TOQEY07PTSe3h2aFD8302h5wxdeJqDE5Rp
kcSs5HKrlHAMZvMiERaJQrqXBQTme/ecYz+QENsgVVKXdJJcCf28B1Gxz9BmZSi0
9C8nRs0zCyfTvxAVGG2jk2+teIXIFUuxbh9BMpDbi6EcADWSWwxALPcNQeWA9jJV
j0avwymGp8nKP0UsWL3+
=OhT1
-----END PGP SIGNATURE-----

--ROJoolE6Ek043xecwrTEUdx2dVaO8r9nB--
