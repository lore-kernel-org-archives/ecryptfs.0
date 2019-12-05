From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for cleanup
Date: Wed, 4 Dec 2019 23:06:46 -0800
Message-ID: <20191205070646.GA29612@bombadil.infradead.org>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
 <20191203135651.GU20752@bombadil.infradead.org>
 <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:56:07AM +0800, Tiezhu Yang wrote:
> > And, as I asked twice in the last round of review, did you benchmark
> > this change?
> 
> Before sending this v2 patch, I have done the test used with your test
> program and already pointed out the following implementation is better:

I didn't mean "have you run the test program i wrote".  I meant "have you
booted a kernel with this change and done some performance measurements
to see if you've changed anything".
