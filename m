From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] ecryptfs: Restore support for both encrypted and
 unencrypted file names
Date: Wed, 28 Mar 2018 09:19:05 -0500
Message-ID: <891ab33d-a140-0a6d-6907-ba226590eb3f@canonical.com>
References: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
 <740f5325-331d-d38c-e9d4-5f81b95a6872@canonical.com>
 <6f35b462-8c36-5ba3-4712-a0782961e548@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fqBDuFNiLxPsee8zM0bIv0KFp4k3J4JiZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f35b462-8c36-5ba3-4712-a0782961e548@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fqBDuFNiLxPsee8zM0bIv0KFp4k3J4JiZ
Content-Type: multipart/mixed; boundary="xNgYWx72qLxfC7gYKQTFL9Oy3FBSibGsE";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <891ab33d-a140-0a6d-6907-ba226590eb3f@canonical.com>
Subject: Re: [PATCH] ecryptfs: Restore support for both encrypted and
 unencrypted file names
References: <1518561368-8324-1-git-send-email-linux@roeck-us.net>
 <740f5325-331d-d38c-e9d4-5f81b95a6872@canonical.com>
 <6f35b462-8c36-5ba3-4712-a0782961e548@roeck-us.net>
In-Reply-To: <6f35b462-8c36-5ba3-4712-a0782961e548@roeck-us.net>

