From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] eCryptfs: enhancing eCryptfs to be used with external
 crypto engine
Date: Sun, 8 Nov 2015 01:26:54 -0800
Message-ID: <20151108092654.GA15861@infradead.org>
References: <1446970202-18514-1-git-send-email-andreym@codeaurora.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41440 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbbKHJ04 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 8 Nov 2015 04:26:56 -0500
Content-Disposition: inline
In-Reply-To: <1446970202-18514-1-git-send-email-andreym@codeaurora.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Markovytch <andreym@codeaurora.org>
Cc: tyhicks@canonical.com, ecryptfs@vger.kernel.org, linaz@codeaurora.org, Andrey Markovytch <andreym@qti.qualcomm.com>, open list <linux-kernel@vger.kernel.org>

On Sun, Nov 08, 2015 at 10:10:00AM +0200, Andrey Markovytch wrote:
> +++ b/fs/ecryptfs/caches_utils.c
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.

Really?  This looks like copy and paste from core code that defintively
was not written by the Linux Foundation.  In addition this patch comes
from Qualcomm so something very fishy is going on here, which if I'd
call copyrght fraud if I'd want to be be mean.

Please a) stop pointlessly copy and pasting code and b) have a word with
your lawyers on how to attribute code both that your wrote and which has
been copy and pasted.
