From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Practical questions about locking and re-encrypting
Date: Mon, 22 Sep 2014 10:58:25 -0500
Message-ID: <20140922155824.GA17376@boyd>
References: <20140922173257.Horde.aPhFRVyqiOZUIEEpuKgAfuA@webmail.ugent.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36375 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbaIVP6a (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 22 Sep 2014 11:58:30 -0400
Content-Disposition: inline
In-Reply-To: <20140922173257.Horde.aPhFRVyqiOZUIEEpuKgAfuA@webmail.ugent.be>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
Cc: ecryptfs@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-09-22 17:32:57, Kenneth Waegeman wrote:
> Hi all,

Hi Kenneth

>=20
>=20
> We want to use ecryptfs on GPFS. How does ecryptfs handles locking if an
> encrypted directory is mounted on different boxes ? Is data corruption
> possible while writing?

eCryptfs is not well suited for being stacked on top of a distributed
file system such as GPFS.

That would result in each node having its own eCryptfs mount. Each
eCryptfs mount has its own page cache. eCryptfs doesn't do any sort of
coordination between remote mounts and there's no way for the lower
filesystem to make eCryptfs aware that file contents, which may be in
the eCryptfs page cache, have been modified by a remote node.

That means that if a file is read into the eCryptfs page cache on node A
and then that file is updated on node B, node A will never know an
update has been made and will never invalidate the old, cached file
contents from its page cache.

>=20
> Another question: Is there an easy way to re-encrypt a directory with
> another key? (when having compromised key or so).

Unfortunately, no. You'd need to set up a new eCryptfs mount, with a new
key, and copy the files between the two eCryptfs mounts.

Tyler

>=20
>=20
> Thank you!!
>=20
> Kenneth
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUIEcgAAoJENaSAD2qAscK5DAQAKje8c4+htBt13LLdnFsFvg+
ZDFYSZNUsOfpRTrkODAj+Ltm5cuObXsOXAg6MBEwnYqxqJqgkvb+Dd1mS4rdfpjs
wW5Kdl4DDFKZ1YVhaoZLfQzdfuoTGAKHiA5NU12SzTY0nulE3Uf4hWVAbO039K85
scowR82okEVP5zE6pRow91iXyH6H8/fKjoeUgbi2LIzIwc2a+DpSvvDH3B8WuesS
7xCBPh7yHOOeo/H8qztLntwOE1cy4p9uzyKaEPwAYGvQfSX4eZ/3IkUJHz0u3+S+
DbyeflADc624h8mLlbLsmSFgG+e7wghxW8YcZ8AREGjGHEOQ5/gjnvvyvHVETmtM
YSpJ4yqyI2bxoKCTMXJ05mxe1bg/+Y9PDNJV0UrK6Ou52KmlcgydOeKvXkKQuam0
DwEm6o3ULLkm/UaQ4XRgg89XrT1hVC6GOQ5r0R762XAyVp/cUDzXjxXiauAvwLh7
EkzkEzN2VKlg146j68/XPWGiHv8stJkBc4K75kPbUb3h6AuvKczWOCSrizzwDeqz
EqZ+VctG/fipoI5VMovqRMOk89xaw7dPO/zQpMnu+/X1Nt7dkIl7vd4fBdyLH32Q
lj4Iqy1VALdSuNRZbzlB+GeFka0b7nWDPEHoHxIz8A62FO5nnqvuzFYDi1ejWHYt
B1mKEXmbb2sPbSZ9WvSB
=4Z7J
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
