From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ecryptfs: Drop cast
Date: Thu, 26 Jun 2014 11:58:53 -0700
Message-ID: <1403809133.7977.63.camel@joe-AO725>
References: <20140626184233.GA4275@himangi-Dell>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140626184233.GA4275@himangi-Dell>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Fri, 2014-06-27 at 00:12 +0530, Himangi Saraogi wrote:
> This patch does away with casts on void * as they are unnecessary.
[]
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
[]
> @@ -53,7 +53,7 @@ static void unlock_dir(struct dentry *dir)
>  
>  static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
>  {
> -	if (ecryptfs_inode_to_lower(inode) == (struct inode *)lower_inode)
> +	if (ecryptfs_inode_to_lower(inode) == lower_inode)
>  		return 1;
>  	return 0;
>  }

True, but perhaps this should be

{
	return ecryptfs_inode_to_lower(inode) == lower_inode;
}


