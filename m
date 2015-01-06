From: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 32-byte encryption key for ecryptfs-setup-private ?
Date: Mon, 5 Jan 2015 19:05:21 -0800 (PST)
Message-ID: <alpine.DEB.2.19.4.1501051903010.19792@trent.utfs.org>
References: <loom.20141221T175441-142@post.gmane.org>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from trent.utfs.org ([94.185.90.103]:48525 "EHLO trent.utfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352AbbAFDLE (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 5 Jan 2015 22:11:04 -0500
In-Reply-To: <loom.20141221T175441-142@post.gmane.org>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Lan <tenoreamer@gmail.com>
Cc: ecryptfs@vger.kernel.org

On Sun, 21 Dec 2014 at 16:57, Eric Lan wrote:
> The default key-bytes for ecryptfs-setup-private is 16 bytes. I tried to
> change "KEYBYTES" in ecryptfs-setup-private to "32" but failed when running
> the script.
> 
> How about offering options for the users to determine "encryption
> parameters" (like encryption algorithm, encryption key bytes, etc.) ? Or is
> there a workaround now ?

There's https://bugs.launchpad.net/ecryptfs/+bug/1047823 - but apparently 
not many people requested this and nobody has implemented this yet.

Christian.
-- 
BOFH excuse #397:

T-1's congested due to porn traffic to the news server.
