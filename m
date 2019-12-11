From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Date: Wed, 11 Dec 2019 04:47:23 +0000
Message-ID: <20191211044723.GC4203@ZenIV.linux.org.uk>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Eric Biggers <ebiggers@kernel.org>, Matthew Wilcox <willy@infradead.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:59:40AM +0800, Tiezhu Yang wrote:

> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> {
>         if (len == 1 && name[0] == '.')
>                 return true;
> 
>         if (len == 2 && name[0] == '.' && name[1] == '.')
>                 return true;
> 
>         return false;
> }
> 
> Hi Matthew,
> 
> How do you think? I think the performance influence is very small
> due to is_dot_or_dotdot() is a such short static inline function.

It's a very short inline function called on a very hot codepath.
Often.

I mean it - it's done literally for every pathname component of
every pathname passed to a syscall.
