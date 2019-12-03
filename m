From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for
 cleanup
Date: Tue, 3 Dec 2019 05:56:51 -0800
Message-ID: <20191203135651.GU20752@bombadil.infradead.org>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Tue, Dec 03, 2019 at 08:56:50PM +0800, Tiezhu Yang wrote:
> There exists many similar and duplicate codes to check "." and "..",
> so introduce is_dot_dotdot helper to make the code more clean.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2:
>   - use the better performance implementation of is_dot_dotdot
>   - make it static inline and move it to include/linux/fs.h

Ugh, not more crap in fs.h.

$ ls -l --sort=size include/linux |head
-rw-r--r--  1 willy willy 154148 Nov 29 22:35 netdevice.h
-rw-r--r--  1 willy willy 130488 Nov 29 22:35 skbuff.h
-rw-r--r--  1 willy willy 123540 Nov 29 22:35 pci_ids.h
-rw-r--r--  1 willy willy 118991 Nov 29 22:35 fs.h

I think this probably fits well in namei.h.  And I think it works
better with bare 'name' and 'len' arguments, rather than taking a qstr.

And, as I asked twice in the last round of review, did you benchmark
this change?
