From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: introduce is_dot_dotdot helper for cleanup
Date: Mon, 2 Dec 2019 18:46:49 -0800
Message-ID: <20191203024649.GQ20752@bombadil.infradead.org>
References: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
 <20191202200302.GN20752@bombadil.infradead.org>
 <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:07:41AM +0800, Tiezhu Yang wrote:
> On 12/03/2019 04:03 AM, Matthew Wilcox wrote:
> > On Mon, Dec 02, 2019 at 06:10:13PM +0800, Tiezhu Yang wrote:
> > > There exists many similar and duplicate codes to check "." and "..",
> > > so introduce is_dot_dotdot helper to make the code more clean.
> > The idea is good.  The implementation is, I'm afraid, badly chosen.
> > Did you benchmark this change at all?  In general, you should prefer the
> 
> Thanks for your reply and suggestion. I measured the
> performance with the test program, the following
> implementation is better for various of test cases:
> 
> bool is_dot_dotdot(const struct qstr *str)
> {
>         if (unlikely(str->name[0] == '.')) {
>                 if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
>                         return true;
>         }
> 
>         return false;
> }
> 
> I will send a v2 patch used with this implementation.

Well, hang on.  If you haven't done any benchmarking, please do so
before sending a v2.  In particular, you've now moved this to being a
function call.  That might slow things down, or it might speed things up.
I also don't know if passing a qstr is going to be the right API --
let's hear from the filesystems affected by the API change that they're
OK with this change.
