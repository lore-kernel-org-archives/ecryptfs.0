From: Randy Dunlap <rdunlap@bombadil.infradead.org>
Subject: Re: [PATCH] ecryptfs: fix incorrect kernel-doc comment syntax in
 files
Date: Sat, 20 Mar 2021 09:08:10 -0700 (PDT)
Message-ID: <731fb5fd-b20-c1e-bfe-276845a9a91@bombadil.infradead.org>
References: <20210320081551.13954-1-yashsri421@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20210320081551.13954-1-yashsri421@gmail.com>
Sender: Randy Dunlap <rdunlap@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Aditya Srivastava <yashsri421@gmail.com>
Cc: code@tyhicks.com, lukas.bulwahn@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com



On Sat, 20 Mar 2021, Aditya Srivastava wrote:

> The opening comment mark '/**' is used for kernel-doc comments.
> There are files in fs/encrypts which follows this syntax, but the content
> inside does not comply with kernel-doc.
> This causes unexpected warnings from kernel-doc.
>
> E.g., header comment for fs/ecryptfs/dentry.c follows kernel-doc syntax
> for comments(i.e., '/**'), but the content inside does not.
>
> Running kernel-doc -none on fs/ecryptfs/dentry.c causes these
> unexpected warnings:
> "warning: Incorrect use of kernel-doc format:  * ecryptfs_d_revalidate - revalidate an ecryptfs dentry"
> "warning: Function parameter or member 'dentry' not described in 'ecryptfs_d_revalidate'"
> "warning: Function parameter or member 'flags' not described in 'ecryptfs_d_revalidate'"
> "warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_d_revalidate() instead"
>
> Similarly for other files too.
>
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210312
>
> fs/ecryptfs/crypto.c          |  2 +-
> fs/ecryptfs/debug.c           |  2 +-
> fs/ecryptfs/dentry.c          |  2 +-
> fs/ecryptfs/ecryptfs_kernel.h |  2 +-
> fs/ecryptfs/file.c            |  2 +-
> fs/ecryptfs/inode.c           |  2 +-
> fs/ecryptfs/keystore.c        |  6 +++---
> fs/ecryptfs/kthread.c         |  2 +-
> fs/ecryptfs/main.c            | 10 +++++-----
> fs/ecryptfs/messaging.c       |  2 +-
> fs/ecryptfs/miscdev.c         |  2 +-
> fs/ecryptfs/mmap.c            |  6 +++---
> fs/ecryptfs/read_write.c      |  2 +-
> fs/ecryptfs/super.c           |  2 +-
> 14 files changed, 22 insertions(+), 22 deletions(-)
>
