From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
Date: Tue, 2 Aug 2016 09:05:04 -0400
Message-ID: <2d10394e-b255-92b0-f378-a164cd731b9e@suse.com>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <577EE3A8.4030106@canonical.com>
 <06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
 <20160802145005.3a7ed0f6@pc-198.iww-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9DjL0jasNEvaVFBQOonDdTDeN3pTMPLsr"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160802145005.3a7ed0f6@pc-198.iww-online.de>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Henry Jensen <hjensen@gmx.de>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Jann Horn <jann@thejh.net>, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9DjL0jasNEvaVFBQOonDdTDeN3pTMPLsr
Content-Type: multipart/mixed; boundary="txcb3nQi94CPJ2bjMN6cBmIPTFddRIMTu"
From: Jeff Mahoney <jeffm@suse.com>
To: Henry Jensen <hjensen@gmx.de>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org,
 Jann Horn <jann@thejh.net>, stable@vger.kernel.org
Message-ID: <2d10394e-b255-92b0-f378-a164cd731b9e@suse.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <577EE3A8.4030106@canonical.com>
 <06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
 <20160802145005.3a7ed0f6@pc-198.iww-online.de>
In-Reply-To: <20160802145005.3a7ed0f6@pc-198.iww-online.de>

--txcb3nQi94CPJ2bjMN6cBmIPTFddRIMTu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 8/2/16 8:50 AM, Henry Jensen wrote:
> Hello,
>=20
> is there any new status? We are meanwhile at kernel 4.4.16 LTS and
> ecryptfs is still broken there.

The revert and the fix below, plus Tyler's cleanup, landed in 4.7.  Both
were tagged for inclusion in -stable but haven't landed there yet.  I'm
afraid that's the limit of my tracking of it.

-Jeff

> Regards,
>=20
> Henry
>=20
>=20
> On Thu, 7 Jul 2016 20:46:34 -0400
> Jeff Mahoney <jeffm@suse.com> wrote:
>=20
>> On 7/7/16 7:20 PM, Tyler Hicks wrote:
>>> On 07/05/2016 04:32 PM, jeffm@suse.com wrote: =20
>>>> From: Jeff Mahoney <jeffm@suse.com>
>>>>
>>>> There are legitimate reasons to disallow mmap on certain files, nota=
bly
>>>> in sysfs or procfs.  We shouldn't emulate mmap support on file syste=
ms
>>>> that don't offer support natively.
>>>>
>>>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>>>> ---
>>>>  fs/ecryptfs/file.c | 16 +++++++++++++++-
>>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
>>>> index 7000b96..4aaa656 100644
>>>> --- a/fs/ecryptfs/file.c
>>>> +++ b/fs/ecryptfs/file.c
>>>> @@ -169,6 +169,20 @@ out:
>>>>  	return rc;
>>>>  }
>>>> =20
>>>> +
>>>> +static int ecryptfs_mmap(struct file *file, struct vm_area_struct *=
vma)
>>>> +{
>>>> +	struct dentry *dentry =3D ecryptfs_dentry_to_lower(file_dentry(fil=
e)); =20
>>>
>>> This should be:
>>>
>>> 	struct file *lower_file =3D ecryptfs_file_to_lower(file);
>>>  =20
>>>> +	/*
>>>> +	 * Don't allow mmap on top of file systems that don't support it
>>>> +	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
>>>> +	 * allows recursive mounting, this will need to be extended.
>>>> +	 */
>>>> +	if (!d_inode(dentry)->i_fop->mmap) =20
>>>
>>> and then:
>>>
>>> 	if (!lower_file->f_op->mmap)
>>>
>>>
>>> I'll make these simple changes, add stable to cc in the patch tags, a=
nd
>>> push to Linus. =20
>>
>> Oh, whoops. Yeah, that's better.
>>
>> Thanks,
>>
>> -Jeff
>>
>>> Thanks again!
>>>
>>> Tyler
>>>  =20
>>>> +		return -ENODEV;
>>>> +	return generic_file_mmap(file, vma);
>>>> +}
>>>> +
>>>>  /**
>>>>   * ecryptfs_open
>>>>   * @inode: inode speciying file to open
>>>> @@ -403,7 +417,7 @@ const struct file_operations ecryptfs_main_fops =
=3D {
>>>>  #ifdef CONFIG_COMPAT
>>>>  	.compat_ioctl =3D ecryptfs_compat_ioctl,
>>>>  #endif
>>>> -	.mmap =3D generic_file_mmap,
>>>> +	.mmap =3D ecryptfs_mmap,
>>>>  	.open =3D ecryptfs_open,
>>>>  	.flush =3D ecryptfs_flush,
>>>>  	.release =3D ecryptfs_release,
>>>> =20
>>>
>>>  =20
>>
>>
>> --=20
>> Jeff Mahoney
>> SUSE Labs
>>
>=20


--=20
Jeff Mahoney
SUSE Labs


--txcb3nQi94CPJ2bjMN6cBmIPTFddRIMTu--

--9DjL0jasNEvaVFBQOonDdTDeN3pTMPLsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXoJqEAAoJEB57S2MheeWydG0P+wTHyQ03FqrWUW7DDd1Fwp+7
yAu0jiRpLu2vDqhGGy1pXy6CGkT8tTOdF9T1itQ4ua9oA6wArKFCvlU3RZZ14GtI
zs4xnk1DAcWDhykXqFzaGWfMWGO17vl3LAvD74OGDnwmyMtVtBQjKY283riQR26L
SBt82QE82OcFba559q+zLcANcD6MOv4q/Y5y0Go1Efmi37qqkgUEvsC3REANvRJV
CkXcqbBMPf0xvrXWHowc3tgPDX0Q/Ns1Wr/1CWaxGJqeKaOorlLzZX1tUt4G4ZZk
pvDeR3f6iLNXRYujOIswTgLD0l14Zkq4ztkGOHcNYITGh3DhM5JJH3osxwdh7dD9
n2pDvpjYN8ygSCyBopD8nk8fgARkXXdZc2NkeVVc8W4HrrrmVCl+oyV6Hd8AzjbI
CK80VPIrGBDbHlK45AO4xaih5fSuLgzUHhv5DRJYPU6diVFW3bggB5AnrC9M4WQl
LxLj9lwtH3a83VabiV9pMPWS9fxXPxKLW7mwXJtm3l7Ep+UXq3gl7I3p0wA4fEBr
/tN7ijrCIDhYBdAPeSuCgZiVcyv6m8TgqKM6LBhUy1R3gy3MCzy8pT+pAlnO8IBY
GnWxlzuQ7EfCAU+Iaq7WVGRvJZooACB8lTiGmc/cPeUDuB2i5d3Oa2yhD1hUe4Oo
Qy4T5VGeOiSp7N+EOtrI
=lVi5
-----END PGP SIGNATURE-----

--9DjL0jasNEvaVFBQOonDdTDeN3pTMPLsr--
