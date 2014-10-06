From: Anna Fischer <a.fischer@sirrix.com>
Subject: AW: Separating different ecryptfs mounts
Date: Mon, 6 Oct 2014 11:14:45 +0000
Message-ID: <ECC8F67CE961104EB2AFE8F7FD50F5D040C735@exchange2010.sirrix.de>
References: <6009718.QGyqnh1K9Q@hp-stueble> <20140924145102.GA20046@boyd>
 <1542927.yeEpMd0H1t@hp-stueble> <5248408.zEIqrqEJ4F@hp-stueble>
 <20141002210519.GC2522@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx.sirrix.com ([176.9.214.66]:44295 "EHLO mx.sirrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbaJFLge convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 6 Oct 2014 07:36:34 -0400
Received: from [172.25.20.101] (helo=exchange2010.sirrix.de)
	by mx.sirrix.com with esmtp (Exim 4.76)
	(envelope-from <a.fischer@sirrix.com>)
	id 1Xb6Ee-0008VT-I8
	for ecryptfs@vger.kernel.org; Mon, 06 Oct 2014 13:13:49 +0200
In-Reply-To: <20141002210519.GC2522@boyd>
Content-Language: de-DE
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>

> Betreff: Re: Separating different ecryptfs mounts
>=20
> My apologies for the long delay.
>=20
> On 2014-09-25 10:48:23, Christian St=FCble wrote:
> > Hello,
> >
> > I had an error in my configuration, see below:
> >
> > Am Donnerstag, 25. September 2014, 10:10:58 schrieb Christian St=FC=
ble:
> > > Hi Tyler,
> > > hi List
> > >
> > > we did some more tests to find out whether there are other=20
> > > alternatives than adding another option and we found some=20
> > > interesting behavior I do not
> > > understand:
> > >
> > > When mounting the example scenario given below:
> > >
> > > 	plain1 -> raw1
> > > 	plain2 -> raw2
> > >
> > > as normal Linux user using sudo and passphrase-based encryption I=
=20
> > > get the result as required:
> > >
> > > 1) The user can write/read files to/from plain1
> > > 2) The user can write/read files to/from plain2
> > > 3) Files exchanged between raw1 and raw2 cannot be read.
> > > 4) The root, however, can read files exchanged between raw1 and=20
> > > raw2
> > >
> > > It this an intended behavior? It seems that ecryptfs only uses th=
e=20
> > > keys directly assigned to the mount for decryption for normal=20
> > > users, but all keys for the root user.
> > This behavior is still unclear to me.
>=20
> I can't reproduce this behavior. I can move the files between the=20
> lower mount points and read the files out of each upper mount point.
>=20
> As I mentioned before, directly modifying the lower mount point while=
=20
> eCryptfs is mounted is not supported and may result in data loss. You=
=20
> should unmount the eCryptfs layer before modifying the lower mount po=
int.
>=20
> One thing to check is that you have both mount keys in each session:
>=20
> $ keyctl show
> Session Keyring
>  965589071 --alswrv   1000  1000  keyring: _ses
>  155596823 --alswrv   1000 65534   \_ keyring: _uid.1000
>  589053956 --alswrv   1000  1000       \_ user: 253ca7e88811d184
>  760940678 --alswrv   1000  1000       \_ user: 72c0078c0eaa7eec
>=20
> Different distributions use the kernel keyring and the pam_keyinit PA=
M=20
> module differently. eCryptfs searches the user session keyring. You'l=
l=20
> only be able to read files created under mounts whose key(s) are in=20
> the current user session keyring. Doing things like opening a new SSH=
=20
> session may result in a new user session keyring, depending on how yo=
ur system is configured.

Hi Tyler,

I have a question related to the use case Chris is describing. I have s=
een that at kernel-level, there is an additional mount option "ecryptfs=
_mount_auth_tok_only" which forces ecryptfs to only use the keys specif=
ied by 'ecryptfs_sig' and 'ecryptfs_fnek_sig' for *decryption* of files=
 (as I understand it is by default only used for encryption of newly cr=
eated files under the given mount point).=20

Can you clarify the (implementation) state of that option? I thought th=
at is a potential way to restrict what keys are used for individual mou=
nt points?

Thanks for your help,
Anna=20
