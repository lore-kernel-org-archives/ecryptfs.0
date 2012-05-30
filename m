From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Active Directory Integration?
Date: Tue, 29 May 2012 17:01:19 -0700
Message-ID: <20120530000119.GA19846@boyd>
References: <20120529225104.GA4091@esri.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55016 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab2E3ABZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 29 May 2012 20:01:25 -0400
Content-Disposition: inline
In-Reply-To: <20120529225104.GA4091@esri.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Ray Van Dolson <rvandolson@esri.com>
Cc: ecryptfs@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-05-29 15:51:04, Ray Van Dolson wrote:
> Hello;
>=20
> I'm exploring using eCryptfs in tandem with Samba, winbindd and Active
> Directory to automount eCryptfs-encrypted directores automatically
> based on the AD user accessing it.
>=20
> Is anyone out there doing something similar or am I barking up the
> wrong tree here?

You're not barking up the wrong tree. I recall this idea popping up in a
few different designs over the years. Unfortunately, no one has
committed the development resources to make it work.

I'm making the assumptions that you're wanting to mount eCryptfs on top
of a SMB client, that the client is the in-kernel CIFS code, and that
you'll pull the key material for the eCryptfs mount from the directory
store. Let me know if any of those assumptions are invalid.


I haven't tested it recently, but eCryptfs is not known to work on top
of the in-kernel CIFS client code. It is worth a shot trying. Please
report any bugs you discover. It may have benefited from some of the
bugs I fixed (about a year ago) when trying to use eCryptfs on top of
the in-kernel NFS client.

Additionally, I don't know of an off-the-shelf way to fetch an eCryptfs
mount passphrase from AD and insert it into the kernel keyring in
preparation for doing the eCryptfs mount. It should just be a matter of
some glue code but no one, that I'm aware of, has done it.

> In addition, this conceptually makes sense to me from a 1:1 user to
> directory or share perspective, but when multiple users are allowed
> access to a file system it's not quite so clear how the implementation
> would look (or even if it would be doable).

eCryptfs lacks the ability to do even slightly complex decision making
about what key should be used when encrypting a new file. Currently, it
is done with just a list of key signatures specified at mount time.

eCryptfs does have some basic support for allowing multiple keys to be
used to access a given file. However, it would be difficult to do if
users are accessing the shares from different client machines because
each client would need to have all of the keys loaded into the kernel
keyring. That is obviously not ideal. :/

Tyler

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJPxWNPAAoJENaSAD2qAscK/6QQAJBgb1dPGPE39eB/t4RHcDRD
dkNB2+lRltJpooVPu21xSKyBu60IeC6CNFYXHhLlkTZEPUMhGH1WYx3kRJhvqS3S
FAbxK4SvYxtl8T47i6gIm2vBKS1sEoC7bYLQubTx3eoU8JkVRL23Dv49WymutC6G
uuIP4RDRXa0prWBHV8t0lyoUzZvNhdrDxKSbqQ+7cQEyH/Ib0cVMa9S6SzWgxw1C
qgIsXGs4PShRqYC4PxXcwGchJUYx8wLRKXbMC2pB7M9y/6JMrBKsmO+2qCMgeBRM
aQvUto4t+EQqHOTDx/OC5L+UfhtMDGyueL7e8PwtIGNjCLXP6r7G5/r9KwuZE8lP
fXIlxS8A9N3ZMKwYRPSSxHGV8MQ8GySMA0nPD2E5cbmMimFkm8dzFx0e8qfCLDpU
7udv6TVc8FbR/8GWlMQjQAe/X9njDBZwpC9Xf6jCadSZ1SNYn4IbnowOKWwFeua+
vRuDzUN17IWHcDhVVJzSRIdnvmWKkzo6aTbqSxp/0a3ZzB4To+x2QI2ixK3n3Qw1
318qxIzd7J7/Sgm99/jThZZGjjXjlFlA3oi0byZcs9iCg801GNHe5vh9nYbECz9z
Nhl7n/glw36Nua0NBo9bfcgGSvUNmUP1gcFLsrLQAnF1HLyLtbnnoYfjLTIBCo5N
pppbWnmxigKEo2UJIsD6
=zpdT
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
