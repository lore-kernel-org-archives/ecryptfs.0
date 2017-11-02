From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: remove unnecessary i_version bump
Date: Thu, 2 Nov 2017 17:43:48 -0500
Message-ID: <5394f39a-2ae4-0e42-d2a0-bac52fc12352@canonical.com>
References: <20171030150131.2587-1-jlayton@kernel.org>
 <1509375810.5412.22.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xkRSxWeGKOnk0uVbSObrpTXcDXvmb3VCM"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44361 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934438AbdKBWny (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 2 Nov 2017 18:43:54 -0400
In-Reply-To: <1509375810.5412.22.camel@poochiereds.net>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jeff Layton <jlayton@poochiereds.net>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xkRSxWeGKOnk0uVbSObrpTXcDXvmb3VCM
Content-Type: multipart/mixed; boundary="KSWb9rxomfVpcOaAFpSRN5Lj75fauARnA";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Jeff Layton <jlayton@poochiereds.net>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5394f39a-2ae4-0e42-d2a0-bac52fc12352@canonical.com>
Subject: Re: [PATCH] ecryptfs: remove unnecessary i_version bump
References: <20171030150131.2587-1-jlayton@kernel.org>
 <1509375810.5412.22.camel@poochiereds.net>
In-Reply-To: <1509375810.5412.22.camel@poochiereds.net>

--KSWb9rxomfVpcOaAFpSRN5Lj75fauARnA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 10:03 AM, Jeff Layton wrote:
> On Mon, 2017-10-30 at 11:01 -0400, Jeff Layton wrote:
>> From: Jeff Layton <jlayton@redhat.com>
>>
>> There is no need to bump the i_version counter here, as ecryptfs does
>> not set the MS_I_VERSION flag, and doesn't use it internally. It also
>=20
> My apologies, I've been sitting on this patch for a while now. That
> should be changed to the SB_I_VERSION flag. Tyler, do you mind fixing
> that up before merge, or would you like me to resend?

That's no problem. Thanks for the patch! It looks good to me and I'll
take it through my tree.

Tyler

>=20
>> only bumps it when the inode is instantiated, which doesn't make much
>> sense.
>>
>> Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> ---
>>  fs/ecryptfs/inode.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>> index efc2db42d175..b59b083379ea 100644
>> --- a/fs/ecryptfs/inode.c
>> +++ b/fs/ecryptfs/inode.c
>> @@ -64,7 +64,6 @@ static int ecryptfs_inode_set(struct inode *inode, v=
oid *opaque)
>>  	/* i_size will be overwritten for encrypted regular files */
>>  	fsstack_copy_inode_size(inode, lower_inode);
>>  	inode->i_ino =3D lower_inode->i_ino;
>> -	inode->i_version++;
>>  	inode->i_mapping->a_ops =3D &ecryptfs_aops;
>> =20
>>  	if (S_ISLNK(inode->i_mode))
>=20



--KSWb9rxomfVpcOaAFpSRN5Lj75fauARnA--

--xkRSxWeGKOnk0uVbSObrpTXcDXvmb3VCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZ+5+kAAoJENaSAD2qAscK0F4P/277+r+KO8ne3Adi0gzs/GQS
YNgCXibz7G5NjmIsVSLzqOZ9fFhsIHU070SfqAVsEVn/zzKPzruo+3/RD62y6T+D
Gy1jieVhyOOMwKVsb+XAsuz5So0FDIvHQR94UyDl2OPFOFkGCn0VZLNNc3pNcG0a
cQwTsmXLSMNXn4XI1cddqTb7PnIi/mYCGrOQQheeE+o/Tf9INvl/QVoHoVj78LkG
Z7M+2z7OmLSAttmH+J51bm5O6LVZdjhNmhzpXP7eYNSDIVmOVglm0owUcdSVFZDU
azMpTqu0QvCL6/3tU95TTDUlGQyIE2rvED/s8wmROxxn0BGlgLK+33tflwtd5wco
EJt131dZBvH6iyAQWUZG+K2FEtm7IZi7mO1tyzk+Isr8bbg5t21b1ruJEgAWS/CO
fvGcu9hO1YSlS8oPuJ3JofH5+bZXSoS2saCk5R7bPMwL5pOmlq3NQ6+R7sUudTfl
OpMi+Y7J8rNR51kxVa+0U9utTZW+8swxxL1cL6sF5jbNqLmIrcgA3H5gu1O9WIlu
piIWM3AQXVckMrNbEIY4Nbfefm6Y5qOmMCBV3syCuIleGDUDZcLP2rdDTjcDhZe9
rJ/pUhUDenDxeCpEcsyxvrW0p9reTeH0Ylz25GbejNjmZ9FY+hkI4fyJwL7QYZkl
Jilz5mJncxyzqKWVMbI5
=ymLQ
-----END PGP SIGNATURE-----

--xkRSxWeGKOnk0uVbSObrpTXcDXvmb3VCM--