--xNgYWx72qLxfC7gYKQTFL9Oy3FBSibGsE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/28/2018 08:33 AM, Guenter Roeck wrote:
> On 03/27/2018 08:58 AM, Tyler Hicks wrote:
>> Hello Guenter
>>
>> On 02/13/2018 04:36 PM, Guenter Roeck wrote:
>>> Commit 88ae4ab9802e ("ecryptfs_lookup(): try either only encrypted or=

>>> plaintext name") was supposed to fix a situation where two files with=

>>> the same name and same inode could be created in ecryptfs. One of tho=
se
>>> files had an encrypted file name, the other file name was unencrypted=
=2E
>>
>> That's correct. Al was concerned about possible deadlocks with aliased=

>> dentries and I thought it would be best to only support encrypted and
>> unencrypted but not both.
>>
>>>
>>> After commit 88ae4ab9802e, having a mix of encrypted and unencrypted
>>> file
>>> names is no longer supposed to be possible. However, that is not the
>>> case.
>>> The only difference is that it is now even easier to create a situati=
on
>>> where two files with the same name coexist (one encrypted and the oth=
er
>>> not encrypted). In practice, this looks like the following (files
>>> created with v4.14.12).
>>>
>>> ecryptfs mounted with file name encryption enabled:
>>>
>>> $ ls -li
>>> total 48
>>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>>> $ grep . *
>>> myfile:encrypted
>>> myfile:encrypted
>>> myfile2:encrypted
>>> myfile2:encrypted
>>>
>>> $ ls -li
>>> total 48
>>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36
>>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-n=
jbcIPoApxk7-E--
>>>
>>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02
>>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9Y=
CtJ70cm911yZ---
>>>
>>> 5252817 -rw-rw-r-- 1 groeck groeck 12 Jan 20 12:52 myfile
>>> 5252827 -rw-rw-r-- 1 groeck groeck 12 Jan 20 15:37 myfile2
>>>
>>> $ grep . *
>>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVun.BU8Zu5-n=
jbcIPoApxk7-E--:encrypted
>>>
>>> ECRYPTFS_FNEK_ENCRYPTED.FWbF9U6H6L6ekEZYGWnkfR4wMiyeTVoCeVunt0fda7t9Y=
CtJ70cm911yZ---:encrypted
>>>
>>> myfile:unencrypted
>>> myfile2:unencrypted
>>>
>>> Creating a file with file name encryption disabled and remounting wit=
h
>>> file name encryption enabled results in the following.
>>>
>>> $ ls -li
>>> ls: cannot access 'myfile3': No such file or directory
>>> total 48
>>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>>> 5252822 -rw-rw-r-- 1 groeck groeck 10 Jan 20 13:02 myfile
>>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>>> 5252824 -rw-rw-r-- 1 groeck groeck 10 Jan 20 15:36 myfile2
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? -????????? ? ?=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? myfile3
>>>
>>> Prior to commit 88ae4ab9802e, the file system had to be mounted with
>>> encrypted file names first to create a file, then the same had to be
>>> repeated after mounting with unencrypted file names. Now the duplicat=
e
>>> files can be created both ways (unencrypted _or_ encrypted first).
>>>
>>> The only real difference is that it is no longer possible to have a
>>> _working_ combination of encrypted and unencrypted file names. In oth=
er
>>> words, commit 88ae4ab9802e results in reduced functionality with no
>>> benefit whatsoever.
>>>
>>> Restore ability to have a mix of unencrypted and encrypted files.
>>> This effectively reverts commit 88ae4ab9802e, but the code is now
>>> better readable since it avoids a number of goto statements.
>>
>> I'd like for us to correctly fix 88ae4ab9802e rather than try to suppo=
rt
>> both filename types under a single mount since that's complex and ther=
e
>> are unknown corner cases to consider. I think this can be done by not
>> copying up the lower filename when an error is encountered in
>> ecryptfs_decode_and_decrypt_filename(). If filename encryption is
>> enabled, it should only return decrypted filenames or an error if it
>> isn't possible to decrypt the lower filename.
>>
>=20
> NP. I'll leave it alone, then. Since our use case requires both encrypt=
ed
> and unencrypted file names, our "fix" will be to carry this patch along=

> locally as long as needed and stop using ecryptfs otherwise.

I think that's a good plan. While eCryptfs has been fairly stable for
quite some time, it is starved for maintenance attention these days as
you've noticed with this thread. :/

Thanks for bringing up this bug. I'll include you on any followup
patches to fix the 88ae4ab9802e change so that you'll be aware of any
additional local patches that you'll need to carry.

Tyler

>=20
> Guenter
>=20
>> Tyler
>>
>>>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> =C2=A0 fs/ecryptfs/inode.c | 10 +++++-----
>>> =C2=A0 1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>>> index 847904aa63a9..14a5c096ead6 100644
>>> --- a/fs/ecryptfs/inode.c
>>> +++ b/fs/ecryptfs/inode.c
>>> @@ -392,11 +392,11 @@ static struct dentry *ecryptfs_lookup(struct
>>> inode *ecryptfs_dir_inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc =3D 0;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lower_dir_dentry =3D
>>> ecryptfs_dentry_to_lower(ecryptfs_dentry->d_parent);
>>> -
>>> +=C2=A0=C2=A0=C2=A0 lower_dentry =3D lookup_one_len_unlocked(name, lo=
wer_dir_dentry,
>>> len);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount_crypt_stat =3D &ecryptfs_superbl=
ock_to_private(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ecryptfs_dentry->d_sb)->mount_crypt_sta=
t;
>>> -=C2=A0=C2=A0=C2=A0 if (mount_crypt_stat
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && (mount_crypt_stat->fla=
gs &
>>> ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(lower_dentry) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (mount_crypt_stat->flags =
&
>>> ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D ecryptf=
s_encrypt_and_encode_filename(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &encrypted_and_encoded_name, &len,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mount_crypt_stat, name, len);
>>> @@ -405,10 +405,10 @@ static struct dentry *ecryptfs_lookup(struct
>>> inode *ecryptfs_dir_inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename; rc =3D [%d=
]\n", __func__, rc);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ERR_PTR(rc);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D encrypted_and_en=
coded_name;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lower_dentry =3D lookup_o=
ne_len_unlocked(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
ncrypted_and_encoded_name, lower_dir_dentry, len);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 lower_dentry =3D lookup_one_len_unlocked(n=
ame, lower_dir_dentry,
>>> len);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(lower_dentry)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ecryptfs_print=
k(KERN_DEBUG, "%s: lookup_one_len() returned "
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "[%ld] on lower_dentry =3D [%s]\n", __f=
unc__,
>>>
>>
>>
>=20



--xNgYWx72qLxfC7gYKQTFL9Oy3FBSibGsE--

--fqBDuFNiLxPsee8zM0bIv0KFp4k3J4JiZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlq7pFkACgkQ1pIAPaoC
xworExAAo0y0GX3mwCopixapYVGNjP0tNMLjCAvHb6hD6qyBOIjf075UREQ3oWKM
48TDNjuIqF+/sTS/4/d+nQ3uLkWz8xExNlcf5bijkkqa4anAPfx28unYn7MEyUEV
mfRgMuDpjbLh36xSDrYuRex8O3uGXFtdUXtraRZSkC1L2cjg4BzFP0xF51eT+XXz
RRt5ykP4tKBtkRmFTRcJWfLMzUmb8n6U2I2QoTwzc/85FuETCJk4UeQ54i9X6UaY
UYGz4WhWQHZCbbSHHRRnq96ZgegJSvfS5Le/SORB0dZUQX7dm+FVEEMptpJX+9+W
M/sgJeuq8lsSGm2rukL72iAlzhFQlSa92Yv9IVO8x6evkCgx1I/1tW5o53WCWWhi
dOA6MzMtTu/ZZmhnvu8ke0bmSdgoL9UMUbRJMg4FJD2/2ClbYD7zmTmO4yiqNjT3
JNz+eIt7BaOi12DBXob5DlQ2imd/kI/ZCZqdD3FvbIbW2rjywxNjZEAG2hE6e8Sw
VswT3Eiw+Ol7dOEVcl2vHbzS3Rs9bIVaj/dhl2Au+Ymp0Hn9KYhwSQVVi6REch9I
Daebofvw/NPARU4CQ7GEHChg28UFdVHVlzYsWOGS9062YAyY4hh81AtMEZbkbZWi
iARgLU+SK9IHptUlybsQQq5IYQv2U5VQ+e1yTfmTZDGIW3a6vkk=
=DUzi
-----END PGP SIGNATURE-----

--fqBDuFNiLxPsee8zM0bIv0KFp4k3J4JiZ--
