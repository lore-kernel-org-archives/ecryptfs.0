From: "B. J. Potter" <bjpotter@gmail.com>
Subject: Re: Encrypting BTRFS Volume
Date: Tue, 4 Dec 2012 20:46:11 -0600
Message-ID: <CACDOv80NnYPfy23JXLK9_RhdHw5_z+SC7bWhuy_B-FscGQEY4Q@mail.gmail.com>
References: <201212011306.59255.CACook@quantum-sci.com>
	<CACDOv81f5YRbrYCwLOMggoHCz9qy0z41DQEDDEqRQbTRJZ7oPg@mail.gmail.com>
	<201212030956.52866.CACook@quantum-sci.com>
	<201212041005.10715.CACook@quantum-sci.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40817 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2LECqN (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 4 Dec 2012 21:46:13 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so3969769lbb.19
        for <ecryptfs@vger.kernel.org>; Tue, 04 Dec 2012 18:46:12 -0800 (PST)
In-Reply-To: <201212041005.10715.CACook@quantum-sci.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: CACook@quantum-sci.com
Cc: ecryptfs@vger.kernel.org

I don't understand your situation well enough to say (I lack the btrfs
subvolume knowledge). The encrypted part of ecryptfs is just a folder
of files on your filesystem. You then mount the folder on your system
and read/write to that mounted location. The encrypted files are
transparently updated as you write to the mounted location. You'll
have to apply that information on how ecryptfs works to your
situation.

On Tue, Dec 4, 2012 at 12:05 PM,  <CACook@quantum-sci.com> wrote:
>
> So ecryptfs cannot be applied in my situation, practically.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ecryptfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
