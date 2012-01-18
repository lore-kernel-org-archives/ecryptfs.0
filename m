From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] eCryptfs: infinite loop bug
Date: Wed, 18 Jan 2012 12:49:17 -0800
Message-ID: <CA+55aFx7CV8wpDLfCr-pVVRxRyYgd2QdRXJSmp+UgrjSHyB1eA@mail.gmail.com>
References: <7f1e961d.f528.134efaf8348.Coremail.dragonylffly@163.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <7f1e961d.f528.134efaf8348.Coremail.dragonylffly@163.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: dragonylffly <dragonylffly@163.com>
Cc: tyhicks@canonical.com, john.johansen@canonical.com, dustin.kirkland@gazzang.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Hmm.

There are *two* cases where we do that "total_remaining_bytes"
calculation. The same bug seems to exist both in ecryptfs_read() and
ecryptfs_write().

Possibly only the ecryptfs_write() one leads to an endless loop, but
the read one looks suspicious too.

Also, what protects things against this just being one nasty DoS
attack - even if the code is fixed to not be an endless loop, it looks
like a trivial "truncate()" can be used to generate a *practically*
infinite write stream. At the very least, this should be KILLABLE. Or
did I mis-read the code?

Tyler, Dustin, others - comments? This looks nasty.

                     Linus.

2012/1/17 dragonylffly <dragonylffly@163.com>:
> Hi,
> =A0 There is an infinite loop bug in eCryptfs, to make it present,
> just truncate to generate a huge file (>=3D 4G) on a 32-bit machine u=
nder
> the plain text foleder mounted with eCryptfs, a simple command
> 'truncate -s 4G dummy' is enough. Note: 4GB is smaller than 4G,
> therefore the following command 'truncate -s 4GB dummy' will not
> trigger=A0this bug. The bug comes from a data overflow, the patch bel=
ow fixes
> it.
>
> Cheers,
> Li Wang
>
> ---
>
> signed-off-by: Li Wang <liwang@nudt.edu.cn>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Yunchuan Wen (wenyunchuan@=
kylinos.com.cn)
>
> --- read_write.c.orig=A02012-01-18 10:39:26.000000000 +0800
> +++ read_write.c=A02012-01-18 19:48:41.484196221 +0800
> @@ -130,7 +130,7 @@
> =A0=A0=A0pgoff_t ecryptfs_page_idx =3D (pos >> PAGE_CACHE_SHIFT);
> =A0=A0=A0size_t start_offset_in_page =3D (pos & ~PAGE_CACHE_MASK);
> =A0=A0=A0size_t num_bytes =3D (PAGE_CACHE_SIZE - start_offset_in_page=
);
> -=A0=A0size_t total_remaining_bytes =3D ((offset + size) - pos);
> +=A0=A0loff_t total_remaining_bytes =3D ((offset + size) - pos);
>
> =A0=A0=A0if (num_bytes > total_remaining_bytes)
> =A0=A0=A0=A0num_bytes =3D total_remaining_bytes;
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
