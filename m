From: Henry Jensen <hjensen@gmx.de>
Subject: Re: [PATCH] eCryptfs: Fix directory open regression in linux-stable
Date: Thu, 7 Jul 2016 16:24:31 +0200
Message-ID: <20160707162431.6c7edb7e@subnote.jensen.local>
References: <1467171581-17654-1-git-send-email-tyhicks@canonical.com>
	<6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58032 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbcGGOZE (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Thu, 7 Jul 2016 10:25:04 -0400
Received: from subnote.jensen.local ([92.50.100.226]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0MYtId-1aq0Jj0z6B-00VjI4 for
 <ecryptfs@vger.kernel.org>; Thu, 07 Jul 2016 16:24:56 +0200
In-Reply-To: <6fe5b584-62b4-c238-916a-3bd68f0a7f20@suse.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

Hello,

it seems, that none of the suggested patches will be included in
4.4.15? GKH doesn't mention one in his mail "4.4.15-stable review" on
the stable list.

Regards,

Henry



On Tue, 5 Jul 2016 17:14:20 -0400
Jeff Mahoney <jeffm@suse.com> wrote:

> On 6/28/16 11:39 PM, Tyler Hicks wrote:
> > Cherry-picking mainline commit 2f36db71009304b3f0b95afacd8eba1f9f046b87
> > introduces a regression in eCryptfs when mainline commit
> > 6a480a7842545ec520a91730209ec0bae41694c1 (4.6+) is not present. The
> > regression causes all attempts at opening directory files to fail with
> > EMEDIUMTYPE when the lower filesystem's file_operations for directory
> > files do not implement mmap.
> > 
> > This is a simple fix that allows the check for the lower file's mmap
> > implementation to be ignored if the lower file is a directory.  
> 
> I have a different fix that I believe is more correct for this.  I would
> have posted it in response to the original fix if it were ever actually
> posted for public discussion.
> 
> Denying open is the wrong place to fix this.  It's too heavy a hammer
> and, as we see here, a bit fragile.
> 
> The right fix is to deny the mmap call instead.
> 
> -Jeff
> 
> > Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> > Tested-by: Tyler Hicks <tyhicks@canonical.com> # 4.4.y, 3.18.y
> > Cc: <stable@vger.kernel.org> # 4.5-
> > ---
> >  fs/ecryptfs/kthread.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
> > index e818f5a..b9faeab 100644
> > --- a/fs/ecryptfs/kthread.c
> > +++ b/fs/ecryptfs/kthread.c
> > @@ -171,7 +171,7 @@ int ecryptfs_privileged_open(struct file **lower_file,
> >  		goto out;
> >  	}
> >  have_file:
> > -	if ((*lower_file)->f_op->mmap == NULL) {
> > +	if ((*lower_file)->f_op->mmap == NULL && !d_is_dir(lower_dentry)) {
> >  		fput(*lower_file);
> >  		*lower_file = NULL;
> >  		rc = -EMEDIUMTYPE;
> >   
> 
> 
> -- 
> Jeff Mahoney
> SUSE Labs
> 
