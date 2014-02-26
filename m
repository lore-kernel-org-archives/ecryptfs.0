From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Can anyone confirm or deny if ecryptfs will work with a
 glusterfs backend?
Date: Wed, 26 Feb 2014 13:56:51 -0600
Message-ID: <20140226195650.GB5056@boyd>
References: <loom.20140226T165932-775@post.gmane.org>
 <20140226180044.GA5056@boyd>
 <loom.20140226T193240-335@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53161 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbaBZT4z (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Feb 2014 14:56:55 -0500
Content-Disposition: inline
In-Reply-To: <loom.20140226T193240-335@post.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Lance Reed <reed.r.lance@gmail.com>
Cc: ecryptfs@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-02-26 18:35:09, Lance Reed wrote:
> Tyler,
>=20
> Thanks for the response!
> Red Hat Enterprise Linux Server release 6.4 (Santiago) (and Centos 6.4)
> 2.6.32-358.14.1.el6.x86_64

While I've not made any recent changes that I would expect to improve
glusterfs support, that is a somewhat old kernel and a newer version
may, obviously, have different results.

However, I should say that even if eCryptfs suddenly works on top of
glusterfs in a newer kernel, there's still a fundamental problem with
eCryptfs stacked on top of any type of remote filesystem. eCryptfs does
not expect the lower/backend filesystem to be modified by another
machine. So you could have cache coherency problems if two or more
clients are reading a file and then one of them updates the file.

Fixing the cache coherency issues would be step 2, after eCryptfs
actually starts working on top of popular remote filesystems (nfs, cifs,
glusterfs, etc.). Unfortunately, I'm not aware of anyone working on step
1 at the moment.

Tyler

>=20
> I am actually planning to use this in a cloud setup.  Mostly for an inter=
nal
> shared NFS like but HA space.
> I had thought HekaFS had gone a bit dormant...(not a lot of talk since May
> 2013...)
> I will look at it again.  Thanks for the tip and taking a look.
> Any thought would be greatly appreciated.
>=20
> Cheers,
>=20
> Lance
>=20
>=20
> If this is a double post, I apologize.. oddness on email vs web interface:
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDkcCAAoJENaSAD2qAscKzo4QAJEeXj2CBRTUXC2a7apYvRHE
quqxDWZjpf8MOIs8WHtJZMkNXGtqcicbjQ3heyg+TkK6R0SnsN9fe+C+2JtNdvzf
jaHn7Riv4q6E7j+i8iCgR+9IcivekPxhQXK/GPzQp2QpRx6qgJyJACe37jsNh6Xa
BrkA3uIktbtZTbWalwbiAUtC3HnQetO2dTOP5G8VNTbcJbi6sYMkImZndwSkZ1sQ
s607aFCyqTjTgU5ALuulFzkLFVlKhnSol/JkzPUwclLTkEPszKRSsKlHi/Lx+9UR
Wff+uX2/e4nBOk3EsqmL+lmOLyVzkgwNZRkJrArBfY6XOqnOoGgnveVYHF3D2riQ
rWHjCnVc2IhgzK9Wnd0LURYmfGa1DIXggV2a2Sm+TFKQ3uqiKQ19KQVUfc0rkr1M
zsRb/t5j86wwWpVravm1AHUhriPDSnZ/Z4l3rYbr+AUhXg1LqcHamMX5v4YqMKZX
zAlfF8trp/wxbNL1qoBMOwu5wDgsyORMG8rCL60frgyKKFTeZnfq1VWgGsH2mOeH
gGFxjhiq2Wp1arEBV5uzBTt2dhUHcVZVvPT88iPr/yw+hDFv0xEwy6Na+uKVnQci
YJ7yBKcukh4b8Sw2KumKyvWATpefjfcn0Rgl9ZbLdjyQxs2Ieaq/0KbLO0/wk5h0
hY/i7V4N/DPVrlduF6t6
=FbF3
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
