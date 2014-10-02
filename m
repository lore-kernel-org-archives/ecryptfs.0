From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Separating different ecryptfs mounts
Date: Thu, 2 Oct 2014 16:05:20 -0500
Message-ID: <20141002210519.GC2522@boyd>
References: <6009718.QGyqnh1K9Q@hp-stueble>
 <20140924145102.GA20046@boyd>
 <1542927.yeEpMd0H1t@hp-stueble>
 <5248408.zEIqrqEJ4F@hp-stueble>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45808 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaJBVFZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 2 Oct 2014 17:05:25 -0400
Content-Disposition: inline
In-Reply-To: <5248408.zEIqrqEJ4F@hp-stueble>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Christian =?iso-8859-1?Q?St=FCble?= <stueble@sirrix.com>
Cc: ecryptfs@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My apologies for the long delay.

On 2014-09-25 10:48:23, Christian St=FCble wrote:
> Hello,
>=20
> I had an error in my configuration, see below:
>=20
> Am Donnerstag, 25. September 2014, 10:10:58 schrieb Christian St=FCble:
> > Hi Tyler,
> > hi List
> >=20
> > we did some more tests to find out whether there are other alternatives=
 than
> > adding another option and we found some interesting behavior I do not
> > understand:
> >=20
> > When mounting the example scenario given below:
> >=20
> > 	plain1 -> raw1
> > 	plain2 -> raw2
> >=20
> > as normal Linux user using sudo and passphrase-based encryption I get t=
he
> > result as required:
> >=20
> > 1) The user can write/read files to/from plain1
> > 2) The user can write/read files to/from plain2
> > 3) Files exchanged between raw1 and raw2 cannot be read.
> > 4) The root, however, can read files exchanged between raw1 and raw2
> >=20
> > It this an intended behavior? It seems that ecryptfs only uses the keys
> > directly assigned to the mount for decryption for normal users, but all
> > keys for the root user.
> This behavior is still unclear to me.

I can't reproduce this behavior. I can move the files between the lower
mount points and read the files out of each upper mount point.

As I mentioned before, directly modifying the lower mount point while eCryp=
tfs
is mounted is not supported and may result in data loss. You should unmount=
 the
eCryptfs layer before modifying the lower mount point.

One thing to check is that you have both mount keys in each session:

$ keyctl show
Session Keyring
 965589071 --alswrv   1000  1000  keyring: _ses
 155596823 --alswrv   1000 65534   \_ keyring: _uid.1000
 589053956 --alswrv   1000  1000       \_ user: 253ca7e88811d184
 760940678 --alswrv   1000  1000       \_ user: 72c0078c0eaa7eec

Different distributions use the kernel keyring and the pam_keyinit PAM modu=
le
differently. eCryptfs searches the user session keyring. You'll only be abl=
e to
read files created under mounts whose key(s) are in the current user session
keyring. Doing things like opening a new SSH session may result in a new us=
er
session keyring, depending on how your system is configured.

>=20
> >=20
> > However, if I do the same setup (sudo etc.) using the openssl module,
> >=20
> > 1) A normal user cannot even write files into plain1 or plain2. I get
> > a "socket not connected" error.
> > 2) Root can write/read files into plain1/plain1
> I just noticed that the difference is that ecryptfsd has to run as the us=
er=20
> who accesses the ecryptfs file system. It is possible to run multiple=20
> ecryptfsd in parallel (one for each user)?

Yes. ecryptfsd was designed with the thought that each user would run their=
 own
daemon.

Tyler

>=20
> Best regards,
> Chris
>=20
>=20
> >=20
> > Here, it seems that ecryptfs only allows users to use keys of its own
> > keyring?
> >=20
> > The bahavior of the ecrypfs mount based on passwords would be ok for us=
, but
> > we would need it in combination with asymmetric encryption. Do you have=
 an
> > idea why these two backends behave differently?
> >=20
> > Best regards,
> > Chris
> >=20
> > Am Mittwoch, 24. September 2014, 09:51:03 schrieb Tyler Hicks:
> > > On 2014-09-24 16:20:54, Christian St=FCble wrote:
> > > > Hi Tyler,
> > > >=20
> > > > thanks for your answer. I hope you have not misunderstood my questi=
on
> > > > (you
> > > > describe copying a file from plain1 to plain2, right?): When an
> > > > encrypted
> > > > file (from directory raw1) is copied into directory raw2,
> > > > I want that it is not decrypted from the view of plain2.
> > > >=20
> > > > That is, I want that key1 is only used to decrypt files to be reada=
ble
> > > > at
> > > > plain1 and key2 is only used to decrypt files for plain2.
> > >=20
> > > I did misunderstand your question. Sorry about that.
> > >=20
> > > Note that you shouldn't modify files/directories underneath eCryptfs
> > > mounts. eCryptfs may have cached something (dentries, inodes, file
> > > contents, etc.) that will not be updated when you directly change the
> > > lower files/directories.
> > >=20
> > > > I have the setup described already but I noticed that a file copied=
 from
> > > > raw1 to raw2 (or vice versa) is accessible in plain1 and plain2 alt=
hough
> > > > the ecryptfs mount assigns only one key fro each overlay.
> > >=20
> > > This is the correct behavior. The mount wide encryption key that you =
set
> > > up a mount time isn't telling eCryptfs that it should only use that k=
ey
> > > for the mount. Instead, it is telling eCryptfs what key should be used
> > > when creating new files in the mount.
> > >=20
> > > > I assume that the reason for this behavior (which is what a normal =
user
> > > > would expect) is, that both mounts access the same keyring and thus=
 have
