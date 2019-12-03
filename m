From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] fs: introduce is_dot_dotdot helper for
 cleanup
Date: Tue, 3 Dec 2019 16:33:47 +0800
Message-ID: <f242be33-f55b-e914-ffc4-f79e74b3e13b@loongson.cn>
References: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
 <20191202200302.GN20752@bombadil.infradead.org>
 <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
 <20191203023954.GB7323@magnolia>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20191203023954.GB7323@magnolia>
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
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Tyler Hicks <tyhicks@canonical.com>, Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 12/03/2019 10:39 AM, Darrick J. Wong wrote:
> On Tue, Dec 03, 2019 at 10:07:41AM +0800, Tiezhu Yang wrote:
>> On 12/03/2019 04:03 AM, Matthew Wilcox wrote:
>>> On Mon, Dec 02, 2019 at 06:10:13PM +0800, Tiezhu Yang wrote:
>>>> There exists many similar and duplicate codes to check "." and "..",
>>>> so introduce is_dot_dotdot helper to make the code more clean.
>>> The idea is good.  The implementation is, I'm afraid, badly chosen.
>>> Did you benchmark this change at all?  In general, you should prefer the
>>> core kernel implementation to that of some less-interesting filesystems.
>>> I measured the performance with the attached test program on my laptop
>>> (Core-i7 Kaby Lake):
>>>
>>> qstr . time_1 0.020531 time_2 0.005786
>>> qstr .. time_1 0.017892 time_2 0.008798
>>> qstr a time_1 0.017633 time_2 0.003634
>>> qstr matthew time_1 0.011820 time_2 0.003605
>>> qstr .a time_1 0.017909 time_2 0.008710
>>> qstr , time_1 0.017631 time_2 0.003619
>>>
>>> The results are quite stable:
>>>
>>> qstr . time_1 0.021137 time_2 0.005780
>>> qstr .. time_1 0.017964 time_2 0.008675
>>> qstr a time_1 0.017899 time_2 0.003654
>>> qstr matthew time_1 0.011821 time_2 0.003620
>>> qstr .a time_1 0.017889 time_2 0.008662
>>> qstr , time_1 0.017764 time_2 0.003613
>>>
>>> Feel free to suggest some different strings we could use for testing.
>>> These seemed like interesting strings to test with.  It's always possible
>>> I've messed up something with this benchmark that causes it to not
>>> accurately represent the performance of each algorithm, so please check
>>> that too.
>> [Sorry to resend this email because the mail list server
>> was denied due to it is not plain text.]
>>
>> Hi Matthew,
>>
>> Thanks for your reply and suggestion. I measured the
>> performance with the test program, the following
>> implementation is better for various of test cases:
>>
>> bool is_dot_dotdot(const struct qstr *str)
>> {
>>          if (unlikely(str->name[0] == '.')) {
>>                  if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
>>                          return true;
>>          }
>>
>>          return false;
>> }
>>
>> I will send a v2 patch used with this implementation.
> Can you make it a static inline since it's such a short function?

Thanks for your suggestion, I will make it static inline and
move it to include/linux/fs.h in the v2 patch.

Thanks,

Tiezhu Yang

>
> --D
>
>> Thanks,
>>
>> Tiezhu Yang
>>
>>>> +bool is_dot_dotdot(const struct qstr *str)
>>>> +{
>>>> +	if (str->len == 1 && str->name[0] == '.')
>>>> +		return true;
>>>> +
>>>> +	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +EXPORT_SYMBOL(is_dot_dotdot);
>>>> diff --git a/fs/namei.c b/fs/namei.c
>>>> index 2dda552..7730a3b 100644
>>>> --- a/fs/namei.c
>>>> +++ b/fs/namei.c
>>>> @@ -2458,10 +2458,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
>>>>    	if (!len)
>>>>    		return -EACCES;
>>>> -	if (unlikely(name[0] == '.')) {
>>>> -		if (len < 2 || (len == 2 && name[1] == '.'))
>>>> -			return -EACCES;
>>>> -	}
>>>> +	if (unlikely(is_dot_dotdot(this)))
>>>> +		return -EACCES;
>>>>    	while (len--) {
>>>>    		unsigned int c = *(const unsigned char *)name++;
