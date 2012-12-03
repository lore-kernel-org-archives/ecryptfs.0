From: CACook@quantum-sci.com
Subject: Re: Encrypting BTRFS Volume
Date: Mon, 3 Dec 2012 09:56:52 -0800
Message-ID: <201212030956.52866.CACook@quantum-sci.com>
References: <201212011306.59255.CACook@quantum-sci.com> <201212030839.12613.CACook@quantum-sci.com> <CACDOv81f5YRbrYCwLOMggoHCz9qy0z41DQEDDEqRQbTRJZ7oPg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from gateway07.websitewelcome.com ([67.18.34.4]:46926 "EHLO
	gateway07.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794Ab2LCSV5 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 3 Dec 2012 13:21:57 -0500
Received: from getz.websitewelcome.com (getz.websitewelcome.com [174.121.36.226])
	by gateway07.websitewelcome.com (Postfix) with ESMTP id 16BB1A6C4AF82
	for <ecryptfs@vger.kernel.org>; Mon,  3 Dec 2012 11:56:53 -0600 (CST)
Received: from [67.183.170.11] (port=37939 helo=hydra.localnet)
	by getz.websitewelcome.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <CACook@quantum-sci.com>)
	id 1TfaGD-0000fo-SC
	for ecryptfs@vger.kernel.org; Mon, 03 Dec 2012 11:56:54 -0600
In-Reply-To: <CACDOv81f5YRbrYCwLOMggoHCz9qy0z41DQEDDEqRQbTRJZ7oPg@mail.gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ecryptfs@vger.kernel.org

On Monday, December 03, 2012 09:04:38 AM B. J. Potter wrote:
> OK. Here's an option. Rename your mount /media/encrypted. Make the
> ecryptfs directory there. Then mount that through ecryptfs as
> /media/backups.  You are necessarily going to lose some btrfs
> features, here you lose subvolumes. You could set it up differently
> depending on what features you care about. You might also consider
> ZFS, which I think is better designed/implemented than BTRFS (but
> comes with other problems).
> 
> As far as ecryptfs goes though. You just make a folder on some device
> (be it a subvolume, normal filesystem, whatever) and then mount it.
> Use that wherever you see fit.

OK thanks.  But subvolumes are critical because we need backup snapshots.  And so I am in this mess I have now.
