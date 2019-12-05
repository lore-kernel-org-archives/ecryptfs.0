From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for
 cleanup
Date: Thu, 5 Dec 2019 08:56:07 +0800
Message-ID: <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
 <20191203135651.GU20752@bombadil.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20191203135651.GU20752@bombadil.infradead.org>
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

On 12/03/2019 09:56 PM, Matthew Wilcox wrote:
> On Tue, Dec 03, 2019 at 08:56:50PM +0800, Tiezhu Yang wrote:
>> There exists many similar and duplicate codes to check "." and "..",
>> so introduce is_dot_dotdot helper to make the code more clean.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2:
>>    - use the better performance implementation of is_dot_dotdot
>>    - make it static inline and move it to include/linux/fs.h
> Ugh, not more crap in fs.h.
>
> $ ls -l --sort=size include/linux |head
> -rw-r--r--  1 willy willy 154148 Nov 29 22:35 netdevice.h
> -rw-r--r--  1 willy willy 130488 Nov 29 22:35 skbuff.h
> -rw-r--r--  1 willy willy 123540 Nov 29 22:35 pci_ids.h
> -rw-r--r--  1 willy willy 118991 Nov 29 22:35 fs.h
>
> I think this probably fits well in namei.h.  And I think it works
> better with bare 'name' and 'len' arguments, rather than taking a qstr.

According to the definition of struct qstr:
"quick string" -- eases parameter passing, but more importantly saves
"metadata" about the string (ie length and the hash), it seems there
is no need to use qstr to only check "." and "..", I will use "name"
and "len" as arguments in the v3 patch and move it to namei.h:

static inline bool is_dot_dotdot(const unsigned char *name, size_t len)
{
         if (unlikely(name[0] == '.')) {
                 if (len < 2 || (len == 2 && name[1] == '.'))
                         return true;
         }

         return false;
}

>
> And, as I asked twice in the last round of review, did you benchmark
> this change?

Before sending this v2 patch, I have done the test used with your test
program and already pointed out the following implementation is better:

bool is_dot_dotdot(const struct qstr *str)
{
         if (unlikely(str->name[0] == '.')) {
                 if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
                         return true;
         }

         return false;
}

[enjoy@linux ~]$ lscpu | grep "Model name"
Model name:            Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz

[enjoy@linux ~]$ ./test
qstr . time_1 0.025204 time_2 0.023717
qstr .. time_1 0.036542 time_2 0.034330
qstr a time_1 0.028123 time_2 0.022514
qstr matthew time_1 0.024282 time_2 0.022617
qstr .a time_1 0.037132 time_2 0.034118
qstr , time_1 0.028121 time_2 0.022527
[enjoy@linux ~]$ ./test
qstr . time_1 0.025200 time_2 0.023666
qstr .. time_1 0.036486 time_2 0.034275
qstr a time_1 0.028113 time_2 0.022514
qstr matthew time_1 0.024289 time_2 0.022515
qstr .a time_1 0.037058 time_2 0.034063
qstr , time_1 0.028117 time_2 0.022523
[enjoy@linux ~]$ ./test
qstr . time_1 0.025128 time_2 0.023692
qstr .. time_1 0.036687 time_2 0.034284
qstr a time_1 0.028133 time_2 0.022527
qstr matthew time_1 0.024246 time_2 0.022589
qstr .a time_1 0.037063 time_2 0.034106
qstr , time_1 0.028127 time_2 0.022522

Additionally, by declaring is_dot_dotdot inline, we can make execution
faster by eliminating the function-call overhead, so the performance
influence is very small with this patch.

If you have any more suggestion, please let me know.

Thanks,

Tiezhu Yang
