From: Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH] ecryptfs: add mount option for specifying cipher driver.
Date: Wed, 19 Feb 2020 10:30:50 -0600
Message-ID: <20200219163050.GA354535@elm>
References: <20200210153907.GA348@brian-desktop>
 <20200216010731.GA260140@elm>
 <20200219014218.GA17588@neutron>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40993 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQbE (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Wed, 19 Feb 2020 11:31:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so24352010oie.8
        for <ecryptfs@vger.kernel.org>; Wed, 19 Feb 2020 08:31:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200219014218.GA17588@neutron>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Kubisiak <brian.kubisiak@gmail.com>
Cc: ecryptfs@vger.kernel.org

On 2020-02-18 17:42:18, Brian Kubisiak wrote:
> Hi Tyler,
> 
> > Can you elaborate some on the use case you have?
> 
> On many modern embedded SoCs, there are multiple implementations of the same
> crypto algorithm---usually a CPU-based implementation using ISA extensions and a
> "security engine" implementation that implements crypto primitives on dedicated
> silicon. There are a few tradeoffs involved (performance, CPU overhead,
> resistance to side-channels attacks, etc), so it is not always clear which
> implementation is best.
> 
> An SoC that I've been working on has both the CPU implementation and the
> security engine implementation of the cbc(aes) algorithm at the same priority,
> so the one picked to perform the encryption for a given ecryptfs mount is
> somewhat random.

Have you looked into the possibility of increasing the priority of the
implementation that you prefer on your SoC?

If that's not feasible, have you considered blacklisting the module
providing the implementation that you don't prefer?

> My intention with this patch is to be able to select which
> implementation gets used for the mount using the
> ecryptfs_cipher_driver option instead of having the kernel pick.

I don't think allowing users to specify a cipher driver is a good idea.
eCryptfs has always assumed that the crypto subsystem knows best about
the ideal implementation of "cbc(aes)" and I believe that this is how
the crypto subsystem expects eCryptfs to make use of their API.

In addition to the design objection above, I'm worried about users
shooting themselves in the foot with this mount option. For example,
"ecryptfs_cipher_driver=ecb_aes_aesni" and
"ecryptfs_cipher_driver=xts_aes_aesni" are accepted. eCryptfs is only
implemented to operated in a (modified) CBC mode and letting users force
their way into using anything else is dangerous/insecure.

Lets see if we can address your problem in the crypto subsystem (or with
the module blacklist) rather than creating this amount of flexibility in
eCryptfs.

Tyler

> The fact that this would also effectively override the ecryptfs_cipher option is
> an unintended side effect, since the crypto_alloc_skcipher() function will take
> either the algorithm name or the driver name. Maybe there is a better way to do
> this?
> 
> Thanks,
> Brian
