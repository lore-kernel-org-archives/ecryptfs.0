From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Tue, 28 Jun 2016 23:36:23 -0500
Message-ID: <57735047.1050706@canonical.com>
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
 <5771AD13.2010408@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cBmc8JtpLfEiOdEbXGFlu12NSvOk9BxA4"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46154 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcF2Egb (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 29 Jun 2016 00:36:31 -0400
In-Reply-To: <5771AD13.2010408@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Henry Jensen <hjensen@gmx.de>, Kenneth Tan <gmane@way-of-the-blade.com>
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cBmc8JtpLfEiOdEbXGFlu12NSvOk9BxA4
Content-Type: multipart/mixed; boundary="VD8Ta5BuJrNUXecSWMg9dWICO9E5vxUlq"
From: Tyler Hicks <tyhicks@canonical.com>
To: Henry Jensen <hjensen@gmx.de>, Kenneth Tan <gmane@way-of-the-blade.com>
Cc: ecryptfs@vger.kernel.org
Message-ID: <57735047.1050706@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
 <5771AD13.2010408@canonical.com>
In-Reply-To: <5771AD13.2010408@canonical.com>

--VD8Ta5BuJrNUXecSWMg9dWICO9E5vxUlq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2016 05:47 PM, Tyler Hicks wrote:
> On 06/27/2016 04:21 PM, Henry Jensen wrote:
>> Hi Tyler,
>>
>> Am 27. Juni 2016 21:19:08 MESZ, schrieb Tyler Hicks <tyhicks@canonical=
=2Ecom>:
>>> On 06/27/2016 11:27 AM, Henry Jensen wrote:
>>>> Greetings,
>>>>
>>>> I'm using ecryptfs with Slackware current and kernel 4.4.14. In
>>> kernel
>>>> 4.4.14 was a patch introduced which make it impossilble to list the
>>>> contents of a directory.[0]
>>>>
>>>> The mount itself works, but listing a directory results in an error
>>>> "wrong medium type". Showing the contents and the file itself
>>> (presumed
>>>> the name of the file is known) works.
>>>
>>> Hi Henry - sorry for the trouble. What filesystem are you mounting
>>> eCryptfs on top of?
>>
>>
>> I use ext4. With 'ecryptfs-mount-private' $HOME/.Private is mounted on=
 $HOME/Private.=20
>>
>> ecryptfs worked perfectly until I upgraded to kernel 4.4.14. I tested =
it on another machine with Slackware64 and a 64bit kernel now - same resu=
lt.
>=20
> Thanks. The backported version of the patch needs to be adjusted. I'll
> try to get a patch out the stable list tomorrow.

I've sent a fix to the stable list (and cc'ed the ecryptfs list). I
tested on 4.4.y and 3.18.y on ext{2,3,4}, btrfs, and xfs. It should fix
the regression that you hit.

Tyler

>=20
> Tyler
>=20
>>
>> Regards,
>> Henry
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in=

>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20



--VD8Ta5BuJrNUXecSWMg9dWICO9E5vxUlq--

--cBmc8JtpLfEiOdEbXGFlu12NSvOk9BxA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXc1BHAAoJENaSAD2qAscKABwQALUBERrYF/eUH8j6tTyHNB5U
iPiwGAki2jWN1kbpwvTejNomf5/5C/Pomrc5IuzqzvgnsdTWiD5ZxUOSAJxbPqQI
yrXdbCReCfN9330HC/VVulczl+sjy/DCg5ngDTGubYVsvorm+c+LnogVNWRUtUcm
+3MHb9BroPoLKPD3/uQvhhlT9VaHAO1+lZdSm5Q6Scq3ReYy1Ubggkl0WfOrC5MY
c5j92zK1dAEPde5PuGkATulqsp2+kDXeVYF0TfHNt/gOCScbxhiDG+XJyL2sdXZ/
c4jJC1hB++GXWjdP4xDEw4vdhpbRn9YSsBzK1drv0SQ/rBI6Q5GmHsTreGIgIxg1
JdDKNSP8FRMWTPBb7dpF0j1wUSlRngN0Z8CuRobVpwSYlZsB9OPI7BvAJAS6Rjo8
SFfxVfpYpvQXI3vf59vEymgumVjR1kfpKrN5aNSreoC/KRQZhBM5d69r9BuUUgZy
xuwT/PdXSNMr5KAhaXY1hqnzX4orU87q9UsZA4wCYmFkxaGgaZwyb30okCfFe+gv
ooy4WQKMMWjzDO4/nQJT68iXcXUmdhmVHI68p2EIcQq4gdPQofnIysUgJyvCIBxu
sRP2Q6HfN4kEMQtwpFg4+mxZQ0T/FV6nPTB6hFED8cAew77gRa2xCSNqIHoJTWqg
MiE0O9PwtJEbxVcmGCIr
=wQCJ
-----END PGP SIGNATURE-----

--cBmc8JtpLfEiOdEbXGFlu12NSvOk9BxA4--
