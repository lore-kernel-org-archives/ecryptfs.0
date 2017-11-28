From: James Muir <james.muir@graphitesoftware.com>
Subject: Re: bug: msm8998, ecryptfs, cannot create files due to invalid keysize
Date: Tue, 28 Nov 2017 10:22:26 -0500
Message-ID: <CAL=R1-=9g2yqhqCS_MJxV8WD537c0CRjzFxRaG-3nSbj03an2Q@mail.gmail.com>
References: <CAL=R1-=TT+A4cW+y7uNHZrPpK+47pQ_z74ZZzHW=zCgJtBsYOA@mail.gmail.com>
 <CAL=R1-mG_xs=rGo+adqOfs279EW5TAzeVXZ_JZGH8xt5=s-p8w@mail.gmail.com> <5092f3db-d574-43e7-dec9-5662a2ee3e3e@canonical.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41602 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdK1PW2 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 28 Nov 2017 10:22:28 -0500
Received: by mail-lf0-f68.google.com with SMTP id f18so199544lfg.8
        for <ecryptfs@vger.kernel.org>; Tue, 28 Nov 2017 07:22:27 -0800 (PST)
In-Reply-To: <5092f3db-d574-43e7-dec9-5662a2ee3e3e@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: linux-arm-msm@vger.kernel.org, ecryptfs@vger.kernel.org

On Mon, Nov 27, 2017 at 1:04 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> On 11/21/2017 09:33 AM, James Muir wrote:
>> On Fri, Oct 27, 2017 at 4:43 PM, James Muir
>> <james.muir@graphitesoftware.com> wrote:
>>> There were some changes made in the msm linux kernel (msm8998) to add
>>> hw support to ecryptfs.
>>>
>>> Unfortunately, those changes break basic ecryptfs usage;
>>
>> <snip>
>>
>>> This regression was introduced in the following commit:
>>>
>>>   https://github.com/sonyxperiadev/kernel/commit/8928f8683bcd0236f5653963deee3bc225fb2206
>>>
>>> That commit is also present in aosp (e.g. the Pixel 2 uses the
>>> msm8998; but note that the aosp kernels do not enable ecryptfs).
>>
>> Since my message was essentially a bug report (without a patch), it
>> might be that linux-arm-msm was not the right place to submit it.
>>
>> Does anyone know of a better way to report msm kernel bugs to Qualcomm?
>
> I can't help here but it might be useful to directly contact the author
> of the patch that introduced the regression.

Thanks, Tyler.

Contacting the author was the first thing I did.  I sent email on 17
Oct and then again on 6 Nov.  Unfortunately, they have not been
responsive.

I may try reaching out to some of the other msm devs who have made
changes under fs/ecryptfs.

-James M
