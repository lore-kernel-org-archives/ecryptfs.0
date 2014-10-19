From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] ecryptfs: add fadvise/set_flags calbacks
Date: Sun, 19 Oct 2014 07:50:25 -0700
Message-ID: <20141019145025.GA9593@infradead.org>
References: <1413645688-13524-1-git-send-email-dmonakhov@openvz.org>
 <1413645688-13524-4-git-send-email-dmonakhov@openvz.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44439 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaJSOuZ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 19 Oct 2014 10:50:25 -0400
Content-Disposition: inline
In-Reply-To: <1413645688-13524-4-git-send-email-dmonakhov@openvz.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@infradead.org, tyhicks@canonical.com, ecryptfs@vger.kernel.org

On Sat, Oct 18, 2014 at 07:21:27PM +0400, Dmitry Monakhov wrote:
> +	if (ecryptfs_file_to_private(file))
> +		lower_file = ecryptfs_file_to_lower(file);
> +
> +	if (!lower_file || !lower_file->f_op)
> +		return rc;

At least a file without f->f_op should never happen.  How could ecryptfs
not have a lower file here?

>
> +
> +	if (lower_file->f_op && lower_file->f_op->fadvise)
> +		rc = lower_file->f_op->fadvise(lower_file, offset, len, advice);
> +	else
> +		rc = generic_fadvise(lower_file, offset, len, advice);

Seems like this should be in a vfs_fadvice helper.

> +	if (!rc)
> +		generic_fadvise(file, offset, len, advice);

Setting the advice on both files seems odd.  Which one do we actually
need them on?

> +	if (lower_file->f_op && lower_file->f_op->set_flags) {
> +		rc = lower_file->f_op->set_flags(lower_file,
> +						 flags & ECRYPTFS_FL_MASK);
> +		if (rc)
> +			return rc;
> +	} else
> +		generic_file_set_flags(file, flags & ECRYPTFS_FL_MASK);

Seems like you want a vfs_set_flags again.
