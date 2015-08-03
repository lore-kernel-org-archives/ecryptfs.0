From: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC][PATCH] ecryptfs: Allow only one instance per lower path
Date: Mon, 3 Aug 2015 20:31:57 +0200
Message-ID: <55BFB39D.5070702@nod.at>
References: <1438338190-22518-1-git-send-email-richard@nod.at>
 <20150802010259.GA19522@boyd> <55BDCBF4.1050305@nod.at>
 <20150803052758.GA24915@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65277 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbbHCScB (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Mon, 3 Aug 2015 14:32:01 -0400
In-Reply-To: <20150803052758.GA24915@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Tyler,

Am 03.08.2015 um 07:27 schrieb Tyler Hicks:
>> So ecryptfs definitely supports mounting the same lower path multiple times?
>> What is the benefit of that behavior?
> 
> No, it doesn't support that in a way that provides consistency among all
> of the eCryptfs mounts.

Okay, then I'd argument to give my patch a try although it is not the solution
to the problem I've reported. :-)
If you don't mind I'll resend with a proper changelog.

> However, multiple mounts on the same lower path is not the cause of this
> bug. The real issue is a stale dcache entry when the lower filesystem
> has been modified without eCryptfs' knowing. I can trigger the same
> warnings with only a single eCryptfs mount.

Interesting, that renders the whole issue into a user triggerable kernel
bug. :-(

Thanks,
//richard
