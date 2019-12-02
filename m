From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: introduce is_dot_dotdot helper for cleanup
Date: Mon, 2 Dec 2019 12:03:02 -0800
Message-ID: <20191202200302.GN20752@bombadil.infradead.org>
References: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>, Tyler Hicks <tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 06:10:13PM +0800, Tiezhu Yang wrote:
> There exists many similar and duplicate codes to check "." and "..",
> so introduce is_dot_dotdot helper to make the code more clean.

The idea is good.  The implementation is, I'm afraid, badly chosen.
Did you benchmark this change at all?  In general, you should prefer the
core kernel implementation to that of some less-interesting filesystems.
I measured the performance with the attached test program on my laptop
(Core-i7 Kaby Lake):

qstr . time_1 0.020531 time_2 0.005786
qstr .. time_1 0.017892 time_2 0.008798
qstr a time_1 0.017633 time_2 0.003634
qstr matthew time_1 0.011820 time_2 0.003605
qstr .a time_1 0.017909 time_2 0.008710
qstr , time_1 0.017631 time_2 0.003619

The results are quite stable:

qstr . time_1 0.021137 time_2 0.005780
qstr .. time_1 0.017964 time_2 0.008675
qstr a time_1 0.017899 time_2 0.003654
qstr matthew time_1 0.011821 time_2 0.003620
qstr .a time_1 0.017889 time_2 0.008662
qstr , time_1 0.017764 time_2 0.003613

Feel free to suggest some different strings we could use for testing.
These seemed like interesting strings to test with.  It's always possible
I've messed up something with this benchmark that causes it to not
accurately represent the performance of each algorithm, so please check
that too.

> +bool is_dot_dotdot(const struct qstr *str)
> +{
> +	if (str->len == 1 && str->name[0] == '.')
> +		return true;
> +
> +	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(is_dot_dotdot);
> diff --git a/fs/namei.c b/fs/namei.c
> index 2dda552..7730a3b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2458,10 +2458,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
>  	if (!len)
>  		return -EACCES;
>  
> -	if (unlikely(name[0] == '.')) {
> -		if (len < 2 || (len == 2 && name[1] == '.'))
> -			return -EACCES;
> -	}
> +	if (unlikely(is_dot_dotdot(this)))
> +		return -EACCES;
>  
>  	while (len--) {
>  		unsigned int c = *(const unsigned char *)name++;

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dotdotdot.c"

#include <stdio.h>
#include <time.h>

typedef _Bool bool;
#define true 1
#define false 0
#define unlikely(x)	(x)
typedef unsigned int u32;
typedef unsigned long long u64;
#define HASH_LEN_DECLARE u32 hash; u32 len

struct qstr {
        union {
                struct {
                        HASH_LEN_DECLARE;
                };
                u64 hash_len;
        };
        const char *name;
};

bool is_dot_dotdot_1(const struct qstr *str)
{
	if (str->len == 1 && str->name[0] == '.')
		return true;
	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
		return true;
	return false;
}

bool is_dot_dotdot_2(const struct qstr *str)
{
	if (unlikely(str->name[0] == '.')) {
		if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
			return false;
	}

	return true;
}

double time_sub(struct timespec *before, struct timespec *after)
{
	struct timespec diff = { .tv_sec  = after->tv_sec  - before->tv_sec,
				 .tv_nsec = after->tv_nsec - before->tv_nsec };
	if (diff.tv_nsec < 0) {
		diff.tv_nsec += 1000 * 1000 * 1000;
		diff.tv_sec -= 1;
	}

	return diff.tv_sec + diff.tv_nsec * 0.0000000001d;
}

bool res;

void mytime(const struct qstr *qstr)
{
	unsigned int i;
	struct timespec start, middle, end;

	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &start);
	for (i = 0; i < 100000000; i++)
		res = is_dot_dotdot_1(qstr);
	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &middle);
	for (i = 0; i < 100000000; i++)
		res = is_dot_dotdot_2(qstr);
	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &end);

	printf("qstr %s time_1 %f time_2 %f\n", qstr->name,
			time_sub(&start, &middle), time_sub(&middle, &end));
}

int main(int argc, char **argv)
{
	struct qstr dot = { .len = 1, .name = "." };
	struct qstr dotdot = { .len = 2, .name = ".." };
	struct qstr a = { .len = 1, .name = "a" };
	struct qstr matthew = { .len = 7, .name = "matthew" };
	struct qstr dota = { .len = 2, .name = ".a" };
	struct qstr comma = { .len = 1, .name = "," };

	mytime(&dot);
	mytime(&dotdot);
	mytime(&a);
	mytime(&matthew);
	mytime(&dota);
	mytime(&comma);

	return 0;
}

--u3/rZRmxL6MmkK24--
