From: Christian =?ISO-8859-1?Q?St=FCble?= <stueble@sirrix.com>
Subject: Re: Separating different ecryptfs mounts
Date: Wed, 24 Sep 2014 16:20:54 +0200
Message-ID: <13707676.TT8WhPMWkl@hp-stueble>
References: <6009718.QGyqnh1K9Q@hp-stueble> <20140924140612.GA19163@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx.sirrix.com ([176.9.214.66]:39568 "EHLO mx.sirrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbaIXOU6 convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 24 Sep 2014 10:20:58 -0400
In-Reply-To: <20140924140612.GA19163@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Hi Tyler,

thanks for your answer. I hope you have not misunderstood my question (=
you=20
describe copying a file from plain1 to plain2, right?): When an encrypt=
ed file=20
(from directory raw1) is copied into directory raw2,
I want that it is not decrypted from the view of plain2.

That is, I want that key1 is only used to decrypt files to be readable =
at=20
plain1 and key2 is only used to decrypt files for plain2.

I have the setup described already but I noticed that a file copied fro=
m
raw1 to raw2 (or vice versa) is accessible in plain1 and plain2 althoug=
h
the ecryptfs mount assigns only one key fro each overlay.

I assume that the reason for this behavior (which is what a normal user=
 would=20
expect) is, that both mounts access the same keyring and thus have acce=
ss to
all keys. Is that correct? My hope is that it is possible to restrict t=
he use=20
of the keys to individual ecryptfs mounts.

My expectation (not verified yet) is that the behavior I need can be re=
alized
by doing the mounts with two different users, but I hope that there is =
a=20
better solution.

Best regards,
Chris

Am Mittwoch, 24. September 2014, 09:06:12 schrieb Tyler Hicks:
> On 2014-09-24 10:50:57, Christian St=FCble wrote:
> > Hi,
> >=20
> > is it possible with ecryptfs to have two different ecryptfs mounts,=
 e.g.,
> >=20
> > plain1 -> raw1
> > plain2 -> raw2
> >=20
> > using two different openssl keys, and to ensure that each key is _o=
nly_
> > used by its own mount? That is, I want to prevent that files copied
> > between
> > raw1 and raw2 are automatically decrypted.
>=20
> Everything above is doable except for the last part. Copying files
> between two eCryptfs mount points will result in the file being
> decrypted when copied out of the first mount and re-encrypted when co=
pied
> into the second mount point.
>=20
> > To my understanding of the IBM paper about ecryptfs, it should be p=
ossible
> > to set a policy defining which mount is allowed to use which key, b=
ut I
> > could not find any documentation about it.
>=20
> The policy feature described in the IBM paper was future thinking. It
> has never been implemented and there are no near term plans to implem=
ent
> it. I would be willing to accept patches that implement the feature.
>=20
> Tyler
>=20
> > When it is possible, can you explain or point me to some docs descr=
ibing
> > how I can do this?
> >=20
> > Thanks,
> > Chris
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ecryptfs"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
