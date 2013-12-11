From: Eric Tschetter <echeddar@gmail.com>
Subject: ecryptfs with an epehemeral key
Date: Tue, 10 Dec 2013 18:46:02 -0600
Message-ID: <CAB8U+h2oxfhoNgZ8jvE0DXQ0nnXz9PywkCiONv51H6n79s-uVQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64742 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab3LKAqE (ORCPT
	<rfc822;ecryptfs@vger.kernel.org>); Tue, 10 Dec 2013 19:46:04 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so6314750wib.8
        for <ecryptfs@vger.kernel.org>; Tue, 10 Dec 2013 16:46:03 -0800 (PST)
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <ecryptfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ecryptfs@vger.kernel.org

Hello all,

I apologize if this is an easy question, but I've been Googling around
for an answer with no luck and the man pages aren't helping, so I'm
asking here.  If this is documented somewhere, feel free to just point
me there.

For context, I want to setup an ecryptfs volume with an ephemeral key.
 I do *not* want the key stored anywhere.  I want to never, ever be
able to access the data again upon restart.  I actually want to be
forced to start over from nothing upon restart.

From looking at the options for starting up ecryptfs, it looks like
they all either require the key to be in a file or available in the
history/ps/etc.:

passphrase_passwd=(passphrase)
passphrase_passwd_file=(filename)
passphrase_passwd_fd=(file descriptor)
passphrase_salt=(hex value)
openssl_keyfile=(filename)
openssl_passwd_file=(filename)
openssl_passwd_fd=(file descriptor)
openssl_passwd=(password)

I'd rather not even store the key in a file and then remove the file,
because technically that file might get persisted to disk and remain
there after the delete.  The only thing I can think of is that maybe
there is something magical you can do with file descriptors to get it
to store the key in memory, have a file descriptor point to that
memory location and then destroy the fd and memory.

I'm unfortunately not that well-versed in how this would work though,
so before diving down that potential rabbit hole was hoping to get
some guidance from people on this list.

All help is appreciated.

--Eric
