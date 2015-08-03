From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Mon, 3 Aug 2015 18:07:54 -0500
Message-ID: <20150803230754.GB2342@boyd>
References: <1438338190-22518-1-git-send-email-richard@nod.at>
 <20150802010259.GA19522@boyd>
 <55BDCBF4.1050305@nod.at>
 <20150803052758.GA24915@boyd>
 <55BFB39D.5070702@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42623 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbHCXIA (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Aug 2015 19:08:00 -0400
Content-Disposition: inline
In-Reply-To: <55BFB39D.5070702@nod.at>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-08-03 20:31:57, Richard Weinberger wrote:
> Tyler,
>=20
> Am 03.08.2015 um 07:27 schrieb Tyler Hicks:
> >> So ecryptfs definitely supports mounting the same lower path multiple =
times?
> >> What is the benefit of that behavior?
> >=20
> > No, it doesn't support that in a way that provides consistency among all
> > of the eCryptfs mounts.
>=20
> Okay, then I'd argument to give my patch a try although it is not the sol=
ution
> to the problem I've reported. :-)
> If you don't mind I'll resend with a proper changelog.

That patch isn't correct since it assumes that all eCryptfs super blocks
are equal if the lower paths (and, ultimately, the lower inode) are
equal. However, the lower path is only one of many properties of an
eCryptfs superblock. For example, the second mount may have been
configured to use a different file encryption key.

Tyler

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVv/RKAAoJENaSAD2qAscKo/wP/2KbNiT3CFg7kXxZPYIrGO/Z
C5ZIpiQYnq7iXdfRw3wVbCUKHle0rlKyMaehBTDy9WI4IhicBaJ6le6DMORy3VXk
wrIG4mB83KYkCsPLr59Vc+BVSzmdyZZd361AILvOSQRyMVPWMv2FJemd2bDwZ7gp
hRfyEXhpoiQJxfqUAunz4oPvTyBX+RTNSkJVfX41NB3KTC19dnUcJtfgHpvAyWPc
tRD6kErPxNad4EoGsvD+y2iypSLmuiIaN35FpfqsUB/NkeVOBs/36UBdUDgoQnpb
eBgFhqcQUB3XcTolWEa4ubbsHtVsXwQ3Y1PiSHLwr8eKI+yYq42uDulNNauUkox9
DMlue7UFBn3afhfPh4gHZqSZI3dYWh3f/2Gnxa0ALxCS10MPDlLnSxWVUjEdK/FD
kFjeC11+H+VMlm1KyPwFE67vxdr2T3n6RbUYFVf1kb3tQDIlmco77nbOBhPtOHlw
7NS48uG7kYN9TMkezSfvHa7pa0M6h3dH5T18/ynJMXcVoTYZQPs6dNpmQj1KojIx
zRy6ZFVFllQh5tZOyZa9OZ2VLvJhUab2nU7y6wjZJyIOAeEuDh5n0h01f4eCkC7w
I1nguVXnmIBybZOzHbudVuZvkTojFMvd4fv7maQSDIKDQGDp6egHfGwES5hgekVC
1S1yDH3AUItb60ALKe6K
=TCGk
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
