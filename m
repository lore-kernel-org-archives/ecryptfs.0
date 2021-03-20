From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] ecryptfs: get rid of pointless dget/dput in
 ->symlink() and ->link()
Date: Sat, 20 Mar 2021 21:55:04 +0000
Message-ID: <YFZvOLzj5eytBV/Q@zeniv-ca.linux.org.uk>
References: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35574 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhCTVzF (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Sat, 20 Mar 2021 17:55:05 -0400
Content-Disposition: inline
In-Reply-To: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 09:51:05PM +0000, Al Viro wrote:
> calls in ->unlink(), ->rmdir() and ->rename() make sense - we want
> to prevent the underlying dentries going negative there.  In
> ->symlink() and ->link() they are absolutely pointless.

[snip]

	FWIW, that patch series can also be found in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.ecryptfs;
Shortlog:
Al Viro (4):
      ecryptfs: get rid of pointless dget/dput in ->symlink() and ->link()
      ecryptfs: saner API for lock_parent()
      ecryptfs: get rid of unused accessors
      ecryptfs: ecryptfs_dentry_info->crypt_stat is never used
Diffstat:
 fs/ecryptfs/ecryptfs_kernel.h |  17 +----
 fs/ecryptfs/inode.c           | 163 +++++++++++++++++++-----------------------
 2 files changed, 75 insertions(+), 105 deletions(-)
