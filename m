From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Linus GIT (3.3.0-rc6+) -- INFO: possible circular locking
 dependency detected
Date: Mon, 5 Mar 2012 21:35:58 +0000
Message-ID: <20120305213557.GO23916@ZenIV.linux.org.uk>
References: <CAHFgRy-V3ZFK6QrC2++Rvyi4e_f-03Xdr9sj4PUJORVq21GiEw@mail.gmail.com>
 <20120305132334.e3fc92cb.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35565 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2CEVf7 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 5 Mar 2012 16:35:59 -0500
Content-Disposition: inline
In-Reply-To: <20120305132334.e3fc92cb.akpm@linux-foundation.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Tyler Hicks <tyhicks@canonical.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org

On Mon, Mar 05, 2012 at 01:23:34PM -0800, Andrew Morton wrote:
> mmap_sem nests inside i_mutex.
> 
> On the path
> 
> 	munmap
> 	->ecryptfs_vma_close
> 	  ->filemap_write_and_wait
> 	    ->generic_file_aio_write
> 
> we're taking i_mutex inside mmap_sem.  So the problem is triggered by
> ecryptfs_vma_close() calling filemap_write_and_wait() inside munmap()'s
> mmap_sem.
> 
> Question is: what did we recently change to cause this to happen?

AFAICS, it's commit 32001d6fe9ac6b0423e674a3093aa56740849f3b
Author: Tyler Hicks <tyhicks@canonical.com>
Date:   Mon Nov 21 17:31:29 2011 -0600

    eCryptfs: Flush file in vma close
