From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH linux-next] ecryptfs: crypto: use strscpy() to instead of
 strncpy()
Date: Thu, 29 Dec 2022 12:51:52 -0800
Message-ID: <Y6396PQlotOmKirR@sol.localdomain>
References: <202212280936545669762@zte.com.cn>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2Uv6 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 29 Dec 2022 15:51:58 -0500
Content-Disposition: inline
In-Reply-To: <202212280936545669762@zte.com.cn>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yang.yang29@zte.com.cn
Cc: code@tyhicks.com, ira.weiny@intel.com, fmdefrancesco@gmail.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, xu.panda@zte.com.cn

On Wed, Dec 28, 2022 at 09:36:54AM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.

Unlike strncpy(), strscpy() does not initialize the full destination array, so
it is unsafe in some situations, such as initializing structures that are then
copied to userspace or to disk.  Please include an actual explanation for why
this patch is correct.

- Eric
