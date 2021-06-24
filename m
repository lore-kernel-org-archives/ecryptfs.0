From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] ecryptfs: add a ->set_page_dirty cludge
Date: Thu, 24 Jun 2021 14:07:47 +0100
Message-ID: <YNSDoyG7VqgJbxS0@casper.infradead.org>
References: <20210624125250.536369-1-hch@lst.de>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXNKa (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 24 Jun 2021 09:10:30 -0400
Content-Disposition: inline
In-Reply-To: <20210624125250.536369-1-hch@lst.de>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 02:52:50PM +0200, Christoph Hellwig wrote:
> "fix" ecryptfs to work the same as before the recent change to the
> behavior without a ->set_page_dirty method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This is atrocious, but we can't really do better.
