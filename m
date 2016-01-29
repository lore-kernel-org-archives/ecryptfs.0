From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Key derivation and passprhase wrapping
Date: Fri, 29 Jan 2016 16:57:11 -0600
Message-ID: <20160129225710.GD15683@boyd>
References: <794484591.224591.1452104561446.JavaMail.zimbra@halfgaar.net>
 <676716416.231851.1453112857325.JavaMail.zimbra@halfgaar.net>
 <20160120030556.GC5623@boyd>
 <1032370780.234696.1453319503133.JavaMail.zimbra@halfgaar.net>
 <497366096.234710.1453320193682.JavaMail.zimbra@halfgaar.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40046 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcA2W5P (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 29 Jan 2016 17:57:15 -0500
Content-Disposition: inline
In-Reply-To: <497366096.234710.1453320193682.JavaMail.zimbra@halfgaar.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Wiebe Cazemier <wiebe@halfgaar.net>
Cc: ecryptfs@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2016-01-20 21:03:13, Wiebe Cazemier wrote:
> ----- Original Message -----
> > From: "Wiebe Cazemier" <wiebe@halfgaar.net>
> > To: "Tyler Hicks" <tyhicks@canonical.com>
> > Cc: ecryptfs@vger.kernel.org
> > Sent: Wednesday, 20 January, 2016 8:51:43 PM
> > Subject: Re: Key derivation and passprhase wrapping
> >=20
> > I think I missed an important bit. I was looking at ecryptfs-wrap-passp=
hrase,
> > which makes you supply the FEK and FEKEK, but ecryptfs-setup-private
> > actually already uses a random passphrase:
> >=20
> > -m, --mountpass MOUNTPASS
> >     Passphrase for mounting the ecryptfs directory, default is 16 bytes=
 from
> >     /dev/urandom if omitted
> >=20
>=20
> I do see an issue though. The bash script says:
>=20
>   random_data=3D`head -c 16000 /dev/urandom | od -x` || error_testing "$t=
emp" "$(gettext 'Could not generate random data')"
>=20
> But when urandom can't be read (doesn't exist, no file handles, whatever):
>=20
>   random_data=3D`head -c 16000 /dev/urando | od -x` || echo "fail"
>   head: cannot open =E2=80=98/dev/urando=E2=80=99 for reading: No such fi=
le or directory
>=20
> Note, no 'fail' and $? =3D=3D 0. And:
>=20
>   echo $random_data
>   0000000

For completeness, we should mention that this is being tracked in
Launchpad:

 https://launchpad.net/bugs/1539553

Tyler

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWq+5GAAoJENaSAD2qAscKZMQP/R+kkGai/L9n+QDqozUHWwzj
+sEZiFmMq6r8mIsMcBK6ox+nVeDWWqQVxQegBAmYE/LeX8bPAnxueRlkZANW8Cnc
S9tUoVf/dzTouz48jhwsjrO+kxxWZkjgNjh+sU9DTZZwoBEZcbUJaSRDL4q3ehii
EfLogUtTpem+a0GD0lt48IjZEFs0hhIhezb1D4TSb7Z4wQzmOZJne2hpI3ecTOLz
0VjMdoKeEJxUxz9a+Lel3bOqIWRueBCAi0ikn5o4mVw8Y/TsVDIzOh4ieURm5AGq
6R4izSWnJ6hewEK58vf4YzjsA5vhNGU9SW4Ubz0MVKHoEQ83Hdi/dIl2kg0PNFYe
rpB+Z68Q20yI2f9ZFDnh89KVMhjJuAYI6Csn7lptM/XBwtcsQAzAYgmsno7ADm7M
L9p4d9g7qPzaoMy83TPlx9i8qVXf/Vc4poaynROsjjLf9i3nAjvvBFVCF3Cwu/w+
xT/lZh3jZJL73rjiPa9gSbmscSzFcmS4FxMZkU+PEit3TiRghBU2OuZQ0uyPbT1w
8yACc9QLve/RtnfmVsgn5ChZeU4poVjZK6WhzgcHdQL+866u6gCE46OfH+dBG9j8
HSzYTwqT+7FGRdhVLvFk6oSHbeVK4RvHNpQHyQkYnRA4o9eBfc770p7y6IE8mDCA
AxjXFbonK32rsMTvf9oh
=NSXS
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
