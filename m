From: Henry Jensen <hjensen@gmx.de>
Subject: Re: [PATCH 2/2] ecryptfs: don't allow mmap when the lower fs
 doesn't support it
Date: Tue, 2 Aug 2016 14:50:05 +0200
Message-ID: <20160802145005.3a7ed0f6@pc-198.iww-online.de>
References: <1467754350-8995-1-git-send-email-jeffm@suse.com>
	<1467754350-8995-2-git-send-email-jeffm@suse.com>
	<577EE3A8.4030106@canonical.com>
	<06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64365 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965825AbcHBM5R (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 2 Aug 2016 08:57:17 -0400
In-Reply-To: <06093b3e-1364-715d-4db1-c9b4756ae2bf@suse.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, Jann Horn <jann@thejh.net>, stable@vger.kernel.org

Hello,

is there any new status? We are meanwhile at kernel 4.4.16 LTS and
ecryptfs is still broken there.

Regards,

Henry


On Thu, 7 Jul 2016 20:46:34 -0400
Jeff Mahoney <jeffm@suse.com> wrote:

> On 7/7/16 7:20 PM, Tyler Hicks wrote:
> > On 07/05/2016 04:32 PM, jeffm@suse.com wrote:  
> >> From: Jeff Mahoney <jeffm@suse.com>
> >>
> >> There are legitimate reasons to disallow mmap on certain files, notably
> >> in sysfs or procfs.  We shouldn't emulate mmap support on file systems
> >> that don't offer support natively.
> >>
> >> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> >> ---
> >>  fs/ecryptfs/file.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> >> index 7000b96..4aaa656 100644
> >> --- a/fs/ecryptfs/file.c
> >> +++ b/fs/ecryptfs/file.c
> >> @@ -169,6 +169,20 @@ out:
> >>  	return rc;
> >>  }
> >>  
> >> +
> >> +static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma)
> >> +{
> >> +	struct dentry *dentry = ecryptfs_dentry_to_lower(file_dentry(file));  
> > 
> > This should be:
> > 
> > 	struct file *lower_file = ecryptfs_file_to_lower(file);
> >   
> >> +	/*
> >> +	 * Don't allow mmap on top of file systems that don't support it
> >> +	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
> >> +	 * allows recursive mounting, this will need to be extended.
> >> +	 */
> >> +	if (!d_inode(dentry)->i_fop->mmap)  
> > 
> > and then:
> > 
> > 	if (!lower_file->f_op->mmap)
> > 
> > 
> > I'll make these simple changes, add stable to cc in the patch tags, and
> > push to Linus.  
> 
> Oh, whoops. Yeah, that's better.
> 
> Thanks,
> 
> -Jeff
> 
> > Thanks again!
> > 
> > Tyler
> >   
> >> +		return -ENODEV;
> >> +	return generic_file_mmap(file, vma);
> >> +}
> >> +
> >>  /**
> >>   * ecryptfs_open
> >>   * @inode: inode speciying file to open
> >> @@ -403,7 +417,7 @@ const struct file_operations ecryptfs_main_fops = {
> >>  #ifdef CONFIG_COMPAT
> >>  	.compat_ioctl = ecryptfs_compat_ioctl,
> >>  #endif
> >> -	.mmap = generic_file_mmap,
> >> +	.mmap = ecryptfs_mmap,
> >>  	.open = ecryptfs_open,
> >>  	.flush = ecryptfs_flush,
> >>  	.release = ecryptfs_release,
> >>  
> > 
> >   
> 
> 
> -- 
> Jeff Mahoney
> SUSE Labs
> 
