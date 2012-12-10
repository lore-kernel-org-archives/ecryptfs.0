From: William Roberts <bill.c.roberts@gmail.com>
Subject: CRASH Undefined Instruction
Date: Mon, 10 Dec 2012 18:04:20 +0900
Message-ID: <CAFftDdp758OXmqTiEbqAzBysdzUBzH1HU+QQEfPEytmvg+AVuA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35848 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab2LJJEV (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 10 Dec 2012 04:04:21 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so2200386vby.19
        for <ecryptfs@vger.kernel.org>; Mon, 10 Dec 2012 01:04:20 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

I filed a bug on launch pad, but was wondering if someone might know
about this exception I encountered.

Kernel OOPS
<6>[ 558.744788] flush-ecryptfs- (3516): undefined instruction: pc=c02d8d28

The details are here
https://bugs.launchpad.net/ecryptfs/+bug/1088397

-- 
Respectfully,

William C Roberts
