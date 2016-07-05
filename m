From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
Date: Tue, 5 Jul 2016 17:14:20 -0400
Message-ID: <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5BsOoalPXixA6Jpxg1HCph6wlnqlcHvF4"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35536 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374AbcGEV1v (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 5 Jul 2016 17:27:51 -0400
In-Reply-To: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5BsOoalPXixA6Jpxg1HCph6wlnqlcHvF4
Content-Type: multipart/mixed; boundary="saOI6bdrO1JGaHH2BotI29iLcWABulfLO"
From: Jeff Mahoney <jeffm@suse.com>
To: Tyler Hicks <tyhicks@canonical.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org
Message-ID: <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>

--saOI6bdrO1JGaHH2BotI29iLcWABulfLO
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 6/28/16 11:39 PM, Tyler Hicks wrote:
> Cherry-picking mainline commit 2f36db71009304b3f0b95afacd8eba1f9f046b87=

> introduces a regression in eCryptfs when mainline commit
> 6a480a7842545ec520a91730209ec0bae41694c1 (4.6+) is not present. The
> regression causes all attempts at opening directory files to fail with
> EMEDIUMTYPE when the lower filesystem's file_operations for directory
> files do not implement mmap.
>=20
> This is a simple fix that allows the check for the lower file's mmap
> implementation to be ignored if the lower file is a directory.

I have a different fix that I believe is more correct for this.  I would
have posted it in response to the original fix if it were ever actually
posted for public discussion.

Denying open is the wrong place to fix this.  It's too heavy a hammer
and, as we see here, a bit fragile.

The right fix is to deny the mmap call instead.

-Jeff

> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> Tested-by: Tyler Hicks <tyhicks@canonical.com> # 4.4.y, 3.18.y
> Cc: <stable@vger.kernel.org> # 4.5-
> ---
>  fs/ecryptfs/kthread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
> index e818f5a..b9faeab 100644
> --- a/fs/ecryptfs/kthread.c
> +++ b/fs/ecryptfs/kthread.c
> @@ -171,7 +171,7 @@ int ecryptfs_privileged_open(struct file **lower_fi=
le,
>  		goto out;
>  	}
>  have_file:
> -	if ((*lower_file)->f_op->mmap =3D=3D NULL) {
> +	if ((*lower_file)->f_op->mmap =3D=3D NULL && !d_is_dir(lower_dentry))=
 {
>  		fput(*lower_file);
>  		*lower_file =3D NULL;
>  		rc =3D -EMEDIUMTYPE;
>=20


--=20
Jeff Mahoney
SUSE Labs


--saOI6bdrO1JGaHH2BotI29iLcWABulfLO--

--5BsOoalPXixA6Jpxg1HCph6wlnqlcHvF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXfCMsAAoJEB57S2MheeWylxwQALM799LKBZBKbH5BSOf0vm14
ddabltWLyyW7DDxlhchmtAAUQ+YU1T42OUKspkN93IMTCNYZRdvaG32FtwjY5Kws
Em1NEp7T4t0cT4KFk1Doyi10rn4G03VRBuZaSPbW65P+Tws1rejvtkNpx2g2yhlJ
R4rudvSfIhGIVSuzGIaQa6LS+9kllwuvyZRH1ph4wHpL+SlcP2RMx4+exDfTgRkG
ZXjcNcyM4viEYBf7Jytjjdw/7Iqcc2A/HkmVse8/Lzl7r5LMZ5iV/MSnX8QLJa9P
jmv565TaLX1Rv+6szeqwvNPPjQpl5pXwh/wfyzo6lkapHhXV/Y6Va4l3hDcIzPnt
L0DdCluupyhyumnuxixaPPcVcU6LiR5t28cV0jeCKcNlb4P26iaAE66GjpqgTvST
+p+h+4D/lKgsF205Sbz7GW/YjcrfEITx5/c/k+asvgTIHg3WLvHKaEN9Y9aGCOvk
FhgO5/znB/lcM3K4NWgrxZB2vs22kaG4K0YvkBU588lDr0REkNR+11o0mRiksI3W
zy09foG375JWGBO5Eo+So8wInka0PHQInh7RgFHt5m4Z1c9X4IQkHWpTFpYLVDz+
41+HDVnozHcylsreActHO6842mwzlQ1D78CxawwxYqm99J6hNG0vqKcvTmgeOd4Z
txB1AfH1Qo2RcNLCHRo/
=9v4z
-----END PGP SIGNATURE-----

--5BsOoalPXixA6Jpxg1HCph6wlnqlcHvF4--
