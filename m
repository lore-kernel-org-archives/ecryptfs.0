From: Yann Droneaud <ydroneaud@opteya.com>
Subject: ecryptfs_privileged_open(): when kthread-ecryptfs is required ?
Date: Fri, 23 May 2014 16:24:05 +0200
Message-ID: <1400855045.23090.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:9433 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbaEWOYO (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Fri, 23 May 2014 10:24:14 -0400
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: ydroneaud@opteya.com

Hi,

While trying to investigate why using ecryptfs is painfully sluggish,
I've find a piece of code that, I believed at first, wouldn't scale.

After adding some printk() there, I've found that it's not at all 
called in my use case.
So I wonder: what's making  ecryptfs_privileged_open()[1] submit work 
to ecryptfs-kthread thread running ecryptfs_threadfn()[2] ?

[1]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/ecryptfs/kthread.c#n155

[2]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/ecryptfs/kthread.c#n56

BTW, I have a patch that remove this kernel thread as I think
credentials can be given to dentry_open(), so instead of running an
helper kthread, some privileged credentials can be given to
dentry_open() in the case ecryptfs_privileged_open() really need to 
open a file read/write. But as I'm not able to verify it's working as 
expected, I'm holding such trival patch.

Regards.

-- 
Yann Droneaud
OPTEYA

