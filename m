From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 00/16] Allow readpage to return a locked page
Date: Fri,  9 Oct 2020 15:30:48 +0100
Message-ID: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

Linus recently made the page lock more fair.  That means that the old
pattern where we returned from ->readpage with the page unlocked and
then attempted to re-lock it will send us to the back of the queue for
this page's lock.

A further benefit is that a synchronous readpage implementation allows
us to return an error to someone who might actually care about it.
There's no need to SetPageError, but I don't want to learn about how
a dozen filesystems handle I/O errors (hint: they're all different),
so I have not attempted to change that.  Except for iomap.

Ideally all filesystems would return from ->readpage with the page
Uptodate and Locked, but it's a bit painful to convert all the
asynchronous readpage implementations to synchronous.  The first 14
filesystems converted are already synchronous.  The last two patches
convert iomap to synchronous readpage.

This patchset is against iomap-for-next.  Andrew, it would make merging
the THP patchset much easier if you could merge at least the first patch
adding AOP_UPDATED_PAGE during the merge window which opens next week.

Matthew Wilcox (Oracle) (16):
  mm: Add AOP_UPDATED_PAGE return value
  mm: Inline wait_on_page_read into its one caller
  9p: Tell the VFS that readpage was synchronous
  afs: Tell the VFS that readpage was synchronous
  ceph: Tell the VFS that readpage was synchronous
  cifs: Tell the VFS that readpage was synchronous
  cramfs: Tell the VFS that readpage was synchronous
  ecryptfs: Tell the VFS that readpage was synchronous
  fuse: Tell the VFS that readpage was synchronous
  hostfs: Tell the VFS that readpage was synchronous
  jffs2: Tell the VFS that readpage was synchronous
  ubifs: Tell the VFS that readpage was synchronous
  udf: Tell the VFS that readpage was synchronous
  vboxsf: Tell the VFS that readpage was synchronous
  iomap: Inline iomap_iop_set_range_uptodate into its one caller
  iomap: Make readpage synchronous

 Documentation/filesystems/locking.rst |  7 +-
 Documentation/filesystems/vfs.rst     | 21 ++++--
 fs/9p/vfs_addr.c                      |  6 +-
 fs/afs/file.c                         |  3 +-
 fs/ceph/addr.c                        |  9 +--
 fs/cifs/file.c                        |  8 ++-
 fs/cramfs/inode.c                     |  5 +-
 fs/ecryptfs/mmap.c                    | 11 ++--
 fs/fuse/file.c                        |  2 +
 fs/hostfs/hostfs_kern.c               |  2 +
 fs/iomap/buffered-io.c                | 92 ++++++++++++++-------------
 fs/jffs2/file.c                       |  6 +-
 fs/ubifs/file.c                       | 16 +++--
 fs/udf/file.c                         |  3 +-
 fs/vboxsf/file.c                      |  2 +
 include/linux/fs.h                    |  5 ++
 mm/filemap.c                          | 33 +++++-----
 17 files changed, 135 insertions(+), 96 deletions(-)

-- 
2.28.0

