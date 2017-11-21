From: James Muir <james.muir@graphitesoftware.com>
Subject: Re: bug: msm8998, ecryptfs, cannot create files due to invalid keysize
Date: Tue, 21 Nov 2017 10:33:46 -0500
Message-ID: <CAL=R1-mG_xs=rGo+adqOfs279EW5TAzeVXZ_JZGH8xt5=s-p8w@mail.gmail.com>
References: <CAL=R1-=TT+A4cW+y7uNHZrPpK+47pQ_z74ZZzHW=zCgJtBsYOA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAL=R1-=TT+A4cW+y7uNHZrPpK+47pQ_z74ZZzHW=zCgJtBsYOA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-msm@vger.kernel.org
Cc: ecryptfs@vger.kernel.org

On Fri, Oct 27, 2017 at 4:43 PM, James Muir
<james.muir@graphitesoftware.com> wrote:
> There were some changes made in the msm linux kernel (msm8998) to add
> hw support to ecryptfs.
>
> Unfortunately, those changes break basic ecryptfs usage;

<snip>

> This regression was introduced in the following commit:
>
>   https://github.com/sonyxperiadev/kernel/commit/8928f8683bcd0236f5653963deee3bc225fb2206
>
> That commit is also present in aosp (e.g. the Pixel 2 uses the
> msm8998; but note that the aosp kernels do not enable ecryptfs).

Since my message was essentially a bug report (without a patch), it
might be that linux-arm-msm was not the right place to submit it.

Does anyone know of a better way to report msm kernel bugs to Qualcomm?

Due to the high volume of traffic on the list, it seems likely a bug
report would get overlooked here.

-James M
