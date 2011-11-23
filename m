From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] eCryptfs fixes for 3.2-rc3
Date: Wed, 23 Nov 2011 14:56:23 -0800
Message-ID: <CA+55aFyZvp=SsBG=SroMDLMEFGgazK1EM3b-Fejpgwf41+_e3w@mail.gmail.com>
References: <20111123222555.GA1094@boyd>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35183 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab1KWW4p convert rfc822-to-8bit (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Wed, 23 Nov 2011 17:56:45 -0500
In-Reply-To: <20111123222555.GA1094@boyd>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Tyler Hicks <tyhicks@canonical.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org

On Wed, Nov 23, 2011 at 2:25 PM, Tyler Hicks <tyhicks@canonical.com> wr=
ote:
>
> Tyler Hicks (3):
> =A0 =A0 =A0eCryptfs: Flush file in vma close

I'm not hugely happy with this one.

The commit message says:

    Dirty pages weren't being written back when an mmap'ed eCryptfs fil=
e was
    closed before the mapping was unmapped. Since f_ops->flush() is not
    called by the munmap() path, the lower file was simply being releas=
ed.
    This patch flushes the eCryptfs file in the vm_ops->close() path.

=46air enough - you've debugged the problem. You're misusing the ->flus=
h
thing which only gets called at close time, rather than flushing
things at ->release time. But why?

"->flush()" is very special, and is literally meant for things that
need to wait at close time. A file descriptor may be flushed many
times for a single open (because it was dup'ed etc), and yes, if it is
closed before mmap, it will be flushed before the mmap is done. The
"flush()" is basically attached to a particular fd - useful mainly for
things like special devices that actually want to delay the close
(serial lines etc).

But the fundamental issue is that I don't think cryptfs should be
using "flush". The file is still *open* when "flush()" is called.
That's the fundamental reason for the bug, I think.

cryptfs should flush the encrypted information at *release* time, not
"flush" time. And that would have avoided the bug with mmap, because
release gets called on the very last internal reference count drop of
the 'struct file' - so it gets called after the last close *and*
munmap.

Is there some reason I am missing that cryptfs has to use flush?

I'm doing the pull, but I really think that this is papering over the
*real* bug, which was the use of 'flush' in the first place.

In general, I'd urge people to *not* use "->flush" at all as a
"correctness issue". It's useful to return EIO to "close()" and to be
*polite* (ie the return value of "flush()" will be returned to user
space at close time), but it really should be seen as a "we try to
flush now to try to give user space nice error reports where
possible", but it's important to understand that it's not the last
close, and if you rely on it for correctness, you're doing something
wrong. It's "release()" that is the "get rid of all your state now",
and is about correctness. "flush" is purely about being polite.

ecryptfs seems to have relied on it for correctness. Not good.

                       Linus
