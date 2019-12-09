From: John Stoffel <john@quad.stoffel.home>
Subject: Re: [PATCH v3] fs: introduce is_dot_dotdot helper for
 cleanup
Date: Sun, 8 Dec 2019 21:00:41 -0500
Message-ID: <20191209020041.et776tzhxqsqqfs5@quad.stoffel.home>
References: <1575718548-19017-1-git-send-email-yangtiezhu@loongson.cn>
 <20191208034144.GP4203@ZenIV.linux.org.uk>
 <20191208123804.GB32169@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20191208123804.GB32169@bombadil.infradead.org>
List-Id: <ecryptfs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Matthew Wilcox <willy@infradead.org>
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-f2fs-devel@lists.sourceforge.net

On Sun, Dec 08, 2019 at 04:38:04AM -0800, Matthew Wilcox wrote:
> On Sun, Dec 08, 2019 at 03:41:44AM +0000, Al Viro wrote:
> > On Sat, Dec 07, 2019 at 07:35:48PM +0800, Tiezhu Yang wrote:
> > > There exists many similar and duplicate codes to check "." and "..",
> > > so introduce is_dot_dotdot helper to make the code more clean.
> > 
> > Umm...  No objections, in principle, but... you try to say that name
> > (e.g. in a phone conversation) without stuttering ;-/
> > 
> > Any suggestions from native speakers?
> 
> I used "is_dot_or_dotdot" when discussing this patch with my wife verbally.

*thumbs up*  Both for the wife, and the name.  :-)

-- 
