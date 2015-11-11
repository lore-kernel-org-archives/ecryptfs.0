From: andreym@codeaurora.org
Subject: Re: [PATCH v1] eCryptfs: enhancing eCryptfs to be used with external
 crypto engine
Date: Wed, 11 Nov 2015 14:06:12 -0000
Message-ID: <351897f46ec3c546dc2c20ecf5c7394f.squirrel@www.codeaurora.org>
References: <1446970202-18514-1-git-send-email-andreym@codeaurora.org>
    <20151108092654.GA15861@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151108092654.GA15861@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrey Markovytch <andreym@codeaurora.org>, tyhicks@canonical.com, ecryptfs@vger.kernel.org, linaz@codeaurora.org, open list <linux-kernel@vger.kernel.org>

> On Sun, Nov 08, 2015 at 10:10:00AM +0200, Andrey Markovytch wrote:
>> +++ b/fs/ecryptfs/caches_utils.c
>> @@ -0,0 +1,78 @@
>> +/*
>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>
> Really?  This looks like copy and paste from core code that defintively
> was not written by the Linux Foundation.  In addition this patch comes
> from Qualcomm so something very fishy is going on here, which if I'd
> call copyrght fraud if I'd want to be be mean.
>
> Please a) stop pointlessly copy and pasting code and b) have a word with
> your lawyers on how to attribute code both that your wrote and which has
> been copy and pasted.
>

Hi Christoph,
Regarding the license, after double checking this, it seems that there has
been a mistake and we unproperly attributed Linux copyright for the code
that actually came from open source files having a different license. I
appologise for that, I am checking this internally and will update patch
with proper license.
As for the 'pointless copy paste', the code was taken from files where
those functions are declared as internal static, we had no choise but to
copy paste them, other option would be alternating the original code and
make those 2 functions public which seems unjustified in this case.
