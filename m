From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] eCryptfs: fix ecryptfs_privileged_open() for read only
 files
Date: Tue, 12 Jun 2012 22:17:27 +0300
Message-ID: <20120612191622.GO13539@mwanda>
References: <20120609091129.GD877@elgon.mountain>
 <20120612190243.GA32418@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:35708 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2FLTT5 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 12 Jun 2012 15:19:57 -0400
Content-Disposition: inline
In-Reply-To: <20120612190243.GA32418@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, ecryptfs@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, Jun 12, 2012 at 12:02:47PM -0700, Tyler Hicks wrote:
> On 2012-06-09 12:11:29, Dan Carpenter wrote:
> > The intent here is to handle read only opens differently.  For example,
> > if we don't want to create the file if it doesn't exist.  The problem
> > here is that O_RDONLY is 0 and if (x & 0) {... is always false.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks, Dan! I committed a slightly different fix with more context in
> the commit message (because I had to remind myself what was going on
> with that conditional in the first place).
> 
> http://git.kernel.org/?p=linux/kernel/git/tyhicks/ecryptfs.git;a=commitdiff;h=91425d9b57c024bf8b28055b6a480809fe0941ee
> 

Looks good.

regards,
dan carpenter
