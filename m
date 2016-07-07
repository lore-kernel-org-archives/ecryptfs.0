From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
Date: Thu, 7 Jul 2016 13:02:14 -0500
Message-ID: <577E9926.2070408@canonical.com>
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
 <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EDBiEmVqtcOHi5XxEGMqNE53CeBNLiCap"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44259 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbcGGSCW (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 7 Jul 2016 14:02:22 -0400
In-Reply-To: <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jeff Mahoney <jeffm@suse.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EDBiEmVqtcOHi5XxEGMqNE53CeBNLiCap
Content-Type: multipart/mixed; boundary="mxbGUAsccarCkemRosE5L8buU5gHn01Wq"
From: Tyler Hicks <tyhicks@canonical.com>
To: Jeff Mahoney <jeffm@suse.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org
Message-ID: <577E9926.2070408@canonical.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
 <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
In-Reply-To: <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>

--mxbGUAsccarCkemRosE5L8buU5gHn01Wq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/05/2016 04:14 PM, Jeff Mahoney wrote:
> On 6/28/16 11:39 PM, Tyler Hicks wrote:
>> Cherry-picking mainline commit 2f36db71009304b3f0b95afacd8eba1f9f046b8=
7
>> introduces a regression in eCryptfs when mainline commit
>> 6a480a7842545ec520a91730209ec0bae41694c1 (4.6+) is not present. The
>> regression causes all attempts at opening directory files to fail with=

>> EMEDIUMTYPE when the lower filesystem's file_operations for directory
>> files do not implement mmap.
>>
>> This is a simple fix that allows the check for the lower file's mmap
>> implementation to be ignored if the lower file is a directory.
>=20
> I have a different fix that I believe is more correct for this.  I woul=
d
> have posted it in response to the original fix if it were ever actually=

> posted for public discussion.

Hi Jeff - I'm glad that you are sending your fix out for review (not
sure if you noticed but I asked you to do so in a reply to your comment
on the project zero blog post).

> Denying open is the wrong place to fix this.  It's too heavy a hammer
> and, as we see here, a bit fragile.

I agree but I think that denying open() has little to do with this
regression in linux-stable. I'd prefer that we leave linux-stable as-is
(after applying my minimal regression fix patch) and take your fix trunk.=


Tyler

>=20
> The right fix is to deny the mmap call instead.
>=20
> -Jeff
>=20
>> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>> Tested-by: Tyler Hicks <tyhicks@canonical.com> # 4.4.y, 3.18.y
>> Cc: <stable@vger.kernel.org> # 4.5-
>> ---
>>  fs/ecryptfs/kthread.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
>> index e818f5a..b9faeab 100644
>> --- a/fs/ecryptfs/kthread.c
>> +++ b/fs/ecryptfs/kthread.c
>> @@ -171,7 +171,7 @@ int ecryptfs_privileged_open(struct file **lower_f=
ile,
>>  		goto out;
>>  	}
>>  have_file:
>> -	if ((*lower_file)->f_op->mmap =3D=3D NULL) {
>> +	if ((*lower_file)->f_op->mmap =3D=3D NULL && !d_is_dir(lower_dentry)=
) {
>>  		fput(*lower_file);
>>  		*lower_file =3D NULL;
>>  		rc =3D -EMEDIUMTYPE;
>>
>=20
>=20



--mxbGUAsccarCkemRosE5L8buU5gHn01Wq--

--EDBiEmVqtcOHi5XxEGMqNE53CeBNLiCap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXfpknAAoJENaSAD2qAscKP6wQAJeTxcCZ0ymBjOU5YB3SpxpE
bUhLuvAbjFcjHs5KfLNZWngMwIsll8kCbOhjemz5IhhgFDDU7FkC8JlZD+mU+EeT
0O6gmupmTL07P8wdcNXrRDIe/DS/cgqtkpSUwjUqv1kDm/YX64NwcJ7Ae7aFisi2
SSbLanQiFK38KfpEVoUaTb4p4fPzlEbbGlmD7SuwerY9nHzyFsCJVim/Ikn8jPwL
2eDv4OTU5nch1JAbUdEOVh83veqHWFBZmLQYYoWfYriBiOdZDexCZBwdRio5UAGh
NEG707ZdNp995fs8C2AsCfRe9X/ASaJt7Udv2UkYxQQHa04d28nwoCrisP0Mxcy1
qtLWPz56eDZ5aRriHElEoY8ARf1zFIFh47YZ9lRDvMpHd1pkAA6ryDVvMH4bv7za
A1Sbfp6BPfcyqXDZV4gEHpsPTNt+4XoiIjbCsOu2SfF6FunXxwoBQZkJWSVQ/Yc0
BGjoZDVmEYhCk9b7qFNSXvwckuXTjzQ8Fzi8pmwxIHaHZqJBJJYZewfTykjUEoui
NPclq5/6dcE3ztn0g+s8yx49ozwG/SMf4vEguq9dGmPNZeBXZmTBQcTYzt+sY4v7
NGX7cN9k20/PC+oayjI/ICkZEgRJqiQGD4y0q4v80vO2604QXzOiQ5aC6xAP9tlr
JmkuvsyaS5rRhQykmCDz
=23eq
-----END PGP SIGNATURE-----

--EDBiEmVqtcOHi5XxEGMqNE53CeBNLiCap--
