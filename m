From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: use after free in ecryptfs_release_messaging()
Date: Fri, 13 Oct 2017 21:24:09 -0400
Message-ID: <2e7b4c48-aea4-0951-1010-33380b2e6b73@canonical.com>
References: <20170822204128.7xhtrlpvueucbisl@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xnqNU52rjoFjOPwgubDQt9eEVvfJGuGOk"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34580 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbdJNBY3 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 13 Oct 2017 21:24:29 -0400
In-Reply-To: <20170822204128.7xhtrlpvueucbisl@mwanda>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, Michael Halcrow <mhalcrow@us.ibm.com>
Cc: ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xnqNU52rjoFjOPwgubDQt9eEVvfJGuGOk
Content-Type: multipart/mixed; boundary="UF5AxctPbXwoDBT5LUjdQX55h5sX3Gtqn";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Michael Halcrow <mhalcrow@us.ibm.com>
Cc: ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-ID: <2e7b4c48-aea4-0951-1010-33380b2e6b73@canonical.com>
Subject: Re: [PATCH] eCryptfs: use after free in ecryptfs_release_messaging()
References: <20170822204128.7xhtrlpvueucbisl@mwanda>
In-Reply-To: <20170822204128.7xhtrlpvueucbisl@mwanda>

--UF5AxctPbXwoDBT5LUjdQX55h5sX3Gtqn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Dan - Thanks for the patch. I'm sorry for not getting back to you
until now.

On 08/22/2017 04:41 PM, Dan Carpenter wrote:
> We're freeing the list iterator so we should be using the _safe()
> version of hlist_for_each_entry().
>=20
> Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism"=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I think this patch is correct. I'll perform some testing and, if all
goes well, get it in before 4.14 is released.

Tyler

> ---
> It's also possible that I misunderstood this code.  Please review with
> caution.
>=20
> diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
> index 286f10b0363b..4f457d5c4933 100644
> --- a/fs/ecryptfs/messaging.c
> +++ b/fs/ecryptfs/messaging.c
> @@ -442,15 +442,16 @@ void ecryptfs_release_messaging(void)
>  	}
>  	if (ecryptfs_daemon_hash) {
>  		struct ecryptfs_daemon *daemon;
> +		struct hlist_node *n;
>  		int i;
> =20
>  		mutex_lock(&ecryptfs_daemon_hash_mux);
>  		for (i =3D 0; i < (1 << ecryptfs_hash_bits); i++) {
>  			int rc;
> =20
> -			hlist_for_each_entry(daemon,
> -					     &ecryptfs_daemon_hash[i],
> -					     euid_chain) {
> +			hlist_for_each_entry_safe(daemon, n,
> +						  &ecryptfs_daemon_hash[i],
> +						  euid_chain) {
>  				rc =3D ecryptfs_exorcise_daemon(daemon);
>  				if (rc)
>  					printk(KERN_ERR "%s: Error whilst "
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--UF5AxctPbXwoDBT5LUjdQX55h5sX3Gtqn--

--xnqNU52rjoFjOPwgubDQt9eEVvfJGuGOk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZ4Wc5AAoJENaSAD2qAscKc9oP/37kR4eHGP84uTyPipmiAn4/
rNSaCL4V1FYbvFCSpWhssZiyQPAiRh/VJ8ESVhuTRNPGPrt0PVofUBP4IKZJwV3f
ZUmj2v2d1JCr3mAJmYUflYu93xmZ6MhGlOXxsRMHDA1KN6GRNgdka8FAnpafBDpX
5GQ2Y4FvWcfHBECysQFkQQROIdYQnH7u7ZTvfoY8KnNTBNw1IQuS0i/7zIClWvod
zoCx8lB7nTEVicrFWo5KXN4JlebMVFc/Rf7puc5b6R5DB7Mk+pGHLUTAskvM3GOy
7cfuk1t1ZlfmifrM6XsgzfVuX/5S5u+moT764sqDzHvI2tQvNNz6kztm5oSUpS1D
X5T0+/HWsdiYOLPYq5JA2j1wBwej3OX62/4cK1AnlLfLSqdn9waHQoSND4hS/JNE
eOLHRjvjhfyCWmXvByH4COnPbqWESI0DRA1AJ691BLreGgvXqS0gpkMDUZk4RULW
iHueRphQiJVEtybljE40gPIxH33FmPYzLjBbW7nxHssXI/CdpzFoqUELQeHKi1iE
HabRhiNzmXQarQW55VSKYqiyzWmGu1DMVjDDdv9/ZjRtofl2nc0sIyfepYg3Un/2
57W+qy6Ki447NVSgkKzAsTKw2GrfWgNntmGYt1SJHic6IE9CZU2FwIGux26tkB/x
7D5ejEmsxe+FNW418UtH
=RyQ+
-----END PGP SIGNATURE-----

--xnqNU52rjoFjOPwgubDQt9eEVvfJGuGOk--
