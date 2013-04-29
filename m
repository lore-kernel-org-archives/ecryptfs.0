From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Ecryptfs over sshfs and timestamps
Date: Sun, 28 Apr 2013 18:27:11 -0700
Message-ID: <20130429012711.GA4925@boyd>
References: <CAHHtCV9kvjbmUnH584HUaDLtVktjcP7fB1myWBx-kcsErF7zZw@mail.gmail.com>
 <alpine.DEB.2.10.1304211324450.13746@trent.utfs.org>
 <CAM-DUcOrs3vws+Vt9BWw29da8M_1LRwkrPHPF_eUc3Mz2a7ZaQ@mail.gmail.com>
 <alpine.DEB.2.10.1304211546110.13746@trent.utfs.org>
 <CAHHtCV8Efp+OJ3Rx54_d_dMcSvZnNxdodBK96hSj9=1iLUSB7g@mail.gmail.com>
 <20130423193016.GB7389@boyd>
 <CAHHtCV-1kwcXESyYLgm9-quTiZJ0XRZXqXcFgMT9pURB0Vw0Ug@mail.gmail.com>
 <CAHHtCV8PCU0v=96Oj8pP3seyh-out_2F=24ekBFio1k1zTwK6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34751 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586Ab3D2B1U (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 28 Apr 2013 21:27:20 -0400
Content-Disposition: inline
In-Reply-To: <CAHHtCV8PCU0v=96Oj8pP3seyh-out_2F=24ekBFio1k1zTwK6g@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Ivan Yosifov <iyosifov@gmail.com>
Cc: Christian Kujau <lists@nerdbynature.de>, Mike Reinstein <reinstein.mike@gmail.com>, ecryptfs@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-04-24 21:59:05, Ivan Yosifov wrote:
> Sorry, the mail got sent incomplete, resending:
>=20
> > Does this happen when only using sshfs (without eCryptfs mounted on
> > top)?
>=20
> No, cp --preserve=3Dtimestamps to sshfs alone works.
>=20
> > Does this happen when only using eCryptfs (mounted locally on top of
> > something like ext4)?
>=20
> No, cp --preserve=3Dtimestamps to ecryptfs on top of ext4 works too.
>=20
> > Nothing like that should be a problem from eCryptfs' standpoint. I have
> > no idea about sshfs.
>=20
> Well, the existence of the allow_root and allow_other sshfs options
> suggest it somehow cares.
>=20
> > Why didn't adding user,noauto to the fstab entry work for you? What
> > error message did you see? Anything relevant in the system log?
>=20
> For example, I just tried with the following line (the key '1' is
> obviously just for testing):
>=20
> /home/obelix/evil_host /home/obelix/bak ecryptfs
> user,noauto,verbose,key=3Dpassphrase:passphrase_passwd=3D1 0 0
>=20
> I got:
>=20
> $ mount ./bak
> Exiting. Unable to obtain passwd info
>=20
> I didn't get anything written to /var/log/messages.log or dmesg.
>=20
> If I run the mount as root, I get asked for the other parameters and
> in the end it mounts.
> I tried with a more comprehensive fstab line too:
>=20
> /home/obelix/evil_host /home/obelix/bak ecryptfs
> user,noauto,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D16,verbose,key=3Dp=
assphrase:passphrase_passwd=3D1,ecryptfs_passthrough,ecryptfs_enable_filena=
me_crypto=3Dn
> 0 0
>=20
> This mounts as root without asking any questions and fails as user
> with the same error.

It is typically easier to manually perform the mount once, then take
note of the mount options listed in /proc/mounts, add an entry to fstab,
then bypass the eCryptfs mount helper when performing mounts.

So, your fstab entry might look something like this:

/tmp/ecryptfs /tmp/ecryptfs ecryptfs ecryptfs_sig=3D253ca7e88811d184,ecrypt=
fs_cipher=3Daes,ecryptfs_key_bytes=3D16,defaults,users,noauto 0 0

Adjust the ecryptfs_sig=3D value accordingly.

Now, do a mount that bypasses the eCryptfs mount helper by using the -i
mount option.

$ mount -i /tmp/ecryptfs

Tyler

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJRfcxvAAoJENaSAD2qAscKr1gP/3jP1wsNyCrWI2+XsLuiKM4M
rjfR9ii6VZOho39JYwPmpSxa9DxQwnZt67G9J00Y3oBq4YN1iEAyc9tKNZWk9bJk
8Eoz7HnLXEFZDmAtnP/8DHKqEZ4XI7WYJJ9gpURfjo85gys8peq04vJxFlB0y8YL
ACPsa2Oiif31QDr4EajHZYlRVJoEXgXbViaggbBSdfBgnN+7v3bEqdpLc1Yn94JG
JPoLHMptZZWPjrN4iICRA550ZTBxULItLCnoQ07q1jd+rze+YHpM5oDA0toQmQM0
5javubRV/g3745BEOTzc897G8WdqU9tueGCxnjCRqLTiys1b1ICjo8xOU09sqpT0
Z7+f05aD+l6EnR9AHAStx8j/EN8kn8Zn9eMG1WPYNCugx+1FLSGzDAF4VKW38dlP
hOEuhK4+H5vHWLKa4rzy3959tr57u6bgwVLJD97wVYky7YNFzgYwv4JSCUw7s07p
NWdZNTEdD2rsm2kS6LSnU1HtsxtnwWF2gW97cQ0jkhauRmY1OSlbsRCTxKylj57H
85snYdHhZ2kdvb0m0y24Wjo4K85QYXLwVRBiu+Hphavb/TxsPJTtay+EDbyeHtTb
ZF/esDfOUaUf5bYEy/brDa1sVJgct1hB+WbyoLhzzxhabDC5RFJqgmbYXfsgAvXh
6FnV3pMSVPr+xIQyA6Da
=q5K2
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
