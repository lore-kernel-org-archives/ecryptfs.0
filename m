From: Brian Kubisiak <brian.kubisiak@gmail.com>
Subject: Re: [PATCH] ecryptfs: add mount option for specifying cipher driver.
Date: Tue, 18 Feb 2020 17:42:18 -0800
Message-ID: <20200219014218.GA17588@neutron>
References: <20200210153907.GA348@brian-desktop>
 <20200216010731.GA260140@elm>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38090 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgBSBmX (ORCPT
        <rfc822;ecryptfs@vger.kernel.org>); Tue, 18 Feb 2020 20:42:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so11872678pgn.5
        for <ecryptfs@vger.kernel.org>; Tue, 18 Feb 2020 17:42:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200216010731.GA260140@elm>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org

Hi Tyler,

> Can you elaborate some on the use case you have?

On many modern embedded SoCs, there are multiple implementations of the same
crypto algorithm---usually a CPU-based implementation using ISA extensions and a
"security engine" implementation that implements crypto primitives on dedicated
silicon. There are a few tradeoffs involved (performance, CPU overhead,
resistance to side-channels attacks, etc), so it is not always clear which
implementation is best.

An SoC that I've been working on has both the CPU implementation and the
security engine implementation of the cbc(aes) algorithm at the same priority,
so the one picked to perform the encryption for a given ecryptfs mount is
somewhat random. My intention with this patch is to be able to select which
implementation gets used for the mount using the ecryptfs_cipher_driver option
instead of having the kernel pick.

The fact that this would also effectively override the ecryptfs_cipher option is
an unintended side effect, since the crypto_alloc_skcipher() function will take
either the algorithm name or the driver name. Maybe there is a better way to do
this?

Thanks,
Brian
