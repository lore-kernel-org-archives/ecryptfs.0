From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Separating different ecryptfs mounts
Date: Wed, 24 Sep 2014 09:51:03 -0500
Message-ID: <20140924145102.GA20046@boyd>
References: <6009718.QGyqnh1K9Q@hp-stueble>
 <20140924140612.GA19163@boyd>
 <13707676.TT8WhPMWkl@hp-stueble>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49302 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbaIXOvH (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 24 Sep 2014 10:51:07 -0400
Content-Disposition: inline
In-Reply-To: <13707676.TT8WhPMWkl@hp-stueble>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Christian =?iso-8859-1?Q?St=FCble?= <stueble@sirrix.com>
Cc: ecryptfs@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-09-24 16:20:54, Christian St=FCble wrote:
> Hi Tyler,
>=20
> thanks for your answer. I hope you have not misunderstood my question (yo=
u=20
> describe copying a file from plain1 to plain2, right?): When an encrypted=
 file=20
> (from directory raw1) is copied into directory raw2,
> I want that it is not decrypted from the view of plain2.
>=20
> That is, I want that key1 is only used to decrypt files to be readable at=
=20
> plain1 and key2 is only used to decrypt files for plain2.

I did misunderstand your question. Sorry about that.

Note that you shouldn't modify files/directories underneath eCryptfs
mounts. eCryptfs may have cached something (dentries, inodes, file
contents, etc.) that will not be updated when you directly change the
lower files/directories.

>=20
> I have the setup described already but I noticed that a file copied from
> raw1 to raw2 (or vice versa) is accessible in plain1 and plain2 although
> the ecryptfs mount assigns only one key fro each overlay.

This is the correct behavior. The mount wide encryption key that you set
up a mount time isn't telling eCryptfs that it should only use that key
for the mount. Instead, it is telling eCryptfs what key should be used
when creating new files in the mount.

>=20
> I assume that the reason for this behavior (which is what a normal user w=
ould=20
> expect) is, that both mounts access the same keyring and thus have access=
 to
> all keys. Is that correct?

Yes, that is correct.

> My hope is that it is possible to restrict the use of the keys to
> individual ecryptfs mounts.

That is not possible with the current ecryptfs-utils and ecryptfs kernel
module.

>=20
> My expectation (not verified yet) is that the behavior I need can be real=
ized
> by doing the mounts with two different users, but I hope that there is a=
=20
> better solution.

Different users should work. I understand that isn't an ideal solution
but I don't recall anyone ever asking for the functionality you're
describing.

The type of change that I'd be willing to accept in order to meet your
requirements would be one where an additional mount option
(ecryptfs_keyring ?) can be given to limit the kernel keyring searches
to a specific kernel keyring. It would also require changes to the utils
to insert the mount key into the specified keyring instead of the user
session keyring.

Would that meet your requirements?

Tyler

>=20
> Best regards,
> Chris
>=20
> Am Mittwoch, 24. September 2014, 09:06:12 schrieb Tyler Hicks:
> > On 2014-09-24 10:50:57, Christian St=FCble wrote:
> > > Hi,
> > >=20
> > > is it possible with ecryptfs to have two different ecryptfs mounts, e=
=2Eg.,
> > >=20
> > > plain1 -> raw1
> > > plain2 -> raw2
> > >=20
> > > using two different openssl keys, and to ensure that each key is _onl=
y_
> > > used by its own mount? That is, I want to prevent that files copied
> > > between
> > > raw1 and raw2 are automatically decrypted.
> >=20
> > Everything above is doable except for the last part. Copying files
> > between two eCryptfs mount points will result in the file being
> > decrypted when copied out of the first mount and re-encrypted when copi=
ed
> > into the second mount point.
> >=20
> > > To my understanding of the IBM paper about ecryptfs, it should be pos=
sible
> > > to set a policy defining which mount is allowed to use which key, but=
 I
> > > could not find any documentation about it.
> >=20
> > The policy feature described in the IBM paper was future thinking. It
> > has never been implemented and there are no near term plans to implement
> > it. I would be willing to accept patches that implement the feature.
> >=20
> > Tyler
> >=20
> > > When it is possible, can you explain or point me to some docs describ=
ing
> > > how I can do this?
> > >=20
> > > Thanks,
> > > Chris
> > >=20
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
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

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUItpWAAoJENaSAD2qAscK+rgQAM91RXozPMghX8lg+mEMcuQF
pfenlx9oDe7RDqakclsUHjpsB0VAz8U7bMiPesHzAi7itwMo+gHd3Xym3w7jc0BB
iYKwzyBYQVB9M87lJ0HJZT3gdohSrTu8KtMvO8lhcujiJ3cUbcCmfVwR4VV+U/3k
Y2PDKKfX2AVNW8AMbCK0bPf6hJYicSeZWDo2N0QR9yOcx+G2rfMW8pHpD9ibY2Nf
6DBiWob4azhNEX0sgoqmaRjPqSATAfQeKiHZhyBpZ/QNlr+V/dQBM9F47bauw4i0
QV1YxYdenuXmwMNB5sVycGoH7l247AymcpVE4efHw7LF7+si3IzKgy6XrVxLRTAP
F1JG2JGe5EaocQbgqTcatD/UDAWEPQNUmStwgjNMvz7L/SxKac2u0cvebQnMOqOO
0KrL1loC64m3yqdLPnHf1xZsqS3O1mT++NhXdvJXIpbOPQCv7lL/AHaGqAa/vhr0
BNuQafgIbUPxWSdOYtbiM0A+HrUMudTbkv7sRd6ktJFoFpUy/hZdSACJi668s79x
umBlopf5G6Qmn6+VZgkR433mijF/rAwjvps5p+D56ZEmJKNHGLfsqz3PlONQF6n/
o4XvV4pTMkmPLykNTe9QjV0V6QLbNAI3dZ5OtyJAAM55wf//dQJNlVFCFvzuhdzp
xYxJJIsKPIQIyBc4rJTu
=cu7S
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
