From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for
 cleanup
Date: Wed, 11 Dec 2019 14:38:34 +0800
Message-ID: <4a90aaa9-18c8-f0a7-19e4-1c5bd5915a28@loongson.cn>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
 <20191211044723.GC4203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20191211044723.GC4203@ZenIV.linux.org.uk>
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
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Tyler Hicks <tyhicks@canonical.com>, Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 12/11/2019 12:47 PM, Al Viro wrote:
> On Wed, Dec 11, 2019 at 11:59:40AM +0800, Tiezhu Yang wrote:
>
>> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
>> {
>>          if (len == 1 && name[0] == '.')
>>                  return true;
>>
>>          if (len == 2 && name[0] == '.' && name[1] == '.')
>>                  return true;
>>
>>          return false;
>> }
>>
>> Hi Matthew,
>>
>> How do you think? I think the performance influence is very small
>> due to is_dot_or_dotdot() is a such short static inline function.
> It's a very short inline function called on a very hot codepath.
> Often.
>
> I mean it - it's done literally for every pathname component of
> every pathname passed to a syscall.

OK. I understand. Let us do not use the helper function in fs/namei.c,
just use the following implementation for other callers:

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
         if (len >= 1 && unlikely(name[0] == '.')) {
                 if (len < 2 || (len == 2 && name[1] == '.'))
                         return true;
         }

         return false;
}

Special thanks for Matthew, Darrick, Al and Eric.
If you have any more suggestion, please let me know.

Thanks,

Tiezhu Yang
