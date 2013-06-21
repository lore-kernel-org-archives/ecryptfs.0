From: Michael Chang <thenewme91@gmail.com>
Subject: Re: ecryptfs on sub-directory?
Date: Fri, 21 Jun 2013 09:09:37 -0400
Message-ID: <CAHcyQ+6vSEOYq4HYhj6RQQo7HPrZRQ0fN0HaFGKiXSGZVsY1Gg@mail.gmail.com>
References: <51C43E3F.4030806@gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:40521 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965746Ab3FUNKS (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Fri, 21 Jun 2013 09:10:18 -0400
Received: by mail-vb0-f49.google.com with SMTP id 12so5731431vbf.8
        for <ecryptfs@vger.kernel.org>; Fri, 21 Jun 2013 06:10:17 -0700 (PDT)
In-Reply-To: <51C43E3F.4030806@gmail.com>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leam Hall <leamhall@gmail.com>
Cc: ecryptfs@vger.kernel.org

On Fri, Jun 21, 2013 at 7:51 AM, Leam Hall <leamhall@gmail.com> wrote:
> Hey all, sorry for the newbie question. I didn't find the answer in the docs
> I found.
>
> If I mount a filessystem on Linux, say /dev/sda4 as /opt, and create a
> directory under /opt; like /opt/backup. Can I use ecryptfs to mount
> /opt/backup onto itself so that just that portion of the file system is
> encrypted?

The impression that I get is that encrypting only part of the
filesystem is one of the primary use cases of ecryptfs. (For example,
if you have a single file system for / but want to have an encrypted
home directory.)

You may want to consider whether it is preferable to have separate
lower and upper mount points, e.g. /opt/backup and
/opt/.backup_encrypted or some such. That way, if /opt is mounted and
/opt/backup isn't, you don't accidentally clobber or try to use the
encrypted backing files.

--
Best regards,

Michael Chang
