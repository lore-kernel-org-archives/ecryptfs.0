From: CACook@quantum-sci.com
Subject: Re: Encrypting BTRFS Volume
Date: Mon, 3 Dec 2012 08:39:12 -0800
Message-ID: <201212030839.12613.CACook@quantum-sci.com>
References: <201212011306.59255.CACook@quantum-sci.com> <201212030701.38614.CACook@quantum-sci.com> <CACDOv81k0-jji9Jkz=pSQt9kc7GmPx7dLDoYSMzDxgCdf=J5kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from gateway01.websitewelcome.com ([67.18.65.19]:45778 "EHLO
	gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754568Ab2LCQqP (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Dec 2012 11:46:15 -0500
Received: from getz.websitewelcome.com (getz.websitewelcome.com [174.121.36.226])
	by gateway01.websitewelcome.com (Postfix) with ESMTP id 85A34A0822136
	for <ecryptfs@vger.kernel.org>; Mon,  3 Dec 2012 10:39:13 -0600 (CST)
Received: from [67.183.170.11] (port=37271 helo=hydra.localnet)
	by getz.websitewelcome.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <CACook@quantum-sci.com>)
	id 1TfZ33-0005DQ-Bt
	for ecryptfs@vger.kernel.org; Mon, 03 Dec 2012 10:39:13 -0600
In-Reply-To: <CACDOv81k0-jji9Jkz=pSQt9kc7GmPx7dLDoYSMzDxgCdf=J5kQ@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

On Monday, December 03, 2012 07:41:09 AM B. J. Potter wrote:
> Ecryptfs is not made for volumes. You make a folder that holds your
> encrypted files. Then you mount it at another location that's in the
> clear. Perhaps your looking for full-disk encryption instead of
> filesystem-level encryption. Here's a note from the btrfs wikipedia
> page:
> 
> The current recommendation for encryption with btrfs is to use a
> full-disk encryption mechanism such as dm-crypt or LUKS on the
> underlying devices, and to create the btrfs filesystem on top of that
> layer (and that if a RAID is to be used with encryption, encrypting a
> dm-raid device or a hardware-RAID device gives much faster disk
> performance than dm-crypt overlaid by btrfs's own filesystem-level
> RAID features)

That may be on the Wikipedia page, but here's what's in the BTRFS FAQ:
https://btrfs.wiki.kernel.org/index.php/FAQ#Does_btrfs_support_encryption.3F
--------------------------------------------------------------------
Does btrfs support encryption?

No. This is a hard task and easy to do wrong (on a filesystem level). There's nobody actively working on it, although you may have heard it's planned (year 2009), try to understand it like not impossible. Instead, you should use available whole-disk encryption solutions such as dm-crypt or LUKS.

This pretty much forbids you to use btrfs' cool RAID features if you need encryption. Using a RAID implementation on top of several encrypted disks is much slower than using encryption on top of a RAID device. So the RAID implementation must be on a lower layer than the encryption, which is not possible using btrfs' RAID support.

Note: there is an option to use a btrfs internal raid1 for data and metadata: create the filesystem with --mixed option (and DUP profiles), but this may impact performace for volume sizes > 15G (or so).

Another solution is to use stacked encrypting layer like ecryptfs. This does not have the disadvantage mentioned in the paragraph above.

Last but not least it the fuse-based filesystem encfs working as a encrypting layer on top of normal filesystem. Note that the performance may be impacted (dive into fuse details for more). --------------------------------------------------------------------

And this is why I'm here.



