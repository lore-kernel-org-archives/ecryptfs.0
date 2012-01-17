From: Jakob Unterwurzacher <jakobunt@gmail.com>
Subject: Re: ecryptfs =?ISO-8859-1?Q?doesn=B4t_like_noauto_and_no?=
 =?ISO-8859-1?Q?atime?=
Date: Tue, 17 Jan 2012 02:07:42 +0100
Message-ID: <4F14C9DE.80101@gmail.com>
References: <201201161044.21718.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37159 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2AQBHq (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 16 Jan 2012 20:07:46 -0500
Received: by eekc14 with SMTP id c14so319317eek.19
        for <ecryptfs@vger.kernel.org>; Mon, 16 Jan 2012 17:07:44 -0800 (PST)
In-Reply-To: <201201161044.21718.Martin@lichtvoll.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: ecryptfs@vger.kernel.org

On 16.01.2012 10:44, Martin Steigerwald wrote:
> Hi!
>=20
> I have
>=20
> merkaba:~> grep ecrypt /etc/fstab
> /home/.ms               /home/ms                ecryptfs       =20
> noatime,noauto  0       0
>=20
> And get:
>=20
> merkaba:~> mount /home/ms
> Passphrase:=20
> Attempting to mount with the following options:
>   ecryptfs_unlink_sigs
>   ecryptfs_fnek_sig=3D0408d19ec184c207
>   ecryptfs_key_bytes=3D32
>   ecryptfs_cipher=3Daes
>   ecryptfs_sig=3D0408d19ec184c207
> Error mounting eCryptfs: [-5] Input/output error
> Check your system logs; visit <http://launchpad.net/ecryptfs>
>=20
>=20
> Still it works.
>=20
>=20
> In dmesg I see:
>=20
> [ 2657.888355] ecryptfs_parse_options: eCryptfs: unrecognized option=20
> [noauto]
> [ 2657.888359] ecryptfs_parse_options: eCryptfs: unrecognized option=20
> [noatime]
> [ 2657.913215] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aes=
ni)
>=20
>=20
> Thus I removed at least noatime, but then I still see:
>=20
> [ 2839.460200] ecryptfs_parse_options: eCryptfs: unrecognized option=20
> [noauto]
>=20
>=20
> On could argue about noatime when ecryptfs doesn=B4t override the set=
ting of=20
> the underlying filesystem - i.e. doesn=B4t write the atime itself. Bu=
t I=20
> think noauto should be silently ignored.
>=20
> Without noatime it would ask me the passwort upon boot, but I do not =
like=20
> that since I do not use that user everytime.
>=20
> I could use mounting via pam, but I like to have a different password=
 for=20
> the user stored in /etc/shadow than the password from the filesystem=20
> itself.

Note that this should work by creating ~/.ecryptfs/wrapping-independent
=2E Pam will ask for the ecryptfs password explicetely then.

Jakob
