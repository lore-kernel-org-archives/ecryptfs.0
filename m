From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Storing the executable bit along with the rest of cryptographic
 metadata
Date: Thu, 31 Jan 2013 09:29:08 -0800
Message-ID: <20130131172907.GA3422@boyd>
References: <CAAq2XdoN6E0xGyn-cVBTvVjmXZ7i2bpfDrdhC9FjB60_DPerWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53168 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab3AaR3N (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 31 Jan 2013 12:29:13 -0500
Content-Disposition: inline
In-Reply-To: <CAAq2XdoN6E0xGyn-cVBTvVjmXZ7i2bpfDrdhC9FjB60_DPerWw@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Thiago Padilha <tpadilha84@gmail.com>
Cc: ecryptfs@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-01-31 09:58:01, Thiago Padilha wrote:
> I'm trying to use a directory in a NTFS external drive as the lower
> mount for ecryptfs, but since ntfs doesn't understand the concept of
> executable files, every file is treated as executable by ntfs-3g
>=20
> Is there a mount option to override the lower encrypted file
> permissions by permissions stored elsewhere(perhaps in the encrypted
> file header) ?

No, sorry. That's not something that eCryptfs will ever do.

Tyler

> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJRCqnjAAoJENaSAD2qAscKoB0P/jHaHYaadnVKURlUFWD3JOO3
lu5PFQFAjdNgXF1UVLyei9wt7sD5cylnjBAnKLeC/4x7Ni7fXxkAE1ibSfyO/xer
86fKAaymzFP8FuD4jpdpH8S3a4NHanW9j5HcG+Ejm78s2n4SMAp5QsZJUtCJQQXf
8an1d/tHQi/6aRJL2//O/7mJBQY7ixjCz2/H4oZlnED/HzKsQM742di8rS+xpRJq
DIUZNqSp9BS8HNpqNyJmxMPTrcejBB6HazmgpHsNfnNm9J8Jq1jwnWqLurQN4C4Q
gcL3r5DASrDfpTBQEFcy9v0aZRKxJ8kmalBtD4EW3X7Y0gQ7LfRJSQPJ0P6C6WI2
KKbw4BQcqnVpbo3zmAWg6SEVdfAtnTHzZOw9W5CDtDPnnqJI1NFq3SuU/f83mKgW
85Ucitpx8Tf1W7wFwXpyvCkEIagfkQTjjyWGNUDC4iiBFx13aMF+02d7Sfh4TD4l
vs5ziSSVO3lDEwVl6sQFswyGcYohPTJvgMAie99dcz5XIWsaKJOrmFUh7Uet9pwG
SWCdFgGkX0aWgF4Uqd/XV9DUGWrC0QHY6LWpP5oFoPkU82W1H1k/OK6aVdQjGdvy
8yxggwe5fRQ4VsIiVCGcWqBS80WOywweSdZ4hnLQuD+94/toc7qGBKOD4LouGop6
HFTD+IIjZLhjKjTyq8xH
=9bj7
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
