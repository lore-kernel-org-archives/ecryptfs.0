From: =?UTF-8?Q?Stefan_Dr=C3=B6ge?= <stefan@sdroege.de>
Subject: ecryptfs with aes-ni slower bug
Date: Wed, 15 Feb 2012 11:43:21 +0100
Message-ID: <CAB89gJErehp2bw6XuWghBXT9D4632rgtowUVqSsna2ng8XQ5Sw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61578 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757080Ab2BOKnl (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 15 Feb 2012 05:43:41 -0500
Received: by obcva7 with SMTP id va7so1330327obc.19
        for <ecryptfs@vger.kernel.org>; Wed, 15 Feb 2012 02:43:41 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hi all,
A while ago I read at phoronix, that ecryptfs is actually slower when
having loaded the aesni-intel kernel module.
Out of curiosiy I checked whether this problem still exists in the
Ubuntu 12.04 alpha2, and it does.
I tried to find infos to this in the mailing list archive, but I found nothing.

So my question: Is somebody working on this?

Regards, Stefan
