From: Ricky Zhou <rickyz@chromium.org>
Subject: Re: [PATCH] ecryptfs: open lower files on kthread under SELinux
Date: Mon, 11 Apr 2016 15:46:37 -0700
Message-ID: <CAJmxDmSthc-LePXFrNJKY1Hj7d4ettuTzvnh-X9rh7RT6=3SPg@mail.gmail.com>
References: <1459478198-37952-1-git-send-email-rickyz@chromium.org>
	<20160409001502.GC25631@boyd>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35860 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbcDKWql (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Mon, 11 Apr 2016 18:46:41 -0400
Received: by mail-vk0-f43.google.com with SMTP id c4so904912vkb.3
        for <ecryptfs@vger.kernel.org>; Mon, 11 Apr 2016 15:46:40 -0700 (PDT)
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com. [209.85.213.43])
        by smtp.gmail.com with ESMTPSA id d10sm4545457uad.24.2016.04.11.15.46.39
        for <ecryptfs@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 15:46:39 -0700 (PDT)
Received: by mail-vk0-f43.google.com with SMTP id c4so904454vkb.3
        for <ecryptfs@vger.kernel.org>; Mon, 11 Apr 2016 15:46:39 -0700 (PDT)
In-Reply-To: <20160409001502.GC25631@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tyler Hicks <tyhicks@canonical.com>
Cc: ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>

On Fri, Apr 8, 2016 at 5:15 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> 1) The kthread doesn't look like it will perform well enough to handle
>    all lower opens. We could probably squeeze some extra performance out
>    of it but I think the better solution is to temporarily change creds,
>    do the lower open, and change back to the original cred. See callers
>    of prepare_creds() for examples of this.
Yup, that was definitely my biggest concern with this change - thanks
for the pointers, I'll take a look at what it'll take to replace the
kthread with override_creds/revert_creds instead.

> 2) I don't think that delegating open() is sufficient. What about inode
>    based operations such as chown()? I think that we'll have a very
>    similar problem.
My impression was that this wasn't likely to be an issue since for
normal filesystems, SELinux doesn't associate any contexts from the
current task with inodes (task_sid in inode_security_struct should
only be used for things like sockets or tmpfs - and the case of tmpfs,
I think the resulting behavior is actually expected and correct under
ecryptfs).

Thanks,
Ricky
