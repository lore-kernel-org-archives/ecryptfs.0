From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4.4, 4.9, 4.14] ecryptfs: Fix up bad backport of
 fe2e082f5da5b4a0a92ae32978f81507ef37ec66
Date: Tue, 3 Mar 2020 07:43:26 +0100
Message-ID: <20200303064326.GA1105859@kroah.com>
References: <20200302203912.27370-1-natechancellor@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCGna (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Tue, 3 Mar 2020 01:43:30 -0500
Content-Disposition: inline
In-Reply-To: <20200302203912.27370-1-natechancellor@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, ecryptfs@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>, Tyler Hicks <tyhicks@canonical.com>

On Mon, Mar 02, 2020 at 01:39:13PM -0700, Nathan Chancellor wrote:
> When doing the 4.9 merge into certain Android trees, I noticed a warning
> from Android's deprecated GCC 4.9.4, which causes a build failure in
> those trees due to basically -Werror:

<snip>

Thanks for this, now queued up.

greg k-h
