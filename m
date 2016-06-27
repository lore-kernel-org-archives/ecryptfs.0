From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Mon, 27 Jun 2016 17:47:47 -0500
Message-ID: <5771AD13.2010408@canonical.com>
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gK6eDVoMCOb3v0MWCsdMv9LbGN0nTnLsW"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58049 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0Wsg (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 27 Jun 2016 18:48:36 -0400
In-Reply-To: <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Henry Jensen <hjensen@gmx.de>, ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gK6eDVoMCOb3v0MWCsdMv9LbGN0nTnLsW
Content-Type: multipart/mixed; boundary="oKqfQeB6i20lvaqgUcwgGNGkJ3127gHg7"
From: Tyler Hicks <tyhicks@canonical.com>
To: Henry Jensen <hjensen@gmx.de>, ecryptfs@vger.kernel.org
Message-ID: <5771AD13.2010408@canonical.com>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
References: <20160627182738.08737a6d@subnote.jensen.local>
 <57717C2C.4010708@canonical.com>
 <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
In-Reply-To: <0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>

--oKqfQeB6i20lvaqgUcwgGNGkJ3127gHg7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2016 04:21 PM, Henry Jensen wrote:
> Hi Tyler,
>=20
> Am 27. Juni 2016 21:19:08 MESZ, schrieb Tyler Hicks <tyhicks@canonical.=
com>:
>> On 06/27/2016 11:27 AM, Henry Jensen wrote:
>>> Greetings,
>>>
>>> I'm using ecryptfs with Slackware current and kernel 4.4.14. In
>> kernel
>>> 4.4.14 was a patch introduced which make it impossilble to list the
>>> contents of a directory.[0]
>>>
>>> The mount itself works, but listing a directory results in an error
>>> "wrong medium type". Showing the contents and the file itself
>> (presumed
>>> the name of the file is known) works.
>>
>> Hi Henry - sorry for the trouble. What filesystem are you mounting
>> eCryptfs on top of?
>=20
>=20
> I use ext4. With 'ecryptfs-mount-private' $HOME/.Private is mounted on =
$HOME/Private.=20
>=20
> ecryptfs worked perfectly until I upgraded to kernel 4.4.14. I tested i=
t on another machine with Slackware64 and a 64bit kernel now - same resul=
t.

Thanks. The backported version of the patch needs to be adjusted. I'll
try to get a patch out the stable list tomorrow.

Tyler

>=20
> Regards,
> Henry
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--oKqfQeB6i20lvaqgUcwgGNGkJ3127gHg7--

--gK6eDVoMCOb3v0MWCsdMv9LbGN0nTnLsW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXca0TAAoJENaSAD2qAscKilMQAK5RTsrZxdUOmBdVvI8k+lX2
A2pJptFZ4nVu/Sbf5mSGDq3lKk57RV0ANnHjLfY3BtDbFmMLjZfD/IyAwuHWtCgs
9qYXWGsEnVuTEmauGoY3yxhd3ry5nM2uK+QvIT0zBytj3Pcs6ucA0iktoWjGqC6d
IkvMWXOWZLsVHNFrAvT9O2QUBpfIb/62glv1cq0TGL+HECf6yrAvc9FZKea57LsT
uruqK11NlPUNSAs4SFsHfBNUzzDZwHzonWeTPrb8cSTln4SDfrw2wMLfxWf1f5bc
plm4AEZbC0Es9GazNuefBLqkbL+MqcNVivZoKHrx0MyeaqIlJVTN6LEZJvVthAMp
gP3y17sqVoliCNK931OMouvAt3SbKjtuqRbWati+UPEWfRaWZnTI5qtDODRt6tag
MrDIdtdiLPteHCbtyAy9EhAtYWT10uU0EO+e70G1UafBgbkGGkey3Sm+9Mabj9lj
YWBSEkB9gJXRiyZfjECO2XbrwnZ1HxOv/1D+Dt0vd0Bw7ZmcEdPUsa187Z3dEOuZ
ldpOOYRyzznAropzzzWc5518ynAmePJ6SvjKgUpC1HhSB8zU25JCjbTX+ADnb6+S
VuurlunJbqs/vFPZFDb2sGAcxxd5/HggTX5RR7P+t2Y0vOUccNoJXna4mp6bNYqZ
wsBUS9W63/szoZnU33z0
=pT3w
-----END PGP SIGNATURE-----

--gK6eDVoMCOb3v0MWCsdMv9LbGN0nTnLsW--
