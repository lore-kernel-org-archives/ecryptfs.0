From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
Date: Thu, 7 Jul 2016 18:17:07 -0500
Message-ID: <577EE2F3.30306@canonical.com>
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
 <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
 <577E9926.2070408@canonical.com>
 <a404658e-61a3-ab61-2b47-170f00b9499d@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="b3bHI2hjBCmSwXSLf7ewxH6dKXX6p9V0l"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47752 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbcGGXRO (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 7 Jul 2016 19:17:14 -0400
In-Reply-To: <a404658e-61a3-ab61-2b47-170f00b9499d@suse.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jeff Mahoney <jeffm@suse.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b3bHI2hjBCmSwXSLf7ewxH6dKXX6p9V0l
Content-Type: multipart/mixed; boundary="TcQmdq7JhPifrObVRK28GU9vBBtUHhtg9"
From: Tyler Hicks <tyhicks@canonical.com>
To: Jeff Mahoney <jeffm@suse.com>, stable@vger.kernel.org
Cc: ecryptfs@vger.kernel.org
Message-ID: <577EE2F3.30306@canonical.com>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
 <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
 <577E9926.2070408@canonical.com>
 <a404658e-61a3-ab61-2b47-170f00b9499d@suse.com>
In-Reply-To: <a404658e-61a3-ab61-2b47-170f00b9499d@suse.com>

--TcQmdq7JhPifrObVRK28GU9vBBtUHhtg9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/07/2016 01:19 PM, Jeff Mahoney wrote:
> On 7/7/16 2:02 PM, Tyler Hicks wrote:
>> On 07/05/2016 04:14 PM, Jeff Mahoney wrote:
>>> On 6/28/16 11:39 PM, Tyler Hicks wrote:
>>>> Cherry-picking mainline commit 2f36db71009304b3f0b95afacd8eba1f9f046=
b87
>>>> introduces a regression in eCryptfs when mainline commit
>>>> 6a480a7842545ec520a91730209ec0bae41694c1 (4.6+) is not present. The
>>>> regression causes all attempts at opening directory files to fail wi=
th
>>>> EMEDIUMTYPE when the lower filesystem's file_operations for director=
y
>>>> files do not implement mmap.
>>>>
>>>> This is a simple fix that allows the check for the lower file's mmap=

>>>> implementation to be ignored if the lower file is a directory.
>>>
>>> I have a different fix that I believe is more correct for this.  I wo=
uld
>>> have posted it in response to the original fix if it were ever actual=
ly
>>> posted for public discussion.
>>
>> Hi Jeff - I'm glad that you are sending your fix out for review (not
>> sure if you noticed but I asked you to do so in a reply to your commen=
t
>> on the project zero blog post).
>=20
> I didn't see that.  Strange that it linked my profile pic but didn't
> send a notification. :)
>=20
>>> Denying open is the wrong place to fix this.  It's too heavy a hammer=

>>> and, as we see here, a bit fragile.
>>
>> I agree but I think that denying open() has little to do with this
>> regression in linux-stable. I'd prefer that we leave linux-stable as-i=
s
>> (after applying my minimal regression fix patch) and take your fix tru=
nk.
>=20
> It doesn't have anything to do with the regression -- but it can be
> backported directly to stable without regressions if the original fix i=
s
> removed and stable fixes should match the upstream ones.

After reviewing and testing, I've changed my mind. I agree that your
patches are the better fix for trunk and stable. I do have some small
changes to make to the second patch. I'll reply directly to that patch
with those changes.

Tyler

>=20
> -Jeff
>=20
>> Tyler
>>
>>>
>>> The right fix is to deny the mmap call instead.
>>>
>>> -Jeff
>>>
>>>> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>>>> Tested-by: Tyler Hicks <tyhicks@canonical.com> # 4.4.y, 3.18.y
>>>> Cc: <stable@vger.kernel.org> # 4.5-
>>>> ---
>>>>  fs/ecryptfs/kthread.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
>>>> index e818f5a..b9faeab 100644
>>>> --- a/fs/ecryptfs/kthread.c
>>>> +++ b/fs/ecryptfs/kthread.c
>>>> @@ -171,7 +171,7 @@ int ecryptfs_privileged_open(struct file **lower=
_file,
>>>>  		goto out;
>>>>  	}
>>>>  have_file:
>>>> -	if ((*lower_file)->f_op->mmap =3D=3D NULL) {
>>>> +	if ((*lower_file)->f_op->mmap =3D=3D NULL && !d_is_dir(lower_dentr=
y)) {
>>>>  		fput(*lower_file);
>>>>  		*lower_file =3D NULL;
>>>>  		rc =3D -EMEDIUMTYPE;
>>>>
>>>
>>>
>>
>>
>=20
>=20



--TcQmdq7JhPifrObVRK28GU9vBBtUHhtg9--

--b3bHI2hjBCmSwXSLf7ewxH6dKXX6p9V0l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXfuLzAAoJENaSAD2qAscKU8AP/2tGGq2+ohlGU0eA/CNYOtqQ
OkwjHVwiPwP1uo25Y+IfKHwoHEXwSMUFiliz1jTDSJjGR0oiusArnYNbYDMvpk1L
up+O5KNW629ui8+da5iS8/Ljr8XazPlwu9WurBA+pK23qzMc4Tf6pYvrrB2b6/oQ
clSW7UKFOO0ixL6PVOPsiW4e271OcxnVTb2ZJO0Hdi5jaN56EIN52V148QZKJ6Lp
rputceC7RsLSEmRCgcxx9OI6v+LHfAdYtWser9QJgRbrkdkC6xsAL9Plyvj4wDY9
utAzvxriqToQXhi0RSZcD8OAqRbAa5B6kij9U0GGprpINYfEBhnaJ1hQv7oN2akm
AGGBI/ne2gAKkE3C0sRRpe6gv9odTWG5hUZDyy72YOd8+vbsry33c/M3/qYrqfRJ
xQjXY40AKmwrear3GNIG2j2j/sudTmBd/PYF5zbQLQU9AMdZd8m/YjChLXjLcDOr
Er5wpBOPgdEJ1IpMrEHuIZEZU5vV/ngBqxTO2yoUHtwXuqLWPrejhOkwny82ShUs
xCUn+Z+Xz2SccNJ3sjHjsb/7lM5Uhf9xIHrSw6oKOIG3EV26PMDFWYaTBK8Zncyw
dvcH4zs3h7aVSR2N0tKBYvgFVLTYkwduluNtjpoZytMpzXgKj7jmPZbDKFEQxMXs
Wu8FRo+pD/gC9o+hvVHl
=sTnt
-----END PGP SIGNATURE-----

--b3bHI2hjBCmSwXSLf7ewxH6dKXX6p9V0l--
