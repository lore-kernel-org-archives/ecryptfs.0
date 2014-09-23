From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Practical questions about locking and re-encrypting
Date: Tue, 23 Sep 2014 10:53:20 -0500
Message-ID: <20140923155319.GB7673@boyd>
References: <20140922173257.Horde.aPhFRVyqiOZUIEEpuKgAfuA@webmail.ugent.be>
 <20140922155824.GA17376@boyd>
 <20140923113955.Horde.hGWGHtD6UQ5UIT-rZ-tGBFA@webmail.ugent.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43033 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbaIWPxX (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 23 Sep 2014 11:53:23 -0400
Content-Disposition: inline
In-Reply-To: <20140923113955.Horde.hGWGHtD6UQ5UIT-rZ-tGBFA@webmail.ugent.be>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
Cc: ecryptfs@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-09-23 11:39:55, Kenneth Waegeman wrote:
>=20
> ----- Message from Tyler Hicks <tyhicks@canonical.com> ---------
>    Date: Mon, 22 Sep 2014 10:58:25 -0500
>    From: Tyler Hicks <tyhicks@canonical.com>
> Subject: Re: Practical questions about locking and re-encrypting
>      To: Kenneth Waegeman <Kenneth.Waegeman@UGent.be>
>      Cc: ecryptfs@vger.kernel.org
>=20
>=20
> >On 2014-09-22 17:32:57, Kenneth Waegeman wrote:
> >>Hi all,
> >
> >Hi Kenneth
> >
> >>
> >>
> >>We want to use ecryptfs on GPFS. How does ecryptfs handles locking if an
> >>encrypted directory is mounted on different boxes ? Is data corruption
> >>possible while writing?
> >
> >eCryptfs is not well suited for being stacked on top of a distributed
> >file system such as GPFS.
> >
> >That would result in each node having its own eCryptfs mount. Each
> >eCryptfs mount has its own page cache. eCryptfs doesn't do any sort of
> >coordination between remote mounts and there's no way for the lower
> >filesystem to make eCryptfs aware that file contents, which may be in
> >the eCryptfs page cache, have been modified by a remote node.
> >
> >That means that if a file is read into the eCryptfs page cache on node A
> >and then that file is updated on node B, node A will never know an
> >update has been made and will never invalidate the old, cached file
> >contents from its page cache.
>=20
> When is the pagecache flushed?

The typical times (periodic background writeout, sync, unmount, etc.)
and when a file is closed.

> is sync honoured? or does that happen only on unmount?

Sync is honored.

> Does this also apply for directories?

Yes

> What happens if 2 hosts modifying different files in same directory?

If one host has pieces of a file cached and then another host modifies
those pieces, then the first host will have outdated cached contents. It
doesn't matter if the files are in the same directory or in different
directories.

Tyler

>=20
> Thank you for the explanation!
>=20
> Kenneth
>=20
> >
> >>
> >>Another question: Is there an easy way to re-encrypt a directory with
> >>another key? (when having compromised key or so).
> >
> >Unfortunately, no. You'd need to set up a new eCryptfs mount, with a new
> >key, and copy the files between the two eCryptfs mounts.
> >
> >Tyler
> >
> >>
> >>
> >>Thank you!!
> >>
> >>Kenneth
> >>
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> ----- End message from Tyler Hicks <tyhicks@canonical.com> -----
>=20
> --=20
>=20
> Met vriendelijke groeten,
> Kenneth Waegeman
>=20

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUIZdvAAoJENaSAD2qAscKqQcP/iny4hTpVgviG3fom7k1jlli
uKfZ5sxfBECIIEnV3LSAMFWJ/3gzKR568nxrJqdJW9Wqh5G7A5b2sKC/5R6e+5RI
LsJseiUTdUsYGKzPKpAB2KtRm0oOb2Q9VGw/sF63MtZ/eDW0gCkn0RHq6MvwW7Wd
YIX9jOtGl+gXeXeDw7imLmfv2plvnlXNLovgoQmpwX8SlkywOYMq5lrg08vBYLHn
kmXsebg7TelBF27cbIByj1jk0XmjLPVvkjKP7DkYhVHlvmktoHlaUqTHXCKDT4ZT
m8ze1EQOLoWK01VdmO0N0Lufp6jgOQHWJ+8KAn1j/CRhUMuYVXQE3doKmfSmM6TA
f6kbnPzqlQYKPmzrHCQXnFoyS9KyVa1ihBXHGvjmFLj2B7ARzTed4Wodz7CIani3
8EalIX63zBFWeYVTi8H8Pt0GHfscbICAVOncPPWzoS+kIq332HSXvlTQJ/GVcMEw
mijpvKWfRgDEC16R7JCpFgTViDDds/4lDV5UJOU7NBSOT79KbQ/7EpyU7SJryvpP
/uLn7/s3EbN5SwGa4XRqVMxGsu05qu9ex/Z9JAjUL6ZEWvZwDElXlRqDCtThY14K
3MYMbX8H668uNdvG2rxbuVBa+Rm2J5V/A+wC+6TnRpZSt9PfA6yB10miMuqmp5l6
gqpbNF3I0VAJ8IH5HIOX
=Oqau
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
