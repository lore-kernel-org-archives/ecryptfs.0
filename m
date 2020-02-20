From: Brian Kubisiak <brian.kubisiak@gmail.com>
Subject: Re: [PATCH] ecryptfs: add mount option for specifying cipher driver.
Date: Thu, 20 Feb 2020 10:44:53 -0800
Message-ID: <20200220184453.GA15849@brian-desktop>
References: <20200210153907.GA348@brian-desktop>
 <20200216010731.GA260140@elm>
 <20200219014218.GA17588@neutron>
 <20200219163050.GA354535@elm>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40611 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSo5 (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Thu, 20 Feb 2020 13:44:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1892247plp.7
        for <ecryptfs@vger.kernel.org>; Thu, 20 Feb 2020 10:44:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200219163050.GA354535@elm>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org

> Have you looked into the possibility of increasing the priority of the
> implementation that you prefer on your SoC?

Yes, this should definitely be done, but I don't think it solves
the underlying issue. There are tradeoffs involved between the
security engine and the CPU implementation, and determining which
is "best" is dependent on what it is being used for. So I could
set the priority based on what I want for eCryptfs, but this also
affects every other consumer of the crypto API.

> I don't think allowing users to specify a cipher driver is a good idea.
> eCryptfs has always assumed that the crypto subsystem knows best about
> the ideal implementation of "cbc(aes)" and I believe that this is how
> the crypto subsystem expects eCryptfs to make use of their API.

I don't think this is true though. The crypto subsystem aims to
provide a sane default (ie whichever is the higher priority), but
allows overriding this choice if it would pick incorrectly. Since
it is making the choice with incomplete information (the crypto
subsystem can't know what you are using it for, so it doesn't
know which implementation is best), it makes sense that it could
be overridden from userspace. For example, the AF_ALG interface
to the crypto subsystem passes 'salg_name' directly from
userspace to allow this if needed.

I'd like to have this same flexibility in eCryptfs so I can
change which crypto implementation is used without affecting
other parts of the system.

> In addition to the design objection above, I'm worried about users
> shooting themselves in the foot with this mount option. For example,
> "ecryptfs_cipher_driver=ecb_aes_aesni" and
> "ecryptfs_cipher_driver=xts_aes_aesni" are accepted. eCryptfs is only
> implemented to operated in a (modified) CBC mode and letting users force
> their way into using anything else is dangerous/insecure.

I should probably also be checking that the requested driver
provides the correct algorithm, but haven't looked too closely
into that.

Brian
