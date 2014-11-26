From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Allocate sufficient buffer space for encrypted
 filename decoding
Date: Wed, 26 Nov 2014 11:23:44 -0600
Message-ID: <20141126172342.GB31285@boyd>
References: <1416589323-4762-1-git-send-email-mhalcrow@google.com>
 <CA+POJK1miq_sJ-7D80cbabtwTi2ftRTdBcrZDP1sacEK9f36GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39190 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaKZRXs (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Nov 2014 12:23:48 -0500
Content-Disposition: inline
In-Reply-To: <CA+POJK1miq_sJ-7D80cbabtwTi2ftRTdBcrZDP1sacEK9f36GA@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Michael Halcrow <mhalcrow@google.com>
Cc: Dmitry Chernenkov <dmitryc@google.com>, ecryptfs@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2014-11-26 09:11:32, Michael Halcrow wrote:
> On Fri, Nov 21, 2014 at 9:02 AM, Michael Halcrow <mhalcrow@google.com> wr=
ote:
> > Dmitry Chernenkov used KASAN to discover that eCryptfs writes past the
> > end of the allocated buffer during encrypted filename decoding. This
> > fix corrects the issue by ensuring that there is sufficient buffer
> > space allocated.
> >
> > Signed-off-by: Michael Halcrow <mhalcrow@google.com>
> > ---
> >  fs/ecryptfs/crypto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> > index 2f6735d..53d4f2e 100644
> > --- a/fs/ecryptfs/crypto.c
> > +++ b/fs/ecryptfs/crypto.c
> > @@ -1871,7 +1871,7 @@ static size_t ecryptfs_max_decoded_size(size_t en=
coded_size)
> >          * the caller with the maximum amount of allocated
> >          * space that @dst will need to point to in a
> >          * subsequent call. */
> > -       return ((encoded_size + 1) * 3) / 4;
> > +       return (((encoded_size + 1) * 3) / 4) + 1;
>=20
> Kees pointed out that the last write of 0 isn't even necessary.
>=20
> Ignore this patch. I've sent out a fix that removes that write.

Agreed. I had been looking into this today and was about to say the same
thing. Thanks!

Tyler

>=20
> >  }
> >
> >  /**
> > --
> > 2.1.0.rc2.206.gedb03e5
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUdgyeAAoJENaSAD2qAscKEmsP/2i1vOgKOglzUCrs9BPSVTQf
Onf9RdlmllLoI0rJCoPKBnbxp8ijXvWfhdPb0W1D5ZgLMUZeO75iB5QU5hev+PeO
+133xv2ewH+5XYbDqqcNqbMeic3Pefpnfq6lBNdbipc2IpTvBJcQ24KvdgFUpnS3
iKd4KU55Iq1zMHg1Eh0onQboOJ9E1YlnvHpMGnhluFEYoTC2CKgvN1wQvWwRJAnX
Bn5LYEVEmR8EWVU5rFcv+xOVHfXPSNgg8E7xEaj0NpxaJiNHhlhJN9oroK2OEpbP
fV9qqqK69yTPoS60qR681Jc1KGhGI20nkfWh9cicNFIl6fE134ZIGYi+Lh6EMhdm
5T+pg6fiWXk23GgaOv6wcoNr2BqMI5UGjYRLd9L+3lKM3aksf9PNANa0gIumMogN
Vr3d8LvYXteic3Uz4gt82Z4Vx+W2UEPwU9mAlVW8Jc/pbVk20swFjUXxSuULrzAs
7h0c+dg2l0ECkl/uO8TeyWvWpnkwuR5T1wSoKRGpoZywQHwSJdhlSAZudnpjbAak
2JZ9W4r/Zun4XVU8QuyQwCvpuMi4QwDrJIrDndNWG14gFuM6DNvLLrLfuNqjYEv5
963qLHRUQkWbrU/J4egP2ODEe0rwMaAYZ4FlYjgRNj6p/MtGFJyi4pEEBsZE5qdK
HlOeufUDEPwcLKtPPCbe
=5RT+
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
