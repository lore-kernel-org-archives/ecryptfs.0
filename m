From: Henry Jensen <hjensen@gmx.de>
Subject: Re: Can't list directories with kernel 4.4.14 and ecryptfs
Date: Fri, 1 Jul 2016 22:15:19 +0200
Message-ID: <20160701221519.229e9e43@subnote.jensen.local>
References: <20160627182738.08737a6d@subnote.jensen.local>
	<57717C2C.4010708@canonical.com>
	<0A028742-6B46-49DB-900F-86CE85F320F4@gmx.de>
	<5771AD13.2010408@canonical.com>
	<57735047.1050706@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:62001 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbcGAUQy (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Fri, 1 Jul 2016 16:16:54 -0400
In-Reply-To: <57735047.1050706@canonical.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Kenneth Tan <gmane@way-of-the-blade.com>, ecryptfs@vger.kernel.org

Hello Tyler

On Tue, 28 Jun 2016 23:36:23 -0500
Tyler Hicks <tyhicks@canonical.com> wrote:

> > Thanks. The backported version of the patch needs to be adjusted. I'll
> > try to get a patch out the stable list tomorrow.  
> 
> I've sent a fix to the stable list (and cc'ed the ecryptfs list). I
> tested on 4.4.y and 3.18.y on ext{2,3,4}, btrfs, and xfs. It should fix
> the regression that you hit.


Sorry, the patch did not work for me. I am still getting error "Wrong
medium type" wwhen accessing directories.


Regards,

Henry
