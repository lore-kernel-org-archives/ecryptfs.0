From: Christian =?ISO-8859-1?Q?St=FCble?= <stueble@sirrix.com>
Subject: Re: Separating different ecryptfs mounts
Date: Thu, 25 Sep 2014 10:10:58 +0200
Message-ID: <1542927.yeEpMd0H1t@hp-stueble>
References: <6009718.QGyqnh1K9Q@hp-stueble> <13707676.TT8WhPMWkl@hp-stueble> <20140924145102.GA20046@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx.sirrix.com ([176.9.214.66]:57221 "EHLO mx.sirrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbaIYI0C convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 25 Sep 2014 04:26:02 -0400
In-Reply-To: <20140924145102.GA20046@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Hi Tyler,
hi List

we did some more tests to find out whether there are other alternatives=
 than=20
adding another option and we found some interesting behavior I do not=20
understand:

When mounting the example scenario given below:

	plain1 -> raw1
	plain2 -> raw2

as normal Linux user using sudo and passphrase-based encryption I get t=
he=20
result as required:

1) The user can write/read files to/from plain1
2) The user can write/read files to/from plain2
3) Files exchanged between raw1 and raw2 cannot be read.
4) The root, however, can read files exchanged between raw1 and raw2

It this an intended behavior? It seems that ecryptfs only uses the keys=
=20
directly assigned to the mount for decryption for normal users, but all
keys for the root user.

However, if I do the same setup (sudo etc.) using the openssl module,

1) A normal user cannot even write files into plain1 or plain2. I get
a "socket not connected" error.
2) Root can write/read files into plain1/plain1

Here, it seems that ecryptfs only allows users to use keys of its own k=
eyring?

The bahavior of the ecrypfs mount based on passwords would be ok for us=
, but=20
we would need it in combination with asymmetric encryption. Do you have=
 an=20
idea why these two backends behave differently?

Best regards,
Chris


Am Mittwoch, 24. September 2014, 09:51:03 schrieb Tyler Hicks:
> On 2014-09-24 16:20:54, Christian St=FCble wrote:
> > Hi Tyler,
> >=20
> > thanks for your answer. I hope you have not misunderstood my questi=
on (you
> > describe copying a file from plain1 to plain2, right?): When an enc=
rypted
> > file (from directory raw1) is copied into directory raw2,
> > I want that it is not decrypted from the view of plain2.
> >=20
> > That is, I want that key1 is only used to decrypt files to be reada=
ble at
> > plain1 and key2 is only used to decrypt files for plain2.
>=20
> I did misunderstand your question. Sorry about that.
>=20
> Note that you shouldn't modify files/directories underneath eCryptfs
> mounts. eCryptfs may have cached something (dentries, inodes, file
> contents, etc.) that will not be updated when you directly change the
> lower files/directories.
>=20
> > I have the setup described already but I noticed that a file copied=
 from
> > raw1 to raw2 (or vice versa) is accessible in plain1 and plain2 alt=
hough
> > the ecryptfs mount assigns only one key fro each overlay.
>=20
> This is the correct behavior. The mount wide encryption key that you =
set
> up a mount time isn't telling eCryptfs that it should only use that k=
ey
> for the mount. Instead, it is telling eCryptfs what key should be use=
d
> when creating new files in the mount.
>=20
> > I assume that the reason for this behavior (which is what a normal =
user
> > would expect) is, that both mounts access the same keyring and thus=
 have
> > access to all keys. Is that correct?
>=20
> Yes, that is correct.
>=20
> > My hope is that it is possible to restrict the use of the keys to
> > individual ecryptfs mounts.
>=20
> That is not possible with the current ecryptfs-utils and ecryptfs ker=
nel
> module.
>=20
> > My expectation (not verified yet) is that the behavior I need can b=
e
> > realized by doing the mounts with two different users, but I hope t=
hat
> > there is a better solution.
>=20
> Different users should work. I understand that isn't an ideal solutio=
n
> but I don't recall anyone ever asking for the functionality you're
> describing.
>=20
> The type of change that I'd be willing to accept in order to meet you=
r
> requirements would be one where an additional mount option
> (ecryptfs_keyring ?) can be given to limit the kernel keyring searche=
s
> to a specific kernel keyring. It would also require changes to the ut=
ils
> to insert the mount key into the specified keyring instead of the use=
r
> session keyring.
>=20
> Would that meet your requirements?
>=20
> Tyler
>=20
> > Best regards,
> > Chris
> >=20
> > Am Mittwoch, 24. September 2014, 09:06:12 schrieb Tyler Hicks:
> > > On 2014-09-24 10:50:57, Christian St=FCble wrote:
> > > > Hi,
> > > >=20
> > > > is it possible with ecryptfs to have two different ecryptfs mou=
nts,
> > > > e.g.,
> > > >=20
> > > > plain1 -> raw1
> > > > plain2 -> raw2
> > > >=20
> > > > using two different openssl keys, and to ensure that each key i=
s
> > > > _only_
> > > > used by its own mount? That is, I want to prevent that files co=
pied
> > > > between
> > > > raw1 and raw2 are automatically decrypted.
> > >=20
> > > Everything above is doable except for the last part. Copying file=
s
> > > between two eCryptfs mount points will result in the file being
> > > decrypted when copied out of the first mount and re-encrypted whe=
n
> > > copied
> > > into the second mount point.
> > >=20
> > > > To my understanding of the IBM paper about ecryptfs, it should =
be
> > > > possible
> > > > to set a policy defining which mount is allowed to use which ke=
y, but
> > > > I
> > > > could not find any documentation about it.
> > >=20
> > > The policy feature described in the IBM paper was future thinking=
=2E It
> > > has never been implemented and there are no near term plans to im=
plement
> > > it. I would be willing to accept patches that implement the featu=
re.
> > >=20
> > > Tyler
> > >=20
> > > > When it is possible, can you explain or point me to some docs
> > > > describing
> > > > how I can do this?
> > > >=20
> > > > Thanks,
> > > > Chris
> > > >=20
> > > >=20
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ecryp=
tfs" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml

--=20
Sirrix AG security technologies - http://www.sirrix.com
Dipl.-Inform. Christian St=FCble  eMail: stueble@sirrix.com
Tel +49(681) 959 86-111    Fax +49(681) 959 86-511

Vorstand: Ammar Alkassar (Vors.), Christian St=FCble, Markus Bernhammer
Vorsitzender des Aufsichtsrates: Harald St=F6ber
Sitz der Gesellschaft: Homburg/Saar, HRB 3857 Amtsgericht Saarbr=FCcken
This message may contain confidential and/or privileged information. If=
 you
are not the addressee, you must not use, copy, disclose or take any act=
ion
based on this message or any information herein. If you have received t=
his
message in error, please advise the sender immediately by reply e-mail =
and
delete this message.
