From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/16] Allow readpage to return a locked page
Date: Thu, 15 Oct 2020 10:02:42 +0100
Message-ID: <20201015090242.GA12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org

On Fri, Oct 09, 2020 at 03:30:48PM +0100, Matthew Wilcox (Oracle) wrote:
> Ideally all filesystems would return from ->readpage with the page
> Uptodate and Locked, but it's a bit painful to convert all the
> asynchronous readpage implementations to synchronous.  The first 14
> filesystems converted are already synchronous.  The last two patches
> convert iomap to synchronous readpage.

Is it really that bad?  It seems like a lot of the remainig file systems
use the generic mpage/buffer/nobh helpers.

But I guess this series is a good first step.
