From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 28/39] ecryptfs: drop null test before destroy functions
Date: Tue, 15 Sep 2015 09:45:35 -0500
Message-ID: <20150915144535.GB3665@boyd>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
 <1442146532-9100-29-git-send-email-Julia.Lawall@lip6.fr>
 <20150915020830.GC32505@boyd>
 <alpine.DEB.2.02.1509150636260.2048@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1509150636260.2048@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-09-15 06:36:30, Julia Lawall wrote:
>=20
>=20
> On Mon, 14 Sep 2015, Tyler Hicks wrote:
>=20
> > On 2015-09-13 14:15:21, Julia Lawall wrote:
> > > Remove unneeded NULL test.
> > >=20
> > > The semantic patch that makes this change is as follows:
> > > (http://coccinelle.lip6.fr/)
> > >=20
> > > // <smpl>
> > > @@ expression x; @@
> > > -if (x !=3D NULL)
> > >   \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
> > > // </smpl>
> > >=20
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >=20
> > Acked-by: Tyler Hicks <tyhicks@canonical.com>
> >=20
> > I assume that you'll be landing this patch set into Linus' tree all
> > together. Let me know if that's incorrect and I should take this single
> > patch into the eCryptfs dev tree.
>=20
> I'm not doing anythign after this point.  Some others have taken the patch
> into their trees.

I've taken it into my tree. Thanks again.

Tyler

>=20
> julia
>=20
> >=20
> > Thanks!
> >=20
> > Tyler
> >=20
> > >=20
> > > ---
> > >  fs/ecryptfs/main.c |    3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> > > index 4f4d047..e83f31c 100644
> > > --- a/fs/ecryptfs/main.c
> > > +++ b/fs/ecryptfs/main.c
> > > @@ -737,8 +737,7 @@ static void ecryptfs_free_kmem_caches(void)
> > >  		struct ecryptfs_cache_info *info;
> > > =20
> > >  		info =3D &ecryptfs_cache_infos[i];
> > > -		if (*(info->cache))
> > > -			kmem_cache_destroy(*(info->cache));
> > > +		kmem_cache_destroy(*(info->cache));
> > >  	}
> > >  }
> > > =20
> > >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV+C8PAAoJENaSAD2qAscKTyIQAMNybJN5/hx9dkc0igcyDjWH
7F+MOyl7s3TEEpfkSKmvM9OaoalyUEyIBAix43+JdBg5f8Fih2UxpeC+p2JHH4VE
xObMSfnU8aj4z+/D6rZJI04jBN9fL086LWV17MxX4wJoPaixQ95/KOa/i29DrsHb
VWhlxJI3hU8rLnfpddaPLe22u9r+ob7Q9kPsJg5Dm5OEz0VoH3AD1E0HepUfgj/k
ALB7lWv7AVkiD8sr4avEwV/QpbERbfJPkeiNHt++SYU7K/347YJnLURlYdmJMGye
JkOWzbU3B9U629Umk33z6S/F+v29J5onyFQSpWeXYRIw7OuxtIijHbukPFPTwzyT
pXe9ua4ZW2I9E4jwHgHorbl/21NkHRLHejSZWHik3FbbyVwoCJ9i2cT38njmViUo
V7ul/6ST8uJC61r0wsGEQnmYxj5fIKqHZ79ds6mJLH5e+4ULaUjT6/QFrJagn8Zr
8ZDfRl9iOPVAHtcJ0fWLIBvaWn0ycicesTdZQZ7sRxWbIVd8AVzUeiFdL3P+9gAZ
pfc14tR9OrXD8JNrjCq+D1vJNd2D5Gf/1CTQMrvx1Gu+JsWyO8LV0bkoFt27Au1v
GGe86ylyEXL5+MATRhS+tHZLfGe+RvaOx0lUraiTjnSBqOY6qdKOVb+1HKLZdV5c
CYBwgIEMN0WUT3wunULZ
=Em/2
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
