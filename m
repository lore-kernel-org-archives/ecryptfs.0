From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Date: Wed, 11 Dec 2019 05:40:14 -0800
Message-ID: <20191211134014.GM32169@bombadil.infradead.org>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
 <20191211044723.GC4203@ZenIV.linux.org.uk>
 <4a90aaa9-18c8-f0a7-19e4-1c5bd5915a28@loongson.cn>
 <20191211071711.GA231266@architecture4>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191211071711.GA231266@architecture4>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gao Xiang <gaoxiang25@huawei.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Al Viro <viro@zeniv.linux.org.uk>, Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>

On Wed, Dec 11, 2019 at 03:17:11PM +0800, Gao Xiang wrote:
> > static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> > {
> >         if (len >= 1 && unlikely(name[0] == '.')) {
> 
> 
> And I suggest drop "unlikely" here since files start with prefix
> '.' (plus specical ".", "..") are not as uncommon as you expected...

They absolutely are uncommon.  Even if you just consider
/home/willy/kernel/linux/.git/config, only one of those six path elements
starts with a '.'.
