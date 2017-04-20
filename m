From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] CHROMIUM: ecryptfs: sync before truncating lower inode
Date: Thu, 20 Apr 2017 18:27:52 -0500
Message-ID: <8ce53762-80fb-2e1d-07bb-95aff17c5d33@canonical.com>
References: <20170418233649.78805-1-apronin@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bgUf6wmhbpDQ0KVro7hPo0oTI1C3bioCq"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43205 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033011AbdDTX2C (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 20 Apr 2017 19:28:02 -0400
In-Reply-To: <20170418233649.78805-1-apronin@chromium.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Andrey Pronin <apronin@chromium.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, gwendal@chromium.org, dtor@chromium.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bgUf6wmhbpDQ0KVro7hPo0oTI1C3bioCq
Content-Type: multipart/mixed; boundary="417b4Rf6IDdOqtDuVBKbiXJjSdG3t5ima";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Andrey Pronin <apronin@chromium.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 gwendal@chromium.org, dtor@chromium.org
Message-ID: <8ce53762-80fb-2e1d-07bb-95aff17c5d33@canonical.com>
Subject: Re: [PATCH] CHROMIUM: ecryptfs: sync before truncating lower inode
References: <20170418233649.78805-1-apronin@chromium.org>
In-Reply-To: <20170418233649.78805-1-apronin@chromium.org>

--417b4Rf6IDdOqtDuVBKbiXJjSdG3t5ima
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 06:36 PM, Andrey Pronin wrote:
> If the updated ecryptfs header data is not written to disk before
> the lower file is truncated, a crash may leave the filesystem
> in the state when the lower file truncation is journaled, while
> the changes to the ecryptfs header are lost (if the underlying
> filesystem is ext4 in data=3Dordered mode, for example). As a result,
> upon remounting and repairing the file may have a pre-truncation
> length and garbage data after the post-truncation end.
>=20
> To reproduce, make a snapshot of the underlying ext4 filesystem
> mounted with data=3Dordered while asynchronously truncating to zero a
> group of files in ecryptfs mounted on top. Mount ecryptfs for the
> snapshot and check the contents of the group of files that was
> being truncated. The following script reproduces it in almost 100%
> of runs:
>=20
> cd /tmp
> mkdir -p ./loop
> dd if=3D/dev/zero of=3D./file.img bs=3D1M count=3D10
> PW=3Dsecret
>=20
> LOOPDEV=3D`losetup --find --show ./file.img`
> mkfs -t ext4 $LOOPDEV
> mount -t ext4 -o rw,nodev,relatime,seclabel,commit=3D600,data=3Dordered=
\
>  $LOOPDEV ./loop
> mkdir -p ./loop/vault ./loop/mount
> mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=3Daes,\
> ecryptfs_key_bytes=3D16,ecryptfs_unlink_sigs,ecryptfs_passthrough=3Dno,=
\
> ecryptfs_enable_filename_crypto=3Dno,passphrase_passwd=3D"$PW",no_sig_c=
ache\
>  ./loop/vault ./loop/mount
> for i in `seq 1 100`; do echo $i > ./loop/mount/test.$i; done
> sync
> for i in `seq 100 -1 1`; do truncate -s 0 ./loop/mount/test.$i; done &
> sleep 0.1; sync; cp ./file.img ./file.snap; sleep 1
> umount ./loop/mount
> umount ./loop
> losetup -d $LOOPDEV
>=20
> LOOPDEV=3D`losetup --find --show ./file.snap`
> mount -t ext4 -o rw,nodev,relatime,seclabel,commit=3D600,data=3Dordered=
\
>  $LOOPDEV ./loop
> mount -t ecryptfs -o rw,relatime,seclabel,ecryptfs_cipher=3Daes,\
> ecryptfs_key_bytes=3D16,ecryptfs_unlink_sigs,ecryptfs_passthrough=3Dno,=
\
> ecryptfs_enable_filename_crypto=3Dno,passphrase_passwd=3D"$PW",no_sig_c=
ache\
>  ./loop/vault ./loop/mount
> for i in `seq 1 100`; do
>   if [ `stat -c %s ./loop/mount/test.$i` !=3D 0 ] &&
>      [ `cat ./loop/mount/test.$i` !=3D $i ]; then
>        echo -n "!!! garbage at $i: ";  cat ./loop/mount/test.$i; echo
>   fi
> done
> umount ./loop/mount
> umount ./loop
> losetup -d $LOOPDEV
>=20
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> ---

Hi Andrey - Thanks for the patch and for the test case. I was able to
reproduce the bug using the test case. I have some comments below.

