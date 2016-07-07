From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
Date: Thu, 7 Jul 2016 18:22:05 -0500
Message-ID: <577EE41D.6000900@canonical.com>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <20160705215740.GA14388@pc.thejh.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aEKgWLaxgUx92DRnEDbfr5RiILQRFAjJd"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160705215740.GA14388@pc.thejh.net>
Sender: stable-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Jann Horn <jann@thejh.net>, jeffm@suse.com
Cc: ecryptfs@vger.kernel.org, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEKgWLaxgUx92DRnEDbfr5RiILQRFAjJd
Content-Type: multipart/mixed; boundary="jslmn5xdbBRbnEeSncjMxnbxaNBkbfiIQ"
From: Tyler Hicks <tyhicks@canonical.com>
To: Jann Horn <jann@thejh.net>, jeffm@suse.com
Cc: ecryptfs@vger.kernel.org, stable@vger.kernel.org
Message-ID: <577EE41D.6000900@canonical.com>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs doesn't
 support it
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
 <1467754350-8995-2-git-send-email-jeffm@suse.com>
 <20160705215740.GA14388@pc.thejh.net>
In-Reply-To: <20160705215740.GA14388@pc.thejh.net>

--jslmn5xdbBRbnEeSncjMxnbxaNBkbfiIQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/05/2016 04:57 PM, Jann Horn wrote:
> On Tue, Jul 05, 2016 at 05:32:30PM -0400, jeffm@suse.com wrote:
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
>> +	/*
>> +	 * Don't allow mmap on top of file systems that don't support it
>> +	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
>> +	 * allows recursive mounting, this will need to be extended.
>=20
> Or if another new stacking filesystem appears whose f_op->mmap just for=
wards
> to lower_f_op->mmap - but thinking about it, in that scenario, my patch=

> would stop working, too.
>=20
> At this point, I dislike both this patch and my own one because of thei=
r
> lack of robustness. Well, at least e54ad7f1ee263ffa5a2de9c609d58dfa27b2=
1cd9
> should be solid. :/

I agree that neither approach provides long term protection from the
attack but they fix the immediate issue at hand. Therefore, I think we
need to move forward with what we have now.

Tyler

>=20
>=20
>> +	 */
>> +	if (!d_inode(dentry)->i_fop->mmap)
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
>> --=20
>> 2.7.1
>>



--jslmn5xdbBRbnEeSncjMxnbxaNBkbfiIQ--

--aEKgWLaxgUx92DRnEDbfr5RiILQRFAjJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXfuQdAAoJENaSAD2qAscKh4sQAI2advPthC2D0nOVCrYCa8gO
N1jyFupc3YjrObDh0n2xzruQQh4DgPUp2eIgaHQlsAs/WY77IEXT7M3bRVs6IdCc
mmUrpoajbT09jrtzVgdF2pkfBiVOJsSD0CHYp3S4i69LGA1NV8RA7pqK8fQI392K
I59OXqDiuuKd9g+Gs8oKF/pvEsMUqkaDTX+aZRwCGYP0qy3WrdoynBzzEF0rAHg8
AwcFdnSL9R/N1eEMaYFoId/Fr747fSJ4GUNZK5lhaGek2Ul7wCmIurnboiYIgKqD
8J2Mi2NM8kEs5PLnkiwfBurqobbNqT9rGRUt9KXQTS1TFYdLaml8zXRUEVmPhnfa
h/bfkFjEBWJ7iBj/zQlJvZfTBvojsi+zXlXlKEWfopSUiORHywY1fCeWFfYAN5+B
xNGvrste/Ib9OcIMKGsUlodnGLvbs4V5tbViJdmuusM9HzojFamvFxuJ3lIQWBYb
oY+Z125NZ6ROlbn0Dc2tulspADDyYDeBvv5FryAbcKbCGFo6NDvq0AuzECMV2r9P
qMiSIoeeZbN5xojZl+fOYFLLwixeJLi2WEIHw5CU/WyCgd0rAqzTxhnLWX1Oq4Sk
Rh5oSg7IIjrNvBTMQdGThN8bSL7acwv88SQe74hKpqlkyJSOzOectt0l5JGZq2lE
AcCVGhZCbyhegTQBrHXQ
=lMmq
-----END PGP SIGNATURE-----

--aEKgWLaxgUx92DRnEDbfr5RiILQRFAjJd--
