From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [3.0.y, 3.2.y, 3.4.y] Re: ecryptfs: corrupted files on a disk
 full event
Date: Sun, 14 Oct 2012 02:37:55 +0100
Message-ID: <1350178664.4832.65.camel@deadeye.wl.decadent.org.uk>
References: <20121009173522.5563.81022.reportbug@klapprechner>
	 <20121009193342.GA3993@elie.Belkin> <1349874250.6874.6.camel@klapprechner>
	 <20121010213203.GC4517@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="=-+OvvZhU2Xx1UQhUmM+mJ"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45259 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752985Ab2JNMtS (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 14 Oct 2012 08:49:18 -0400
In-Reply-To: <20121010213203.GC4517@elie.Belkin>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org, Sebastian Heinlein <devel@glatzor.de>, Tyler Hicks <tyhicks@canonical.com>, Colin King <colin.king@canonical.com>, ecryptfs@vger.kernel.org


--=-+OvvZhU2Xx1UQhUmM+mJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-10-10 at 14:32 -0700, Jonathan Nieder wrote:
> Hi Ben and Greg,
>=20
> Please consider
>=20
>   8bc2d3cf6129 eCryptfs: Unlink lower inode when ecryptfs_create() fails
>   e3ccaa976120 eCryptfs: Initialize empty lower files when opening them
>   821f7494a776 eCryptfs: Revert to a writethrough cache model
>   7149f2558d5b eCryptfs: Write out all dirty pages just before releasing =
the
>                lower file
>   64e6651dcc10 eCryptfs: Call lower ->flush() from ecryptfs_flush()
>=20
> for application to the 3.0.y, 3.2.y, and 3.4.y trees.  (These fixes were
> all applied to mainline during the 3.6 cycle.)
>=20
> The patches apply cleanly to 3.2.y.  The backport to 3.0.y would take mor=
e
> work since it lacks, for example, b59db43ad443 (eCryptfs: Prevent file
> create race condition, 2011-11-21).
>=20
> Patches 1-4 improve error handling and recovery.  The fifth ensures
> flushes get propagated to the underlying filesystem, which would be
> important to avoid data loss from power loss or crashes.
[...]

They all sound worthwhile, and I understand they have already had some
testing on Ubuntu's 3.2-based branch.  Therefore, added to the queue.

Ben.

--=20
Ben Hutchings
Always try to do things in chronological order;
it's less confusing that way.

--=-+OvvZhU2Xx1UQhUmM+mJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUHoXaOe/yOyVhhEJAQoULw//RREYPHTkU4W0d2G9tVr77OgX8pGn8mDw
c0pbpvGTup3V09gtOBQibDQdoVb1EGMbHcsHogaJtFtzL1KS5w2aC4xWQqwve4eI
uWFpPr3sTkQJV8+Z4W3z8tLNH6hfAl9lUyoFsXZPsHtIKTgXbaNjq2Bf9yjx3Am2
/y2IIkSAiNzlhpwZDMLMextkN5CwLtL7kClkIN2ki4CBXG5GOhjpJeOAigjSaxMW
C6xU13tCNpGowCClVBmt9tc6qbBhc/q/U+SK5+l7HUqHk+6KSV50XhtzrxSbPwa0
ZIoO4/1Tgpns7yDQQxAxEzd89fKzBwB1qat485vaVCa99EOeKa/7rlv05JqWVlk2
8EDUqEGO5vNAAFYn4aB5UxuYMxgVv4D8Hp//rtxklRBxcgsVbLRp0D7gaFgqWtIm
mf8QvS5tPlDRq9uhwNdI7c0fUS4obtEM4kycXHg9VgJ9B9Q7rx5759j4qXKcbyf9
85q8qCgmwfATra0MzUHLKjhv9/lkrs7DdCalvnmmcPcBTQnedeHX+EDkVpUrVX/T
yVcNfL4CoEJMs7a4bDlG5P20Z9NFyZYa0yPKbQ4/IxTYgQm6SkefgadPIxzel7rE
0R4XeCWvqDvEYNZ45Y5OdyRDjhtRk5ugdYC2E/Alji+iMj662J+Bgk84ku0U/Mdg
d8xxPfbbWC4=
=ejYK
-----END PGP SIGNATURE-----

--=-+OvvZhU2Xx1UQhUmM+mJ--
