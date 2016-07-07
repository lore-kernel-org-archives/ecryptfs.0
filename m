From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
Date: Thu, 7 Jul 2016 14:19:36 -0400
Message-ID: <a404658e-61a3-ab61-2b47-170f00b9499d@suse.com>
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
 <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
 <577E9926.2070408@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9sjomV3GujVKggndTXexGJ68hxbl2i7wG"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <577E9926.2070408@canonical.com>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9sjomV3GujVKggndTXexGJ68hxbl2i7wG
Content-Type: multipart/mixed; boundary="wVTuJAI5BHC2U2q1g4n1qKtwf8nWOVQPt"
From: Jeff Mahoney <jeffm@suse.com>
To: Tyler Hicks <tyhicks@canonical.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org
Message-ID: <a404658e-61a3-ab61-2b47-170f00b9499d@suse.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
 <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
 <577E9926.2070408@canonical.com>
In-Reply-To: <577E9926.2070408@canonical.com>

--wVTuJAI5BHC2U2q1g4n1qKtwf8nWOVQPt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 7/7/16 2:02 PM, Tyler Hicks wrote:
> On 07/05/2016 04:14 PM, Jeff Mahoney wrote:
>> On 6/28/16 11:39 PM, Tyler Hicks wrote:
>>> Cherry-picking mainline commit 2f36db71009304b3f0b95afacd8eba1f9f046b=
87
>>> introduces a regression in eCryptfs when mainline commit
>>> 6a480a7842545ec520a91730209ec0bae41694c1 (4.6+) is not present. The
>>> regression causes all attempts at opening directory files to fail wit=
h
>>> EMEDIUMTYPE when the lower filesystem's file_operations for directory=

>>> files do not implement mmap.
>>>
>>> This is a simple fix that allows the check for the lower file's mmap
>>> implementation to be ignored if the lower file is a directory.
>>
>> I have a different fix that I believe is more correct for this.  I wou=
ld
>> have posted it in response to the original fix if it were ever actuall=
y
>> posted for public discussion.
>=20
> Hi Jeff - I'm glad that you are sending your fix out for review (not
> sure if you noticed but I asked you to do so in a reply to your comment=

> on the project zero blog post).

I didn't see that.  Strange that it linked my profile pic but didn't
send a notification. :)

>> Denying open is the wrong place to fix this.  It's too heavy a hammer
>> and, as we see here, a bit fragile.
>=20
> I agree but I think that denying open() has little to do with this
> regression in linux-stable. I'd prefer that we leave linux-stable as-is=

> (after applying my minimal regression fix patch) and take your fix trun=
k.

It doesn't have anything to do with the regression -- but it can be
backported directly to stable without regressions if the original fix is
removed and stable fixes should match the upstream ones.

-Jeff

> Tyler
>=20
>>
>> The right fix is to deny the mmap call instead.
>>
>> -Jeff
>>
>>> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>>> Tested-by: Tyler Hicks <tyhicks@canonical.com> # 4.4.y, 3.18.y
>>> Cc: <stable@vger.kernel.org> # 4.5-
>>> ---
>>>  fs/ecryptfs/kthread.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
>>> index e818f5a..b9faeab 100644
>>> --- a/fs/ecryptfs/kthread.c
>>> +++ b/fs/ecryptfs/kthread.c
>>> @@ -171,7 +171,7 @@ int ecryptfs_privileged_open(struct file **lower_=
file,
>>>  		goto out;
>>>  	}
>>>  have_file:
>>> -	if ((*lower_file)->f_op->mmap =3D=3D NULL) {
>>> +	if ((*lower_file)->f_op->mmap =3D=3D NULL && !d_is_dir(lower_dentry=
)) {
>>>  		fput(*lower_file);
>>>  		*lower_file =3D NULL;
>>>  		rc =3D -EMEDIUMTYPE;
>>>
>>
>>
>=20
>=20


--=20
Jeff Mahoney
SUSE Labs


--wVTuJAI5BHC2U2q1g4n1qKtwf8nWOVQPt--

--9sjomV3GujVKggndTXexGJ68hxbl2i7wG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXfp07AAoJEB57S2MheeWybDcP/RyNKV8NfcM/YvsQT5WYK3Uo
WhR3vRCCFTaHdPBvbRXzps97RdsrJgQIVa4RFygFFtb1SA1L968A3LzTXs/T2Uhp
+iZF+jUmP5xLvIuA/UyW39TUMDpoernxsOp5BF3UbO2fZmNgdGDUAtP8Df7aLkBk
sGIQwYXUYe7V/JtZfSi/S3RjeK5AVZE9KKURIb46edz1M1jcc/Flht6DZCQsC9pN
RMyJ0D0s+ZjPoNWX/zus0tX95sSSgvKPilIFLhfCnfZ2iyRScByZKCOeKkTn7sGf
RXDWHKjLTUVNUDEJXwZKKRRH4P5/sZBLkvMxWZcAk6+5h7PO3k2XPZnBzgMWTYHF
zTS/ecHk7A7sjubIxdCvmM1ixBYg68iOLyEglEO0hsEiZV73OCKsqO6dInhpHolf
qqHHGzduu45GV5SanYfIRaxJQWaeQPCx1zbCJ1JMpPXRAUgeSg1e1IKCe8439xgh
d5NRjZp/xNe4XkkSmAJ1QFjIColxH7YQPV2GMq2G0QprYAxZf2cEuDrFdQgCgT3s
ngCgS5KuggQfnaOBscnjn4IAnx+I3yq+GjqQpGQcYlvn4YOgc1ouasS0n1X0tBtU
1Lc518+zvzR61gHMqdOZWWyvO95g/jySLQdyp3c5zYwxcrByoG6SsRCifXv0ZXd+
waMJU+1n+ei3vaDUBX1f
=2tI4
-----END PGP SIGNATURE-----

--9sjomV3GujVKggndTXexGJ68hxbl2i7wG--
