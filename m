From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can anyone confirm or deny if ecryptfs will work with a
 glusterfs backend?
Date: Wed, 26 Feb 2014 12:00:45 -0600
Message-ID: <20140226180044.GA5056@boyd>
References: <loom.20140226T165932-775@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52625 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaBZSAu (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Feb 2014 13:00:50 -0500
Content-Disposition: inline
In-Reply-To: <loom.20140226T165932-775@post.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Lance Reed <reed.r.lance@gmail.com>
Cc: ecryptfs@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lance!

On 2014-02-26 16:06:20, Lance Reed wrote:
> I am attempting to setup encrypted user home directories via eCryptfs usi=
ng
> gluster as a backend.
>=20
> Very simple setup currently has a small two node gluster cluster mounted =
by
> a separate client.  Normal gluster client and NFS mount / file options are
> working fine.
>=20
>=20
> e.g. https://wiki.archlinux.org/index.php/ECryptfs#Encrypting_a_home_dire=
ctory
>=20
> In my attempts lay ecryptfs on top of the mounted native gluster setup, I=
 am
> unable to edit a file, write etc.  I either get zero length or fixed size=
s.
>=20
> Only log messages I get are:
> "Either the lower file is not in a valid eCryptfs format, or the key could
> not be retrieved. Plaintext passthrough mode is not enabled; returning -E=
IO"
>=20
> I am posting in this forum to see if anyone knows of any reason why this =
may
> be failing from the ecryptfs side and I should stop banging my head again=
st
> the wall...
>=20
> I am trying Centos / RHEL.
> See these bugs:
> Bug 762976 - (GLUSTER-1244) ecryptfs does not work when the directory to =
be
> encrypted is on gluster mount
> https://bugzilla.redhat.com/show_bug.cgi?id=3D762976
>=20
> A non-empty file created on glusterfs with ecryptfs reports as a file of
> size zero
> https://bugzilla.redhat.com/show_bug.cgi?id=3D989702#c1
>=20
> These look to be issues with O_DIRECT usage in fuse but are suppose to be
> fixed now.
>=20
> I was hoping someone might have an idea or remember some of this to help =
me
> figure out if using glusterfs for a backend with  eCryptfs is even an opt=
ion.

eCryptfs mounted on top of glusterfs is something that I've never tried
and I don't recall anyone talking with upstream eCryptfs about it,
either. It wouldn't surprise me if it doesn't work. :/

I haven't paid much attention to glusterfs, but I thought the answer to
encryption with glusterfs was hekafs?

While briefly refreshing my memory on hekafs, it sounds like it is
geared towards cloud storage providers. Maybe it is too complex for your
needs?

>=20
> Is it possible that this bug is still the core problem?
> "ecryptfs does not work properly over nfs, cifs, samba, WebDAV, or aufs"
> https://bugs.launchpad.net/ecryptfs/+bug/277578
> It is old but still seems to be open..

That bug is a mess. It needs to be reevaluated and split up into
separate bug reports for individual lower filesystems. There is no
single fix for that bug and it will never be closed in its current
state.

>=20
> versions of the code I am using:
> glusterfs-cli-3.4.2-1.el6.x86_64
> glusterfs-libs-3.4.2-1.el6.x86_64
> glusterfs-fuse-3.4.2-1.el6.x86_64
> glusterfs-server-3.4.2-1.el6.x86_64
> ecryptfs-utils-82-6.el6_1.3.x86_64
> glusterfs-3.4.2-1.el6.x86_64

Kernel version?

Tyler

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDivMAAoJENaSAD2qAscKoM8P/2oiErTAlNYtVZUXWr+L0gAh
WaDLG/KtoRuWfWYMuWV+8+iQ4z5iVnRBfYU0F+kWG+P1k/P6kWPnPjaZkjelQRlp
tiCb7h4nQxcvDxC+4c7cr4GIZtHwiTRKsdReSr6unHq8EB7fK785TSpgA9cOTYSl
yq5+w77DMC6jAJ7RRXg5imXuRxtcqoIbqY5ELWWneJQGqiBtgvFDxjavzM2/BvY7
xW1b5ApH7LILU5Cqzm3Ef1T79cf4h2A/Ttpm9u1lL8lFnkEJc13Y4OnpkV7tsk3R
wLMvTlyp5/2yHHs5AySqfAGn8Z2KVJCC8jr0O7w5PumHTe5tXThG24Q/1/nArtE1
QFj2pTLHGmzVKp9kngtQYVe4zq7b4jBS8Q8l2jTJrqtaJbDxgflM1Vk9Mxrw4NV+
nbEhnMOqziVhxFvz+FS7UwBHi+cx2wCyBpsR3BJ032SxkgHgTka1s0gdFG479Flk
HZJ1MWk0e1IvZgz5aI1zgqg5BBJUfC5FRrtN/LYvxuzPh0ck2a9oe5QodQF5QPHE
/vLNPJ9cx8E/prDzYPmmeLa1e+5f72mnMxyH7Ldx3RIU2Db1S/stGeHnp6PyxCuv
kQhii9jf4b+rN5P5pyw3g0obdIDYkDHckmNvKfHzGrdnmaRpBzmOBngYNl3rG6Vb
t58N5qdvKSoB/kVSf7Yn
=k0dd
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
