From: "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Date: Wed, 17 Jun 2020 11:31:07 -0400
Message-ID: <20200617153107.GL266716@pick.fieldses.org>
References: <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
 <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li>
 <20200617144256.1028414-1-agruenba@redhat.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726836AbgFQPbQ (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 17 Jun 2020 11:31:16 -0400
Content-Disposition: inline
In-Reply-To: <20200617144256.1028414-1-agruenba@redhat.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: ecryptfs@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>, Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org, linux-nfs@vger.kernel.org

On Wed, Jun 17, 2020 at 04:42:56PM +0200, Andreas Gruenbacher wrote:
> Hi Bruce,
> 
> On Wed, Jun 17, 2020 at 2:58 AM J. Bruce Fields <bfields@redhat.com> wrote:
> > I think I'll send the following upstream.
> 
> looking good, but how about using a little helper for this?

I like it.  And the new comment's helpful too.

> 
> Also I'm not sure if ecryptfs gets this right, so taking the ecryptfs
> list into the CC.

Yes, questions I had while doing this:

	- cachefiles, ecrypfs, devtmpfs, and unix_mknod skip the check,
	  is that OK for all of them?  (Overlayfs too, I think?--that
	  code's harder to follow.

	- why don't vfs_{create,mknod,mkdir} do the IS_POSIXACL check
	  themselves?  Even if it's unnecessary for some callers, surely
	  it wouldn't be wrong?

I also wondered why both vfs_{create,mknod,mkdir} and the callers were
calling security hooks, but now I see that the callers are calling
security_path_* hooks and the vfs_ functions are calling
security_inode_* hooks, so I guess they're not redundant.

Though now I wonder why some of the callers (nfsd, overlayfs) are
skipping the security_path_* hooks.

--b.

> 
> Thanks,
> Andreas
> 
> --
> 
> Add a posix_acl_apply_umask helper for filesystems like nfsd to apply
> the umask before calling into vfs_create, vfs_mkdir, and vfs_mknod when
> necessary.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/namei.c                |  9 +++------
>  fs/nfsd/vfs.c             |  6 ++----
>  fs/overlayfs/dir.c        |  4 ++--
>  fs/posix_acl.c            | 15 +++++++++++++++
>  include/linux/posix_acl.h |  6 ++++++
>  5 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 72d4219c93ac..a68887d3a446 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3054,8 +3054,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		if (!IS_POSIXACL(dir->d_inode))
> -			mode &= ~current_umask();
> +		posix_acl_apply_umask(dir->d_inode, &mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(&nd->path, dentry, mode);
>  		else
> @@ -3580,8 +3579,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	posix_acl_apply_umask(path.dentry->d_inode, &mode);
>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (error)
>  		goto out;
> @@ -3657,8 +3655,7 @@ long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	posix_acl_apply_umask(path.dentry->d_inode, &mode);
>  	error = security_path_mkdir(&path, dentry, mode);
>  	if (!error)
>  		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d22a056da477..0c625b004b0c 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1226,8 +1226,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		iap->ia_mode = 0;
>  	iap->ia_mode = (iap->ia_mode & S_IALLUGO) | type;
>  
> -	if (!IS_POSIXACL(dirp))
> -		iap->ia_mode &= ~current_umask();
> +	posix_acl_apply_umask(dirp, &iap->ia_mode);
>  
>  	err = 0;
>  	host_err = 0;
> @@ -1461,8 +1460,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		goto out;
>  	}
>  
> -	if (!IS_POSIXACL(dirp))
> -		iap->ia_mode &= ~current_umask();
> +	posix_acl_apply_umask(dirp, &iap->ia_mode);
>  
>  	host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
>  	if (host_err < 0) {
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 1bba4813f9cb..4d98db2a0208 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -325,8 +325,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
>  	struct dentry *newdentry;
>  	int err;
>  
> -	if (!attr->hardlink && !IS_POSIXACL(udir))
> -		attr->mode &= ~current_umask();
> +	if (!attr->hardlink)
> +	       posix_acl_apply_umask(udir, &attr->mode);
>  
>  	inode_lock_nested(udir, I_MUTEX_PARENT);
>  	newdentry = ovl_create_real(udir,
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 95882b3f5f62..7ee647b74bc2 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -578,6 +578,21 @@ posix_acl_chmod(struct inode *inode, umode_t mode)
>  }
>  EXPORT_SYMBOL(posix_acl_chmod);
>  
> +/*
> + * On inode creation, filesystems with ACL support are expected to apply the
> + * umask when no ACL is inherited from the parent directory; this is usually
> + * done by posix_acl_create.  Filesystems like nfsd that call vfs_create,
> + * vfs_mknod, or vfs_mkdir directly are expected to call posix_acl_apply_umask
> + * to apply the umask first when necessary.
> + */
> +void
> +posix_acl_apply_umask(struct inode *inode, umode_t *mode)
> +{
> +	if (!IS_POSIXACL(inode))
> +		*mode &= ~current_umask();
> +}
> +EXPORT_SYMBOL(posix_acl_apply_umask);
> +
>  int
>  posix_acl_create(struct inode *dir, umode_t *mode,
>  		struct posix_acl **default_acl, struct posix_acl **acl)
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 90797f1b421d..76e402ff4f92 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -73,6 +73,7 @@ extern int set_posix_acl(struct inode *, int, struct posix_acl *);
>  
>  #ifdef CONFIG_FS_POSIX_ACL
>  extern int posix_acl_chmod(struct inode *, umode_t);
> +extern void posix_acl_apply_umask(struct inode *, umode_t *);
>  extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
>  		struct posix_acl **);
>  extern int posix_acl_update_mode(struct inode *, umode_t *, struct posix_acl **);
> @@ -99,6 +100,11 @@ static inline int posix_acl_chmod(struct inode *inode, umode_t mode)
>  
>  #define simple_set_acl		NULL
>  
> +static inline void posix_acl_apply_umask(struct inode *inode, umode_t *mode)
> +{
> +	*mode &= ~current_umask();
> +}
> +
>  static inline int simple_acl_create(struct inode *dir, struct inode *inode)
>  {
>  	return 0;
> 
> base-commit: 69119673bd50b176ded34032fadd41530fb5af21
> prerequisite-patch-id: a8319d40da9f70f478892d0bd8e63f540364b089
> -- 
> 2.26.2
> 

