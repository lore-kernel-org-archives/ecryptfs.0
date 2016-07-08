From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
Date: Thu, 7 Jul 2016 20:46:34 -0400
Message-ID: <06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <577EE3A8.4030106@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IMc50O4vXmtUf8ugJWx9nJQvdHdBKqxn8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <577EE3A8.4030106@canonical.com>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org
Cc: Jann Horn <jann@thejh.net>, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMc50O4vXmtUf8ugJWx9nJQvdHdBKqxn8
Content-Type: multipart/mixed; boundary="m65s0MGGjqs866fxDAGV4wJDL7TUUTX3G"
From: Jeff Mahoney <jeffm@suse.com>
To: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org
Cc: Jann Horn <jann@thejh.net>, stable@vger.kernel.org
Message-ID: <06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <577EE3A8.4030106@canonical.com>
In-Reply-To: <577EE3A8.4030106@canonical.com>

--m65s0MGGjqs866fxDAGV4wJDL7TUUTX3G
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 7/7/16 7:20 PM, Tyler Hicks wrote:
> On 07/05/2016 04:32 PM, jeffm@suse.com wrote:
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> There are legitimate reasons to disallow mmap on certain files, notabl=
y
>> in sysfs or procfs.  We shouldn't emulate mmap support on file systems=

>> that don't offer support natively.
>>
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>>  fs/ecryptfs/file.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
>> index 7000b96..4aaa656 100644
>> --- a/fs/ecryptfs/file.c
>> +++ b/fs/ecryptfs/file.c
>> @@ -169,6 +169,20 @@ out:
>>  	return rc;
>>  }
>> =20
>> +
>> +static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vm=
a)
>> +{
>> +	struct dentry *dentry =3D ecryptfs_dentry_to_lower(file_dentry(file)=
);
>=20
> This should be:
>=20
> 	struct file *lower_file =3D ecryptfs_file_to_lower(file);
>=20
>> +	/*
>> +	 * Don't allow mmap on top of file systems that don't support it
>> +	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
>> +	 * allows recursive mounting, this will need to be extended.
>> +	 */
>> +	if (!d_inode(dentry)->i_fop->mmap)
>=20
> and then:
>=20
> 	if (!lower_file->f_op->mmap)
>=20
>=20
> I'll make these simple changes, add stable to cc in the patch tags, and=

> push to Linus.

Oh, whoops. Yeah, that's better.

Thanks,

-Jeff

> Thanks again!
>=20
> Tyler
>=20
>> +		return -ENODEV;
>> +	return generic_file_mmap(file, vma);
>> +}
>> +
>>  /**
>>   * ecryptfs_open
>>   * @inode: inode speciying file to open
>> @@ -403,7 +417,7 @@ const struct file_operations ecryptfs_main_fops =3D=
 {
>>  #ifdef CONFIG_COMPAT
>>  	.compat_ioctl =3D ecryptfs_compat_ioctl,
>>  #endif
>> -	.mmap =3D generic_file_mmap,
>> +	.mmap =3D ecryptfs_mmap,
>>  	.open =3D ecryptfs_open,
>>  	.flush =3D ecryptfs_flush,
>>  	.release =3D ecryptfs_release,
>>
>=20
>=20


--=20
Jeff Mahoney
SUSE Labs


--m65s0MGGjqs866fxDAGV4wJDL7TUUTX3G--

--IMc50O4vXmtUf8ugJWx9nJQvdHdBKqxn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXfvfuAAoJEB57S2MheeWyhIgQAMaBZsR4QzfxDW9QG3laLbbQ
yZ47OXUTnHP0MGHJF2zvN+BiWq+lCDngN/HcJf1SxE6Hf70H4rUe+AbZ+53PfFwW
ZgyAjDWxILmRxjC1KNEWaaSLd9rFtDEncC+QrPcWDmUy+VSWuClFJZ7o4yAyMTn0
pqKT1AA0xRUs4VzB8dgUZvBCYp5U4r0AdVoEC+WF/GKYQgRlftCYwRBZY64Hu9IN
aFbSQ8kyJwds4qOWsK3AgDesXOXV/6NtnTxnxe/EuzJ9Syu904XhVEKT9sQvE4Ur
Cj23TOyhAenUVOFr3ngNo5HuZyp0d1ozsNLq+1FIvGhMUfUSoApRWII5i8iiK0hL
v31VykGH82y/7oDJYo/2clvXR3M3TZvnvWozmjB+5p8/carVRm58S48FCrMhf9Kb
DcLz9DaDXt26K7CBS0ejncGnUFAtgy4pHRX8dDb/O9cCWCEAZWnlJ00GeQvdKB7x
9BulgT4fNJV//AC2Roi45J3YnFlw1IfXoH7+AkJNZBF97VxMWI1bDaxLQeRHX/B8
c5BHoZuFurBte4JjcaDJio/TQn1OlNvu5bA4YmI7gyGpytBG9JbeWZ/b/J6HdQoL
QMX3LLF7v701oNG9uyb8amRtClAoFe+2RN/ybl2yuYaosdrzTBGT/XRqdt0yh5u4
8HBE+BEV+ekdbji71YwS
=0avc
-----END PGP SIGNATURE-----

--IMc50O4vXmtUf8ugJWx9nJQvdHdBKqxn8--
