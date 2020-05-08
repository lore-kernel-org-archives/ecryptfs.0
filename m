From: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: Re: [PATCH] ecryptfs: Fix inodes not being evicted until unmount
Date: Fri, 8 May 2020 09:32:58 -0500
Message-ID: <20200508143257.GA7181@jeffrey-work>
References: <20200508143131.GA7116@jeffrey-work>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-dm3gcc02on2092.outbound.protection.outlook.com ([40.107.91.92]:4255
        "EHLO GCC02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbgEHOdC (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Fri, 8 May 2020 10:33:02 -0400
Content-Disposition: inline
In-Reply-To: <20200508143131.GA7116@jeffrey-work>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.robertson@starlab.io

Steps to reproduce issue:
Mount nfs
Inside the nfs mount, create back and front directories for ecryptfs
Use ecryptfs to mount one directory onto the other
Create a few files inside the ecryptfs mount
Set ftrace to monitor ecryptfs_do_unlink() and ecryptfs_evict_inode()
Delete files
Unmount ecryptfs

ftrace output before patch:
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 1)               |  /* Tracing enabled */
 1)               |  /* Writing to files */
 1)               |  /* Unlinking first file */
 0) * 27804.34 us |  ecryptfs_do_unlink();
 1)               |  /* rm'ing second file */
 ------------------------------------------
 0)  unlink-1384   =>    rm-1385
 ------------------------------------------
 
 0) * 32828.63 us |  ecryptfs_do_unlink();
 1)               |  /* Unmounting eCryptFS */
 ------------------------------------------
 1)  trace-a-1365  =>  umount-1387
 ------------------------------------------
 
 1)   2.408 us    |  ecryptfs_evict_inode();
 1)   8.914 us    |  ecryptfs_evict_inode();
 1)   3.344 us    |  ecryptfs_evict_inode();

ftrace output after patch:
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  /* Tracing enabled */
 0)               |  /* Writing to files */
 0)               |  /* Unlinking first file */
 1) * 24728.81 us |  ecryptfs_do_unlink();
 1) + 20.923 us   |  ecryptfs_evict_inode();
 0)               |  /* rm'ing second file */
 ------------------------------------------
 1)  unlink-1333   =>    rm-1334
 ------------------------------------------
 
 1) * 41093.71 us |  ecryptfs_do_unlink();
 1) + 11.384 us   |  ecryptfs_evict_inode();
 0)               |  /* Unmounting eCryptFS */
 ------------------------------------------
 0)  trace-a-1314  =>  umount-1336
 ------------------------------------------
 
 0)   2.986 us    |  ecryptfs_evict_inode();

On Fri, May 08, 2020 at 09:31:33AM -0500, Jeffrey Mitchell wrote:
> On asynchronous base filesystems like NFS, eCryptFS leaves inodes for
> deleted files in the cache until unmounting. Change call in
> ecryptfs_do_unlink() from set_nlink() to drop_nlink() in order to reliably
> evict inodes from the cache even on top of NFS.
> 
> Signed-off-by: Dan Robertson <daniel.robertson@starlab.io>
> Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
> ---
>  fs/ecryptfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d..f7594b6 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -147,7 +147,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
>  		goto out_unlock;
>  	}
>  	fsstack_copy_attr_times(dir, lower_dir_inode);
> -	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
> +	drop_nlink(inode);
>  	inode->i_ctime = dir->i_ctime;
>  out_unlock:
>  	dput(lower_dentry);
> -- 
> 2.7.4
> 