>  fs/ecryptfs/ecryptfs_kernel.h |  1 +
>  fs/ecryptfs/inode.c           |  6 ++++++
>  fs/ecryptfs/read_write.c      | 22 ++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>=20
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kerne=
l.h
> index f622a733f7ad..567698421270 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -689,6 +689,7 @@ int ecryptfs_read_lower_page_segment(struct page *p=
age_for_ecryptfs,
>  				     pgoff_t page_index,
>  				     size_t offset_in_page, size_t size,
>  				     struct inode *ecryptfs_inode);
> +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync);
>  struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t inde=
x);
>  int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
>  				 size_t *length_size);
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 5eab400e2590..e7eb8ea154d2 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -827,6 +827,12 @@ static int truncate_upper(struct dentry *dentry, s=
truct iattr *ia,
>  			       "rc =3D [%d]\n", rc);
>  			goto out;
>  		}
> +		rc =3D ecryptfs_fsync_lower(inode, 0);

Wouldn't we want datasync to be true in this situation?


I am also wondering if it'd be best to sync from inside
ecryptfs_write_inode_size_to_metadata() itself. Your test case shows
that the code path when truncating an inode size to zero is affected
but, from what I can tell, the code path when increasing an inode size
should also be affected:

 truncate_upper -> ecryptfs_write() ->
  ecryptfs_write_inode_size_to_metdata()

Did you consider/test doing that?

Thanks again!

Tyler

> +		if (rc) {
> +			printk(KERN_WARNING "Problem with ecryptfs_fsync_lower,"
> +			       "continue without syncing; "
> +			       "rc =3D [%d]\n", rc);
> +		}
>  		/* We are reducing the size of the ecryptfs file, and need to
>  		 * know if we need to reduce the size of the lower file. */
>  		lower_size_before_truncate =3D
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 09fe622274e4..ba2dd6263875 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -271,3 +271,25 @@ int ecryptfs_read_lower_page_segment(struct page *=
page_for_ecryptfs,
>  	flush_dcache_page(page_for_ecryptfs);
>  	return rc;
>  }
> +
> +/**
> + * ecryptfs_fsync_lower
> + * @ecryptfs_inode: The eCryptfs inode
> + * @datasync: Only perform a fdatasync operation
> + *
> + * Write back data and metadata for the lower file to disk.  If @datas=
ync is
> + * set only metadata needed to access modified file data is written.
> + *
> + * Returns 0 on success; less than zero on error
> + */
> +int ecryptfs_fsync_lower(struct inode *ecryptfs_inode, int datasync)
> +{
> +	struct file *lower_file;
> +
> +	lower_file =3D ecryptfs_inode_to_private(ecryptfs_inode)->lower_file;=

> +	if (!lower_file)
> +		return -EIO;
> +	if (!lower_file->f_op->fsync)
> +		return 0;
> +	return vfs_fsync(lower_file, datasync);
> +}
>=20



--417b4Rf6IDdOqtDuVBKbiXJjSdG3t5ima--

--bgUf6wmhbpDQ0KVro7hPo0oTI1C3bioCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY+UP5AAoJENaSAD2qAscKdbsP/ReDkSSRx99cqPTaznHMb7rn
u8fgS7kriUqJUFROibHsD6z6ZBNBpmKfjmHtndmen+qreemK3PiE5ZTjBRh5kqmC
azNNZ5OlAIZKNKHMgMSSmK5TO+eREjeF8xbI1QQNHEAFosXUfgfNswv29ykxXGwP
8VKf6Vy+uWN8OOooOH0KmW5ZWHdaZbY3G3e4T9OVCgLfJ8UMfGk/fXkncmztEz/b
J135mRCnaXEjgCi4/+FiZKwMJTaICY0CSiX3URF3QNL2wfzF8J/ldmWRunxQJ+Di
/quqMrW8tzpe/iwWQ90bh056W1r3Uwf5VJvmjwhJNCwbPmA2LmnBJu/jveZ+UUoJ
7wTrRFFDXWAHOUFd0RGgS6SIav/37t+/6PNvFTrAkqUoVpgITSl8GpMUGzJXkS+L
zjrSmyeFfiQKTdIg9dB0mbwHmeWn5/3GcWSPzDDah5cxomtRhf2InnyTmGqEr6U2
2c+/73YugCW+Bc+J5wlUGlgjc/34+nl8bi/KRoK5R0orAUnNUGGV4aX69WDdkUBs
n7tWKS4w97VuoAyP/KJXfqLsuqGTPRQg0Xihr3Y96mBr0JBZDjY1N2SiehBrswJd
4EnBwAlaQgdHhN/CPgGNLHrMhNJi1RtHB6rLxHLaP/vJPJ34a8OErtgtPXtCNi1J
wU1IlWn2FlYvC8lFfaT1
=495l
-----END PGP SIGNATURE-----

--bgUf6wmhbpDQ0KVro7hPo0oTI1C3bioCq--
