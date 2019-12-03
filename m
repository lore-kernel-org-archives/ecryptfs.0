From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] fs: introduce is_dot_dotdot helper for cleanup
Date: Tue, 3 Dec 2019 10:07:41 +0800
Message-ID: <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
References: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
 <20191202200302.GN20752@bombadil.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191202200302.GN20752@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 12/03/2019 04:03 AM, Matthew Wilcox wrote:
> On Mon, Dec 02, 2019 at 06:10:13PM +0800, Tiezhu Yang wrote:
>> There exists many similar and duplicate codes to check "." and "..",
>> so introduce is_dot_dotdot helper to make the code more clean.
> The idea is good.  The implementation is, I'm afraid, badly chosen.
> Did you benchmark this change at all?  In general, you should prefer the
> core kernel implementation to that of some less-interesting filesystems.
> I measured the performance with the attached test program on my laptop
> (Core-i7 Kaby Lake):
>
> qstr . time_1 0.020531 time_2 0.005786
> qstr .. time_1 0.017892 time_2 0.008798
> qstr a time_1 0.017633 time_2 0.003634
> qstr matthew time_1 0.011820 time_2 0.003605
> qstr .a time_1 0.017909 time_2 0.008710
> qstr , time_1 0.017631 time_2 0.003619
>
> The results are quite stable:
>
> qstr . time_1 0.021137 time_2 0.005780
> qstr .. time_1 0.017964 time_2 0.008675
> qstr a time_1 0.017899 time_2 0.003654
> qstr matthew time_1 0.011821 time_2 0.003620
> qstr .a time_1 0.017889 time_2 0.008662
> qstr , time_1 0.017764 time_2 0.003613
>
> Feel free to suggest some different strings we could use for testing.
> These seemed like interesting strings to test with.  It's always possible
> I've messed up something with this benchmark that causes it to not
> accurately represent the performance of each algorithm, so please check
> that too.

[Sorry to resend this email because the mail list server
was denied due to it is not plain text.]

Hi Matthew,

Thanks for your reply and suggestion. I measured the
performance with the test program, the following
implementation is better for various of test cases:

bool is_dot_dotdot(const struct qstr *str)
{
         if (unlikely(str->name[0] == '.')) {
                 if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
                         return true;
         }

         return false;
}

I will send a v2 patch used with this implementation.

Thanks,

Tiezhu Yang

>
>> +bool is_dot_dotdot(const struct qstr *str)
>> +{
>> +	if (str->len == 1 && str->name[0] == '.')
>> +		return true;
>> +
>> +	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
>> +		return true;
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(is_dot_dotdot);
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 2dda552..7730a3b 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -2458,10 +2458,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
>>   	if (!len)
>>   		return -EACCES;
>>   
>> -	if (unlikely(name[0] == '.')) {
>> -		if (len < 2 || (len == 2 && name[1] == '.'))
>> -			return -EACCES;
>> -	}
>> +	if (unlikely(is_dot_dotdot(this)))
>> +		return -EACCES;
>>   
>>   	while (len--) {
>>   		unsigned int c = *(const unsigned char *)name++;

