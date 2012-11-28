From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Regd: Prefetching and Buffering in eCryptfs
Date: Tue, 27 Nov 2012 18:44:25 -0800
Message-ID: <20121128024424.GA17780@boyd>
References: <CAAQA4tWoyrM09FQkTRBBh8tQMiRng+Dp=2Q2TXTZn7z99vMARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56028 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2K1Coa (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 27 Nov 2012 21:44:30 -0500
Content-Disposition: inline
In-Reply-To: <CAAQA4tWoyrM09FQkTRBBh8tQMiRng+Dp=2Q2TXTZn7z99vMARA@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Rahul Agrawal <mailrhl@gmail.com>
Cc: ecryptfs <ecryptfs@vger.kernel.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-11-27 21:03:28, Rahul Agrawal wrote:
> Hello all,
>=20
> I have been running some tests for using eCryptfs with MySQL and have
> posted a query on Stackexchange regarding the results that I got.
>=20
> http://superuser.com/questions/511275/does-ecryptfs-prefetch-and-or-buffe=
r-data
>=20
> If someone knows about this and could answer the question, I'd really
> appreciate it.

Your test results don't make sense to me at first glance.

In the majority of kernel versions, eCryptfs uses write-through caching.
There were a few kernel releases where a write-back cache was
implemented, but it caused some problems and that patch was reverted.

For the SUM query that you're doing, I'd expect it to be all reads, so
write-back or write-through shouldn't matter much. There would be a
layer of caching of the encrypted pages in the lower filesystem and then
another cached layer of the decrypted pages at the eCryptfs level, so it
is certainly different than when you are just using plain ext4.

You talked about clearing the MySQL buffers and the eCryptfs page cache
(by unmounting and remounting eCryptfs) between tests. There is still
the lower filesystem page cache which isn't being cleared. Maybe that
has something to do with it, but I doubt that is the full story here.

Are you using innodb_flush_method=3DO_DIRECT? eCryptfs doesn't implement
direct I/O, so I'm not sure how MySQL would handle that on top of
eCryptfs vs. ext4, which does do direct I/O.

This is something that I'd have to dig into more to make any sense of
it. What you're seeing is definitely odd.

Tyler

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQtXqIAAoJENaSAD2qAscKUkUP/iKfWpM/aq7qhcXzsY+Q+BuG
MxZIwMMUAG1AJ83isKDilZnkKP1VOaFB6BUkaTI0/j7GdmOF8BjWKcKtLV7lZ7ko
m1F5fHVRFwpGNui5k+NjAOgoirGB8HDhAV95gN/krOq1bbKMYYIHB/a6ls+6UYbU
fOWUPEtCjOMPvjYKRJHX36wuvQHG+gwvDIKAB2hocxPEexyMU9/WTZ7McNw0jSbP
GVb+RtVS3WtOVYqT8HVkcTi9dKpdn/4DEUCSY4BI+vUu0/HVWh2ABe6wdJVACzpQ
aGokmrKvuwb2q14cb+JGttEfjkrsxfON/S1iN6zI3b8b7fWc1EtAISR0w/M0ZGRz
+p2Ro/kGR9n66GiWinWFgLKUIRjvR+BOt3iP/AmyjzOMkwMLdMgXGNsr6uBt/kmF
G/ki5WM5pehtecQDTtkdETzHGyj7wVQRIuobilUVWFXasf832z99SIqkzqS5j0EC
s1YrtUTizpxnYXKnLXVHCDE51S3FbWRNkaIIAENhVsyNHJOjGiEBzRXvC2b3ze9g
T0TDie8843mpmvAzBIZgjCgQSb8ouOnj1uW/9OD+/sj7Y1Z64jPO9nckaxGRTtMH
rTemLefAmw9xTeIFYuXKWZ6F8XS4A3uBg6a5NGJ9u47TDeYCdwcg+DQoOo/NsNE6
G9op1HvT/Cn7G/Pt2lnq
=ow27
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
