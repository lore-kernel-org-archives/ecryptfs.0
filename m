From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Date: Wed, 11 Dec 2019 08:56:32 +0800
Message-ID: <98a07d66-8479-f780-89ce-13a6d2c85efd@loongson.cn>
References: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
 <20191210191912.GA99557@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210191912.GA99557@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 12/11/2019 03:19 AM, Eric Biggers wrote:
> On Tue, Dec 10, 2019 at 08:10:01PM +0800, Tiezhu Yang wrote:
>> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
>> index 3da3707..ef7eba8 100644
>> --- a/fs/crypto/fname.c
>> +++ b/fs/crypto/fname.c
>> @@ -11,21 +11,11 @@
>>    * This has not yet undergone a rigorous security audit.
>>    */
>>   
>> +#include <linux/namei.h>
>>   #include <linux/scatterlist.h>
>>   #include <crypto/skcipher.h>
>>   #include "fscrypt_private.h"
>>   
>> -static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
>> -{
>> -	if (str->len == 1 && str->name[0] == '.')
>> -		return true;
>> -
>> -	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
>> -		return true;
>> -
>> -	return false;
>> -}
>> -
>>   /**
>>    * fname_encrypt() - encrypt a filename
>>    *
>> @@ -255,7 +245,7 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
>>   	const struct qstr qname = FSTR_TO_QSTR(iname);
>>   	struct fscrypt_digested_name digested_name;
>>   
>> -	if (fscrypt_is_dot_dotdot(&qname)) {
>> +	if (is_dot_or_dotdot(qname.name, qname.len)) {
> There's no need for the 'qname' variable anymore.  Can you please remove it and
> do:
>
> 	if (is_dot_or_dotdot(iname->name, iname->len)) {

Hi Eric,

Thanks for your review, I will do it in the v5 patch.

>
>> diff --git a/include/linux/namei.h b/include/linux/namei.h
>> index 7fe7b87..aba114a 100644
>> --- a/include/linux/namei.h
>> +++ b/include/linux/namei.h
>> @@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
>>   	return error == -ESTALE && !(flags & LOOKUP_REVAL);
>>   }
>>   
>> +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
>> +{
>> +	if (unlikely(name[0] == '.')) {
>> +		if (len < 2 || (len == 2 && name[1] == '.'))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
> This doesn't handle the len=0 case.  Did you check that none of the users pass
> in zero-length names?  It looks like fscrypt_fname_disk_to_usr() can, if the
> directory entry on-disk has a zero-length name.  Currently it will return
> -EUCLEAN in that case, but with this patch it may think it's the name ".".
>
> So I think there needs to either be a len >= 1 check added, *or* you need to
> make an argument for why it's okay to not care about the empty name case.

Anyway, let me modify the if condition "len < 2" to "len == 1".

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
         if (unlikely(name[0] == '.')) {
                 if (len == 1 || (len == 2 && name[1] == '.'))
                         return true;
         }

         return false;
}

I will send v5 patch as soon as possible.

Thanks,

Tiezhu Yang

>
> - Eric

