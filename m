From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] mm: require ->set_page_dirty to be explicitly wire
 up
Date: Mon, 21 Jun 2021 07:26:12 +0200
Message-ID: <20210621052612.GA4064@lst.de>
References: <20210614061512.3966143-1-hch@lst.de> <20210614061512.3966143-4-hch@lst.de> <ddafcc0d-8636-46ca-44b7-54392e0d22b4@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhFUF23 (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
        Mon, 21 Jun 2021 01:28:29 -0400
Content-Disposition: inline
In-Reply-To: <ddafcc0d-8636-46ca-44b7-54392e0d22b4@gmail.com>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Osipenko <digetx@gmail.com>, Tyler Hicks <code@tyhicks.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

On Fri, Jun 18, 2021 at 10:23:55PM +0300, Dmitry Osipenko wrote:
> >  21 files changed, 29 insertions(+), 14 deletions(-)
> 
> The ecryptfs is now crashing with NULL deference, please fix.

Which means it crashed the same before on configs without CONFIG_BLOCK.

Tyler, can you look at what ecryptfs should do for ->set_page_dirty?
Currently it implicitly gets __set_page_dirty_buffers for kernels
with COFIG_BLOCK set, but given that this function looks at buffer_heads
that ecryptfs doesn't use it can't really be the right choice.
__set_page_dirty_nobuffers will probably work, but I'd love to see an
audit of the page dirtying and writeback for ecryptfs while we're at it.
