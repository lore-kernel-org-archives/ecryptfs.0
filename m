From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Date: Tue, 10 Dec 2019 23:10:09 +0000
Message-ID: <20191210231009.GB4203@ZenIV.linux.org.uk>
References: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
 <20191210191912.GA99557@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191210191912.GA99557@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Biggers <ebiggers@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:19:13AM -0800, Eric Biggers wrote:

> > +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> > +{
> > +	if (unlikely(name[0] == '.')) {
> > +		if (len < 2 || (len == 2 && name[1] == '.'))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> This doesn't handle the len=0 case.  Did you check that none of the users pass
> in zero-length names?  It looks like fscrypt_fname_disk_to_usr() can, if the
> directory entry on-disk has a zero-length name.  Currently it will return
> -EUCLEAN in that case, but with this patch it may think it's the name ".".
> 
> So I think there needs to either be a len >= 1 check added, *or* you need to
> make an argument for why it's okay to not care about the empty name case.

Frankly, the only caller that matters in practice is link_path_walk(); _that_
is by far the hottest path that might make use of that thing.

BTW, the callers that might end up passing 0 for len really ought to take
a good look at another thing - that name[0] is, in fact, mapped.  Something
along the lines of
	if (name + len > end_of_buffer)
		sod off
	if (<that function>(name, len))
		....
is not enough, for obvious reasons.
