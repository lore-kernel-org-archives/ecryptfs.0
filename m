From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Wrapper to mount Private directories without root
Date: Tue, 15 Jan 2013 11:18:20 -0800
Message-ID: <20130115191820.GA5302@boyd>
References: <loom.20121212T175359-906@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59173 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab3AOTSZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 15 Jan 2013 14:18:25 -0500
Content-Disposition: inline
In-Reply-To: <loom.20121212T175359-906@post.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: David Obadia <dav-ecryptfs@odav.org>
Cc: ecryptfs@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-12-12 16:58:41, David Obadia wrote:
> Not sure why ecryptfs-recover-private requires root, I've found a way to =
do the
> same thing without root.

A quick glance at that script shows that it needs root to do the
`mount -t ecryptfs ...` command. The main eCryptfs mount helper
(/sbin/mount.ecryptfs) is big and complex. It hasn't been security
audited and setting the setuid bit on it (which would give non-root
users sufficient privilege to perform generic eCryptfs mounts) is a bad
idea because there are likely security bugs in that program.

>=20
> Also I think it would be helpful to have a user friendly API for
> creating/mounting/unmounting ecrypted folders that doesn't require root u=
sing
> the setuid in mount.ecryptfs_private.

That might be a nice thing to have, but we want mount.ecryptfs_private
to stay as simple as possible so that it can be audited and so that we
don't introduce new security flaws into the code. It is intentionally
locked down to do very specific actions.

Tyler

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQ9at7AAoJENaSAD2qAscK4KQQAJwkoj2MvIiBy/RCr/DM1/ms
NNZrbUOe6elaS33ObOSgY6yN0G1jD3oAnTIdrnd+rJaS0PdZfHVI9ml3TTnorneE
qcpCL1YufkXwGJVHm/fojBEzF6djeTRUpN83S9HtRcUSD3dSeEBz73G3ZNxKvkAo
rgTubyIlN3wI6b2JxgMteZ/D8bSvl6rp1G7L+WDi5hSseiS8HxxO0FUzQ1ZkKaHZ
lvwFAxif4LR4mBqKCjytlWhDkpKs6AudYcYnX2p0iUvT5X0HsPxmqWYMpwHbUSEP
gnkDAG4MGz6YgXY1wglT8RDycHISHMrfLB0ipPeKDzyheSgdyeC8dzsm2n9kfQUw
44PIUD+4Mb1NdafR2YZeBhfGLWYUOEh7wA8ngpJcZNUzAvFTsYiSdIQbE7zw6Ulp
LjNZzDfoz2jo7Hme6QK/zBHJokA1JC2VwNKlggCdwXIHMXcklRKhTL1OZwmfQHbA
rosxlHGEtNkJLwX8XaVojqQZ3MHYblAZ6fQuFd+boiHB/ZKKFL+4tjiXyv3LREEw
Y9BKZLmYiY9fbVGauL1uaW+nYzWjWIh/wy1dBmKJAaNMS6UnW5XuQ5h9wJ7L5OUw
EroZcuAQMr3C6rhEGwzEwp6LdgosdS2Ymnk307/ktA1RUaEw8fZV7+myw4ahsqRb
0/GXXQXa/P6OvvuRG1UT
=/o31
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
