From: CACook@quantum-sci.com
Subject: Re: Encrypting BTRFS Volume
Date: Mon, 3 Dec 2012 07:01:38 -0800
Message-ID: <201212030701.38614.CACook@quantum-sci.com>
References: <201212011306.59255.CACook@quantum-sci.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from gateway09.websitewelcome.com ([67.18.44.5]:48526 "EHLO
	gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169Ab2LCPSX (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Dec 2012 10:18:23 -0500
Received: from getz.websitewelcome.com (getz.websitewelcome.com [174.121.36.226])
	by gateway09.websitewelcome.com (Postfix) with ESMTP id F2B8E9B4E1520
	for <ecryptfs@vger.kernel.org>; Mon,  3 Dec 2012 09:01:31 -0600 (CST)
Received: from [67.183.170.11] (port=36463 helo=hydra.localnet)
	by getz.websitewelcome.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <CACook@quantum-sci.com>)
	id 1TfXWd-0005YS-9Y
	for ecryptfs@vger.kernel.org; Mon, 03 Dec 2012 09:01:39 -0600
In-Reply-To: <201212011306.59255.CACook@quantum-sci.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

On Saturday, December 01, 2012 01:06:59 PM CACook@quantum-sci.com wrote:
> 
> My backups server has a 4 drive BTRFS array (2TB each), and is mounted on /media/backups.  Under that are BTRFS subvolumes named for the LAN systems they back up, such as hex, droog, etc.  Also under backups is where the snapshots are made, such as hex-snap-2012-10-15, droog-snap-2012-10-15, and so on.
>  
> So where can I encrypt?  Do I have to go in to each subvolume and make private directories for each of those subdirs like bin, etc, lib, and so on?  If so, how would I update the new snapshots which are created, for encryption?
>  
> It doesn't seem possible to encrypt a BTRFS subvolume, and certainly not an array?

Anyone here?
