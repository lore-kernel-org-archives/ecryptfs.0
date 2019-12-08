From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] fs: introduce is_dot_dotdot helper for cleanup
Date: Sun, 8 Dec 2019 04:38:04 -0800
Message-ID: <20191208123804.GB32169@bombadil.infradead.org>
References: <1575718548-19017-1-git-send-email-yangtiezhu@loongson.cn>
 <20191208034144.GP4203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191208034144.GP4203@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 03:41:44AM +0000, Al Viro wrote:
> On Sat, Dec 07, 2019 at 07:35:48PM +0800, Tiezhu Yang wrote:
> > There exists many similar and duplicate codes to check "." and "..",
> > so introduce is_dot_dotdot helper to make the code more clean.
> 
> Umm...  No objections, in principle, but... you try to say that name
> (e.g. in a phone conversation) without stuttering ;-/
> 
> Any suggestions from native speakers?

I used "is_dot_or_dotdot" when discussing this patch with my wife verbally.