> > > > access to all keys. Is that correct?
> > >=20
> > > Yes, that is correct.
> > >=20
> > > > My hope is that it is possible to restrict the use of the keys to
> > > > individual ecryptfs mounts.
> > >=20
> > > That is not possible with the current ecryptfs-utils and ecryptfs ker=
nel
> > > module.
> > >=20
> > > > My expectation (not verified yet) is that the behavior I need can be
> > > > realized by doing the mounts with two different users, but I hope t=
hat
> > > > there is a better solution.
> > >=20
> > > Different users should work. I understand that isn't an ideal solution
> > > but I don't recall anyone ever asking for the functionality you're
> > > describing.
> > >=20
> > > The type of change that I'd be willing to accept in order to meet your
> > > requirements would be one where an additional mount option
> > > (ecryptfs_keyring ?) can be given to limit the kernel keyring searches
> > > to a specific kernel keyring. It would also require changes to the ut=
ils
> > > to insert the mount key into the specified keyring instead of the user
> > > session keyring.
> > >=20
> > > Would that meet your requirements?
> > >=20
> > > Tyler
> > >=20
> > > > Best regards,
> > > > Chris
> > > >=20
> > > > Am Mittwoch, 24. September 2014, 09:06:12 schrieb Tyler Hicks:
> > > > > On 2014-09-24 10:50:57, Christian St=FCble wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > is it possible with ecryptfs to have two different ecryptfs mou=
nts,
> > > > > > e.g.,
> > > > > >=20
> > > > > > plain1 -> raw1
> > > > > > plain2 -> raw2
> > > > > >=20
> > > > > > using two different openssl keys, and to ensure that each key is
> > > > > > _only_
> > > > > > used by its own mount? That is, I want to prevent that files co=
pied
> > > > > > between
> > > > > > raw1 and raw2 are automatically decrypted.
> > > > >=20
> > > > > Everything above is doable except for the last part. Copying files
> > > > > between two eCryptfs mount points will result in the file being
> > > > > decrypted when copied out of the first mount and re-encrypted when
> > > > > copied
> > > > > into the second mount point.
> > > > >=20
> > > > > > To my understanding of the IBM paper about ecryptfs, it should =
be
> > > > > > possible
> > > > > > to set a policy defining which mount is allowed to use which ke=
y,
> > > > > > but
> > > > > > I
> > > > > > could not find any documentation about it.
> > > > >=20
> > > > > The policy feature described in the IBM paper was future thinking=
=2E It
> > > > > has never been implemented and there are no near term plans to
> > > > > implement
> > > > > it. I would be willing to accept patches that implement the featu=
re.
> > > > >=20
> > > > > Tyler
> > > > >=20
> > > > > > When it is possible, can you explain or point me to some docs
> > > > > > describing
> > > > > > how I can do this?
> > > > > >=20
> > > > > > Thanks,
> > > > > > Chris
> > > > > >=20
> > > > > >=20
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe ecryp=
tfs"
> > > > > > in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>=20
> --=20
> Sirrix AG security technologies - http://www.sirrix.com
> Dipl.-Inform. Christian St=FCble  eMail: stueble@sirrix.com
> Tel +49(681) 959 86-111    Fax +49(681) 959 86-511
>=20
> Vorstand: Ammar Alkassar (Vors.), Christian St=FCble, Markus Bernhammer
> Vorsitzender des Aufsichtsrates: Harald St=F6ber
> Sitz der Gesellschaft: Homburg/Saar, HRB 3857 Amtsgericht Saarbr=FCcken
> This message may contain confidential and/or privileged information. If y=
ou
> are not the addressee, you must not use, copy, disclose or take any action
> based on this message or any information herein. If you have received this
> message in error, please advise the sender immediately by reply e-mail and
> delete this message.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJULb4PAAoJENaSAD2qAscKibcP/1pyXNwgELlot+2aTXFNBqcu
tHF7bI++vseOZm1QoXeScKhrsj1a3xC9LriiQKC7RTQxX6gw8xDSqv6nO2Lv8Zar
8apXdFJ2E4UlJ0s5LK1xEByHk4kCSsJau3wKuA2PWSSF/uXToZ2v1yYbj5WA/u9G
nvBdeIgQsx2SEPk5+FJsHZoMy/KBMmWooRLhW23AXoPPUIzS6fZr5jCBxFhhzFIa
GE7g1hlzFNw/hQ4S/c19t5epRtknGMs8lmtJDbeUU2YzSw2hG4NYfQpVCZ3NJr5Z
B2Uf1s2YtmVYft/MGV0R4VsJkeAmdjJc6BbJmUl93ylRrmdO6rxsb+jN5FASHLyZ
xtsY2Brel4PTVnH+cy5QwnYBL+i4917hvSoZFqdSlK3FTkUknwob4WCvAYFF3atB
gWyAQv+7BdJ75iIxVRfUvoyklfQrCODFsA+LF2nUWI756PXzBssk4eOr1KHBG/+C
to+aEw2K2g8rqWvvXzSd7+78aJaj9oga4z+BoDdG88N9SMZ9DXeTjSXjEf1qchGb
Kp06Px7bOhA1vDYoutfiqajlAqiHxZLysDGFT968sUo2QiAUHmkt/B9/SKMyJqgE
wzmkLt7som2RaF7fzTUHkfEdHdj1rCGsuyS5s/I4Izhi61uQyI+ej9SNMy5N8nBW
l6PleMI5wVEJXubXaTni
=KoKr
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
