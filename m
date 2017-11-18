From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2] ecryptfs: sync before truncating lower inode
Date: Fri, 17 Nov 2017 18:49:22 -0600
Message-ID: <bf4f7f6b-53ab-adea-3e9e-786be3111f2b@canonical.com>
References: <20170418233649.78805-1-apronin@chromium.org>
 <20170426180215.42572-1-apronin@chromium.org>
 <CAKdAkRTvfsAnGujX43=Z=_ihZFQsRycy7mXHwLxTfQj1-w=-bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pMekTMrDvKSPF41l4W3jIgi4GPtAcGjto"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53801 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423643AbdKRAta (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 17 Nov 2017 19:49:30 -0500
In-Reply-To: <CAKdAkRTvfsAnGujX43=Z=_ihZFQsRycy7mXHwLxTfQj1-w=-bg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrey Pronin <apronin@chromium.org>
Cc: ecryptfs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Dmitry Torokhov <dtor@chromium.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMekTMrDvKSPF41l4W3jIgi4GPtAcGjto
Content-Type: multipart/mixed; boundary="OnBoiNNSaxhxK8vE1n0V0UMkIikWmSbBI";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andrey Pronin <apronin@chromium.org>
Cc: ecryptfs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Gwendal Grignou <gwendal@chromium.org>, Dmitry Torokhov <dtor@chromium.org>
Message-ID: <bf4f7f6b-53ab-adea-3e9e-786be3111f2b@canonical.com>
Subject: Re: [PATCH v2] ecryptfs: sync before truncating lower inode
References: <20170418233649.78805-1-apronin@chromium.org>
 <20170426180215.42572-1-apronin@chromium.org>
 <CAKdAkRTvfsAnGujX43=Z=_ihZFQsRycy7mXHwLxTfQj1-w=-bg@mail.gmail.com>
In-Reply-To: <CAKdAkRTvfsAnGujX43=Z=_ihZFQsRycy7mXHwLxTfQj1-w=-bg@mail.gmail.com>

--OnBoiNNSaxhxK8vE1n0V0UMkIikWmSbBI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/2017 06:58 PM, Dmitry Torokhov wrote:
> On Wed, Apr 26, 2017 at 11:02 AM, Andrey Pronin <apronin@chromium.org> =
wrote:
>> If the updated ecryptfs header data is not written to disk before
>> the lower file is truncated, a crash may leave the filesystem
>> in the state when the lower file truncation is journaled, while
>> the changes to the ecryptfs header are lost (if the underlying
>> filesystem is ext4 in data=3Dordered mode, for example). As a result,
>> upon remounting and repairing the file may have a pre-truncation
>> length and garbage data after the post-truncation end.
>>
>> To reproduce, make a snapshot of the underlying ext4 filesystem
>> mounted with data=3Dordered while asynchronously truncating to zero a
>> group of files in ecryptfs mounted on top. Mount ecryptfs for the
>> snapshot and check the contents of the group of files that was
>> being truncated. The following script reproduces it in almost 100%
>> of runs:
>>
>> cd /tmp
>> mkdir -p ./loop
>> dd if=3D/dev/zero of=3D./file.img bs=3D1M count=3D10
>> PW=3Dsecret
>>
>> LOOPDEV=3D`losetup --find --show ./file.img`
>> mkfs -t ext4 $LOOPDEV
>> mount -t ext4 -o rw,nodev,relatime,seclabel,commit=3D600,data=3Dordere=
d\
>>  $LOOPDEV ./loop
>> mkdir -p ./loop/vault ./loop/mount
>> mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=3Daes,\
>> ecryptfs_key_bytes=3D16,ecryptfs_unlink_sigs,ecryptfs_passthrough=3Dno=
,\
>> ecryptfs_enable_filename_crypto=3Dno,passphrase_passwd=3D"$PW",no_sig_=
cache\
>>  ./loop/vault ./loop/mount
>> for i in `seq 1 100`; do echo $i > ./loop/mount/test.$i; done
>> sync
>> for i in `seq 100 -1 1`; do truncate -s 0 ./loop/mount/test.$i; done &=

>> sleep 0.1; sync; cp ./file.img ./file.snap; sleep 1
>> umount ./loop/mount
>> umount ./loop
>> losetup -d $LOOPDEV
>>
>> LOOPDEV=3D`losetup --find --show ./file.snap`
>> mount -t ext4 -o rw,nodev,relatime,seclabel,commit=3D600,data=3Dordere=
d\
>>  $LOOPDEV ./loop
>> mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=3Daes,\
>> ecryptfs_key_bytes=3D16,ecryptfs_unlink_sigs,ecryptfs_passthrough=3Dno=
,\
>> ecryptfs_enable_filename_crypto=3Dno,passphrase_passwd=3D"$PW",no_sig_=
cache\
>>  ./loop/vault ./loop/mount
>> for i in `seq 1 100`; do
>>   if [ `stat -c %s ./loop/mount/test.$i` !=3D 0 ] &&
>>      [ `cat ./loop/mount/test.$i` !=3D $i ]; then
>>        echo -n "!!! garbage at $i: ";  cat ./loop/mount/test.$i; echo
>>   fi
>> done
>> umount ./loop/mount
>> umount ./loop
>> losetup -d $LOOPDEV
>>
>> Signed-off-by: Andrey Pronin <apronin@chromium.org>
>> ---
>>
>> Changes since v1:
>>  - Switched to datasync=3D1 for ecryptfs_fsync_lower() in truncate_upp=
er()\
>=20
> It looks like this patch got lost... Can we get it in?

