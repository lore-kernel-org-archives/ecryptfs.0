From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Date: Tue, 10 Dec 2019 18:48:58 -0800
Message-ID: <20191211024858.GB732@sol.localdomain>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:20:01AM +0800, Tiezhu Yang wrote:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 7fe7b87..0fd9315 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
>  	return error == -ESTALE && !(flags & LOOKUP_REVAL);
>  }
>  
> +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> +{
> +	if (unlikely(name[0] == '.')) {
> +		if (len == 1 || (len == 2 && name[1] == '.'))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  #endif /* _LINUX_NAMEI_H */

I had suggested adding a len >= 1 check to handle the empty name case correctly.
What I had in mind was

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
	if (len >= 1 && unlikely(name[0] == '.')) {
		if (len < 2 || (len == 2 && name[1] == '.'))
			return true;
	}

	return false;
}

As is, you're proposing that it always dereference the first byte even when
len=0, which seems like a bad idea for a shared helper function.  Did you check
whether it's okay for all the existing callers?  fscrypt_fname_disk_to_usr() is
called from 6 places, did you check all of them?

How about keeping the existing optimized code for the hot path in fs/namei.c
(i.e. not using the helper function), while having the helper function do the
extra check to handle len=0 correctly?

- Eric
