From: Simon Que <sque@chromium.org>
Subject: Re: [PATCH] fs: ecryptfs: initialize payload_len in keystore.c
Date: Thu, 17 Jan 2013 11:15:25 -0800
Message-ID: <CANV8Hs1ra6huezsJvixkn_rdFbA07Vm-1hTwmGhay_2RvwmDQQ@mail.gmail.com>
References: <1358388494-31158-1-git-send-email-sque@chromium.org>
	<20130117190806.GA2394@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:40820 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3AQTP1 (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Thu, 17 Jan 2013 14:15:27 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so1435382eek.9
        for <ecryptfs@vger.kernel.org>; Thu, 17 Jan 2013 11:15:26 -0800 (PST)
In-Reply-To: <20130117190806.GA2394@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, dustin.kirkland@gazzang.com, Mandeep Baines <msb@chromium.org>

Hi Tyler --

> Is this to just quiet a useless compiler warning or is there a place
> were we actually use payload_len without initializing it? If we use it
> uninitialized, does it cause a crash or do we "handle" it in error
> paths? These details are factored in to determine if I need to send this
> to the stable team and if distros need to backport it. It also keeps me
> from scratching my head a year down the road when someone asks me about
> the patch with no commit message. :)

This is just to squash a compiler warning.  Assuming
write_tag_64_packet() works as intended, if it fails to initialize
payload_len, it should return an error and the function should skip to
the end.

I'll re-send the patch with a comment explaining this.
