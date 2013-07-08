From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Filesystem boundaries
Date: Mon, 08 Jul 2013 09:05:22 +0800
Message-ID: <51DA1052.2060606@ubuntukylin.com>
References: <51D6E23A.7000103@aol.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:35674 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab3GHBFm (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Sun, 7 Jul 2013 21:05:42 -0400
In-Reply-To: <51D6E23A.7000103@aol.de>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karl-Philipp Richter <krichter722@aol.de>
Cc: ecryptfs@vger.kernel.org

Are those subdirs basically symbol links to somewhere else not inside
the eCryptfs dir? Then those dirs won't be encrypted by eCryptfs.
For native subdirs, eCryptfs could not exclude them for being encrypted.

On 07/05/2013 11:11 PM, Karl-Philipp Richter wrote:
> Hi together,
> I'm new to mailing list and hope to be at the right address. I tried to
> figure out how to prevent ecryptfs to cross file system borders or
> exclude subdirectories of the source directory (the current setup is
> that I linked a lot of directories from an encrypted disk, which don't
> need encryption). I guess it's explained somewhere. So I'd rather
> suggest to put it on the man page.
>
> Greetings, Kalle
>
