From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: ecryptfs-mount-private fails the first time after boot
Date: Fri, 15 Nov 2013 20:00:14 -0500
Message-ID: <CAAk6P0XU2E+8z9pHcORs_PnKG3OkVK0FD9VL8y60m_kLZ=2VtA@mail.gmail.com>
References: <CAAk6P0VYWJA+pC6CfeLKhZc6kZ5EVASS+8ELoAUEWCOnqVhhuw@mail.gmail.com>
	<20131115233445.GA4911@boyd>
	<CAAk6P0XLJK_aF-kvrdaBT7P6qoK_2Scu3hyjPJedDyqQUWmvSw@mail.gmail.com>
	<20131116004134.GB4911@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:40992 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3KPBAQ (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 15 Nov 2013 20:00:16 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so4287555wgh.32
        for <ecryptfs@vger.kernel.org>; Fri, 15 Nov 2013 17:00:14 -0800 (PST)
In-Reply-To: <20131116004134.GB4911@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org

Running modprobe ecryptfs was all I needed.  I guess this is something
that should really be fixed at the package level, but now that I know
what's going on I can easily kludge around it. :)

(Although, I don't know if this makes sense, but wouldn't it be better
in a situation like this to *try* to load both keys, even if we don't
know the kernel supports filename encryption, and only fall back to
showing the encrypted filenames if that fails?)

Thanks again!

Benjamin