It did get lost. I'll have another look at it and get it into an
upcoming -rc release. Thanks for the reminder!

Tyler

>=20
> Thanks!
>=20
>>
>>  fs/ecryptfs/ecryptfs_kernel.h |  1 +
>>  fs/ecryptfs/inode.c           |  6 ++++++
>>  fs/ecryptfs/read_write.c      | 22 ++++++++++++++++++++++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kern=
el.h
>> index f622a733f7ad..567698421270 100644
>> --- a/fs/ecryptfs/ecryptfs_kernel.h
>> +++ b/fs/ecryptfs/ecryptfs_kernel.h
>> @@ -689,6 +689,7 @@ int ecryptfs_read_lower_page_segment(struct page *=
page_for_ecryptfs,
>>                                      pgoff_t page_index,
>>                                      size_t offset_in_page, size_t siz=
e,
>>                                      struct inode *ecryptfs_inode);
>> +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync);=

>>  struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t ind=
ex);
>>  int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
>>                                  size_t *length_size);
>> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>> index 5eab400e2590..a96988ba6928 100644
>> --- a/fs/ecryptfs/inode.c
>> +++ b/fs/ecryptfs/inode.c
>> @@ -827,6 +827,12 @@ static int truncate_upper(struct dentry *dentry, =
struct iattr *ia,
>>                                "rc =3D [%d]\n", rc);
>>                         goto out;
>>                 }
>> +               rc =3D ecryptfs_fsync_lower(inode, 1);
>> +               if (rc) {
>> +                       printk(KERN_WARNING "Problem with ecryptfs_fsy=
nc_lower,"
>> +                              "continue without syncing; "
>> +                              "rc =3D [%d]\n", rc);
>> +               }
>>                 /* We are reducing the size of the ecryptfs file, and =
need to
>>                  * know if we need to reduce the size of the lower fil=
e. */
>>                 lower_size_before_truncate =3D
>> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
>> index 09fe622274e4..ba2dd6263875 100644
>> --- a/fs/ecryptfs/read_write.c
>> +++ b/fs/ecryptfs/read_write.c
>> @@ -271,3 +271,25 @@ int ecryptfs_read_lower_page_segment(struct page =
*page_for_ecryptfs,
>>         flush_dcache_page(page_for_ecryptfs);
>>         return rc;
>>  }
>> +
>> +/**
>> + * ecryptfs_fsync_lower
>> + * @ecryptfs_inode: The eCryptfs inode
>> + * @datasync: Only perform a fdatasync operation
>> + *
>> + * Write back data and metadata for the lower file to disk.  If @data=
sync is
>> + * set only metadata needed to access modified file data is written.
>> + *
>> + * Returns 0 on success; less than zero on error
>> + */
>> +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync)
>> +{
>> +       struct file *lower_file;
>> +
>> +       lower_file =3D ecryptfs_inode_to_private(ecryptfs_inode)->lowe=
r_file;
>> +       if (!lower_file)
>> +               return -EIO;
>> +       if (!lower_file->f_op->fsync)
>> +               return 0;
>> +       return vfs_fsync(lower_file, datasync);
>> +}
>> --
>> 2.13.0.rc0.306.g87b477812d-goog
>>
>=20
>=20
>=20



--OnBoiNNSaxhxK8vE1n0V0UMkIikWmSbBI--

--pMekTMrDvKSPF41l4W3jIgi4GPtAcGjto
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJaD4OSAAoJENaSAD2qAscKzeUQAIjXDgdYVrB+1GjOK3aU+tha
Q8SkTbnwcqYsU4RLR5ECMpLlzzLHzxOJkdsV4pQtIhnOXGH96nrB4y/TxElvOi71
FZsvLD1qdtsAo/6VkNo7HazvCp+BjB8iurv2/mppqmZvHAr6yAqXJUUmHpy7t96v
rTlMQH+eHPjHwHBvv31uDU/OXBFiZeoP+dFU3dTjvWVTGlPnW4kz0mj5kiBdd9tj
GFYZnHQKhsm+f5EXq0Ql0LUv5iyIJ5j25hwic1lm69ZALzAf7ZSUQ/hkBIzYok7b
uLy5qWwIgKZVp45R+hsDs9qvO7PQt5yJ0r51NtHAWpcSuGFHb3yTVdSB+t4qWP6S
nJatjaJyE+zGq0oMBfHb/c5vD9yecodQAr74sU1/Tulorz+/yhVzdhZLOOu6reqa
R7OMbE1RzZ3pSrpCphRxa/9b6NUbHwghq6FdGRUfTcUw0sj/AyU+wf0Yvb+ywcnU
mn5XKrGe9uyBFzpQcWXD5DfSoYavzt6qdDJm68Qo7no73buJfs+w1TC9QMTh7YRy
B0A6Df3dfHo/hgWcYfGKs8lEk98tZNRsMMM1v53xifwC5Oe8JMbpTUpfQKnQkOCr
5lHkAV5Tzd7kpYi2WOcHpH+gRLJj06wlV+wbtKrw4sBO5yqnCK+uBgPPxXTtA4la
YX/ugYx2TaeMsXJ0gAgJ
=qkPY
-----END PGP SIGNATURE-----

--pMekTMrDvKSPF41l4W3jIgi4GPtAcGjto--
