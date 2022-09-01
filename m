From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RESEND PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Date: Thu,  1 Sep 2022 18:07:04 +0200
Message-ID: <20220901160704.25701-1-fmdefrancesco@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiIAQHL (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 1 Sep 2022 12:07:11 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Tyler Hicks <code@tyhicks.com>, Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@digitalocean.com>, Amir Goldstein <amir73il@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, Theodore Ts'o <tytso@mit.edu>, Muchun Song <songmuchun@bytedance.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>, Ira Weiny <ira.weiny@intel.com>

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap=E2=80=99s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ecryptfs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ecryptfs.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I'm resending this patch because some recipients were missing in the
previous submission. In the meantime I'm also adding some more information
in the commit message. There are no changes in the code.

 fs/ecryptfs/crypto.c     | 8 ++++----
 fs/ecryptfs/read_write.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e3f5d7f3c8a0..03263ebcccc6 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -465,10 +465,10 @@ int ecryptfs_encrypt_page(struct page *page)
 	}
=20
 	lower_offset =3D lower_offset_for_page(crypt_stat, page);
-	enc_extent_virt =3D kmap(enc_extent_page);
+	enc_extent_virt =3D kmap_local_page(enc_extent_page);
 	rc =3D ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
-	kunmap(enc_extent_page);
+	kunmap_local(enc_extent_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to write lower page; rc =3D [%d]\n",
@@ -514,10 +514,10 @@ int ecryptfs_decrypt_page(struct page *page)
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
=20
 	lower_offset =3D lower_offset_for_page(crypt_stat, page);
-	page_virt =3D kmap(page);
+	page_virt =3D kmap_local_page(page);
 	rc =3D ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
-	kunmap(page);
+	kunmap_local(page_virt);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR,
 			"Error attempting to read lower page; rc =3D [%d]\n",
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 60bdcaddcbe5..5edf027c8359 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -64,11 +64,11 @@ int ecryptfs_write_lower_page_segment(struct inode *ecr=
yptfs_inode,
=20
 	offset =3D ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
 		  + offset_in_page);
-	virt =3D kmap(page_for_lower);
+	virt =3D kmap_local_page(page_for_lower);
 	rc =3D ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
 	if (rc > 0)
 		rc =3D 0;
-	kunmap(page_for_lower);
+	kunmap_local(virt);
 	return rc;
 }
=20
@@ -253,11 +253,11 @@ int ecryptfs_read_lower_page_segment(struct page *pag=
e_for_ecryptfs,
 	int rc;
=20
 	offset =3D ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
-	virt =3D kmap(page_for_ecryptfs);
+	virt =3D kmap_local_page(page_for_ecryptfs);
 	rc =3D ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
 	if (rc > 0)
 		rc =3D 0;
-	kunmap(page_for_ecryptfs);
+	kunmap_local(virt);
 	flush_dcache_page(page_for_ecryptfs);
 	return rc;
 }
--=20
2.37.2

