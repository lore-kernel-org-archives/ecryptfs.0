From: Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH] eCryptfs: Allocate sufficient buffer space for encrypted
 filename decoding
Date: Wed, 26 Nov 2014 09:11:32 -0800
Message-ID: <CA+POJK1miq_sJ-7D80cbabtwTi2ftRTdBcrZDP1sacEK9f36GA@mail.gmail.com>
References: <1416589323-4762-1-git-send-email-mhalcrow@google.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:65308 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaKZRLd (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 26 Nov 2014 12:11:33 -0500
Received: by mail-qa0-f46.google.com with SMTP id u7so2188494qaz.33
        for <ecryptfs@vger.kernel.org>; Wed, 26 Nov 2014 09:11:32 -0800 (PST)
In-Reply-To: <1416589323-4762-1-git-send-email-mhalcrow@google.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Dmitry Chernenkov <dmitryc@google.com>, ecryptfs@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>

On Fri, Nov 21, 2014 at 9:02 AM, Michael Halcrow <mhalcrow@google.com> wrote:
> Dmitry Chernenkov used KASAN to discover that eCryptfs writes past the
> end of the allocated buffer during encrypted filename decoding. This
> fix corrects the issue by ensuring that there is sufficient buffer
> space allocated.
>
> Signed-off-by: Michael Halcrow <mhalcrow@google.com>
> ---
>  fs/ecryptfs/crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 2f6735d..53d4f2e 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1871,7 +1871,7 @@ static size_t ecryptfs_max_decoded_size(size_t encoded_size)
>          * the caller with the maximum amount of allocated
>          * space that @dst will need to point to in a
>          * subsequent call. */
> -       return ((encoded_size + 1) * 3) / 4;
> +       return (((encoded_size + 1) * 3) / 4) + 1;

Kees pointed out that the last write of 0 isn't even necessary.

Ignore this patch. I've sent out a fix that removes that write.

>  }
>
>  /**
> --
> 2.1.0.rc2.206.gedb03e5
>
