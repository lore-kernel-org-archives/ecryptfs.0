From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH] eCryptfs: Revert to a writethrough cache model
Date: Fri, 13 Jul 2012 16:52:12 -0700
Message-ID: <20120713235211.GA24393@boyd>
References: <1341614432-1106-1-git-send-email-tyhicks@canonical.com>
 <4FFC1585.8080204@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41128 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab2GMXwR (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 13 Jul 2012 19:52:17 -0400
Content-Disposition: inline
In-Reply-To: <4FFC1585.8080204@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: ecryptfs@vger.kernel.org, Thieu Le <thieule@google.com>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-07-10 12:44:05, Colin Ian King wrote:
> On 06/07/12 23:40, Tyler Hicks wrote:
> >A change was made about a year ago to get eCryptfs to better utilize its
> >page cache during writes. The idea was to do the page encryption
> >operations during page writeback, rather than doing them when initially
> >writing into the page cache, to reduce the number of page encryption
> >operations during sequential writes. This meant that the encrypted page
> >would only be written to the lower filesystem during page writeback,
> >which was a change from how eCryptfs had previously wrote to the lower
> >filesystem in ecryptfs_write_end().
> >
> >The change caused a few eCryptfs-internal bugs that were shook out.
> >Unfortunately, more grave side effects have been identified that will
> >force changes outside of eCryptfs. Because the lower filesystem isn't
> >consulted until page writeback, eCryptfs has no way to pass lower write
> >errors (ENOSPC, mainly) back to userspace. Additionaly, it was reported
> >that quotas could be bypassed because of the way eCryptfs may sometimes
> >open the lower filesystem using a privileged kthread.
> >
> >It would be nice to resolve the latest issues, but it is best if the
> >eCryptfs commits be reverted to the old behavior in the meantime.
> >
> >This reverts:
> >32001d6f "eCryptfs: Flush file in vma close"
> >5be79de2 "eCryptfs: Flush dirty pages in setattr"
> >57db4e8d "ecryptfs: modify write path to encrypt page in writepage"
> >
> >Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> >Cc: Colin King <colin.king@canonical.com>
> >Cc: Thieu Le <thieule@google.com>
> >---
> >  fs/ecryptfs/file.c  |   33 ++-------------------------------
> >  fs/ecryptfs/inode.c |    6 ------
> >  fs/ecryptfs/mmap.c  |   39 +++++++++++++--------------------------
> >  3 files changed, 15 insertions(+), 63 deletions(-)
> >
> >diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> >index baf8b05..44ce5c6 100644
> >--- a/fs/ecryptfs/file.c
> >+++ b/fs/ecryptfs/file.c
> >@@ -138,27 +138,6 @@ out:
> >  	return rc;
> >  }
> >
> >-static void ecryptfs_vma_close(struct vm_area_struct *vma)
> >-{
> >-	filemap_write_and_wait(vma->vm_file->f_mapping);
> >-}
> >-
> >-static const struct vm_operations_struct ecryptfs_file_vm_ops =3D {
> >-	.close		=3D ecryptfs_vma_close,
> >-	.fault		=3D filemap_fault,
> >-};
> >-
> >-static int ecryptfs_file_mmap(struct file *file, struct vm_area_struct =
*vma)
> >-{
> >-	int rc;
> >-
> >-	rc =3D generic_file_mmap(file, vma);
> >-	if (!rc)
> >-		vma->vm_ops =3D &ecryptfs_file_vm_ops;
> >-
> >-	return rc;
> >-}
> >-
> >  struct kmem_cache *ecryptfs_file_info_cache;
> >
> >  static int read_or_initialize_metadata(struct dentry *dentry)
> >@@ -311,15 +290,7 @@ static int ecryptfs_release(struct inode *inode, st=
ruct file *file)
> >  static int
> >  ecryptfs_fsync(struct file *file, loff_t start, loff_t end, int datasy=
nc)
> >  {
> >-	int rc =3D 0;
> >-
> >-	rc =3D generic_file_fsync(file, start, end, datasync);
> >-	if (rc)
> >-		goto out;
> >-	rc =3D vfs_fsync_range(ecryptfs_file_to_lower(file), start, end,
> >-			     datasync);
> >-out:
> >-	return rc;
> >+	return vfs_fsync(ecryptfs_file_to_lower(file), datasync);
> >  }
> >
> >  static int ecryptfs_fasync(int fd, struct file *file, int flag)
> >@@ -388,7 +359,7 @@ const struct file_operations ecryptfs_main_fops =3D {
> >  #ifdef CONFIG_COMPAT
> >  	.compat_ioctl =3D ecryptfs_compat_ioctl,
> >  #endif
> >-	.mmap =3D ecryptfs_file_mmap,
> >+	.mmap =3D generic_file_mmap,
> >  	.open =3D ecryptfs_open,
> >  	.flush =3D ecryptfs_flush,
> >  	.release =3D ecryptfs_release,
> >diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> >index 2d4143f..769fb85 100644
> >--- a/fs/ecryptfs/inode.c
> >+++ b/fs/ecryptfs/inode.c
> >@@ -981,12 +981,6 @@ static int ecryptfs_setattr(struct dentry *dentry, =
struct iattr *ia)
> >  			goto out;
> >  	}
> >
> >-	if (S_ISREG(inode->i_mode)) {
> >-		rc =3D filemap_write_and_wait(inode->i_mapping);
> >-		if (rc)
> >-			goto out;
> >-		fsstack_copy_attr_all(inode, lower_inode);
> >-	}
> >  	memcpy(&lower_ia, ia, sizeof(lower_ia));
> >  	if (ia->ia_valid & ATTR_FILE)
> >  		lower_ia.ia_file =3D ecryptfs_file_to_lower(ia->ia_file);
> >diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> >index a46b3a8..bd1d57f 100644
> >--- a/fs/ecryptfs/mmap.c
> >+++ b/fs/ecryptfs/mmap.c
> >@@ -66,18 +66,6 @@ static int ecryptfs_writepage(struct page *page, stru=
ct writeback_control *wbc)
> >  {
> >  	int rc;
> >
> >-	/*
> >-	 * Refuse to write the page out if we are called from reclaim context
> >-	 * since our writepage() path may potentially allocate memory when
> >-	 * calling into the lower fs vfs_write() which may in turn invoke
> >-	 * us again.
> >-	 */
> >-	if (current->flags & PF_MEMALLOC) {
> >-		redirty_page_for_writepage(wbc, page);
> >-		rc =3D 0;
> >-		goto out;
> >-	}
> >-
> >  	rc =3D ecryptfs_encrypt_page(page);
> >  	if (rc) {
> >  		ecryptfs_printk(KERN_WARNING, "Error encrypting "
> >@@ -498,7 +486,6 @@ static int ecryptfs_write_end(struct file *file,
> >  	struct ecryptfs_crypt_stat *crypt_stat =3D
> >  		&ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
> >  	int rc;
> >-	int need_unlock_page =3D 1;
> >
> >  	ecryptfs_printk(KERN_DEBUG, "Calling fill_zeros_to_end_of_page"
> >  			"(page w/ index =3D [0x%.16lx], to =3D [%d])\n", index, to);
> >@@ -519,26 +506,26 @@ static int ecryptfs_write_end(struct file *file,
> >  			"zeros in page with index =3D [0x%.16lx]\n", index);
> >  		goto out;
> >  	}
> >-	set_page_dirty(page);
> >-	unlock_page(page);
> >-	need_unlock_page =3D 0;
> >+	rc =3D ecryptfs_encrypt_page(page);
> >+	if (rc) {
> >+		ecryptfs_printk(KERN_WARNING, "Error encrypting page (upper "
> >+				"index [0x%.16lx])\n", index);
> >+		goto out;
> >+	}
> >  	if (pos + copied > i_size_read(ecryptfs_inode)) {
> >  		i_size_write(ecryptfs_inode, pos + copied);
> >  		ecryptfs_printk(KERN_DEBUG, "Expanded file size to "
> >  			"[0x%.16llx]\n",
> >  			(unsigned long long)i_size_read(ecryptfs_inode));
> >-		balance_dirty_pages_ratelimited(mapping);
> >-		rc =3D ecryptfs_write_inode_size_to_metadata(ecryptfs_inode);
> >-		if (rc) {
> >-			printk(KERN_ERR "Error writing inode size to metadata; "
> >-			       "rc =3D [%d]\n", rc);
> >-			goto out;
> >-		}
> >  	}
> >-	rc =3D copied;
> >+	rc =3D ecryptfs_write_inode_size_to_metadata(ecryptfs_inode);
> >+	if (rc)
> >+		printk(KERN_ERR "Error writing inode size to metadata; "
> >+		       "rc =3D [%d]\n", rc);
> >+	else
> >+		rc =3D copied;
> >  out:
> >-	if (need_unlock_page)
> >-		unlock_page(page);
> >+	unlock_page(page);
> >  	page_cache_release(page);
> >  	return rc;
> >  }
> >
>=20
> This fixes the ENOSPC issue, I've tested this patch with ext2, ext3,
> ext4, xfs and btrfs lower file systems and it works fine. The patch
> also looks sane to me.
>=20
> Tested-by: Colin Ian King <colin.king@canonical.com>

Thanks, Colin! I've pushed the patch to the eCryptfs -next branch. I'll
get it in during the 3.6 merge window.

Tyler


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJQALSrAAoJENaSAD2qAscKfTsP/A08rtiriL9G9GmdDmvfOzBo
T4Z4LY8FvDQkvvKbH5B7oTwSIe8D5SgNCUCaiwnjnB+mhXnMb0PkL5MutR15T5eS
lmbcGv6OBU0diIzjbOA86Psxv+qg8Z9xXGcU7jfU8uvTYggUr3/jL2jjwX5XyOMZ
Xqe71Pvge0QG2KdrGnWUC645n0b32UAvA463uwFMuHd2th1L6jWPc9ZlDr694phO
/N4ib6gXgcXjAvAolw8Fuq7bisEEP5jh/AoaIm8v876FIKTYIg7VLBovtNXcGExH
HnFvImdLGTm4pikpZgbXNERhT6Cq+1kV4WJbPIJLn5J1SMUCwPPHaeWQS2ashOQW
TkMChoi/QriqAuDIpHgl2iDPY5OsYk3hay6QBXKnuRj5zMrCKephOE4869zfK67/
bSxYHbjRh+fPwRTL8phn4hfOB7TrkGqmVtJufs4UDpI32JDR50rYPprr1TbOZHX1
whnH2ZUx1yoptFFiZLaIcc+rYDYCG0razaTiYnYatR3pT2bfnBWAQ10KsOUMyLGy
1UKbt7fGhC5wBGurbuuUYVtYjwrVdic+yv6oq83Cmtwhi5RTX3sIerVdNGB/k8SU
KL4klfpco2laYyXN3gI3kClLk6K5ePNFQhmkI8M85MCIvqSew99F/54URVty2lXJ
Km+bOUEMYiijn+bNfcHI
=GAqd
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
