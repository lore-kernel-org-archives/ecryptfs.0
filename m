From: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: Re: [PATCH] ecryptfs: Fix inodes not being evicted until unmount
Date: Tue, 2 Feb 2021 09:22:55 -0600
Message-ID: <20210202152255.GA3383@jeffrey-work-20.04>
References: <20201218190730.141761-1-jeffrey.mitchell@starlab.io>
 <20210130170640.GA58096@elm>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-bl2gcc02on2123.outbound.protection.outlook.com ([40.107.89.123]:37632
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235283AbhBBPXx (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Tue, 2 Feb 2021 10:23:53 -0500
Content-Disposition: inline
In-Reply-To: <20210130170640.GA58096@elm>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Robertson <daniel.robertson@starlab.io>

On Sat, Jan 30, 2021 at 11:06:40AM -0600, Tyler Hicks wrote:
> Hey Jeffrey and Dan - thanks for the patch! Unfortunately, I think this
> would allow the eCryptfs inode's nlink count to get out of sync with the
> lower inode's nlink count in the case of direct manipulation to the
> lower filesystem.

Hmm. What if I instead synchronize it before calling vfs_unlink(), then
call drop_nlink() if vfs_unlink() succeeds?

> Is the condition that you're trying to fix a result of going through the
> this code path?
> 
>  ecryptfs_unlink() -> ecryptfs_do_unlink() -> vfs_unlink() -> nfs_unlink() -> nfs_sillyrename() -> nfs_async_unlink()

Yes, that is the code path that causes it.

V/R,
Jeffrey Mitchell
