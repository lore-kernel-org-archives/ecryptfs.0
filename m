From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Date: Thu, 12 Dec 2019 10:13:02 -0800
Message-ID: <20191212181302.GT32169@bombadil.infradead.org>
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
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

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

Trying to wrench this back on track ...

fscrypt_fname_disk_to_usr is called by:

fscrypt_get_symlink():
       if (cstr.len == 0)
                return ERR_PTR(-EUCLEAN);
ext4_readdir():
	Does not currently check de->name_len.  I believe this check should
	be added to __ext4_check_dir_entry() because a zero-length directory
	entry can affect both encrypted and non-encrypted directory entries.
dx_show_leaf():
	Same as ext4_readdir().  Should probably call ext4_check_dir_entry()?
htree_dirblock_to_tree():
	Would be covered by a fix to ext4_check_dir_entry().
f2fs_fill_dentries():
	if (de->name_len == 0) {
		...
ubifs_readdir():
	Does not currently check de->name_len.  Also affects non-encrypted
	directory entries.

So of the six callers, two of them already check the dirent length for
being zero, and four of them ought to anyway, but don't.  I think they
should be fixed, but clearly we don't historically check for this kind
of data corruption (strangely), so I don't think that's a reason to hold
up this patch until the individual filesystems are fixed.
