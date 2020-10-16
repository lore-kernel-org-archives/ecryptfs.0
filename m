From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v3 00/18] Allow readpage to return a locked page
Date: Fri, 16 Oct 2020 17:04:25 +0100
Message-ID: <20201016160443.18685-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410556AbgJPQEs (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 16 Oct 2020 12:04:48 -0400
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Hans de Goede <hdegoede@redhat.com>

I've dropped the conversion of readpage implementations to synchronous
from this patchset.  I realised I'd neglected the requirement for making
the sleep killable, and that turns out to be more convoluted to fix.

So these patches add:
 - An error-path bugfix for cachefiles.
 - The ability for the filesystem to tell the caller of ->readpage
   that the read was successful and the page was not unlocked.  This is
   a performance improvement for some scenarios that I think are rare.
 - Mildly improved error handling for ext4.

v2: https://lore.kernel.org/linux-fsdevel/20201009143104.22673-1-willy@infradead.org/
v1: https://lore.kernel.org/linux-fsdevel/20200917151050.5363-1-willy@infradead.org/
Matthew Wilcox (Oracle) (18):
  cachefiles: Handle readpage error correctly
  swap: Call aops->readahead if appropriate
  fs: Add AOP_UPDATED_PAGE return value
  mm/filemap: Inline wait_on_page_read into its one caller
  9p: Tell the VFS that readpage was synchronous
  afs: Tell the VFS that readpage was synchronous
  ceph: Tell the VFS that readpage was synchronous
  cifs: Tell the VFS that readpage was synchronous
  cramfs: Tell the VFS that readpage was synchronous
  ecryptfs: Tell the VFS that readpage was synchronous
  ext4: Tell the VFS that readpage was synchronous
  ext4: Return error from ext4_readpage
  fuse: Tell the VFS that readpage was synchronous
  hostfs: Tell the VFS that readpage was synchronous
  jffs2: Tell the VFS that readpage was synchronous
  ubifs: Tell the VFS that readpage was synchronous
  udf: Tell the VFS that readpage was synchronous
  vboxsf: Tell the VFS that readpage was synchronous

 Documentation/filesystems/locking.rst |  7 +++---
 Documentation/filesystems/vfs.rst     | 21 +++++++++++------
 fs/9p/vfs_addr.c                      |  6 ++++-
 fs/afs/file.c                         |  3 ++-
 fs/buffer.c                           | 15 +++++++-----
 fs/cachefiles/rdwr.c                  |  9 ++++++++
 fs/ceph/addr.c                        |  9 ++++----
 fs/cifs/file.c                        |  8 +++++--
 fs/cramfs/inode.c                     |  5 ++--
 fs/ecryptfs/mmap.c                    | 11 +++++----
 fs/ext4/inline.c                      |  9 +++++---
 fs/ext4/readpage.c                    | 24 +++++++++++--------
 fs/fuse/file.c                        |  2 ++
 fs/hostfs/hostfs_kern.c               |  2 ++
 fs/jffs2/file.c                       |  6 +++--
 fs/ubifs/file.c                       | 16 ++++++++-----
 fs/udf/file.c                         |  3 +--
 fs/vboxsf/file.c                      |  2 ++
 include/linux/fs.h                    |  5 ++++
 mm/filemap.c                          | 33 +++++++++++++--------------
 mm/page_io.c                          | 27 ++++++++++++++++++++--
 mm/readahead.c                        |  3 ++-
 22 files changed, 151 insertions(+), 75 deletions(-)

-- 
2.28.0

