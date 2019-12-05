From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for
 cleanup
Date: Thu, 5 Dec 2019 15:55:50 +0800
Message-ID: <b3f23eef-3799-6ddd-43ba-11a90f49279d@loongson.cn>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
 <20191203135651.GU20752@bombadil.infradead.org>
 <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
 <20191205070646.GA29612@bombadil.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20191205070646.GA29612@bombadil.infradead.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Matthew Wilcox <willy@infradead.org>
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 12/05/2019 03:06 PM, Matthew Wilcox wrote:
> On Thu, Dec 05, 2019 at 08:56:07AM +0800, Tiezhu Yang wrote:
>>> And, as I asked twice in the last round of review, did you benchmark
>>> this change?
>> Before sending this v2 patch, I have done the test used with your test
>> program and already pointed out the following implementation is better:
> I didn't mean "have you run the test program i wrote".  I meant "have you
> booted a kernel with this change and done some performance measurements
> to see if you've changed anything".

Oh, no, it is hard to measure the performance influence with this patch.
Based on the above analysis, I think the performance influence is very
small due to is_dot_dotdot() is a such short static inline function.

Thanks,

Tiezhu Yang
