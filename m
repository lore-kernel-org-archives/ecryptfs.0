From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 01/16] mm: Add AOP_UPDATED_PAGE return value
Date: Thu, 15 Oct 2020 15:06:31 +0100
Message-ID: <20201015140631.GZ20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-2-willy@infradead.org>
 <20201015090651.GB12879@infradead.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgJOOGd (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 15 Oct 2020 10:06:33 -0400
Content-Disposition: inline
In-Reply-To: <20201015090651.GB12879@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

On Thu, Oct 15, 2020 at 10:06:51AM +0100, Christoph Hellwig wrote:
> Don't we also need to handle the new return value in a few other places
> like cachefiles_read_reissue swap_readpage?  Maybe those don't get
> called on the currently converted instances, but just leaving them
> without handling AOP_UPDATED_PAGE seems like a time bomb.

Er, right.  And nobh_truncate_page(), and read_page().  And then I
noticed the bug in cachefiles_read_reissue().  Sigh.

Updated patch series coming soon.
