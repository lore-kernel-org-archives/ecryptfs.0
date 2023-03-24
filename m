From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Date: Fri, 24 Mar 2023 17:42:43 -0500
Message-ID: <ZB4nYykRg6UwZ0cj@sequoia>
References: <ZBlQT2Os/hB2Rxqh@kroah.com>
 <20230322171910.60755-1-frank.li@vivo.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCXWms (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Fri, 24 Mar 2023 18:42:48 -0400
Content-Disposition: inline
In-Reply-To: <20230322171910.60755-1-frank.li@vivo.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yangtao Li <frank.li@vivo.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

On 2023-03-23 01:19:10, Yangtao Li wrote:
> +cc code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

Hey Yangtao - I think it is a good idea to deprecate eCryptfs and
prepare for its removal in a couple years.

It never received the dedication needed to sort out the stacked
filesystem design issues and its crypto design is aging without
updates/improvements for some time. The majority of the user base, which
came about when Ubuntu added home dir encryption as an option in the
installer, has greatly decreased since Ubuntu removed it from the
installer and dropped official support several years back. Finally,
fscrypt should provide a more than complete alternative for the majority
of use cases.

Deprecating and removing is the right thing to do.

I can devote some time to limping it by until removal but would also
appreciate a hand if anyone has time/interest.

Tyler

> 
> Thx,
> Yangtao
