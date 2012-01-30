From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: =?ISO-8859-1?Q?Re=3A_ecryptfs_doesn=B4t_like_noauto_and_noatime?=
Date: Mon, 30 Jan 2012 12:49:56 -0600
Message-ID: <CANT6BaMtS0C0iHBBbB7JMvYHqx2qMUnZMeHkpdDDzf+kB01zTQ@mail.gmail.com>
References: <201201161044.21718.Martin@lichtvoll.de>
	<201201170937.10613.Martin@lichtvoll.de>
	<4F154383.6040201@gmail.com>
	<201201301158.36957.ms@teamix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43505 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab2A3St5 convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 30 Jan 2012 13:49:57 -0500
Received: by pbaa10 with SMTP id a10so3994363pba.19
        for <ecryptfs@vger.kernel.org>; Mon, 30 Jan 2012 10:49:57 -0800 (PST)
In-Reply-To: <201201301158.36957.ms@teamix.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Martin Steigerwald <ms@teamix.de>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>, Martin Steigerwald <Martin@lichtvoll.de>, ecryptfs@vger.kernel.org

On Mon, Jan 30, 2012 at 4:58 AM, Martin Steigerwald <ms@teamix.de> wrot=
e:
>
> Hi Jakob,
>
> Am Dienstag, 17. Januar 2012 schrieb Jakob Unterwurzacher:
> > On 17.01.2012 09:37, Martin Steigerwald wrote:
> > > Am Dienstag, 17. Januar 2012 schrieb Jakob Unterwurzacher:
> > >> On 16.01.2012 10:44, Martin Steigerwald wrote:
> > >>> Hi!
> > >>>
> > >>> I have
> > >>>
> > >>> merkaba:~> grep ecrypt /etc/fstab
> > >>> /home/.ms =A0 =A0 =A0 =A0 =A0 =A0 =A0 /home/ms =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0ecryptfs
> > >>> noatime,noauto =A00 =A0 =A0 =A0 0
> > >>>
> > >>> And get:
> > >>>
> > >>> merkaba:~> mount /home/ms
> > >
> > >>> Passphrase:
> > > [=85]
> > >
> > >>> Error mounting eCryptfs: [-5] Input/output error
> > >
> > > [=85]
> > >
> > >>> Still it works.
> > >>>
> > >>>
> > >>> In dmesg I see:
> > >>>
> > >>> [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized o=
ption
> > >>> [noauto]
> > >>> [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized o=
ption
> > >>> [noatime]
> > >>> [ 2657.913215] alg: No test for __gcm-aes-aesni
> > >>> (__driver-gcm-aes-aesni)
> > >>>
> > >>>
> > >>> Thus I removed at least noatime, but then I still see:
> > >>>
> > >>> [ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized o=
ption
> > >>> [noauto]
> > >
> > > [=85]
> > >
> > >>> Without noatime it would ask me the passwort upon boot, but I d=
o not
> > >>> like that since I do not use that user everytime.
> > >
> > > noauto that is.
> > >
> > >>> I could use mounting via pam, but I like to have a different pa=
ssword
> > >>> for the user stored in /etc/shadow than the password from the
> > >>> filesystem itself.
> > >>
> > >> Note that this should work by creating ~/.ecryptfs/wrapping-inde=
pendent
> > >> . Pam will ask for the ecryptfs password explicitely then.
> > >
> > > Thanks.
> > >
> > > Would that also work within a display manager like kdm?
> > >
> > > Ciao,
> >
> > Yes! It will ask for two passwords on login.
>
> Hmmm, I think this won't work for me.
>
> This is used by ecryptfs-mount-private it seems, but I am not only en=
crypting
> /home/$USER/Private, but /home/$USER itself. Thus I'd like to mount ~=
 as is
> with a different passphrase than my PAM login password.
>
> I tried putting an empty ~/.ecryptfs/wrapping-independent, which has =
the sig-
> cache.txt for the /home/ms mount but this doesn't do the trick, I am =
not asked
> for a password and home directory remains empty. I could put
>
> Is it true that PAM ecryptfs stuff is only for a ~/Private directory?

Definitely not.  pam_ecryptfs.so is the method by which keys are
loaded into your keyring at login time, by unwrapping
~/.ecryptfs/wrapped-passphrase using your login passphrase.

It should work with either a randomly generated one, or one of your
choosing.  It doesn't really care what's inside of
~/.ecryptfs/wrapped-passphrase -- just that your login passphrase can
symmetrically decrypt it.

Now, getting a passphrase of your choosing into that file requires
running ecryptfs-setup-private by hand, rather than using wrappers,
like the Ubuntu installer or the adduser utility.

> Then that would be a reason for me to make a feature request ;).

--=20
:-Dustin

Dustin Kirkland
Chief Architect
Gazzang, Inc.
www.gazzang.com
